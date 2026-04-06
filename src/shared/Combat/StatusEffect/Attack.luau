--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages

--- Requires ---
local WCS = require(packages.WCS)

local MovementBase = WCS.RegisterStatusEffect("Attack")

function MovementBase:OnStartClient()
	self:SetHumanoidData({
		WalkSpeed = { 2, "Set" },
		JumpHeight = { 0, "Set" },
	}, 100)
end

return MovementBase
