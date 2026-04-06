--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

--- Definition ---
local idle: Types.StateNode = {

	OnEntry = function(ctx)
		ctx.components.animation:playAnimation("movement", "idle")
		ctx.network.movementStateChanged:Fire("idle")
	end,

	OnExit = function(ctx)
		ctx.components.animation:stopAnimation("movement", "idle")
	end,

	events = {
		startSprint = { target = "dashing", guards = { "canSprint" }, actions = { "startSprintCD" } } :: Types.Event,
		startWalking = { target = "walking", guards = { "isMoving" } } :: Types.Event,
	},
}

return idle
