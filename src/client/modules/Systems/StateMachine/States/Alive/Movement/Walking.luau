--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

--- Definition ---
local walking: Types.StateNode = {

	OnEntry = function(ctx)
		ctx.components.animation:playAnimation("movement", "walk_cycle")
		ctx.network.movementStateChanged:Fire("walking")
	end,

	OnExit = function(ctx)
		ctx.components.animation:stopAnimation("movement", "walk_cycle")
	end,

	events = {
		startSprint = { target = "dashing", guards = { "canSprint" }, actions = { "startSprintCD" } } :: Types.Event,
		stopWalking = { target = "idle" } :: Types.Event,
	},
}

return walking
