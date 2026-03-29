local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage:WaitForChild("ModulesClient")
local controllers = clientModules:WaitForChild("Controllers")

--- Requires ---
local StateMachine = require(clientModules.StateMachine)
local CharacterController = require(controllers.CharacterController)
local InputController = require(controllers.InputController)

--- Variables ---
local MovementController = {}

MovementController.RunningHeldDown = false

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
function MovementController.Start(self: typeof(MovementController))
	InputController:GetPressedSignal("MovementContext", "RunAction"):Connect(function()
		self.RunningHeldDown = true
		self:Update()
	end)

	InputController:GetReleasedSignal("MovementContext", "RunAction"):Connect(function()
		self.RunningHeldDown = false
		self:Update()
	end)
end

return MovementController
