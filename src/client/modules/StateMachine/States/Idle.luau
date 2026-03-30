--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local controllers = clientModules.Controllers

--- Requires ---
local CharacterController = require(ReplicatedStorage.ModulesClient.Controllers.CharacterController)
local AnimationController = require(controllers.AnimationController)

--- Definition ---
local idle = {

	events = {
		startRun = { target = "running", guards = { "isGrounded" } },

		startWalk = "walk",
	},

	OnEntry = function()
		AnimationController:PlayAnimation("Movement", "Idle")
		CharacterController:SetJumpHeight(7.2)
	end,

	OnExit = function()
		AnimationController:StopAnimation("Movement", "Idle")
	end,
}

return idle
