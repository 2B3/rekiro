--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local shared = ReplicatedStorage.Shared

local controllers = clientModules.Controllers

--- Requires ---
local callWithSelf = require(shared.Utils.callWithSelf)
local CharacterController = require(controllers.CharacterController)

--- Definition ---
local guards = {
	---// Character Guards //--
	isGrounded = callWithSelf(CharacterController, CharacterController.IsGrounded),

	isMoving = callWithSelf(CharacterController, CharacterController.IsMoving),

	isOnAir = callWithSelf(CharacterController, CharacterController.IsOnAir),

	isReady = callWithSelf(CharacterController, CharacterController.IsReady),
}

return guards
