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
local CharacterController = {}
CharacterController.CharacterReady = signal()

--- Private Methods ---
local function updateCharacterReferences(character: Model)
	CharacterController.Character = character

	CharacterController.HumanoidRootPart = character and character:WaitForChild("HumanoidRootPart") :: BasePart
	CharacterController.Humanoid = character and character:WaitForChild("Humanoid") :: Humanoid

	CharacterController.RootAttachment = CharacterController.HumanoidRootPart
		and CharacterController.HumanoidRootPart:WaitForChild("RootAttachment") :: Attachment
	CharacterController.Animator = CharacterController.Humanoid
		and CharacterController.Humanoid:WaitForChild("Animator") :: Animator
end

local function onCharacterAdded(character: Model)
	updateCharacterReferences(character)
	CharacterController.CharacterReady:Fire()
end

--- Public Methods ---

--[=[
	Check if character references exist.
	@return boolean --> return true if character references exist.
]=]
function CharacterController:IsReady(): boolean
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
function CharacterController:SetWalkSpeed(walkSpeed: number)
	if not self.Humanoid then
		warn("[CharacterController]: Humaniod not found.")
		return
	end

	self.Humanoid.WalkSpeed = walkSpeed
end

--[=[
	Set the humanoid jump height speed in studs.
	@param jumpHeight number --> jump height in studs.
	]=]
function CharacterController:SetJumpHeight(jumpHeight: number)
	if not self.Humanoid then
		warn("[CharacterController]: Humaniod not found.")
		return
	end

	self.Humanoid.JumpHeight = jumpHeight
end

--[=[
	Returns the move vector provided by the Control PlayerModule.
	@return Vector3 --> normalizated move vector.
	]=]
function CharacterController:GetMoveVector(): Vector3
	return Control:GetMoveVector()
end

--[=[
	Check if the player is moving.
	@return boolean --> return true if the player is moving.
]=]
function CharacterController.IsMoving(self: typeof(CharacterController)): boolean
	return if self.Humanoid then self.Humanoid.MoveDirection.magnitude >= 0.1 else false
end

--[=[
   Check if the player is grounded.
   @return boolean --> return true if the player is on the ground.
]=]
function CharacterController.IsGrounded(self: typeof(CharacterController)): boolean
	return if self.Humanoid
		then self.Humanoid.FloorMaterial ~= Enum.Material.Air and self.Humanoid.FloorMaterial ~= Enum.Material.Water
		else false
end

--[=[
   Check if the player is on air.
   @return boolean --> returns true if the player is airborne.
]=]
function CharacterController.IsOnAir(self: typeof(CharacterController)): boolean
	return if self.Humanoid then self.Humanoid.FloorMaterial == Enum.Material.Air else false
end

--- Main ---
function CharacterController:Start()
	onCharacterAdded(localPlayer.Character or localPlayer.CharacterAdded:Wait())
	localPlayer.CharacterAdded:Connect(onCharacterAdded)
end

return CharacterController
