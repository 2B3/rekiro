--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local controllers = clientModules.Controllers

--- Requires ---
local AnimationController = require(controllers.AnimationController)

--- Definition ---
local idle = {

	events = {
		startRun = { target = "running", guards = { "isReady", "isGrounded" } },

		startWalk = { target = "walk", guards = { "isReady" } },
	},

	OnEntry = function()
		AnimationController:PlayAnimation("Movement", "Idle")
	end,

	OnExit = function()
		AnimationController:StopAnimation("Movement", "Idle")
	end,
}

return idle
