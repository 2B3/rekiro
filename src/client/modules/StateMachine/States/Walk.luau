--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local modulesClient = ReplicatedStorage.ModulesClient

--- Requires ---
local CharacterController = require(modulesClient.CharacterController)
local AnimationController = require(modulesClient.AnimationController)

--- Definition ---
local walk = {

	events = {
		startRun = { target = "running", guards = { "isGrounded" } },

		stopWalk = "idle",
	},

	OnEntry = function()
		AnimationController:PlayAnimation("Movement", "Walk")
		CharacterController:SetWalkSpeed(8)
	end,

	OnExit = function()
		AnimationController:StopAnimation("Movement", "Walk")
	end,
}

return walk
