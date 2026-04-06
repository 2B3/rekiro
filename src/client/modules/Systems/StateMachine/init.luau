--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages
local states = script.States

--- Requires ---
local Arch = require(packages.Arch)

local Actions = require(script.Actions)
local Context = require(script.Context)
local Guards = require(script.Guards)

local Alive = require(states.Alive)
local Death = require(states.Death)

--- Options ---
local options = {
	guards = Guards, -- dictionary of guards that can be referenced by transitions
	context = Context, -- the initial context of the machine passed to each state
	actions = Actions, -- dictionary of actions that can be referenced by state and transition callbacks

	maxLogs = 30, -- max logs in the log history, when the max is reached it deletes the oldest log
	logTime = true, -- determines whether or not to include a time property to each log
	debugMode = false, -- when set to true, the machine will print basic changes in the machine such as entering and exiting of states
}

--- Definition ---
local definition = {
	id = "PlayerMachine",
	initial = "alive",

	states = {
		alive = Alive,
		death = Death,
	},
}

--- Main ---
local arch = Arch.createMachine(definition :: any, options :: any)

local StateMachine = setmetatable({}, { __index = arch })

function StateMachine:init()
	arch:Start()
end

function StateMachine:start() end --[[ Keep this, if you deleted the StateMachine called .start() two times. ]]

return StateMachine
