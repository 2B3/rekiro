local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages
local shared = ReplicatedStorage.Shared
local assets = ReplicatedStorage.Assets
local models = assets.Models

local combat = shared.Combat

--- Requires ---
local _MovementBase = require(combat.StatusEffect.MovementBase)
local WCS = require(packages.WCS)

--- Variables ---
local CombatService = {}
CombatService.server = WCS.CreateServer()

CombatService.movementBaseEffect = {} :: { [Model]: typeof(_MovementBase) }

CombatService.swords = {} :: {
	[Model]: Model,
}

local sheateCFrame = {
	[true] = CFrame.new(0.788, 0.837, -0.986) * CFrame.Angles(0, 90, 0),
	[false] = CFrame.new(0.025, 0.836, 0.106) * CFrame.Angles(0, -90, 0),
}

--- Private Methods ---
local function weldSword(sword: Model, part: BasePart): Weld
	local handle = sword:FindFirstChild("Handle")
	if not handle then
		return
	end

	for _, v in handle:GetChildren() do
		if v:IsA("Weld") then
			v:Destroy()
		end
	end

	local weld = Instance.new("Weld")
	weld.Part0 = handle
	weld.Part1 = part
	weld.Parent = handle

	return weld
end

--- Public Methods ---
function CombatService:toggleSheathe(character: Model, value: boolean)
	local rightArm = character:FindFirstChild("Right Arm")
	local torso = character:FindFirstChild("Torso")
	if not rightArm or not torso then
		return
	end

	local sword = self:getSword(character)
	sword.Parent = if value then torso else rightArm

	local weld = weldSword(sword, if value then torso else rightArm)
	weld.C0 = sheateCFrame[value]
end

function CombatService:getSword(character: Model)
	local sword = self.swords[character]

	if not sword then
		sword = models.Katana:Clone()
		self.swords[character] = sword
	end

	return sword
end

--[=[
	Register all needed directories.
]=]
function CombatService.loadDirectories(self: typeof(CombatService))
	self.server:RegisterDirectory(combat.Movesets)
	self.server:RegisterDirectory(combat.Skills)
	self.server:RegisterDirectory(combat.StatusEffect)
end

return CombatService
