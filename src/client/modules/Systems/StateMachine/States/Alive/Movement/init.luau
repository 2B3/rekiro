--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Dashing = require(script.Dashing)
local Types = require(systems.StateMachine.Types)

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

	events = {
		startWalking = { target = "walking", guards = { "isMoving" } } :: Types.Event,
		startRunning = { target = "running", guards = { "canRun" } } :: Types.Event, --> Only call after dashing.

		stopWalking = { target = "idle" } :: Types.Event,
		stopRunning = {
			{ target = "walking", guards = { "isMoving" } } :: Types.Event,
			{ target = "idle" } :: Types.Event,
		},
	},
}

return movement
