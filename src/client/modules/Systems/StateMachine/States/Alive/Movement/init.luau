--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

local Dashing = require(script.Dashing)
local Running = require(script.Running)
local Walking = require(script.Walking)
local Idle = require(script.Idle)

--- Definition ---
local movement: Types.StateNode = {
	initial = "idle",
	history = "shallow",

	states = {
		idle = Idle,

		walking = Walking,
		running = Running,
		dashing = Dashing,
	},
}

return movement
