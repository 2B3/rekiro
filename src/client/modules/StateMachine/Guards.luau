--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local callWithSelf = require(ReplicatedStorage.Shared.Utils.callWithSelf)
local CharacterController = require(ReplicatedStorage.ModulesClient.CharacterController)

--- Definition ---
local guards = {
	---// Character Guards //--
	isGrounded = callWithSelf(CharacterController, CharacterController.IsGrounded),

	isMoving = callWithSelf(CharacterController, CharacterController.isMoving),

	isOnAir = callWithSelf(CharacterController, CharacterController.IsOnAir),
}

return guards
