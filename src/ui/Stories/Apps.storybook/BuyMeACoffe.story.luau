local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)
local App = require(ReplicatedStorage.UI.Components.BuyMeACoffe.App)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)

local controls = {
	visible = true,
}

local story = {
	react = React,
	reactRoblox = ReactRoblox,
	controls = controls,

	story = function(props)
		return React.createElement(App, props.controls)
	end,
}

return story
