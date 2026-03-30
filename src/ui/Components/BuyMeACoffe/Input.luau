--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local React = require(ReplicatedStorage.Packages.React)
local Style = require(script.Parent.Style)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)

--- Variables ---
local createElement = React.createElement
local useSpring = ReactSpring.useSpring
local useState = React.useState

--- Types ---
export type InputProps = {
	TextYAlignment: Enum.TextYAlignment,
	TextWrapped: boolean,
	LayoutOrder: number,
	MinY: number,

	PlaceholderText: string,
}

--- Elements ---
local function Input(props: InputProps)
	local hovering, setHovering = useState(false)
	local focused, setFocused = useState(false)

	local styles = useSpring({
		BackgroundTransparency = if focused then 1 elseif hovering then 0.9 else 0.95,
		StrokeTransparency = if focused then 0 else 1,
		Thickness = if focused then 2 else 0,
	})

	return createElement("TextBox", {
		BackgroundTransparency = styles.BackgroundTransparency,

		BackgroundColor3 = Color3.fromHex("222222"),
		Size = UDim2.new(1, 0, 0, props.MinY),
		ClearTextOnFocus = false,

		TextTruncate = Enum.TextTruncate.SplitWord,
		TextXAlignment = Enum.TextXAlignment.Left,
		AutomaticSize = Enum.AutomaticSize.Y,

		TextYAlignment = props.TextYAlignment,
		LayoutOrder = props.LayoutOrder,
		TextWrapped = props.TextWrapped,

		FontFace = Style.faceBold,
		TextSize = Style.textmd,

		PlaceholderText = props.PlaceholderText,
		Text = "",

		[React.Event.MouseEnter] = function()
			setHovering(true)
		end,

		[React.Event.MouseLeave] = function()
			setHovering(false)
		end,

		[React.Event.Focused] = function()
			setFocused(true)
		end,

		[React.Event.FocusLost] = function()
			setFocused(false)
		end,
	}, {

		Stroke = createElement("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Style.bgPageTheme,

			Transparency = styles.StrokeTransparency,
			Thickness = styles.Thickness,
		}),

		Padding = createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 16),
			PaddingRight = UDim.new(0, 16),
			PaddingLeft = UDim.new(0, 16),
			PaddingTop = UDim.new(0, 16),
		}),

		Corner = createElement("UICorner", {
			CornerRadius = UDim.new(0, 8),
		}),
	})
end

return Input
