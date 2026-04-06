--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)
local Guards = require(systems.StateMachine.Guards)

--- Variables ---
local TOGGLE_COOLDOWN = 1.5
local ATTACK_AFTER_EQUIP_COOLDOWN = 0.8

--- Definition ---
local unsheathed: Types.StateNode = {
	OnEntry = function(ctx)
		--// Evit toggle spam //--
		ctx.lastSheathedToggle = os.clock()
	end,

	events = {
		startAttacking = {
			target = "attack",
			guards = {
				"canAttack",
				function(ctx)
					return os.clock() - (ctx.lastEquip or 0) > ATTACK_AFTER_EQUIP_COOLDOWN
				end,
			},
		} :: Types.Event,

		toggleSheathe = {
			target = "sheathed",
			guards = {
				function(ctx)
					return os.clock() - (ctx.lastSheathedToggle or 0) > TOGGLE_COOLDOWN
				end,

				function(ctx)
					return not Guards.wantsSprint(ctx)
				end,
			},
			actions = { "unequip" },
		} :: Types.Event,
	},
}

return unsheathed
