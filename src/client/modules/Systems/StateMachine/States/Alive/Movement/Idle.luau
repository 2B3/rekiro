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
		ctx.components.character:setJumpHeight(7.2)
	end,

	OnExit = function(ctx)
		ctx.components.animation:stopAnimation("movement", "idle")
	end,

	events = {
		startWalking = { target = "walking", guards = { "isMoving" } } :: Types.Event,
		startRunning = { target = "dashing", guards = { "canRun" } } :: Types.Event,
	},
}

return idle
