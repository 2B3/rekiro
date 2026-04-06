--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages
local combat = ReplicatedStorage.Shared.Combat

--- Requires ---
local Melee = require(combat.Skills.Melee)
local WCS = require(packages.WCS)

--- Moveset ---
return WCS.CreateMoveset("Default", { Melee })
