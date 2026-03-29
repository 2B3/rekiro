--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

--- Folders ---
local modulesClient = ReplicatedStorage.ModulesClient

--- Requires ---
local CharacterController = require(modulesClient.CharacterController)
local AnimationController = require(modulesClient.AnimationController)

--- Variables ---
local AXES_FORCE = Vector3.zAxis * 4000

local INITIAL_ACCELERATION = 45
local ACCELERATION = 50

--- Definition ---
local sprintRunning = {

	janitor = true,

	event = {
		land = { { target = "regularRunning", guards = { "isMoving" } }, { target = "idle" } },
	},

	OnEntry = function(context)
		---// Instancializate linearVelocity //--
		local linearVelocity = Instance.new("LinearVelocity")

		linearVelocity.Attachment0 = CharacterController.RootAttachment
		linearVelocity.Parent = CharacterController.Character

		linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
		linearVelocity.ForceLimitMode = Enum.ForceLimitMode.PerAxis

		linearVelocity.VectorVelocity = -Vector3.zAxis * INITIAL_ACCELERATION
		linearVelocity.MaxAxesForce = AXES_FORCE

		linearVelocity.Enabled = false

		context.janitor:Add(linearVelocity)

		--// Call when sprint mark reached. //--
		local function dash(): ()
			linearVelocity.Enabled = true

			local conn: RBXScriptConnection = RunService.RenderStepped:Connect(function(dt: number): ()
				local nextVelocity = linearVelocity.VectorVelocity + Vector3.zAxis * dt * ACCELERATION

				if nextVelocity.Magnitude >= 0 then
					linearVelocity.VectorVelocity = Vector3.zero
				end

				linearVelocity.VectorVelocity = nextVelocity
			end)

			context.janitor:Add(conn, "Disconnect")
		end

		--// Play animation //--
		AnimationController:PlayAnimation("Movement", "SprintRunning", 0.1, "running_sprint", dash)

		--// Await and transite to the regular state //--
		task.wait(0.65)
		context.Send("land")
	end,
}

return sprintRunning
