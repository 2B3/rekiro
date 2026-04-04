--- Services ---
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages
local shared = ReplicatedStorage.Shared
local assets = ReplicatedStorage.Assets
local models = assets.Models

local combat = shared.Combat

--- Requires ---
local Packet = require(packages.Packet)
local Attack = require(combat.Skills.Attack)
local WCS = require(packages.WCS)

--- Variables ---
local CombatController = {}
CombatController.server = WCS.CreateServer()
CombatController.swords = {}

local toggleSheatheEvent = Packet("ToggleSheathe", Packet.Boolean8)
local characterClass = WCS.Character

--- Private Methods ---
local function weldSword(sword: Model, part: BasePart): Weld
	local handle = sword:FindFirstChild("Handle")
	if not handle then
		return
	end

	-- limpiar welds anteriores
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

local function onToggleSheathe(character: Model, value: boolean)
	local rightArm = character:FindFirstChild("Right Arm")
	local torso = character:FindFirstChild("Torso")
	if not rightArm or not torso then
		return
	end

	local sword = CombatController.swords[character]

	if not sword then
		sword = models.Katana:Clone()

		CombatController.swords[character] = sword
		sword.Parent = character
	end

	local handle = sword:FindFirstChild("Handle")
	if not handle then
		return
	end

	if value then
		local weld = weldSword(sword, torso)
		if weld then
			weld.C0 = CFrame.new(0.788, 0.837, -0.986) * CFrame.Angles(0, 90, 0)
		end
	else
		local weld = weldSword(sword, rightArm)
		if weld then
			weld.C0 = CFrame.new(0.025, 0.836, 0.106) * CFrame.Angles(0, -90, 0)
		end
	end
end

local function onCharacterAdded(characterModel)
	local wcsCharacter = characterClass.new(characterModel)

	--// Apply skill //--
	Attack.new(wcsCharacter)

	local humanoid = characterModel:WaitForChild("Humanoid") :: Humanoid
	humanoid.Died:Once(function()
		wcsCharacter:Destroy()
	end)

	onToggleSheathe(characterModel, true)
end

--- Public Methods ---

--[=[
	Register all needed directories.
]=]
function CombatController.loadDirectories(self: typeof(CombatController))
	self.server:RegisterDirectory(combat.Movesets)
	self.server:RegisterDirectory(combat.Skills)
	self.server:RegisterDirectory(combat.StatusEffect)
end

function CombatController.start(self: typeof(CombatController))
	self:loadDirectories()
	self.server:Start()

	Players.PlayerAdded:Connect(function(player: Player)
		player.CharacterAdded:Connect(onCharacterAdded)
	end)

	toggleSheatheEvent.OnServerEvent:Connect(function(player: Player, value: boolean)
		if not player.Character then
			return
		end
		onToggleSheathe(player.Character, value)
	end)
end

return CombatController
