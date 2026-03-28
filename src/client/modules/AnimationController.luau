--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--- Folders ---
local assets: Folder = ReplicatedStorage:WaitForChild("Assets")
local animations: Folder = assets:WaitForChild("Animations")

--- Players ---
local localPlayer = Players.LocalPlayer
local character: Model = localPlayer.Character or localPlayer.CharacterAdded:Wait()

--- Variables ---
local AnimationController = {}
AnimationController.Tracks = {} :: { [string]: { [string]: AnimationTrack } }

--- Private Methods ---
local function getAnimatorFromCharacter(targetCharacter: Model): Animator
	local animator: Animator? = targetCharacter:FindFirstChild("Animator", true)
	if not animator then
		warn("character doesn't have animator.")
		return
	end

	return animator
end

local function onCharacterAdded(newCharacter: Model)
	for _, animation in animations:QueryDescendants("Animation") do
		warn("[AnimationController]: Load animation", animation)
		AnimationController:LoadAnimation(newCharacter, animation.Parent.Name, animation)
	end
end

--- Public Methods ---

--[=[
   Loads an `Animation` onto an `Animator`.

   @param Model targetCharacter --> The character you want load into the `Animator`.
   @param string type --> A simple organization method.
   @param Animation animation --> The `Animation` you want to load.
]=]
function AnimationController.LoadAnimation(
	self: typeof(AnimationController),
	targetCharacter: Model,
	type: string,
	animation: Animation
): ()
	if not character or not type or not animation then
		return
	end

	local animator = getAnimatorFromCharacter(targetCharacter)
	if not animator then
		return
	end

	local track: AnimationTrack = animator:LoadAnimation(animation)

	self.Tracks[type] = AnimationController.Tracks[type] or {}
	self.Tracks[type][animation.Name] = track
end

--[=[
   Plays the `AnimationTrack`. Once called an `AnimationTrack` will play with the specified speed.

   @param string type --> A simple organization method.
   @param string animationName --> The name of the track you want to play.
   @param number? fadeTime --> time to interpolate the track.
   @param string? markerName --> MarkerReached name.
   @param ((value: string) -> ())? --> Called when MarkerReached.

   @return AnimationTrack
]=]
function AnimationController.PlayAnimation(
	self: typeof(AnimationController),
	type: string,
	animationName: string,
	fadeTime: number?,
	markerName: string?,
	callback: ((value: string) -> ())?
): AnimationTrack
	local track: AnimationTrack = self.Tracks[type] and self.Tracks[type][animationName]
	if not track then
		return
	end

	if markerName and callback then
		local connection: RBXScriptConnection = track:GetMarkerReachedSignal(markerName):Connect(callback)

		task.delay(track.Length + 0.1, function()
			connection:Disconnect()
		end)
	end

	track:Play(fadeTime)

	return track
end

--[=[
   Stops the `AnimationTrack`.

   @param string type --> A simple organization method.
   @param string animationName --> The name of the `AnimationTrack` you want stop.
]=]
function AnimationController.StopAnimation(self: typeof(AnimationController), type: string, animationName: string): ()
	local track: AnimationTrack = self.Tracks[type] and self.Tracks[type][animationName]
	if not track then
		return
	end

	track:Stop()
end

--- Main ---
function AnimationController:Start(): ()
	onCharacterAdded(character)
	localPlayer.CharacterAdded:Connect(onCharacterAdded)
end

return AnimationController :: typeof(AnimationController) & { read Start: nil, read Init: nil }
