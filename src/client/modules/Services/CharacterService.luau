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
local CharacterService = {}
CharacterService.characterReady = signal()

--- Private Methods ---
local function updateCharacterReferences(character: Model)
	CharacterService.Character = character

	CharacterService.HumanoidRootPart = character and character:WaitForChild("HumanoidRootPart") :: BasePart
	CharacterService.Humanoid = character and character:WaitForChild("Humanoid") :: Humanoid

	CharacterService.RootAttachment = CharacterService.HumanoidRootPart
		and CharacterService.HumanoidRootPart:WaitForChild("RootAttachment") :: Attachment
	CharacterService.Animator = CharacterService.Humanoid
		and CharacterService.Humanoid:WaitForChild("Animator") :: Animator
end

local function onCharacterAdded(character: Model)
	updateCharacterReferences(character)
	CharacterService.characterReady:Fire()
end

--- Public Methods ---

--[=[
	Check if character references exist.
	@return boolean --> return true if character references exist.
]=]
function CharacterService:isReady(): boolean
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
function CharacterService:setWalkSpeed(walkSpeed: number)
	if not self.Humanoid then
		warn("[CharacterService]: Humaniod not found.")
		return
	end

	self.Humanoid.WalkSpeed = walkSpeed
end

--[=[
	Set the humanoid jump height speed in studs.
	@param jumpHeight number --> jump height in studs.
	]=]
function CharacterService:setJumpHeight(jumpHeight: number)
	if not self.Humanoid then
		warn("[CharacterService]: Humaniod not found.")
		return
	end

	self.Humanoid.JumpHeight = jumpHeight
end

--[=[
	Returns the move vector provided by the Control PlayerModule.
	@return Vector3 --> normalizated move vector.
	]=]
function CharacterService:getMoveVector(): Vector3
	return Control:GetMoveVector()
end

--[=[
	Returns the assembly mass of all parts into the character.
	@return Vector3 --> assembly mass. 
]=]
function CharacterService.getAssemblyMass(self: typeof(CharacterService))
	if not self:isReady() then
		warn("Can't get the character assembly mass, character is not ready")
		return
	end

	local mass = 0
	for _, part in self.Character:GetDescendants() do
		if part:IsA("BasePart") and not part.Massless then
			mass += part.AssemblyMass
		end
	end

	return mass
end

--[=[
	Returns the assembly mass of all parts into the character.
	@return Vector3 --> assembly mass. 
]=]
function CharacterService.getMass(self: typeof(CharacterService))
	if not self:isReady() then
		warn("Can't get the character mass, character is not ready")
		return
	end

	local mass = 0
	for _, part in self.Character:GetDescendants() do
		if part:IsA("BasePart") and not part.Massless then
			mass += part:GetMass()
		end
	end

	return mass
end

--[=[
	Check if the player is moving.
	@return boolean --> return true if the player is moving.
]=]
function CharacterService.isMoving(self: typeof(CharacterService)): boolean
	return if self.Humanoid then self.Humanoid.MoveDirection.magnitude >= 0.1 else false
end

--[=[
   Check if the player is grounded.
   @return boolean --> return true if the player is on the ground.
]=]
function CharacterService.isGrounded(self: typeof(CharacterService)): boolean
	return if self.Humanoid
		then self.Humanoid.FloorMaterial ~= Enum.Material.Air and self.Humanoid.FloorMaterial ~= Enum.Material.Water
		else false
end

--[=[
   Check if the player is on air.
   @return boolean --> returns true if the player is airborne.
]=]
function CharacterService.isOnAir(self: typeof(CharacterService)): boolean
	return if self.Humanoid then self.Humanoid.FloorMaterial == Enum.Material.Air else false
end

--- Main ---
function CharacterService:start()
	onCharacterAdded(localPlayer.Character or localPlayer.CharacterAdded:Wait())
	localPlayer.CharacterAdded:Connect(onCharacterAdded)
end

return CharacterService
