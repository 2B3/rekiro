--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

local Unsheathed = require(script.Unsheathed)
local Sheathed = require(script.Sheathed)

local Attacking = require(script.Attacking)

--- Definition ---
local combat: Types.StateNode = {
	initial = "sheathed",

	states = {
		unsheathed = Unsheathed,
		sheathed = Sheathed,

		attack = Attacking,
	},
}

return combat
