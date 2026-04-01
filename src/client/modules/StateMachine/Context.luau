--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local AnimationController = require(ReplicatedStorage.ModulesClient.Controllers.AnimationController)
local CharacterController = require(ReplicatedStorage.ModulesClient.Controllers.CharacterController)
local InputController = require(ReplicatedStorage.ModulesClient.Controllers.InputController)

--- Definition ---
local context = {
	character = CharacterController,
	animation = AnimationController,
	input = InputController,
}

return context
