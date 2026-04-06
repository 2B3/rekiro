--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

--- Definition ---
local attacking: Types.StateNode = {

	OnEntry = function(ctx, skillName: string)
		local characterWCS = ctx.components.combat:getWCSCharacter()
		local skill = characterWCS:GetSkillFromString(skillName)
		if not skill then
			return
		end

		task.spawn(function()
			skill:Start()
			skill.Ended:Once(function()
				ctx.Send("stopAttacking")
			end)
		end)
	end,

	events = {
		stopAttacking = { target = "unsheathed" } :: Types.Event,
	},
}

return attacking
