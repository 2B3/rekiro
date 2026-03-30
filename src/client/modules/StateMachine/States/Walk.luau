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
		startRun = { target = "running", guards = { "isGrounded" } },

		stopWalk = "idle",
	},

	OnEntry = function()
		AnimationController:PlayAnimation("Movement", "Walk")
		CharacterController:SetJumpHeight(7.2)
		CharacterController:SetWalkSpeed(8)
	end,

	OnExit = function()
		AnimationController:StopAnimation("Movement", "Walk")
	end,
}

return walk
