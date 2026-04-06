local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Refx = require(ReplicatedStorage.Packages.Refx)

local BladeTrail = Refx.CreateEffect("BladeTrail")

function BladeTrail:OnStart(_: typeof(BladeTrail))
	print("Start Effect")
end

function BladeTrail:OnConstruct()
	print("OnConstruct")
end

return BladeTrail
