--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local characterController = require(ReplicatedStorage.ModulesClient.Controllers.CharacterController)
local animationController = require(ReplicatedStorage.ModulesClient.Controllers.AnimationController)
local inputController = require(ReplicatedStorage.ModulesClient.Controllers.InputController)

--- Definition ---
local context = {}
context.components = {
	character = characterController,
	animation = animationController,
	input = inputController,
}

return context
