--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local systems = clientModules.Systems

--- Requires ---
local Types = require(systems.StateMachine.Types)

--- Variables ---
local DIRECTION = -Vector3.zAxis

local RELATIVE_FORCE: number = 30000
local VELOCITY = 28

local DASH_DURATION = 0.4

--- Definition ---
local dashing: Types.StateNode = {
	janitor = true,

	OnEntry = function(ctx)
		local character = ctx.components.character
		local animation = ctx.components.animation

		animation:playAnimation("movement", "dashing_front")
		character:setJumpHeight(0)

		---// Instancializate linearVelocity //--
		local linearVelocity = Instance.new("LinearVelocity")

		linearVelocity.Attachment0 = character.RootAttachment
		linearVelocity.Parent = character.Character

		linearVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
		linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		linearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis

		linearVelocity.MaxAxesForce = Vector3.zAxis * RELATIVE_FORCE
		linearVelocity.VectorVelocity = DIRECTION * VELOCITY

		ctx.janitor:Add(linearVelocity)

		--// Disable falling down state when running //--
		ctx.janitor:Add(RunService.RenderStepped:Connect(function()
			character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		end))

		--// After dash duration, change to the best state //--
		ctx.janitor:Add(task.delay(DASH_DURATION, ctx.Send, "stopDashing"))
	end,

	OnExit = function(ctx)
		local animation = ctx.components.animation

		animation:stopAnimation("movement", "dashing_front")
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
