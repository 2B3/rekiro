--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local services = clientModules.Services

--- Requires ---
local AnimationService = require(services.AnimationService)
local CharacterService = require(services.CharacterService)
local CombatService = require(services.CombatService)
local InputService = require(services.InputService)

--- Definition ---
local context = {}
context.wcsCharacter = CombatService.getWCSCharacter

context.components = {
	character = CharacterService,
	animation = AnimationService,
	input = InputService,
}

return context
