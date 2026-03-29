--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local modulesClient = ReplicatedStorage.ModulesClient

--- Requires ---
local AnimationController = require(modulesClient.AnimationController)

--- Definition ---
local idle = {

	events = {
		startRun = { target = "running", guards = { "isGrounded" } },

		startWalk = "walk",
	},

	OnEntry = function()
		AnimationController:PlayAnimation("Movement", "Idle")
	end,

	OnExit = function()
		AnimationController:StopAnimation("Movement", "Idle")
	end,
}

return idle
