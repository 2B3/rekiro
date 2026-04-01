--!strict

--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient

--- Requires ---
local Types = require(clientModules.StateMachine.Types)
local Movement = require(script.Movement)

--- Definition ---
local alive: Types.StateNode = {
	parallel = true, --> Error if states does have more than 1 nodeState
	initial = "movement",

	states = {
		movement = Movement,
	},
}

return alive
