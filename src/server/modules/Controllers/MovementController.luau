local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local CombatService = require(ServerStorage.ModulesServer.Services.CombatService)
local Events = require(ReplicatedStorage.Shared.Events)

local MovementController = {}
MovementController.effect = {}

local dataValues = {
	running = {
		WalkSpeed = 22,
		JumpHeight = 0,
	},

	walking = {
		WalkSpeed = 10,
		JumpHeight = 7.2,
	},

	idle = {
		WalkSpeed = 2,
		JumpHeight = 7.2,
	},
} :: { [string]: { WalkSpeed: number, JumpHeight: number } }

function MovementController:start()
	Events.movementStateChanged.OnServerEvent:Connect(function(player: Player, state: string)
		local effect = CombatService.movementBaseEffect[player.Character]
		local data = dataValues[state]

		if not data or not effect then
			warn("Something wrong here!!!")
			return
		end

		effect:SetHumanoidData({ WalkSpeed = { data.WalkSpeed, "Set" }, JumpHeight = { data.JumpHeight, "Set" } }, 1)
	end)
end

return MovementController
