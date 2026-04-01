--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient

--- Requires ---
local Types = require(clientModules.StateMachine.Types)

--- Definition ---
local running: Types.StateNode = {

	OnEntry = function(ctx)
		ctx.animation:PlayAnimation("Movement", "run_cycle")
		ctx.character:SetWalkSpeed(22)
	end,

	OnExit = function(ctx)
		ctx.animation:StopAnimation("Movement", "run_cycle")
	end,
}

return running
