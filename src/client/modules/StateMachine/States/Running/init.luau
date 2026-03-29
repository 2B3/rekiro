--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local modulesClient = ReplicatedStorage.ModulesClient

--- Requires ---
local CharacterController = require(modulesClient.CharacterController)

local RegularRunning = require(script.RegularRunning)
local SprintRunning = require(script.SprintRunning)

--- Definition ---
local running = {
	initial = "sprintRunning",

	events = {
		startWalk = { target = "walk", guards = { "isGrounded" } },

		stopRun = "idle",
	},

	states = {
		sprintRunning = SprintRunning,

		regularRunning = RegularRunning,
	},

	OnEntry = function()
		CharacterController:SetJumpHeight(0)
	end,
}

return running
