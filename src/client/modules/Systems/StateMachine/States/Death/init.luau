--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

--- Definition ---
local death: Types.StateNode = {
	OnEntry = function()
		print(`[{script.Name}]: Entry.`)
	end,
}

return death
