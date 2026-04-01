--- Services ---
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Player ---
local localPlayer = Players.LocalPlayer
local playerScripts = localPlayer.PlayerScripts

--- Requires ---
local Control = require(playerScripts.PlayerModule.ControlModule) :: { GetMoveVector: () -> Vector3? }
local signal = require(ReplicatedStorage.Shared.Utils.signal)

--- Variables ---
local characterController = {}
characterController.characterReady = signal()

--- Private Methods ---
local function updateCharacterReferences(character: Model)
	characterController.Character = character

	characterController.HumanoidRootPart = character and character:WaitForChild("HumanoidRootPart") :: BasePart
	characterController.Humanoid = character and character:WaitForChild("Humanoid") :: Humanoid

	characterController.RootAttachment = characterController.HumanoidRootPart
		and characterController.HumanoidRootPart:WaitForChild("RootAttachment") :: Attachment
	characterController.Animator = characterController.Humanoid
		and characterController.Humanoid:WaitForChild("Animator") :: Animator
end

local function onCharacterAdded(character: Model)
	updateCharacterReferences(character)
	characterController.characterReady:Fire()
end

--- Public Methods ---

--[=[
	Check if character references exist.
	@return boolean --> return true if character references exist.
]=]
function characterController:isReady(): boolean
	return if self.Character
			and self.HumanoidRootPart
			and self.RootAttachment
			and self.Humanoid
			and self.Animator
		then true
		else false
end

--[=[
	Set the humanoid maximum movement speed in studs per second.
	@param walkSpeed number --> maximun movement speed in studs/s
]=]
function characterController:setWalkSpeed(walkSpeed: number)
	if not self.Humanoid then
		warn("[characterController]: Humaniod not found.")
		return
	end

	self.Humanoid.WalkSpeed = walkSpeed
end

--[=[
	Set the humanoid jump height speed in studs.
	@param jumpHeight number --> jump height in studs.
	]=]
function characterController:setJumpHeight(jumpHeight: number)
	if not self.Humanoid then
		warn("[characterController]: Humaniod not found.")
		return
	end

	self.Humanoid.JumpHeight = jumpHeight
end

--[=[
	Returns the move vector provided by the Control PlayerModule.
	@return Vector3 --> normalizated move vector.
	]=]
function characterController:getMoveVector(): Vector3
	return Control:GetMoveVector()
end

--[=[
	Check if the player is moving.
	@return boolean --> return true if the player is moving.
]=]
function characterController.isMoving(self: typeof(characterController)): boolean
	return if self.Humanoid then self.Humanoid.MoveDirection.magnitude >= 0.1 else false
end

--[=[
   Check if the player is grounded.
   @return boolean --> return true if the player is on the ground.
]=]
function characterController.isGrounded(self: typeof(characterController)): boolean
	return if self.Humanoid
		then self.Humanoid.FloorMaterial ~= Enum.Material.Air and self.Humanoid.FloorMaterial ~= Enum.Material.Water
		else false
end

--[=[
   Check if the player is on air.
   @return boolean --> returns true if the player is airborne.
]=]
function characterController.isOnAir(self: typeof(characterController)): boolean
	return if self.Humanoid then self.Humanoid.FloorMaterial == Enum.Material.Air else false
end

--- Main ---
function characterController:start()
	onCharacterAdded(localPlayer.Character or localPlayer.CharacterAdded:Wait())
	localPlayer.CharacterAdded:Connect(onCharacterAdded)
end

return characterController
