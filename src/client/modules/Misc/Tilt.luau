--- Services ---
local Runtime = game:GetService("RunService")
local Players = game:GetService("Players")

--- Player ---
local localPlayer = Players.LocalPlayer
local Character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

local root = Character:WaitForChild("HumanoidRootPart")
local humanoid = Character:WaitForChild("Humanoid")
local rootJoint = root:WaitForChild("RootJoint")

local c0 = rootJoint.C0

--- Variables ---
local leanCFrame = CFrame.new()

local Tilt = {}

--- Private Methods ---
function onCharacterAdded(NewCharacter: Model)
	Character = NewCharacter
	root = Character:FindFirstChild("HumanoidRootPart")
	humanoid = Character:FindFirstChild("Humanoid")
	rootJoint = root:FindFirstChild("RootJoint")
	c0 = rootJoint.C0

	root.CanCollide = false
end

local function onStepped(dt: number)
	if not rootJoint or not humanoid then
		return
	end

	local MoveDirection = root.CFrame:VectorToObjectSpace(humanoid.MoveDirection)

	leanCFrame = leanCFrame:Lerp(
		CFrame.Angles(math.rad(-MoveDirection.Z) * 8, math.rad(-MoveDirection.X) * 8, 0),
		0.2 ^ (1 / (dt * 60))
	)
	rootJoint.C0 = c0 * leanCFrame
end

--- Main ---
function Tilt:Start()
	localPlayer.CharacterAdded:Connect(onCharacterAdded)
	Runtime.RenderStepped:Connect(onStepped)
end

return Tilt
