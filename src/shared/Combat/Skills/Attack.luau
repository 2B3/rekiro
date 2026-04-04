--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- local ServerStorage = game:GetService("ServerStorage")

--- Folders ---

-- local serverModules = ServerStorage:FindFirstChild("ModulesServer")
-- local serverServices = serverModules:FindFirstChild("Services")

local clientModules = ReplicatedStorage.ModulesClient
local clientServices = clientModules.Services

local packages = ReplicatedStorage.Packages

--- Requires ---
local WCS = require(packages.WCS)

--- Variables ---
local Attack = WCS.RegisterSkill("Attack")

--- Public Methods ---
function Attack:OnStartServer()
	task.wait(1)
	self:ApplyCooldown(3)
end

function Attack:OnStartClient()
	local AnimationService = require(clientServices.AnimationService)

	AnimationService:playAnimation("combat", "attack_1").Ended:Wait()
	task.wait(3)
end

return Attack
