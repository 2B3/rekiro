local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.Packages.React)

local function map<T>(sources: { [any]: T }, constructor: (child: T, index: any) -> any)
	local elements = {}

	for index, source in pairs(sources) do
		elements[index] = constructor(source, index)
	end

	return React.createElement(React.Fragment, nil, elements)
end

return map
