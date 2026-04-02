--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local AnimationService = require(ReplicatedStorage.ModulesClient.Services.AnimationService)
local CharacterService = require(ReplicatedStorage.ModulesClient.Services.CharacterService)
local InputService = require(ReplicatedStorage.ModulesClient.Services.InputService)

--- Definition ---
local context = {}
context.components = {
	character = CharacterService,
	animation = AnimationService,
	input = InputService,
}

return context
