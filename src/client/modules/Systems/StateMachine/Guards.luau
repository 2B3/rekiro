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

function guards.wantsSprint(ctx: Context): boolean
	return ctx.components.input:isKeyDown("LeftShift")
end

function guards.isAttacking(ctx: Context)
	local characterWCS = ctx.components.combat:getWCSCharacter()
	local activeSkills = characterWCS:GetAllActiveSkills()

	return #activeSkills > 1
end

function guards.isSprintCD(ctx: Context)
	return os.clock() - (ctx.lastSprint or 0) < 0.85
end

function guards.canSprint(ctx: Context)
	return if guards.isReady(ctx)
			and guards.isGrounded(ctx)
			and guards.isMoving(ctx)
			and guards.wantsSprint(ctx)
			and not guards.isAttacking(ctx)
			and not guards.isSprintCD(ctx)
		then true
		else false
end

function guards.canRunning(ctx: Context)
	return if guards.isReady(ctx)
			and guards.isGrounded(ctx)
			and guards.isMoving(ctx)
			and guards.wantsSprint(ctx)
			and not guards.isAttacking(ctx)
		then true
		else false
end

function guards.canAttack(ctx: Context)
	return if guards.isReady(ctx) and not guards.wantsSprint(ctx) and not guards.isAttacking(ctx) then true else false
end

-- --- Negate guards ---
-- for name: index<typeof(guards), keyof<typeof(guards)>>, func: (() -> ()) in pairs(guards) do
-- 	guards[`!{name}`] = function(...)
-- 		return not func(...)
-- 	end
-- end

return guards
