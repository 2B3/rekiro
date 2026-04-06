--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local services = clientModules.Services

--- Requires ---
local Events = require(ReplicatedStorage.Shared.Events)
local AnimationService = require(services.AnimationService)
local CharacterService = require(services.CharacterService)
local CombatService = require(services.CombatService)
local InputService = require(services.InputService)

--- Definition ---
local context = {}

context.components = {
	character = CharacterService,
	animation = AnimationService,
	combat = CombatService,
	input = InputService,
}

context.network = Events

return context
