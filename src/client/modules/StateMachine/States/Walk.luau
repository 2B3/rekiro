--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local controllers = clientModules.Controllers

--- Requires ---
local AnimationController = require(controllers.AnimationController)
local CharacterController = require(controllers.CharacterController)

--- Definition ---
local walk = {

	events = {
		startRun = { target = "running", guards = { "isReady", "isGrounded" } },

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
