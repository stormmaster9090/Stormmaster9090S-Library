local module = {}

export type ToggleProps = {
	Text: string,
	Theme: string,
	OnClick: () -> (),
	DefaultOn: boolean
}

export type Toggle = {
	GetFrame: () -> (GuiObject),
	ChangeText: (string) -> (),
	OnClick: () -> (boolean)
}

local INIT = require(script.Parent.Init)

function module.NewToggle(Props: ToggleProps): Toggle
	local NewFrame = Instance.new("Frame")
	local Newbtn
	if Props.Theme:lower() == "dark" then
		local C1, C2 = INIT.GetColors("dark")
		NewFrame.BackgroundColor3 = C1
		local NewButton = Instance.new("TextButton")
		NewButton.Size =INIT.Size.ButtonPosToggle
		local Corner, Stroke = INIT.GetUIAddOns("button")
		Corner.Parent = NewButton
		Stroke.Parent = NewButton
		NewButton.Position = INIT.Size.ButtonPosToggle
		Stroke.Color = C2
		NewButton.BackgroundColor3 = C2
		Newbtn = NewButton
	else
		local C3, C4 = INIT.GetColors("light")
		NewFrame.BackgroundColor3 = C3
		local NewButton = Instance.new("TextButton")
		NewButton.Size =INIT.Size.ButtonPosToggle
		local Corner, Stroke = INIT.GetUIAddOns("button")
		Corner.Parent = NewButton
		Stroke.Parent = NewButton
		NewButton.Position = INIT.Size.ButtonPosToggle
		Stroke.Color = C4
		NewButton.BackgroundColor3 = C3
		Newbtn = NewButton
	end
	Newbtn.Size = INIT.Size.ButtonSizeToggle
	Newbtn.AnchorPoint = Vector2.new(0.5,0.5)
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Position = INIT.Size.ButtonLabelPos
	label.Size = INIT.Size.ButtonLabelSize
	label.Parent = NewFrame
	Newbtn.Parent = NewFrame
	label.Text = Props.Text
	local currentvalue = Props.DefaultOn
	NewFrame.Size = INIT.Size.FrameSizeToggle
	if Props.Theme:lower() == "dark" then
		label.TextColor3 = Color3.fromRGB(255,255,255)
		Newbtn.TextColor3 = Color3.fromRGB(255,255,255)
	else
		label.TextColor3 = Color3.fromRGB(0,0,0)
		Newbtn.TextColor3 = Color3.fromRGB(0,0,0)
	end
	local Corner2, Stroke2 = INIT.GetUIAddOns("frame")
	Corner2.Parent = NewFrame
	label.TextXAlignment = Enum.TextXAlignment.Left
	Newbtn.BackgroundColor3 = NewFrame.BackgroundColor3
	if currentvalue == true then
		Newbtn.Text = "On"
	else
		Newbtn.Text = "Off"
	end
	local PaddingFrame = Instance.new("UIPadding")
	PaddingFrame.PaddingRight = UDim.new(0,5)
	local PaddingLabel = Instance.new("UIPadding")
	PaddingLabel.PaddingLeft = UDim.new(0,14)
	PaddingLabel.PaddingRight = UDim.new(0,5)
	label.TextTruncate = Enum.TextTruncate.SplitWord
	PaddingLabel.Parent = label
	PaddingFrame.Parent = NewFrame
	label.Font = Enum.Font.Roboto
	label.TextSize = 14
	label.TextTransparency = 0.3
	local NewToggle: Toggle = {
		GetFrame = function()
			return NewFrame
		end,
		ChangeText = function(Text:string)
			label.Text = Text
		end,
		OnClick = Props.OnClick or function() end,
	}
	local Event = Instance.new("BindableEvent")
	Event.Event:Connect(NewToggle.OnClick)
	
	Newbtn.MouseButton1Click:Connect(function()
		currentvalue = not currentvalue
		Event:Fire(currentvalue)
		if currentvalue == true then
			Newbtn.Text ="On" 
		else
			Newbtn.Text = "Off"
		end
	end)
	return NewToggle
end

return module
