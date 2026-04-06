--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local clientServices = clientModules.Services

local packages = ReplicatedStorage.Packages
local shared = ReplicatedStorage.Shared

local combat = shared.Combat

--- Requires ---

--// Shared //--
local BladeTrail = require(shared.Effects.BladeTrail)
local AttackEffect = require(combat.StatusEffect.Attack)
local WCS = require(packages.WCS)

local ShapecastHitbox = require(packages.ShapecastHitbox)

local MeleeSettings = require(shared.Constants.Skills.Melee)

local Events = require(shared.Events)

--// Client //--
local AnimationService = RunService:IsClient() and require(clientServices.AnimationService)

--// Server //--
local CombatService = RunService:IsServer() and require(ServerStorage.ModulesServer.Services.CombatService)

--- Variables ---
local Melee = WCS.RegisterSkill("Melee") :: typeof(WCS.RegisterSkill()) & {
	CurrentMelee: number,
	LastMelee: number,
	MaxCombo: number,
}

--- Types ---
export type Self = typeof(Melee)

--- Private Methods ---
local function onHit(hitResult: RaycastResult)
	local adornee = Instance.new("SphereHandleAdornment")
	adornee.CFrame = CFrame.new(hitResult.Position)

	adornee.Color3 = Color3.fromHex("ff0000")
	adornee.Transparency = 0.5
	adornee.Radius = 0.5

	adornee.Adornee = workspace.Terrain
	adornee.Parent = workspace

	task.delay(0.5, game.Destroy, adornee)
end

local function dash(character: Model, force: number, velocity: Vector3, duration: number)
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then
		return
	end

	---// Instancializate linearVelocity //--
	local linearVelocity = Instance.new("LinearVelocity")

	linearVelocity.Attachment0 = root:FindFirstChild("RootAttachment")
	linearVelocity.Parent = character

	linearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
	linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
	linearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis

	linearVelocity.MaxAxesForce = Vector3.zAxis * force
	linearVelocity.VectorVelocity = velocity

	task.delay(duration, game.Destroy, linearVelocity)
end

local function getSword(): Model
	local sword = Events.getSword:Fire()
	if not sword then
		warn("Sword not provided.")
		return
	end

	return sword
end

--- Extended Public Methods ---
function Melee.OnConstructServer(self: Self)
	self.ResetDuration = 1.5
	self.CurrentCombo = 1
	self.LastMelee = 0
	self.MaxCombo = 5
end

function Melee.OnConstructClient(self: Self)
	local characterModel = self.Character.Instance

	--// Sword //--
	local sword = getSword()
	local hitPart = sword and sword:FindFirstChild("Hitbox")
	if not sword or not hitPart then
		return
	end

	--// Hitbox //--
	local function onHitboxReached(markedName: string, i: number)
		local enabled = markedName == "enable"

		self:toggleHitbox(enabled)
		if enabled then
			local dashData = MeleeSettings.Combos[i].Dash

			dash(characterModel, 30_000, dashData.Velocity, dashData.Duration)
		end
	end

	for i = 1, #MeleeSettings.Combos do
		AnimationService:getTrack("combat", "attack_" .. i)
			:GetMarkerReachedSignal("hitbox")
			:Connect(function(markedName: string)
				onHitboxReached(markedName, i)
			end)
	end

	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { characterModel, sword }

	local hitbox = ShapecastHitbox.new(hitPart, raycastParams)
	hitbox:OnHit(onHit)

	self.Hitbox = hitbox
end

function Melee.OnStartServer(self: Self)
	if self.LastMelee + self.ResetDuration > os.clock() then
		self.CurrentCombo = (self.CurrentCombo % self.MaxCombo) + 1
	else
		self.CurrentCombo = 1
	end

	local duration = MeleeSettings.Combos[self.CurrentCombo].Duration
	self.LastMelee = os.clock()

	local sword = CombatService:getSword(self.Character.Instance)
	BladeTrail.new(sword):Start(Players:GetPlayers())

	AttackEffect.new(self.Character):Start(duration)
	self:ApplyCooldown(duration)

	task.wait(duration) --> Yield the code after start
end

function Melee.OnStartClient(self: Self)
	task.defer(function()
		local success, combo = self:getCombo():await()
		if not success then
			warn("Unknow error, something wrong with combo.")
			return
		end

		local track = AnimationService:getTrack("combat", "attack_" .. combo)
		track:Play(0.3, combo)
	end)
end

--- Public Methods ---
function Melee.toggleHitbox(self: Self, enabled: boolean)
	self.Hitbox[if enabled then "HitStart" else "HitStop"](self.Hitbox)
end

function Melee.getCombo(self: Self)
	return self.CurrentCombo :: number
end

--- Messages ---
WCS.DefineMessage(Melee.toggleHitbox, {
	Type = "Event",
	Destination = "Client",
})

WCS.DefineMessage(Melee.getCombo, {
	Type = "Request",
	Destination = "Server",
})

return Melee
