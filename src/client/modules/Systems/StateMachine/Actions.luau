--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local Events = require(ReplicatedStorage.Shared.Events)
local _Context = require(script.Parent.Context)

--- Variables ---
local toggleSheatheEvent = Events.toggleSheathe

local actions = {}

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

	ctx.lastEquip = os.clock()
end

function actions.startSprintCD(ctx: Context)
	ctx.lastSprint = os.clock()
end

return actions
