local ENABLED = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(script.Parent.StateMachine)
local Iris = require(ReplicatedStorage.Packages.Iris)

local module = {}

local function renderNode(node)
	Iris.Tree({ node.id })

	Iris.Text({ `type: {node.type}` })
	Iris.Text({ `active: {tostring(node.active)}` })

	if node.events then
		Iris.Tree({ "events" })

		for name in node.events do
			Iris.Text({ name })
		end

		Iris.End()
	end

	if node.states then
		Iris.Tree({ "states" })

		for _, child in node.states do
			renderNode(child)
		end

		Iris.End()
	end

	Iris.End()
end

function module:Start()
	Iris = Iris.Init()

	Iris:Connect(function()
		Iris.Window({ "debug" })

		-- if Iris.Button({ "update_state_machine" }).clicked() then
		-- 	datamodel = StateMachine.datamodel
		-- end

		local datamodel = StateMachine.datamodel

		if datamodel then
			renderNode(datamodel)
		end

		Iris.End()
	end)
end

return if ENABLED then module else {}
