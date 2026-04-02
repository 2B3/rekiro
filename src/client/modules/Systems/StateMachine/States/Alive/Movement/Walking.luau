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
		ctx.components.character:setJumpHeight(7.2)
		ctx.components.character:setWalkSpeed(10)
	end,

	OnExit = function(ctx)
		ctx.components.animation:stopAnimation("movement", "walk_cycle")
	end,

	events = {
		startRunning = { target = "dashing", guards = { "canRun" } } :: Types.Event,

		stopWalking = { target = "idle" } :: Types.Event,
	},
}

return walking
