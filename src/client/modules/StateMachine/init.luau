--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages
local states = script.States

--- Requires ---
local Arch = require(packages.Arch)

local Guards = require(script.Guards)

local Running = require(states.Running)
local Idle = require(states.Idle)
local Walk = require(states.Walk)

--- Options ---
local options = {
	context = {}, -- the initial context of the machine passed to each state
	actions = {}, -- dictionary of actions that can be referenced by state and transition callbacks
	guards = Guards, -- dictionary of guards that can be referenced by transitions
	maxLogs = 30, -- max logs in the log history, when the max is reached it deletes the oldest log
	logTime = true, -- determines whether or not to include a time property to each log
	debugMode = true, -- when set to true, the machine will print basic changes in the machine such as entering and exiting of states
}

--- Definition ---
local definition = {
	id = "PlayerMachine",
	initial = "idle",

	states = {
		idle = Idle,

		walk = Walk,

		running = Running,
	},
}

--- StateMachine ---
return Arch.createMachine(definition, options)
