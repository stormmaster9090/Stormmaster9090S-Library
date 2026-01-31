local module = {}

export type SelectorProps = {
	DefaultColor: Color3,
	Theme: string,
	OnChange: () -> ()
}

export type Color3Selector = {
	OnChange: () -> (Color3),
	ChangeColor: (Color3) -> (),
	GetFrame:() -> (GuiObject)
}
local INITmodule = require(script.Parent.Init)

function module.new(Props: SelectorProps): Color3Selector
	local NewFrame = Instance.new("Frame")
	local NewTextLabel = Instance.new("TextLabel")
	local NewTextBoxR = Instance.new("TextBox")
	local NewTextBoxG = Instance.new("TextBox")
	local NewTextBoxB = Instance.new("TextBox")
	local ColorIndicator = Instance.new("Frame")
	local TitleBarPadding = Instance.new("UIPadding")
	TitleBarPadding.PaddingLeft = UDim.new(0,14)
	TitleBarPadding.PaddingRight = UDim.new(0,5)
	----
	local MainColor, StrokeColor = INITmodule.GetColors(Props.Theme)
	NewFrame.BackgroundColor3 = MainColor
	local StrokeButton = Instance.new("UIStroke")
	StrokeButton.Color = StrokeColor
	StrokeButton.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	local FrameCorner = Instance.new("UICorner")
	FrameCorner.CornerRadius = UDim.new(0,4)
	FrameCorner.Parent = NewFrame
	----
	local NewRstroke = StrokeButton:Clone()
	local NewGstroke = StrokeButton:Clone()
	local NewBstroke = StrokeButton:Clone()
	NewRstroke.Parent = NewTextBoxR
	NewGstroke.Parent = NewTextBoxG
	NewBstroke.Parent = NewTextBoxB
	local NewCorner1 = Instance.new("UICorner")
	NewCorner1.CornerRadius = UDim.new(0,2)
	NewCorner1:Clone().Parent = NewTextBoxB
	NewCorner1:Clone().Parent = NewTextBoxG
	NewCorner1:Clone().Parent = NewTextBoxR
	----
	NewTextBoxB.Parent = NewFrame
	NewTextBoxG.Parent = NewFrame
	NewTextBoxR.Parent = NewFrame
	NewTextLabel.Parent = NewFrame
	ColorIndicator.Parent = NewFrame
	StrokeButton:Clone().Parent = ColorIndicator
	----
	NewTextBoxB.BackgroundColor3 = MainColor
	NewTextBoxG.BackgroundColor3 = MainColor
	NewTextBoxR.BackgroundColor3 = MainColor
	NewTextLabel.BackgroundColor3 = MainColor
	----
	ColorIndicator.Size = UDim2.new(0,25,0,25)
	NewTextBoxB.Size = UDim2.new(0,55,0,25)
	NewTextBoxG.Size = UDim2.new(0,55,0,25)
	NewTextBoxR.Size = UDim2.new(0,55,0,25)
	NewTextLabel.Size = UDim2.new(0,106,0,30)
	----
	NewTextBoxB.Position = UDim2.new(0.584,0,0.418,0)
	NewTextBoxG.Position = UDim2.new(0.336,0,0.418,0)
	NewTextBoxR.Position = UDim2.new(0.084,0,0.418,0)
	NewTextLabel.Position = UDim2.new(0.296,0,-0.009,0)
	ColorIndicator.Position = UDim2.new(0.836,0,0.418,0)
	----
	local NEWCOLOR = {
		OnChange = Props.OnChange or function() end,
		ChangeColor = function(Color: Color3)
			ColorIndicator.BackgroundColor3 = Color
			R = Color.R
			G = Color.G
			B = Color.B
		end,
		GetFrame = function()
			return NewFrame
		end,
	}
	---- Function
	B = 255
	R = 255
	G = 255
	local EVENT = Instance.new("BindableEvent")
	EVENT.Event:Connect(NEWCOLOR.OnChange)
	local function CreateColor()
		ColorIndicator.BackgroundColor3 = Color3.fromRGB(R,G,B)
		EVENT:Fire(ColorIndicator.BackgroundColor3)
	end
	NewTextBoxB:GetPropertyChangedSignal("Text"):Connect(function()
		B = tonumber(NewTextBoxB.Text)
		CreateColor()
	end)
	NewTextBoxG:GetPropertyChangedSignal("Text"):Connect(function()
		G = tonumber(NewTextBoxG.Text)
		CreateColor()
	end)
	NewTextBoxR:GetPropertyChangedSignal("Text"):Connect(function()
		R = tonumber(NewTextBoxR.Text)
		CreateColor()
	end)
	----
	ColorIndicator.BackgroundColor3 = Props.DefaultColor or Color3.fromRGB(255,255,255)
	R = Props.DefaultColor.R
	G = Props.DefaultColor.G
	B = Props.DefaultColor.B
	NewFrame.Size = UDim2.new(1,0,0.026,100)
	NewTextLabel.BorderSizePixel = 0
	NewTextLabel.Text = "Color3"
	NewTextBoxB.Text = "255"
	NewTextBoxR.Text = "255"
	NewTextBoxG.Text = "255"
	if Props.Theme:lower() == "dark" then
		NewTextBoxR.TextColor3 = Color3.fromRGB(255,255,255)
		NewTextBoxG.TextColor3 = Color3.fromRGB(255,255,255)
		NewTextBoxB.TextColor3 = Color3.fromRGB(255,255,255)
		NewTextLabel.TextColor3 = Color3.fromRGB(255,255,255)
		NewTextBoxB.PlaceholderColor3 = Color3.fromRGB(255,255,255)
		NewTextBoxG.PlaceholderColor3 = Color3.fromRGB(255,255,255)
		NewTextBoxR.PlaceholderColor3 = Color3.fromRGB(255,255,255)
	end
	NewTextBoxB.PlaceholderText = "B"
	NewTextBoxG.PlaceholderText = "G"
	NewTextBoxR.PlaceholderText = "R"
	NewTextLabel.TextSize = 14
	NewTextLabel.Font = Enum.Font.Roboto
	NewTextLabel.TextTransparency = 0.3
	return NEWCOLOR
end

return module
