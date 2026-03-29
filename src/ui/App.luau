local ReplicatedStorage = game:GetService("ReplicatedStorage")

local packages = ReplicatedStorage.Packages

local React = require(packages.React)

local createElement = React.createElement

local function App()
	return createElement(React.Fragment)
end

return App
