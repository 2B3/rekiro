--- Services ---
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

--- Player ---
local localPlayer = Players.LocalPlayer

--- Requires ---
local TopbarPlus = require(ReplicatedStorage.Packages.TopbarPlus)
local getCreatorNameAsync = require(ReplicatedStorage.Shared.Utils.getCreatorNameAsync)
local React = require(ReplicatedStorage.Packages.React)
local cups = require(ReplicatedStorage.UI.Data.cups)
local Style = require(script.Parent.Style)
local Counters = require(script.Parent.Counters)
local Input = require(script.Parent.Input)
local Body = require(script.Parent.Body)

--- Variables ---
local IS_RUNNING = RunService:IsRunning()

local createElement = React.createElement
local useEffect = React.useEffect
local useState = React.useState

--- Types ---
export type AppProps = {
	visible: boolean?,
}

--- Elements ---
local function App(props: AppProps)
	---// States //--
	local counter, setCounter = useState(cups[1])
	local title, setTitle = useState("")

	---// Effects //--

	-- Dots Effect
	useEffect(function()
		local running = true

		task.spawn(function()
			local i = 1

			while running do
				setTitle(`Buy {string.rep(".", i) .. string.rep(" ", 3 - i)} a coffe`)
				i = (i % 3) + 1
				task.wait(1 / 3)
			end
		end)

		task.spawn(function()
			local creatorName = getCreatorNameAsync()

			if creatorName then
				setTitle(`Buy {creatorName} a coffe`)
			end

			running = false
		end)
	end, {})

	-- Purchase Effect
	useEffect(function()
		local purchaseConnection = MarketplaceService.PromptProductPurchaseFinished:Connect(
			function(_, productId: number, isPurchared: boolean)
				if not isPurchared then
					return
				end

				for _, cup in cups do
					if cup.Id ~= productId then
						continue
					end

					-- TODO: Coffe purchase logic down here.
					-- Need hook state for the two inputs(UserInput, MessageInput) and save it.
				end
			end
		)

		return function()
			purchaseConnection:Disconnect()
			purchaseConnection = nil
		end
	end, {})

	--// Element Functions //--
	local function purchare()
		MarketplaceService:PromptProductPurchase(localPlayer, counter.Id)
	end

	--// Definition //--
	return createElement(Body, {
		visible = props.visible, --> On running toggled with topbarplus else using element props.
	}, {

		Title = createElement("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left,
			AutomaticSize = Enum.AutomaticSize.Y,

			Size = UDim2.fromScale(1, 0),
			BackgroundTransparency = 1,

			FontFace = Style.faceBold,
			TextSize = Style.text2xl,

			Text = title,

			LayoutOrder = 1,
		}),

		Counters = createElement(Counters, {
			setCounter = setCounter,
			counter = counter,
		}),

		UserInput = createElement(Input, {
			TextYAlignment = Enum.TextYAlignment.Center,
			MinY = 52,

			LayoutOrder = 3,
			PlaceholderText = "Name or @yoursocial",
		}),

		MessageInput = createElement(Input, {
			TextYAlignment = Enum.TextYAlignment.Top,
			TextWrapped = true,
			MinY = 124,

			LayoutOrder = 3,
			PlaceholderText = "Say something nice...",
		}),

		Send = createElement("TextButton", {
			TextColor3 = Color3.fromHex("ffffff"),
			BackgroundColor3 = Style.bgPageTheme,
			Size = UDim2.new(1, 0, 0, 45),

			FontFace = Style.faceBold,
			TextSize = Style.textsm,

			Text = "Support " .. utf8.char(0xE002) .. counter.Amount * 50,
			LayoutOrder = 4,

			[React.Event.Activated] = purchare,
		}, {

			Corner = createElement("UICorner", {
				CornerRadius = UDim.new(1),
			}),
		}),
	})
end

return function(props: AppProps)
	local visible, setVisible = useState(props.visible or false)

	useEffect(function()
		if not IS_RUNNING then
			return
		end

		local icon = TopbarPlus.new()
			:align("Right")
			:setCaption("Support the project with BuyMeACoffe.")
			:bindEvent("deselected", function()
				setVisible(false)
			end)
			:bindEvent("selected", function()
				setVisible(true)
			end)
			:setImage("rbxassetid://110999845498673")

		return function()
			icon:destroy()
		end
	end, {})

	return if visible then createElement(App, { visible = visible }) else nil
end
