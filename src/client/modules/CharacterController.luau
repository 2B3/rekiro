--- Services ---
local Players = game:GetService("Players")

--- Player ---
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

local Control = require(localPlayer.PlayerScripts:WaitForChild("PlayerModule").ControlModule :: ModuleScript)

local CharacterController = {}

local function onCharacterAdded(newCharacter: Model)
	character = newCharacter

	CharacterController.HumanoidRootPart = character and character:WaitForChild("HumanoidRootPart") :: BasePart
	CharacterController.Humanoid = character and character:WaitForChild("Humanoid") :: Humanoid

	CharacterController.RootAttachment = CharacterController.HumanoidRootPart
		and CharacterController.HumanoidRootPart:WaitForChild("RootAttachment") :: Attachment
	CharacterController.Animator = CharacterController.Humanoid
		and CharacterController.Humanoid:WaitForChild("Animator") :: Animator
end

--- Public Methods ---

--[=[
	Set the humanoid maximum movement speed in studs per second.
	@param number --> maximun movement speed in studs/s
]=]
function CharacterController:SetWalkSpeed(walkSpeed: number)
	if not self.Humanoid then
		return
	end

	self.Humanoid.WalkSpeed = walkSpeed
end

--[=[
	Set the humanoid jump height speed in studs.
	@param number --> jump height in studs.
]=]
function CharacterController:SetJumpHeight(jumpHeight: number)
	if not self.Humanoid then
		return
	end

	self.Humanoid.JumpHeight = jumpHeight
end

--[=[
	Return the move vector provided by the Control PlayerModule.
	@return Vector3 --> Normalizated MoveVector.
	]=]
function CharacterController:GetMoveVector(): Vector3
	return Control:GetMoveVector()
end

--[=[
	Check if the player is moving.
	@return Boolean --> Return true if the player is moving.
]=]
function CharacterController.IsMoving(self: typeof(CharacterController)): boolean
	return if self.Humanoid then self.Humanoid.MoveDirection.magnitude >= 0.1 else false
end

--[=[
   Check if the player is grounded.
   @return Boolean --> Return true if the player is grounded.
]=]
function CharacterController.IsGrounded(self: typeof(CharacterController)): boolean
	return if self.Humanoid then self.Humanoid.FloorMaterial ~= Enum.Material.Air else false
end

--[=[
   Check if the player is on air.
   @return Boolean --> Return true if the player is on the air.
]=]
function CharacterController.IsOnAir(self: typeof(CharacterController)): boolean
	return if self.Humanoid then self.Humanoid.FloorMaterial == Enum.Material.Air else false
end

--- Main ---
function CharacterController:Start()
	localPlayer.CharacterAdded(onCharacterAdded)
end

return CharacterController :: typeof(CharacterController) & { read Start: nil }
