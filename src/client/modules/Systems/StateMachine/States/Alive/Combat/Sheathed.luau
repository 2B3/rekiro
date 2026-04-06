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

--- Definition ---
local sheathed: Types.StateNode = {
	OnEntry = function(ctx)
		--// Evit toggle spam //--
		ctx.lastSheathedToggle = os.clock()
	end,

	events = {
		toggleSheathe = {
			target = "unsheathed",
			guards = {
				function(ctx)
					return os.clock() - (ctx.lastSheathedToggle or 0) > TOGGLE_COOLDOWN
				end,

				function(ctx)
					return not Guards.wantsSprint(ctx)
				end,
			},
			actions = { "equip" },
		} :: Types.Event,
	},
}

return sheathed
