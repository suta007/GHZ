local v1 = game:GetService("ProximityPromptService")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("TextService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local v_u_6 = {
	["Gamepad"] = {
		[Enum.KeyCode.ButtonX] = "rbxasset://textures/ui/Controls/xboxX.png",
		[Enum.KeyCode.ButtonY] = "rbxasset://textures/ui/Controls/xboxY.png",
		[Enum.KeyCode.ButtonA] = "rbxasset://textures/ui/Controls/xboxA.png",
		[Enum.KeyCode.ButtonB] = "rbxasset://textures/ui/Controls/xboxB.png",
		[Enum.KeyCode.DPadLeft] = "rbxasset://textures/ui/Controls/dpadLeft.png",
		[Enum.KeyCode.DPadRight] = "rbxasset://textures/ui/Controls/dpadRight.png",
		[Enum.KeyCode.DPadUp] = "rbxasset://textures/ui/Controls/dpadUp.png",
		[Enum.KeyCode.DPadDown] = "rbxasset://textures/ui/Controls/dpadDown.png",
		[Enum.KeyCode.ButtonSelect] = "rbxasset://textures/ui/Controls/xboxmenu.png",
		[Enum.KeyCode.ButtonL1] = "rbxasset://textures/ui/Controls/xboxLS.png",
		[Enum.KeyCode.ButtonR1] = "rbxasset://textures/ui/Controls/xboxRS.png"
	},
	["KeyboardIcons"] = {
		[Enum.KeyCode.Backspace] = "rbxasset://textures/ui/Controls/backspace.png",
		[Enum.KeyCode.Return] = "rbxasset://textures/ui/Controls/return.png",
		[Enum.KeyCode.LeftShift] = "rbxasset://textures/ui/Controls/shift.png",
		[Enum.KeyCode.RightShift] = "rbxasset://textures/ui/Controls/shift.png",
		[Enum.KeyCode.Tab] = "rbxasset://textures/ui/Controls/tab.png"
	},
	["SpecialCharacters"] = {
		["\'"] = "rbxasset://textures/ui/Controls/apostrophe.png",
		[","] = "rbxasset://textures/ui/Controls/comma.png",
		["`"] = "rbxasset://textures/ui/Controls/graveaccent.png",
		["."] = "rbxasset://textures/ui/Controls/period.png",
		[" "] = "rbxasset://textures/ui/Controls/spacebar.png"
	},
	["Modifiers"] = {
		[Enum.KeyCode.LeftControl] = "Ctrl",
		[Enum.KeyCode.RightControl] = "Ctrl",
		[Enum.KeyCode.LeftAlt] = "Alt",
		[Enum.KeyCode.RightAlt] = "Alt",
		[Enum.KeyCode.F1] = "F1",
		[Enum.KeyCode.F2] = "F2",
		[Enum.KeyCode.F3] = "F3",
		[Enum.KeyCode.F4] = "F4",
		[Enum.KeyCode.F5] = "F5",
		[Enum.KeyCode.F6] = "F6",
		[Enum.KeyCode.F7] = "F7",
		[Enum.KeyCode.F8] = "F8",
		[Enum.KeyCode.F9] = "F9",
		[Enum.KeyCode.F10] = "F10",
		[Enum.KeyCode.F11] = "F11",
		[Enum.KeyCode.F12] = "F12"
	},
	["Touch"] = "rbxasset://textures/ui/Controls/TouchTapIcon.png"
}
local v_u_7 = {}
v_u_7.__index = v_u_7
function v_u_7.new(p8)
	-- upvalues: (copy) v_u_7
	local v9 = v_u_7
	local v_u_10 = setmetatable({}, v9)
	v_u_10.Left = p8.Left.ProgressBar.UIGradient
	v_u_10.Right = p8.Right.ProgressBar.UIGradient
	p8.ProgressValue.Value = 0
	p8.ProgressValue.Changed:Connect(function(p11)
		-- upvalues: (copy) v_u_10
		local v12 = p11 * 360
		local v13 = math.clamp(v12, 0, 360)
		v_u_10.Left.Rotation = math.clamp(v13, 180, 360)
		v_u_10.Right.Rotation = math.clamp(v13, 0, 180)
	end)
	return v_u_10
end
local v_u_14 = {}
v_u_14.__index = v_u_14
function v_u_14.new()
	-- upvalues: (copy) v_u_14
	local v15 = {
		["groups"] = {
			["shrink"] = {},
			["expand"] = {},
			["dismiss"] = {},
			["reset"] = {}
		}
	}
	local v16 = v_u_14
	return setmetatable(v15, v16)
end
function v_u_14.Add(p17, p18, p19)
	local v20 = p17.groups[p18]
	table.insert(v20, p19)
end
function v_u_14.Play(p21, p22)
	for _, v23 in ipairs(p21.groups[p22]) do
		v23:Play()
	end
end
local function v_u_27(p24, p25, p26)
	-- upvalues: (copy) v_u_2
	p24.Transparency = 1
	p25:Add("shrink", v_u_2:Create(p24, p26, {
		["Transparency"] = 1
	}))
	p25:Add("expand", v_u_2:Create(p24, p26, {
		["Transparency"] = 1
	}))
	p25:Add("dismiss", v_u_2:Create(p24, p26, {
		["Transparency"] = 1
	}))
	p25:Add("reset", v_u_2:Create(p24, p26, {
		["Transparency"] = 1
	}))
end
local function v_u_32(p28, p29, p30)
	-- upvalues: (copy) v_u_2
	local v31 = p28.BackgroundTransparency
	p28.BackgroundTransparency = 1
	p29:Add("shrink", v_u_2:Create(p28, p30, {
		["BackgroundTransparency"] = 1
	}))
	p29:Add("expand", v_u_2:Create(p28, p30, {
		["BackgroundTransparency"] = v31
	}))
	p29:Add("dismiss", v_u_2:Create(p28, p30, {
		["BackgroundTransparency"] = 1
	}))
	p29:Add("reset", v_u_2:Create(p28, p30, {
		["BackgroundTransparency"] = v31
	}))
end
local function v_u_39(p33, p34, p35)
	-- upvalues: (copy) v_u_2
	local v36 = p33.TextTransparency
	p33.TextTransparency = 1
	p33.TextStrokeTransparency = 1
	local v37 = {
		["TextTransparency"] = 1,
		["TextStrokeTransparency"] = 1
	}
	local v38 = {
		["TextTransparency"] = v36,
		["TextStrokeTransparency"] = 1
	}
	p34:Add("shrink", v_u_2:Create(p33, p35, v37))
	p34:Add("expand", v_u_2:Create(p33, p35, v38))
	p34:Add("dismiss", v_u_2:Create(p33, p35, v37))
	p34:Add("reset", v_u_2:Create(p33, p35, v38))
end
local function v_u_44(p40, p41, p42)
	-- upvalues: (copy) v_u_2
	local v43 = p40.ImageTransparency
	p40.ImageTransparency = 1
	p41:Add("shrink", v_u_2:Create(p40, p42, {
		["ImageTransparency"] = 1
	}))
	p41:Add("expand", v_u_2:Create(p40, p42, {
		["ImageTransparency"] = v43
	}))
	p41:Add("dismiss", v_u_2:Create(p40, p42, {
		["ImageTransparency"] = 1
	}))
	p41:Add("reset", v_u_2:Create(p40, p42, {
		["ImageTransparency"] = v43
	}))
end
local function v_u_49(p45, p46, p47)
	-- upvalues: (copy) v_u_27, (copy) v_u_32, (copy) v_u_39, (copy) v_u_44, (copy) v_u_49
	if p45:IsA("UIStroke") then
		v_u_27(p45, p46, p47)
	elseif p45:IsA("GuiObject") and not p45:IsA("UIGradient") then
		v_u_32(p45, p46, p47)
		if p45:IsA("TextLabel") or p45:IsA("TextButton") then
			v_u_39(p45, p46, p47)
		elseif p45:IsA("ImageLabel") or p45:IsA("ImageButton") then
			v_u_44(p45, p46, p47)
		end
	end
	for _, v48 in ipairs(p45:GetChildren()) do
		v_u_49(v48, p46, p47)
	end
end
local function v_u_52(p50)
	if not p50:FindFirstChild("DropShadow") then
		local v51 = Instance.new("ImageLabel")
		v51.Name = "DropShadow"
		v51.BackgroundTransparency = 1
		v51.Image = "rbxasset://textures/ui/Controls/shadow.png"
		v51.ImageColor3 = Color3.fromRGB(0, 0, 0)
		v51.ImageTransparency = 0.7
		v51.ScaleType = Enum.ScaleType.Slice
		v51.SliceCenter = Rect.new(10, 10, 118, 118)
		v51.Size = UDim2.new(1, 8, 1, 8)
		v51.Position = UDim2.new(0, -4, 0, -4)
		v51.ZIndex = p50.ZIndex - 1
		v51.Parent = p50
		return v51
	end
end
local function v_u_73(p53, p54, p55, p_u_56, p_u_57)
	-- upvalues: (copy) v_u_2, (copy) v_u_6, (copy) v_u_4
	local v58 = p53.ButtonKeyImage
	local v_u_59 = p53.ButtonKeyText
	local v60 = p53.ButtonTextImage
	v58.Visible = false
	v_u_59.Visible = false
	v60.Visible = false
	local function v63(p61, p62)
		-- upvalues: (copy) p_u_56, (ref) v_u_2, (copy) p_u_57
		p61.Visible = true
		p61.BackgroundTransparency = 1
		p61.ImageTransparency = 0
		if p62 then
			p61.Image = p62
		end
		p_u_56:Add("dismiss", v_u_2:Create(p61, p_u_57, {
			["ImageTransparency"] = 1,
			["BackgroundTransparency"] = 1
		}))
		p_u_56:Add("reset", v_u_2:Create(p61, p_u_57, {
			["ImageTransparency"] = 0,
			["BackgroundTransparency"] = 1
		}))
	end
	local function v68(p64)
		-- upvalues: (copy) v_u_59, (copy) p_u_56, (ref) v_u_2, (copy) p_u_57
		v_u_59.Visible = true
		v_u_59.BackgroundTransparency = 1
		v_u_59.TextStrokeTransparency = 1
		v_u_59.TextTransparency = 0
		v_u_59.Text = p64
		if #p64 > 2 then
			local v65 = v_u_59
			local v66 = v_u_59.TextSize * 6 / 7
			v65.TextSize = math.round(v66)
		end
		p_u_56:Add("dismiss", v_u_2:Create(v_u_59, p_u_57, {
			["TextTransparency"] = 1,
			["TextStrokeTransparency"] = 1,
			["BackgroundTransparency"] = 1
		}))
		p_u_56:Add("reset", v_u_2:Create(v_u_59, p_u_57, {
			["TextTransparency"] = 0,
			["TextStrokeTransparency"] = 1,
			["BackgroundTransparency"] = 1
		}))
		for _, v67 in ipairs(v_u_59:GetChildren()) do
			if v67:IsA("UIStroke") then
				v67.Transparency = 1
				p_u_56:Add("dismiss", v_u_2:Create(v67, p_u_57, {
					["Transparency"] = 1
				}))
				p_u_56:Add("reset", v_u_2:Create(v67, p_u_57, {
					["Transparency"] = 1
				}))
			end
		end
	end
	if p54 == Enum.ProximityPromptInputType.Gamepad then
		if v_u_6.Gamepad[p55.GamepadKeyCode] then
			v63(v60, v_u_4:GetImageForKeyCode(p55.GamepadKeyCode):gsub("@2x", "@3x"))
			return
		end
	else
		if p54 == Enum.ProximityPromptInputType.Touch then
			v63(v58, v_u_6.Touch)
			return
		end
		v63(v58)
		local v69 = p55.KeyboardKeyCode
		local v70 = v_u_6.KeyboardIcons[v69]
		local v71
		if v70 then
			v71 = "icon"
		else
			v70 = v_u_6.Modifiers[v69]
			if v70 then
				v71 = "text"
			else
				local v72 = v_u_4:GetStringForKeyCode(v69)
				v70 = v_u_6.SpecialCharacters[v72]
				if v70 then
					v71 = "icon"
				elseif v72 and v72 ~= "" then
					v70 = v72:upper()
					v71 = "text"
				else
					v71 = nil
					v70 = nil
				end
			end
		end
		if v71 == "icon" then
			v63(v60, v70)
			return
		end
		if v71 == "text" then
			v68(v70)
		end
	end
end
local v_u_74 = {}
v_u_74.__index = v_u_74
local v_u_75 = Instance.new("GetTextBoundsParams")
v_u_75.Width = 1000
local v_u_76 = Instance.new("GetTextBoundsParams")
v_u_76.Width = 1000
function v_u_74.new(p77, p78, p79)
	-- upvalues: (copy) v_u_74, (copy) v_u_52, (copy) v_u_73, (copy) v_u_7
	local v80 = v_u_74
	local v81 = setmetatable({}, v80)
	v81.prompt = p77
	if p77:GetAttribute("TapOnly") then
		p78 = Enum.ProximityPromptInputType.Touch
	end
	v81.inputType = p78
	v81.connections = {}
	v81.holdTween = nil
	local v82 = p77:GetAttribute("Theme")
	v81.billboard = (v82 and script:FindFirstChild(v82) or script.StandardPrompt):Clone()
	v81.billboard.Enabled = true
	local v83 = v81.billboard.MainPromptFrame
	v81.ui = {
		["mainFrame"] = v83,
		["actionText"] = v83.Action,
		["objectText"] = v83.Object,
		["scale"] = v83.Input.Frame.UIScale,
		["buttonFrame"] = v83.Input.Frame.ButtonBackground,
		["Progress"] = v83.Input.Frame.Progress
	}
	v81.original = {
		["frameBg"] = v83.BackgroundTransparency,
		["frameImg"] = v83.ImageTransparency,
		["buttonBg"] = v81.ui.buttonFrame.BackgroundTransparency,
		["buttonImg"] = v81.ui.buttonFrame.ImageTransparency
	}
	v83.BackgroundTransparency = 1
	v83.ImageTransparency = 1
	v_u_52(v81.ui.buttonFrame)
	v81:SetupAnimations()
	v_u_73(v83.Input.Frame, p78, p77, v81.tweens, TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out))
	v81.progress = v_u_7.new(v81.ui.Progress)
	v81:SetupTouch()
	v81:ConnectEvents()
	v81:UpdateText()
	v81.billboard.Adornee = p77.Parent
	v81.billboard.Parent = p79
	v81.tweens:Play("reset")
	return v81
end
function v_u_74.SetupAnimations(p84)
	-- upvalues: (copy) v_u_14, (copy) v_u_2, (copy) v_u_39, (copy) v_u_49
	p84.tweens = v_u_14.new()
	local v85 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local v86 = TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
	local v87 = p84.ui.mainFrame
	local v88 = p84.original
	p84.tweens:Add("shrink", v_u_2:Create(v87, v85, {
		["Size"] = UDim2.fromScale(0.5, 1),
		["BackgroundTransparency"] = 1,
		["ImageTransparency"] = 1
	}))
	p84.tweens:Add("expand", v_u_2:Create(v87, v85, {
		["Size"] = UDim2.fromScale(1, 1),
		["BackgroundTransparency"] = v88.frameBg,
		["ImageTransparency"] = v88.frameImg
	}))
	p84.tweens:Add("dismiss", v_u_2:Create(v87, v85, {
		["Size"] = UDim2.fromScale(0.5, 1),
		["BackgroundTransparency"] = 1,
		["ImageTransparency"] = 1
	}))
	p84.tweens:Add("reset", v_u_2:Create(v87, v85, {
		["Size"] = UDim2.fromScale(1, 1),
		["BackgroundTransparency"] = v88.frameBg,
		["ImageTransparency"] = v88.frameImg
	}))
	p84.tweens:Add("shrink", v_u_2:Create(p84.ui.scale, v85, {
		["Scale"] = 1.33
	}))
	p84.tweens:Add("expand", v_u_2:Create(p84.ui.scale, v85, {
		["Scale"] = 1
	}))
	p84.tweens:Add("reset", v_u_2:Create(p84.ui.Progress.ProgressValue, TweenInfo.new(0), {
		["Value"] = 0
	}))
	v_u_39(p84.ui.actionText, p84.tweens, v85)
	v_u_39(p84.ui.objectText, p84.tweens, v85)
	p84.tweens:Add("dismiss", v_u_2:Create(p84.ui.buttonFrame, v86, {
		["BackgroundTransparency"] = 1,
		["ImageTransparency"] = 1
	}))
	p84.tweens:Add("reset", v_u_2:Create(p84.ui.buttonFrame, v86, {
		["BackgroundTransparency"] = v88.buttonBg,
		["ImageTransparency"] = v88.buttonImg
	}))
	for _, v89 in ipairs(p84.ui.buttonFrame:GetChildren()) do
		if v89:IsA("UIStroke") then
			v89.Transparency = 1
			p84.tweens:Add("dismiss", v_u_2:Create(v89, v86, {
				["Transparency"] = 1
			}))
			p84.tweens:Add("reset", v_u_2:Create(v89, v86, {
				["Transparency"] = 1
			}))
		end
	end
	local v90 = {
		[v87.Input] = false,
		[p84.ui.actionText] = true,
		[p84.ui.objectText] = true
	}
	for _, v91 in ipairs(v87:GetChildren()) do
		local v92 = v90[v91]
		if v92 == nil then
			v_u_49(v91, p84.tweens, v85)
		elseif v92 == true then
			for _, v93 in ipairs(v91:GetChildren()) do
				v_u_49(v93, p84.tweens, v85)
			end
		end
	end
	p84.tweens:Add("expand", v_u_2:Create(p84.ui.Progress.ProgressValue, TweenInfo.new(0), {
		["Value"] = 0
	}))
end
function v_u_74.SetupTouch(p_u_94)
	if not p_u_94.prompt:GetAttribute("NoTouch") then
		if p_u_94.inputType == Enum.ProximityPromptInputType.Touch or p_u_94.prompt.ClickablePrompt then
			local v95 = p_u_94.billboard.TextButton
			local v_u_96 = false
			local v_u_97 = nil
			v95.InputBegan:Connect(function(p98)
				-- upvalues: (copy) p_u_94, (ref) v_u_97, (ref) v_u_96
				if (p98.UserInputType == Enum.UserInputType.Touch or p98.UserInputType == Enum.UserInputType.MouseButton1) and p98.UserInputState ~= Enum.UserInputState.Change then
					if p_u_94.prompt:GetAttribute("TapOnly") and p98.UserInputType == Enum.UserInputType.Touch then
						v_u_97 = p98.Position
						v_u_96 = true
						return
					end
					p_u_94.prompt:InputHoldBegin()
					v_u_96 = true
				end
			end)
			v95.InputEnded:Connect(function(p99)
				-- upvalues: (ref) v_u_96, (copy) p_u_94, (ref) v_u_97
				if (p99.UserInputType == Enum.UserInputType.Touch or p99.UserInputType == Enum.UserInputType.MouseButton1) and v_u_96 then
					v_u_96 = false
					if p_u_94.prompt:GetAttribute("TapOnly") and p99.UserInputType == Enum.UserInputType.Touch then
						if v_u_97 then
							local v100 = (p99.Position - v_u_97).Magnitude
							v_u_97 = nil
							if v100 <= 15 then
								p_u_94.prompt:InputHoldBegin()
								task.delay(p_u_94.prompt.HoldDuration + 0.01, function()
									-- upvalues: (ref) p_u_94
									p_u_94.prompt:InputHoldEnd()
								end)
								return
							end
						end
					else
						p_u_94.prompt:InputHoldEnd()
					end
				end
			end)
			p_u_94.billboard.Active = true
		end
	end
end
function v_u_74.ConnectEvents(p_u_101)
	-- upvalues: (copy) v_u_2
	local v102 = p_u_101.connections
	local v103 = p_u_101.prompt.PromptButtonHoldBegan
	local function v104()
		-- upvalues: (copy) p_u_101, (ref) v_u_2
		if p_u_101.prompt.HoldDuration > 0 then
			p_u_101.holdTween = v_u_2:Create(p_u_101.ui.Progress.ProgressValue, TweenInfo.new(p_u_101.prompt.HoldDuration, Enum.EasingStyle.Linear), {
				["Value"] = 1
			})
			p_u_101.holdTween:Play()
			p_u_101.tweens:Play("shrink")
		end
	end
	table.insert(v102, v103:Connect(v104))
	local v105 = p_u_101.connections
	local v106 = p_u_101.prompt.PromptButtonHoldEnded
	table.insert(v105, v106:Connect(function()
		-- upvalues: (copy) p_u_101
		if p_u_101.holdTween then
			p_u_101.holdTween:Cancel()
			p_u_101.holdTween = nil
		end
		p_u_101.tweens:Play("expand")
	end))
	local v107 = p_u_101.connections
	local v108 = p_u_101.prompt.Triggered
	table.insert(v107, v108:Connect(function()
		-- upvalues: (copy) p_u_101
		p_u_101.tweens:Play("dismiss")
	end))
	local v109 = p_u_101.connections
	local v110 = p_u_101.prompt.TriggerEnded
	table.insert(v109, v110:Connect(function()
		-- upvalues: (copy) p_u_101
		p_u_101.tweens:Play("reset")
	end))
	local v111 = p_u_101.connections
	local v112 = p_u_101.prompt.Changed
	table.insert(v111, v112:Connect(function()
		-- upvalues: (copy) p_u_101
		p_u_101:UpdateText()
	end))
end
function v_u_74.UpdateText(p_u_113)
	-- upvalues: (copy) v_u_75, (copy) v_u_76, (copy) v_u_3
	pcall(function()
		-- upvalues: (ref) v_u_75, (copy) p_u_113, (ref) v_u_76, (ref) v_u_3
		v_u_75.Text = p_u_113.prompt.ActionText
		v_u_75.Font = p_u_113.ui.actionText.FontFace
		v_u_75.Size = p_u_113.ui.actionText.TextSize
		v_u_76.Text = p_u_113.prompt.ObjectText
		v_u_76.Font = p_u_113.ui.objectText.FontFace
		v_u_76.Size = p_u_113.ui.objectText.TextSize
		local v114
		if p_u_113.prompt.ActionText and p_u_113.prompt.ActionText ~= "" or p_u_113.prompt.ObjectText and p_u_113.prompt.ObjectText ~= "" then
			local v115 = v_u_3:GetTextBoundsAsync(v_u_75).X
			local v116 = v_u_3:GetTextBoundsAsync(v_u_76).X
			v114 = math.max(v115, v116) + 72 + 24
		else
			v114 = 96
		end
		local v117 = p_u_113.prompt.ObjectText and p_u_113.prompt.ObjectText ~= "" and 9 or 0
		local v118 = 72 - v114 / 2
		p_u_113.ui.actionText.Position = UDim2.new(0.5, v118, 0, v117)
		p_u_113.ui.objectText.Position = UDim2.new(0.5, v118, 0, -10)
		p_u_113.ui.actionText.Text = p_u_113.prompt.ActionText
		p_u_113.ui.objectText.Text = p_u_113.prompt.ObjectText
		p_u_113.ui.actionText.AutoLocalize = p_u_113.prompt.AutoLocalize
		p_u_113.ui.actionText.RootLocalizationTable = p_u_113.prompt.RootLocalizationTable
		p_u_113.ui.objectText.AutoLocalize = p_u_113.prompt.AutoLocalize
		p_u_113.ui.objectText.RootLocalizationTable = p_u_113.prompt.RootLocalizationTable
		p_u_113.billboard.Size = UDim2.fromOffset(v114, 72)
		p_u_113.billboard.SizeOffset = Vector2.new(p_u_113.prompt.UIOffset.X / v114, p_u_113.prompt.UIOffset.Y / 72)
	end)
end
function v_u_74.Destroy(p119)
	for _, v120 in ipairs(p119.connections) do
		v120:Disconnect()
	end
	if p119.holdTween then
		p119.holdTween:Cancel()
	end
	p119.tweens:Play("dismiss")
	task.wait(0.2)
	p119.billboard:Destroy()
end
v1.PromptShown:Connect(function(p121, p122)
	-- upvalues: (copy) v_u_5, (copy) v_u_74
	if not p121:GetAttribute("DontShow") and p121.Style ~= Enum.ProximityPromptStyle.Default then
		local v123 = p121.Name == "HarvestPrompt" and p121.Parent
		if v123 then
			if not v123:IsA("Model") then
				v123 = v123.Parent
			end
			if v123 and v123:GetAttribute("Favorited") then
				p121.Enabled = false
				return
			end
		end
		local v124 = v_u_5:FindFirstChild("ProximityPrompts")
		if not v124 then
			v124 = Instance.new("ScreenGui")
			v124.Name = "ProximityPrompts"
			v124.ResetOnSpawn = false
			v124.Parent = v_u_5
		end
		local v125 = v_u_74.new(p121, p122, v124)
		p121.PromptHidden:Wait()
		v125:Destroy()
	end
end)