--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Players = game:GetService("Players")

--- Folders ---
local serverModules = ServerStorage.ModulesServer
local packages = ReplicatedStorage.Packages
local shared = ReplicatedStorage.Shared
local combat = shared.Combat

--- Requires ---
local Default = require(ReplicatedStorage.Shared.Combat.Movesets.Default)
local MovementBase = require(combat.StatusEffect.MovementBase)
local CombatService = require(serverModules.Services.CombatService)
local Events = require(shared.Events)
local WCS = require(packages.WCS)

--- Variables ---
local CombatController = {}

local function onCharacterAdded(characterModel)
	CombatService:toggleSheathe(characterModel, true)

	local characterWCS = WCS.Character.new(characterModel)

	--// Apply default moveset //--
	characterWCS:ApplyMoveset(Default)

	-- // Apply Base Movement Effect //--
	CombatService.movementBaseEffect[characterModel] = MovementBase.new(characterWCS)
	CombatService.movementBaseEffect[characterModel]:Start()

	local humanoid = characterModel:WaitForChild("Humanoid") :: Humanoid
	humanoid.Died:Once(function()
		characterWCS:Destroy()
	end)
end

function CombatController.start()
	CombatService:loadDirectories()
	CombatService.server:Start()

	Players.PlayerAdded:Connect(function(player: Player)
		player.CharacterAdded:Connect(onCharacterAdded)
	end)

	Events.toggleSheathe.OnServerEvent:Connect(function(player: Player, value: boolean)
		if not player.Character then
			return
		end

		CombatService:toggleSheathe(player.Character, value)
	end)

	Events.getSword.OnServerInvoke = function(player: Player)
		return CombatService.swords[player.Character]
	end
end

return CombatController
