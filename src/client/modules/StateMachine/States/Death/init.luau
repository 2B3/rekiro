--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient

--- Requires ---
local Types = require(clientModules.StateMachine.Types)

--- Definition ---
local death: Types.StateNode = {
	OnEntry = function()
		print(`[{script.Name}]: Entry.`)
	end,
}

return death
