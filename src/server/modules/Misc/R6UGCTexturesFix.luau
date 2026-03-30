local InsertService = game:GetService("InsertService")
local Players = game:GetService("Players")

local AccesoryCache = {} :: { [number]: Part }

local ACCESORY_NAME_PREFIX = "%s %d"
local ACCESORIES_NAME = {
	"BackAccessory",
	"FaceAccessory",
	"FrontAccessory",
	"HairAccessory",
	"HatAccessory",
	"NeckAccessory",
	"ShouldersAccessory",
	"WaistAccessory",
}

local function LoadAccessory(id: number, character: Model, accesoryName: string)
	local accesoryFolder = character:FindFirstChild("Accesories")
	if not accesoryFolder then
		accesoryFolder = Instance.new("Folder")
		accesoryFolder.Parent = character
		accesoryFolder.Name = "Accesories"
	end

	if not character or not id then
		return
	end

	local fixAccesory = if AccesoryCache[id]
		then AccesoryCache[id]:Clone()
		else InsertService:LoadAsset(id):GetChildren()[1].Handle
	fixAccesory.Name = ACCESORY_NAME_PREFIX:format(accesoryName, id)
	fixAccesory.Parent = accesoryFolder

	if not AccesoryCache[id] then
		fixAccesory.CanCollide = false
		fixAccesory.CanQuery = false
		fixAccesory.CanTouch = false
		fixAccesory.Massless = true
	end

	local attachName = fixAccesory:FindFirstChildOfClass("Attachment").Name
	local attachOnBody = character:FindFirstChild(attachName, true)
	local attachPart = attachOnBody.Parent

	if not attachOnBody then
		return
	end

	fixAccesory.CFrame = attachOnBody.WorldCFrame * fixAccesory[attachName].CFrame:Inverse()

	local weld = Instance.new("WeldConstraint")
	weld.Name = "WeldAccesory"
	weld.Parent = fixAccesory
	weld.Part0 = fixAccesory
	weld.Part1 = attachPart

	AccesoryCache[id] = AccesoryCache[id] or fixAccesory:Clone()
end

local function onCharacterAppearanceLoaded(character: Model)
	local humanoid = character:WaitForChild("Humanoid", 20) :: Humanoid

	if not humanoid and humanoid.RigType ~= Enum.HumanoidRigType.R6 then
		return
	end

	local humaniodAppliedDesc = humanoid:GetAppliedDescription()
	humanoid:RemoveAccessories()

	for _, accesoryName: string in ACCESORIES_NAME do
		local accesoryDesc = tostring(humaniodAppliedDesc[accesoryName])

		if accesoryDesc == nil then
			return
		end

		for _, id: number in accesoryDesc:split(",") do
			LoadAccessory(tonumber(id) :: number, character, accesoryName)
		end
	end
end

local function onPlayerAdded(player: Player)
	player.CharacterAppearanceLoaded:Connect(onCharacterAppearanceLoaded)
end

local function init()
	Players.PlayerAdded:Connect(onPlayerAdded)
	for _, player in Players:GetPlayers() do
		task.spawn(onPlayerAdded, player)
	end
end

return {
	Init = init,
}
