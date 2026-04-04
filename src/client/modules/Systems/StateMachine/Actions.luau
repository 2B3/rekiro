--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages

--- Requires ---
local Packet = require(packages.Packet)
local _Context = require(script.Parent.Context)

local actions = {}
local toggleSheatheEvent = Packet("ToggleSheathe", Packet.Boolean8)

--- Types ---
type Context = typeof(_Context)

--- Definitions ---
function actions.unequip(ctx: Context)
	local animation = ctx.components.animation

	local track = animation:playAnimation("combat", "unsheathed", 0.075, "sheathe", function()
		toggleSheatheEvent:Fire(true)
	end)
	track.TimePosition = track.Length - 0.001
	track:AdjustSpeed(-1)
end

function actions.equip(ctx: Context)
	local animation = ctx.components.animation

	animation:playAnimation("combat", "unsheathed", 0.075, "sheathe", function()
		toggleSheatheEvent:Fire(false)
	end)
end

return actions
