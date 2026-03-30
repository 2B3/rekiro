local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage:WaitForChild("ModulesClient")
local controllers = clientModules:WaitForChild("Controllers")

--- Requires ---
local StateMachine = require(clientModules:WaitForChild("StateMachine"))
local CharacterController = require(controllers.CharacterController)
local InputController = require(controllers.InputController)

--- Variables ---
local MovementController = {}

MovementController.RunningHeldDown = false

--- Private Methods ---
local function onMoveDirectionChanged()
	MovementController:Update()
end

local function onCharacterReady()
	CharacterController.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(onMoveDirectionChanged)
end

local function toggleRun(value: boolean?)
	MovementController.RunningHeldDown = value or not MovementController.RunningHeldDown
	MovementController:Update()
end

--- Public Methods ---

function MovementController.Update(self: typeof(MovementController))
	local variation = self.RunningHeldDown and "Run" or "Walk"

	if CharacterController:IsMoving() then
		StateMachine:Send("start" .. variation)
	else
		StateMachine:Send("stop" .. variation)
	end
end

--- Main ---
function MovementController.Start()
	InputController:GetPressedSignal("MovementContext", "RunAction"):Connect(function()
		toggleRun(true)
	end)

	InputController:GetReleasedSignal("MovementContext", "RunAction"):Connect(function()
		toggleRun(false)
	end)

	CharacterController.CharacterReady:Connect(onCharacterReady)
end

return MovementController
