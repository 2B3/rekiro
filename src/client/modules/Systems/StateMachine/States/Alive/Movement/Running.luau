--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

--- Definition ---
local running: Types.StateNode = {
	janitor = true,

	OnEntry = function(ctx)
		ctx.components.animation:playAnimation("movement", "run_cycle")
		ctx.components.character:setWalkSpeed(22)
		ctx.components.character:setJumpHeight(0)
	end,

	OnExit = function(ctx)
		ctx.components.animation:stopAnimation("movement", "run_cycle")
	end,

	events = {
		startWalking = { target = "walking", guards = { "isMoving" } } :: Types.Event,

		stopRunning = {
			{ target = "walking", guards = { "isMoving" } } :: Types.Event,
			{ target = "idle" } :: Types.Event,
		},
	},
}

return running
