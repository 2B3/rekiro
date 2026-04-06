--[=[ 
   Effects Controller

   TODO:
      - Error using Refx Effects and wally-package-types with the next gen roblox typechecker
]=]

--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local shared = ReplicatedStorage.Shared
local effects = shared.Effects

--- Requires ---
local Refx = require(ReplicatedStorage.Packages.Refx)

--- Variables ---
local EffectController = {}

--- Public Methods ---
function EffectController:start()
	Refx.Register(effects)
	Refx.Start()
end

return EffectController
