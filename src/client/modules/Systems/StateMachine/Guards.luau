--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local Attack = require(ReplicatedStorage.Shared.Combat.Skills.Attack)

local _Context = require(script.Parent.Context)

--- Variables ---
local guards = {}

--- Types ---
type Context = typeof(_Context)

--- Definition ---
function guards.isGrounded(ctx: Context): boolean
	return ctx.components.character:isGrounded()
end

function guards.isMoving(ctx: Context): boolean
	return ctx.components.character:isMoving()
end

function guards.isReady(ctx: Context): boolean
	return ctx.components.character:isReady()
end

function guards.wantsToRun(ctx: Context): boolean
	return ctx.components.input:isKeyDown("LeftShift")
end

function guards.canRun(ctx: Context): boolean
	return if guards.isReady(ctx) --[[ Character exist for the initial dash ]]
			and guards.wantsToRun(ctx) --[[ RunKey is held down ]]
			and guards.isGrounded(ctx)
			and guards.isMoving(ctx)
		then true
		else false
end

function guards.canAttack(ctx: Context)
	if not guards.isReady(ctx) then
		return
	end

	local characterWCS = ctx.components.combat:getWCSCharacter()
	return characterWCS:GetSkillFromConstructor(Attack):ShouldStart()
end

-- --- Negate guards ---
-- for name: index<typeof(guards), keyof<typeof(guards)>>, func: (() -> ()) in pairs(guards) do
-- 	guards[`!{name}`] = function(...)
-- 		return not func(...)
-- 	end
-- end

return guards
