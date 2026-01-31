local module = {}

--[[
    Version 0.2
    Update log:
    
    re-purposed module to be importable from github.
    -- Module can no longer be acessed via the toolbox
    
    Please read github docs for information
]]

local DefaultUDIM = UDim2.new(0, 12, 0, 12)

local ThemeDark = {
	["Box"] = "rbxasset://textures/DeveloperFramework/checkbox_unchecked_dark.png";
	["Check"] = "rbxasset://textures/DeveloperFramework/checkbox_checked_dark.png"
}

local ThemeWhite = {
	["Box"] = "rbxasset://textures/DeveloperFramework/checkbox_unchecked_light.png";
	["Check"] = "rbxasset://textures/DeveloperFramework/checkbox_checked_light.png"
}

local Template = Instance.new("Frame")
local Divider = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
Divider.Name = "Divider"
Template.Size = UDim2.new(0, 198, 0, 23)
Divider.Size = UDim2.new(0,1,0,23)
TextLabel.Size = UDim2.new(0,119,0,23)
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
local UIpadding = Instance.new("UIPadding"
)
TextLabel.Transparency = 1
UIpadding.PaddingBottom = UDim.new(0,3)
UIpadding.PaddingTop = UDim.new(0,2)
UIpadding.PaddingLeft = UDim.new(0,16)

local Theme_Template_White = {
	["DivierColor"] = Color3.fromRGB(238, 238, 238);
	["FrameColor"] = Color3.fromRGB(255,255,255)
}

local Theme_Template_Dark = {
	["DividerColor"] = Color3.fromRGB(46,46,46);
	["FrameColor"] = Color3.fromRGB(56,56,56)
}

TextLabel.Parent = Template
Divider.Parent = Template
UIpadding.Parent = TextLabel

TextLabel.Position = UDim2.new(-0,0,0,0)
Divider.Position = UDim2.new(0.6,0,0)
Template.Position = UDim2.new(0.546,0,0.45,0)
Template.BorderSizePixel = 0
Divider.BorderSizePixel = 0
TextLabel.TextStrokeTransparency = 1
TextLabel.TextTransparency = 0
TextLabel.TextSize = 14
TextLabel.TextTruncate = Enum.TextTruncate.SplitWord
TextLabel.Font = Enum.Font.SourceSans

function module.newCheckBox(Theme: string)
	local Self_Btn = {}

	local BTN_ = Instance.new("ImageButton")
	BTN_.Size = UDim2.new(0,12,0,12)
	BTN_.Visible = true
	BTN_.BackgroundTransparency = 1

	local TEMP
	
	if Theme:lower() == "dark" then
		BTN_.Image = ThemeDark.Box
		TEMP = Template:Clone()
		TEMP:WaitForChild("Divider").BackgroundColor3= Theme_Template_Dark.DividerColor
		TEMP.BackgroundColor3 = Theme_Template_Dark.FrameColor
		TEMP.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	elseif Theme:lower() == "light" then
		BTN_.Image = ThemeWhite.Box
		TEMP = Template:Clone()
		TEMP:WaitForChild("Divider").BackgroundColor3= Theme_Template_White.DivierColor
		TEMP.BackgroundColor3 = Theme_Template_White.FrameColor
		TEMP.TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	end
	
	task.wait(0.1)
	
	function Self_Btn.GetBtn()
		return BTN_
	end
	function Self_Btn:ChangeText(Text: string)
		TEMP.TextLabel.Text = Text
	end
	local BoxUDIM = UDim2.new(0.641,0,0.217,0)
	
	BTN_.Position = BoxUDIM
	
	BTN_.Parent = TEMP
	
	Self_Btn.CurrentValue = false -- default value
	function Self_Btn:GetCheckBox()
		return TEMP
	end
	BTN_.Activated:Connect(function()
		if Self_Btn.CurrentValue == true then
			Self_Btn.CurrentValue = not Self_Btn.CurrentValue
			if Theme:lower() == "light" then
				BTN_.Image = ThemeWhite.Box
			else
				BTN_.Image = ThemeDark.Box
			end
		else
			Self_Btn.CurrentValue = not Self_Btn.CurrentValue
			if Theme:lower() == "light" then
				BTN_.Image = ThemeWhite.Check
			else
				BTN_.Image = ThemeDark.Check
			end
		end
	end)
	
	
	Self_Btn.Clicked = Instance.new("BindableEvent")
	BTN_.Activated:Connect(function() Self_Btn.Clicked:Fire(Self_Btn.CurrentValue) end)
	
	local function displayvalueintermsofcontext(Value: boolean)
		if Value == true then
			if Theme:lower() == "light" then
				BTN_.Image = ThemeWhite.Check
			else
				BTN_.Image = ThemeDark.Check
			end
		else
			if Theme:lower() == "light" then
				BTN_.Image = ThemeWhite.Box
			else
				BTN_.Image = ThemeDark.Box
			end
		end
	end
	
	
	function Self_Btn.ForceValue(Value: boolean)
		Self_Btn.CurrentValue = Value
		
	end
	
	return Self_Btn
end

return module
