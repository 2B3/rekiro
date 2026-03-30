--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local controllers = clientModules.Controllers

--- Requires ---
local CharacterController = require(controllers.CharacterController)

local RegularRunning = require(script.RegularRunning)
local SprintRunning = require(script.SprintRunning)

--- Definition ---
local running = {
	initial = "sprintRunning",

	events = {
		startWalk = { target = "walk", guards = { "isReady", "isGrounded" } },

		stopRun = "idle",
	},

	states = {
		sprintRunning = SprintRunning,

		regularRunning = RegularRunning,
	},

	OnEntry = function()
		CharacterController:SetJumpHeight(0)
		CharacterController:SetWalkSpeed(22)
	end,
}

return running
