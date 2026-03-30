--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local fragmentMap = require(ReplicatedStorage.UI.Utils.fragmentMap)
local React = require(ReplicatedStorage.Packages.React)
local cups = require(ReplicatedStorage.UI.Data.cups)
local Style = require(script.Parent.Style)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)

--- Variables ---
local createElement = React.createElement
local useSpring = ReactSpring.useSpring
local useState = React.useState

--- Types ---
export type CountersProps = {
	setCounter: (index<typeof(cups), typeof(cups)>) -> (),
	counter: index<typeof(cups), typeof(cups)>,
}

local function Counters(props: CountersProps)
	return createElement("Frame", {
		BackgroundColor3 = Style.bgPageTheme,
		Size = UDim2.new(1, 0, 0, 74),
		BackgroundTransparency = 0.9,

		LayoutOrder = 2,
	}, {

		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),

		Stroke = createElement("UIStroke", {
			BorderStrokePosition = Enum.BorderStrokePosition.Center,
			Color = Style.bgPageTheme,
			Transparency = 0.8,
		}),

		Layout = createElement("UIListLayout", {
			Padding = UDim.new(0, 9),

			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		["☕"] = createElement("TextLabel", {
			Size = UDim2.fromOffset(40, 60),
			BackgroundTransparency = 1,
			TextScaled = true,

			Text = "☕",
			LayoutOrder = 1,
		}),

		["X"] = createElement("TextLabel", {
			TextColor3 = Color3.fromHex("222222"),

			AutomaticSize = Enum.AutomaticSize.XY,

			BackgroundTransparency = 1,
			TextTransparency = 0.5,
			FontFace = Style.faceBold,
			TextSize = Style.text2xl,

			Text = "x",
			LayoutOrder = 2,
		}),

		Counters = fragmentMap(cups, function(child: { Amount: number, Id: string, default: boolean? }, index)
			local hovering, setHovering = useState(false)

			local isSelected = child == props.counter

			local styles = useSpring({
				BackgroundColor3 = if isSelected then Style.bgPageTheme else Color3.fromHex("ffffff"),
				TextColor3 = if isSelected then Color3.fromHex("ffffff") else Style.bgPageTheme,
				StrokeTransparency = if isSelected or hovering then 0 else 0.7,
			})

			return createElement("TextButton", {
				BackgroundColor3 = styles.BackgroundColor3,
				Size = UDim2.fromOffset(40, 40),
				AutoButtonColor = false,
				BorderSizePixel = 0,

				TextColor3 = styles.TextColor3,
				FontFace = Style.faceBold,
				TextSize = Style.textmd,

				Text = child.Amount,

				LayoutOrder = 2 + index,
				key = index,

				[React.Event.MouseEnter] = function()
					setHovering(true)
				end,

				[React.Event.MouseLeave] = function()
					setHovering(false)
				end,

				[React.Event.Activated] = function()
					if isSelected then
						return
					end

					props.setCounter(child)
				end,
			}, {

				Corner = createElement("UICorner", {
					CornerRadius = UDim.new(1),
				}),

				Stroke = createElement("UIStroke", {
					BorderStrokePosition = Enum.BorderStrokePosition.Center,
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Transparency = styles.StrokeTransparency,
					Color = Style.bgPageTheme,
				}),
			})
		end),
	})
end

return Counters
