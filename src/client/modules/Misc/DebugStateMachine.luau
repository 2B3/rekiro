local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local CharacterController = require(ReplicatedStorage.ModulesClient.Controllers.CharacterController)
local StateMachine = require(ReplicatedStorage.ModulesClient.StateMachine)
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local Janitor = require(ReplicatedStorage.Packages.Janitor)
local fragmentMap = require(ReplicatedStorage.UI.Utils.fragmentMap)

local DebugStateMachine = {}

local createElement = React.createElement
local useState = React.useState
local useEffect = React.useEffect

local function App()
	local data, setData = useState({})

	useEffect(function()
		local updateConn = RunService.RenderStepped:Connect(function()
			setData(StateMachine.value and StateMachine.value[1] or data)
			-- print(StateMachine.value)
		end)

		return function()
			updateConn:Disconnect()
		end
	end, {})

	local function Value(props: { name: string, value: any, layoutOrder: number })
		if not props.value then
			return
		end

		return createElement("TextLabel", {
			TextColor3 = Color3.fromHex("fcfd00"),
			Text = `{props.name}:<br/>{props.value}<br/>`,
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundTransparency = 1,
			Size = UDim2.new(),
			RichText = true,
			LayoutOrder = props.layoutOrder,
		}, {

			Stroke = createElement("UIStroke", {}),
		})
	end

	local content = data.events or {}
	if data.type and data.type == "atomic" then
		for i, v in data.parent.events or {} do
			content["parent_" .. i] = v
		end
	end

	return createElement(React.Fragment, nil, {
		Layout = createElement("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Bottom,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		Active = createElement(Value, {
			name = "active",
			value = data.active,
			LayoutOrder = 1,
		}),

		Id = createElement(Value, {
			name = "id",
			value = data.id,
			LayoutOrder = 2,
		}),

		Parent = createElement(Value, {
			name = "parent",
			value = data.parent and data.parent.id,
			LayoutOrder = 3,
		}),

		Content = fragmentMap(content, function(child, index)
			return createElement(Value, {
				name = index,
				value = child,
				key = index,
				LayoutOrder = 4,
			})
		end),
	})
end

local function displayMachineData(target: Instance)
	local trove = Janitor.new()

	local billboard = Instance.new("BillboardGui")
	billboard.StudsOffset = Vector3.new(0, 7.5, 0)
	billboard.Size = UDim2.fromScale(30, 10)
	billboard.AlwaysOnTop = true
	billboard.Adornee = target
	billboard.Parent = target

	local root = ReactRoblox.createRoot(billboard)

	trove:Add(billboard)
	trove:Add(function()
		root:unmount()
	end)

	root:render(createElement(App))

	return trove
end

function DebugStateMachine:Start()
	if CharacterController:IsReady() then
		displayMachineData(CharacterController.HumanoidRootPart)
	end

	CharacterController.CharacterReady:Connect(function()
		displayMachineData(CharacterController.HumanoidRootPart)
	end)
end

return DebugStateMachine
