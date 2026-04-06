--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local shared = ReplicatedStorage.Shared

local combat = shared.Combat

--- Requires ---
local InputService = require(ReplicatedStorage.ModulesClient.Services.InputService)
local StateMachine = require(ReplicatedStorage.ModulesClient.Systems.StateMachine)
local CombatService = require(clientModules.Services.CombatService)

--- Variables ---
local CombatController = {}

--- Private Methods ---
--[=[
	Register all needed directories.
]=]
local function loadDirectories()
	CombatService.client:RegisterDirectory(combat.Movesets)
	CombatService.client:RegisterDirectory(combat.Skills)
	CombatService.client:RegisterDirectory(combat.StatusEffect)
end

--- Public Methods ---
function CombatController:start()
	loadDirectories()
	CombatService.client:Start()

	InputService:getInputAction("CombatContext", "MeleeAction").Pressed:Connect(function()
		StateMachine:Send("startAttacking", "Melee")
	end)

	InputService:getInputAction("CombatContext", "UnsheathedAction").Pressed:Connect(function()
		StateMachine:Send("toggleSheathe")
	end)
end

return CombatController
