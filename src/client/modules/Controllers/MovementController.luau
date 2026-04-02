--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CharacterService = require(ReplicatedStorage.ModulesClient.Services.CharacterService)
local MovementService = require(ReplicatedStorage.ModulesClient.Services.MovementService)
local InputService = require(ReplicatedStorage.ModulesClient.Services.InputService)

--- Variables ---
local MovementController = {}

--- Private Methods ---
local function onCharacterReady()
	local function update()
		MovementService:update()
	end

	CharacterService.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(update)
	CharacterService.Humanoid.StateChanged:Connect(update)
end

--- Public Methods ---
function MovementController.setupInputConnections()
	local runningAction = InputService:getInputAction("MovementContext", "RunAction")
	if not runningAction then
		return
	end

	runningAction.Pressed:Connect(function()
		MovementService.wantsToRun = true
		MovementService:update()
	end)

	runningAction.Released:Connect(function()
		MovementService.wantsToRun = false
		MovementService:update()
	end)
end

function MovementController.start(self: typeof(MovementController))
	CharacterService.characterReady:Connect(onCharacterReady)
	if CharacterService:isReady() then
		onCharacterReady()
	end

	self:setupInputConnections()
end

return MovementController
