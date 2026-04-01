--- Requires ---
local _Context = require(script.Parent.Context)

--- Variables ---
local guards = {}

--- Types ---
type Context = typeof(_Context)

--- Definition ---
function guards.isGrounded(ctx: Context): boolean
	return ctx.character:isGrounded()
end

function guards.isMoving(ctx: Context): boolean
	return ctx.character:isMoving()
end

function guards.isReady(ctx: Context): boolean
	return ctx.character:isReady()
end

function guards.wantsToRun(ctx: Context): boolean
	return ctx.input:isKeyDown("LeftShift")
end

function guards.canRun(ctx: Context): boolean
	return if guards.isReady(ctx) --[[ Character exist for the initial dash ]]
			and guards.isMoving(ctx) --[[ if the player is moving ]]
			and guards.wantsToRun(ctx) --[[ RunKey is held down ]]
		then true
		else false
end

-- --- Negate guards ---
-- for name: index<typeof(guards), keyof<typeof(guards)>>, func: (() -> ()) in pairs(guards) do
-- 	guards[`!{name}`] = function(...)
-- 		return not func(...)
-- 	end
-- end

return guards
