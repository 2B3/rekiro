--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

--- Definition ---
local running: Types.StateNode = {

	OnEntry = function(ctx)
		ctx.components.animation:playAnimation("movement", "run_cycle")
		ctx.components.character:setWalkSpeed(22)
	end,

	OnExit = function(ctx)
		ctx.components.animation:stopAnimation("movement", "run_cycle")
	end,
}

return running
