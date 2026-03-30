--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages

--- Requires ---
local React = require(packages.React)

local BuyMeACoffe = require(ReplicatedStorage.UI.Components.BuyMeACoffe.App)

--- Variables ---
local createElement = React.createElement

--- Elements ---
local function App()
	return createElement(React.Fragment, nil, {
		BuyMeACoffe = createElement(BuyMeACoffe, {}),
	})
end

return App
