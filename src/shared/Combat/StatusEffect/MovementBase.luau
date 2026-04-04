--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages

--- Requires ---
local WCS = require(packages.WCS)

local MovementBase = WCS.RegisterStatusEffect("MovementBase")

function MovementBase.OnStartServer(self: typeof(MovementBase)) end

return MovementBase
