--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Requires ---
local React = require(ReplicatedStorage.Packages.React)
local ReactSpring = require(ReplicatedStorage.Packages.ReactSpring)
local Style = require(script.Parent.Style)

--- Variables ---
local createElement = React.createElement
local useSpring = ReactSpring.useSpring

--- Types ---
export type BodyProps = {
	visible: boolean,
	children: { any },
}

--- Elements ---
local function Body(props: BodyProps)
	local styles = useSpring({
		transparency = if props.visible then 0 else 1,
		position = if props.visible then UDim2.fromScale(0.5, 0.5) else UDim2.fromScale(0.5, 1),
		scale = if props.visible then 1 else 0.8,
	})

	return createElement("CanvasGroup", {
		Position = styles.position,
		AnchorPoint = Vector2.one * 0.5,
		Size = UDim2.fromOffset(386, 0),

		AutomaticSize = Enum.AutomaticSize.Y,
		Visible = props.visible,

		GroupTransparency = styles.transparency,
		BackgroundColor3 = Style.bgWhite,
		BorderSizePixel = 0,
	}, {

		Layout = createElement("UIListLayout", {
			Padding = UDim.new(0, 16),

			HorizontalAlignment = Enum.HorizontalAlignment.Left,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),

		Padding = createElement("UIPadding", {
			PaddingBottom = UDim.new(0, 24),
			PaddingRight = UDim.new(0, 32),
			PaddingLeft = UDim.new(0, 32),
			PaddingTop = UDim.new(0, 24),
		}),

		Stroke = createElement("UIStroke", {
			BorderStrokePosition = Enum.BorderStrokePosition.Center,
			Transparency = styles.transparency,
			Color = Style.bgGray,
			Thickness = 2,
		}),

		Scale = createElement("UIScale", {
			Scale = styles.scale,
		}),

		Corner = createElement("UICorner", {
			CornerRadius = Style.rounded4xl,
		}),

		Content = createElement(React.Fragment, nil, props.children),
	})
end

return Body
