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
local AnimationService = {}
AnimationService.tracks = {} :: { [string]: { [string]: AnimationTrack } }

local DEFAULT_FADE_TIME = 0.2

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
		AnimationService:loadAnimation(newCharacter, animation.Parent.Name, animation)
	end
end

--- Public Methods ---

--[=[
   Loads an `Animation` onto an `Animator`.

   @param Model targetCharacter --> The character you want load into the `Animator`.
   @param string type --> A simple organization method.
   @param Animation animation --> The `Animation` you want to load.
]=]
function AnimationService.loadAnimation(
	self: typeof(AnimationService),
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

	self.tracks[type] = AnimationService.tracks[type] or {}
	self.tracks[type][animation.Name] = track
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
function AnimationService.playAnimation(
	self: typeof(AnimationService),
	type: string,
	animationName: string,
	fadeTime: number?,
	markerName: string?,
	callback: ((value: string) -> ())?
): AnimationTrack
	local track: AnimationTrack = self.tracks[type] and self.tracks[type][animationName]
	if not track then
		return
	end

	if markerName and callback then
		local connection: RBXScriptConnection = track:GetMarkerReachedSignal(markerName):Connect(callback)

		task.delay(track.Length + 0.1, function()
			connection:Disconnect()
		end)
	end

	track:Play(fadeTime or DEFAULT_FADE_TIME)

	return track
end

--[=[
   Stops the `AnimationTrack`.

   @param string type --> A simple organization method.
   @param string animationName --> The name of the `AnimationTrack` you want stop.
	@param number? fadeTime --> time to interpolate the track.
]=]
function AnimationService.stopAnimation(
	self: typeof(AnimationService),
	type: string,
	animationName: string,
	fadeTime: number?
): ()
	local track: AnimationTrack = self.tracks[type] and self.tracks[type][animationName]
	if not track then
		return
	end

	track:Stop(fadeTime or DEFAULT_FADE_TIME)
end

--- Main ---
function AnimationService:start(): ()
	onCharacterAdded(character)
	localPlayer.CharacterAdded:Connect(onCharacterAdded)
end

return AnimationService
