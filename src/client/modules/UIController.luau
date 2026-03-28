--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--- Folders ---
local packages = ReplicatedStorage.Packages

--- Dependencies ---
local React = require(packages.React)
local ReactRoblox = require(packages.ReactRoblox)
local App = require(ReplicatedStorage.UI.App)

--- Player ---
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer.PlayerGui

--- Variables ---
local UIController = {}

--- Types ---
type Root = typeof(ReactRoblox.createRoot(Instance.new("ScreenGui")))

--- Private Methods ---
local function createRoot(): Root
	local rootScreen = Instance.new("ScreenGui")
	rootScreen.Name = "ReactRootScreen"
	rootScreen.Parent = playerGui

	rootScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	rootScreen.ClipToDeviceSafeArea = false
	rootScreen.IgnoreGuiInset = true
	rootScreen.ResetOnSpawn = false

	return ReactRoblox.createRoot(rootScreen)
end

--- Public Methods ---
function UIController:RenderApp()
	local app = React.createElement(App)
	local root = createRoot()

	root:render(app)
end

--- Main ---
function UIController:Start()
	self:RenderApp()
end

return UIController
