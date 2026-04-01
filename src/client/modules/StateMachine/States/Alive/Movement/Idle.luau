--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient

--- Requires ---
local Types = require(clientModules.StateMachine.Types)

--- Definition ---
local idle: Types.StateNode = {

	OnEntry = function(ctx)
		ctx.animation:PlayAnimation("Movement", "idle")
	end,

	OnExit = function(ctx)
		ctx.animation:StopAnimation("Movement", "idle")
	end,
}

return idle
