local module = {}

function module.GetColors(Theme) -- returns the main color, and the stroke color for the given theme
	if string.lower(Theme) == 'dark' then
		return Color3.fromRGB(46,46,46), Color3.fromRGB(34,34,34)
	else 
		return Color3.fromRGB(255,255,255), Color3.fromRGB(204, 204, 204)
	end
end

module.Size = {
	["FrameSizeToggle"] = UDim2.new(1,0,-0.164,100),
	["ButtonSizeToggle"] = UDim2.new(0,76,0,23),
	["ButtonPosToggle"] = UDim2.new(0.849,0,0.5,0),
	["ButtonLabelSize"] = UDim2.new(0,154,0,30),
	["ButtonLabelPos"] = UDim2.new(0,0,0,0),
	["SizeFrameColorSelection"] = UDim2.new(1,0,0.026,100)
}

function module.GetUIAddOns(Type: string): (UICorner, UIStroke)
	if Type == "button" then
		local Newstroke = Instance.new("UIStroke")
		local Newcorner = Instance.new("UICorner")
		Newstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Newstroke.Thickness = 1
		Newcorner.CornerRadius = UDim.new(0,3)
		return Newcorner, Newstroke
	elseif Type == "frame" then
		local CORNER = Instance.new("UICorner")
		CORNER.CornerRadius = UDim.new(0,3)
		local STROKE = Instance.new("UIStroke")
		STROKE.Transparency = 1
		return CORNER, STROKE
	end
end


return module
