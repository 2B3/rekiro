--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

--- Variables ---
local AXES_FORCE = Vector3.zAxis * 4000

local INITIAL_ACCELERATION = 45
local DASH_DURATION = 2 / 3

--- Definition ---
local dashing: Types.StateNode = {
	janitor = true,

	OnEntry = function(ctx)
		ctx.components.animation:playAnimation("movement", "dashing_front")

		---// Instancializate linearVelocity //--
		local linearVelocity = Instance.new("LinearVelocity")

		linearVelocity.Attachment0 = ctx.character.RootAttachment
		linearVelocity.Parent = ctx.character.Character

		linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		linearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis

		linearVelocity.VectorVelocity = -Vector3.zAxis * INITIAL_ACCELERATION
		linearVelocity.MaxAxesForce = AXES_FORCE

		ctx.janitor:Add(linearVelocity)

		--// After dash duration, change to the best state //--
		task.wait(DASH_DURATION)
		ctx.Send("stopDashing")
	end,

	events = {
		stopDashing = {
			{ target = "running", guards = { "canRun" } } :: Types.Event,
			{ target = "walking", guards = { "isMoving" } } :: Types.Event,
			{ target = "idle" } :: Types.Event,
		},
	},
}

return dashing
