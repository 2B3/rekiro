--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local combat = ReplicatedStorage.Shared.Combat
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

local Attack = require(combat.Skills.Attack)

--- Definition ---
local attack: Types.StateNode = {

	OnEntry = function(ctx)
		local characterWCS = ctx.components.combat:getWCSCharacter()
		local skill = characterWCS:GetSkillFromConstructor(Attack)

		skill:Start()
		ctx.Send("stopAttack")
	end,

	events = {
		stopAttack = { target = "unsheathed" } :: Types.Event,
	},
}

return attack
