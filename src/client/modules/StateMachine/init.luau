local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Arch = require(ReplicatedStorage.Packages.Arch)

local definition = {
	id = "PlayerMachine",
	initial = "idle",

	states = {},
}

local options = {
	context = {}, -- the initial context of the machine passed to each state
	actions = {}, -- dictionary of actions that can be referenced by state and transition callbacks
	guards = {}, -- dictionary of guards that can be referenced by transitions
	maxLogs = 30, -- max logs in the log history, when the max is reached it deletes the oldest log
	logTime = true, -- determines whether or not to include a time property to each log
	debugMode = true, -- when set to true, the machine will print basic changes in the machine such as entering and exiting of states
}

local MovementService = Arch.createMachine(definition, options)

return MovementService
