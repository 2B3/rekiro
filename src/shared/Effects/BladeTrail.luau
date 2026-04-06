--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local Refx = require(ReplicatedStorage.Packages.Refx)

--- Variables ---
local BladeTrail = Refx.CreateEffect("BladeTrail")

--- Types ---
type Self = typeof(BladeTrail) & {
	Sword: Model?,
	Trail: Trail?,

	DestroyOnEnd: true?,
	MaxLifetime: number?,
}

--- Public Methods ---
function BladeTrail.OnStart(self: Self)
	local trail = (self.Sword :: Model):FindFirstChild("BladeTrail", true) :: Trail?
	self.Trail = trail

	if trail and trail:IsA("Trail") then
		trail.Enabled = true

		local wantsEnable = self.Trail:GetAttribute("WantsEnable")
		self.Trail:SetAttribute("WantsEnable", (wantsEnable or 0) + 1)
	end
end

function BladeTrail.OnDestroy(self: Self)
	local duration = self.MaxLifetime

	task.delay(duration, function()
		if not self.Trail then
			return
		end

		local wantsEnable = self.Trail:GetAttribute("WantsEnable") :: number?

		self.Trail.Enabled = if (wantsEnable - 1) >= 1 then true else false
		self.Trail:SetAttribute("WantsEnable", (wantsEnable or 1) - 1)
	end)
end

function BladeTrail.OnConstruct(self: Self, sword: Model)
	self.MaxLifetime = 0.8

	self.Sword = sword
end

return BladeTrail
