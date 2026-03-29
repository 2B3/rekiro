--- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local modulesClient = ReplicatedStorage.ModulesClient

--- Requires ---
local CharacterController = require(modulesClient.CharacterController)
local AnimationController = require(modulesClient.AnimationController)

--- Definition ---
local regularRunning = {

	OnEntry = function()
		AnimationController:PlayAnimation("Movement", "Run", 0.2)
		CharacterController:SetWalkSpeed(22)
	end,

	OnExit = function()
		AnimationController:StopAnimation("Movement", "Run")
	end,
}

return regularRunning
