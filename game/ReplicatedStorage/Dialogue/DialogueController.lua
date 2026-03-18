local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v4 = game:GetService("SoundService")
local v_u_5 = game:GetService("UserInputService")
local v_u_6 = game:GetService("GamepadService")
local v_u_7 = game:GetService("GuiService")
local v_u_8 = {
	["TypewriterDelay"] = 0.02,
	["FadeOutTime"] = 0.5,
	["MaxInteractionDistance"] = 15,
	["PlayerResponseDisplay"] = 1.5,
	["HighlightColor"] = Color3.fromRGB(255, 255, 100),
	["HighlightOutlineAlpha"] = 0.25,
	["DialogueDisplayTime"] = 1,
	["DisplayTimePerChar"] = 0.02,
	["NametagBackground"] = Color3.new(255, 255, 255),
	["NametagText"] = Color3.new(0, 0, 0),
	["NametagStroke"] = Color3.new(0, 0, 0)
}
local v_u_9 = v3.LocalPlayer
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = v4:WaitForChild("SFX"):WaitForChild("UI"):WaitForChild("Typing")
local v_u_13 = v4:WaitForChild("SFX"):WaitForChild("UI"):WaitForChild("Click")
local function v_u_15(p14)
	return (p14:IsA("TextLabel") or p14:IsA("TextButton")) and "TextTransparency" or ((p14:IsA("ImageLabel") or p14:IsA("ImageButton")) and "ImageTransparency" or (p14:IsA("Frame") and "BackgroundTransparency" or "Transparency"))
end
local function v_u_22(p_u_16, p17)
	-- upvalues: (copy) v_u_8, (copy) v_u_15, (copy) v_u_1
	local v18 = p17 or v_u_8.FadeOutTime
	local v19 = TweenInfo.new(v18, Enum.EasingStyle.Sine)
	for _, v20 in p_u_16:GetDescendants() do
		local v21 = v_u_15(v20)
		if v20:IsA("GuiObject") or v20:IsA("UIStroke") then
			v_u_1:Create(v20, v19, {
				[v21] = 1
			}):Play()
		end
	end
	task.delay(v18, function()
		-- upvalues: (copy) p_u_16
		if p_u_16 and p_u_16.Parent then
			p_u_16:Destroy()
		end
	end)
end
local function v_u_29(p23, p24, p25, p26, p27)
	-- upvalues: (copy) v_u_12
	p23.Text = p24
	p23.MaxVisibleGraphemes = 0
	local v28 = 0
	for _ in utf8.graphemes(p24) do
		if p27 and p27() then
			break
		end
		v28 = v28 + 1
		p23.MaxVisibleGraphemes = v28
		if p26 then
			v_u_12.PlaybackSpeed = math.random(80, 110) / 100
			v_u_12:Play()
		end
		task.wait(p25)
	end
	p23.MaxVisibleGraphemes = -1
end
local function v_u_38(p_u_30, p_u_31, p_u_32, p_u_33, p34, p_u_35)
	-- upvalues: (copy) v_u_29
	local v36 = coroutine.create(function()
		-- upvalues: (ref) v_u_29, (copy) p_u_30, (copy) p_u_32, (copy) p_u_33, (copy) p_u_35
		v_u_29(p_u_30, p_u_32, p_u_33, true, p_u_35)
	end)
	local v37 = coroutine.create(function()
		-- upvalues: (ref) v_u_29, (copy) p_u_31, (copy) p_u_32, (copy) p_u_33, (copy) p_u_35
		v_u_29(p_u_31, p_u_32:gsub("color%s*=%s*\"#%x+\"", "color=\"#000000\""):gsub("color%s*=%s*\"rgb%b()\"", "color=\"#000000\""):gsub("color%s*=%s*\'#%x+\'", "color=\"#000000\""):gsub("color%s*=%s*\'rgb%b()\'", "color=\"#000000\""), p_u_33, false, p_u_35)
	end)
	coroutine.resume(v36)
	coroutine.resume(v37)
	while (coroutine.status(v36) ~= "dead" or coroutine.status(v37) ~= "dead") and not (p34 and p34()) do
		task.wait()
	end
end
local function v_u_47(p39, p40)
	-- upvalues: (copy) v_u_15, (copy) v_u_1
	local v_u_41 = {}
	for _, v42 in p39:GetDescendants() do
		local v43 = v_u_15(v42)
		if v42:IsA("GuiObject") or v42:IsA("UIStroke") then
			local v44 = {
				["obj"] = v42,
				["prop"] = v43,
				["original"] = v42[v43]
			}
			table.insert(v_u_41, v44)
			v42[v43] = 1
		end
	end
	task.delay(p40, function()
		-- upvalues: (copy) v_u_41, (ref) v_u_1
		local v45 = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		for _, v46 in v_u_41 do
			v_u_1:Create(v46.obj, v45, {
				[v46.prop] = v46.original
			}):Play()
		end
	end)
end
local v_u_48 = {}
v_u_48.__index = v_u_48
function v_u_48.new(p49)
	-- upvalues: (ref) v_u_10, (copy) v_u_2, (ref) v_u_11, (copy) v_u_48, (copy) v_u_8
	local v50 = p49.NPC
	assert(v50, "NPC is required")
	if not v_u_10 then
		local v51 = v_u_2:WaitForChild("Dialogue"):WaitForChild("DialogueTemplates")
		v_u_10 = v51:WaitForChild("OverheadSpeech")
		v_u_11 = v51:WaitForChild("Nametag")
	end
	local v52 = v_u_48
	local v53 = setmetatable({}, v52)
	v53.NPC = p49.NPC
	v53.ProximityPrompt = p49.ProximityPrompt or v53.NPC:FindFirstChildWhichIsA("ProximityPrompt", true)
	local v54 = v53.ProximityPrompt
	assert(v54, "ProximityPrompt not found on NPC")
	v53.RootPart = p49.RootPart or (v53.NPC:FindFirstChild("HumanoidRootPart") or v53.NPC.PrimaryPart)
	v53.Dialogue = p49.Dialogue or {}
	v53.HighlightColor = p49.HighlightColor or v_u_8.HighlightColor
	v53.MaxDistance = p49.MaxDistance or v_u_8.MaxInteractionDistance
	v53.TypewriterDelay = v_u_8.TypewriterDelay
	v53.DialogueDisplayTime = p49.DialogueDisplayTime or v_u_8.DialogueDisplayTime
	v53.DisplayTimePerCharacter = p49.DisplayTimePerCharacter or v_u_8.DisplayTimePerChar
	v53.Name = p49.Name or "NPC"
	v53.NametagBackgroundColor = p49.NametagBackgroundColor or v_u_8.NametagBackground
	v53.NametagTextColor = p49.NametagTextColor or v_u_8.NametagText
	v53.NametagStrokeColor = p49.NametagStrokeColor or v_u_8.NametagStroke
	v53.OnDialogueStart = p49.OnDialogueStart
	v53.OnDialogueEnd = p49.OnDialogueEnd
	v53.RandomLine = p49.RandomLine
	v53.Active = false
	v53.CurrentPlayer = nil
	v53.Cancelled = false
	v53.SkipRequested = false
	v53.SkipConnection = nil
	v53.NametagRestoreToken = 0
	v53.ActiveNPCBubble = nil
	v53.Connections = {}
	v53.ActiveGuis = {}
	v53:_setupHighlight()
	v53:_setupNametag()
	v53:_setupProximityPrompt()
	return v53
end
function v_u_48._setupHighlight(p55)
	local v56 = p55.NPC:FindFirstChild("DialogueHighlight")
	if not v56 then
		v56 = Instance.new("Highlight")
		v56.Name = "DialogueHighlight"
		v56.FillTransparency = 1
		v56.OutlineTransparency = 1
		v56.OutlineColor = p55.HighlightColor
		v56.DepthMode = Enum.HighlightDepthMode.Occluded
		v56.Adornee = p55.NPC
		v56.Parent = p55.NPC
	end
	p55.Highlight = v56
end
function v_u_48._setupNametag(p57)
	-- upvalues: (ref) v_u_11
	local v58 = p57.NPC:FindFirstChild("Head")
	if v58 then
		local v59 = v58:FindFirstChild("Nametag")
		if v59 then
			p57.Nametag = v59
		else
			local v60 = v_u_11:Clone()
			v60.Adornee = v58
			v60.Parent = v58
			local v61 = v60:WaitForChild("CanvasGroup")
			local v62 = v61:WaitForChild("Blur")
			local v63 = v62:WaitForChild("NPCName")
			v61:WaitForChild("Arrow").ImageColor3 = p57.NametagBackgroundColor
			v62.ImageColor3 = p57.NametagBackgroundColor
			v63.Text = p57.Name
			v63.TextColor3 = p57.NametagTextColor
			v63:WaitForChild("UIStroke").Color = p57.NametagStrokeColor
			v61.GroupTransparency = 1
			p57.Nametag = v60
		end
	else
		return
	end
end
function v_u_48._setupProximityPrompt(p_u_64)
	-- upvalues: (copy) v_u_1, (copy) v_u_8
	local v_u_65 = TweenInfo.new(0.2, Enum.EasingStyle.Sine)
	local v_u_66 = p_u_64.Nametag
	if v_u_66 then
		v_u_66 = p_u_64.Nametag:WaitForChild("CanvasGroup")
	end
	p_u_64:_connect(p_u_64.ProximityPrompt.PromptShown:Connect(function()
		-- upvalues: (copy) p_u_64, (ref) v_u_1, (copy) v_u_65, (ref) v_u_8, (copy) v_u_66
		if not p_u_64.NPC:GetAttribute("DisableDialogue") then
			v_u_1:Create(p_u_64.Highlight, v_u_65, {
				["OutlineTransparency"] = v_u_8.HighlightOutlineAlpha
			}):Play()
			if v_u_66 then
				v_u_1:Create(v_u_66, v_u_65, {
					["GroupTransparency"] = 0
				}):Play()
			end
		end
	end))
	p_u_64:_connect(p_u_64.ProximityPrompt.PromptHidden:Connect(function()
		-- upvalues: (ref) v_u_1, (copy) p_u_64, (copy) v_u_65, (copy) v_u_66
		v_u_1:Create(p_u_64.Highlight, v_u_65, {
			["OutlineTransparency"] = 1
		}):Play()
		if v_u_66 then
			v_u_1:Create(v_u_66, v_u_65, {
				["GroupTransparency"] = 1
			}):Play()
		end
	end))
	p_u_64:_connect(p_u_64.ProximityPrompt.Triggered:Connect(function(p67)
		-- upvalues: (copy) p_u_64
		p_u_64:StartDialogue(p67)
	end))
	p_u_64.ProximityPrompt.Enabled = true
end
function v_u_48._connect(p68, p69)
	local v70 = p68.Connections
	table.insert(v70, p69)
end
function v_u_48._hideNametag(p71)
	if p71.Nametag and p71.Nametag.Parent then
		p71.Nametag.Enabled = false
	end
end
function v_u_48._scheduleNametagRestore(p_u_72, p73)
	p_u_72.NametagRestoreToken = p_u_72.NametagRestoreToken + 1
	local v_u_74 = p_u_72.NametagRestoreToken
	task.delay(p73 or 0, function()
		-- upvalues: (copy) p_u_72, (copy) v_u_74
		if p_u_72.NametagRestoreToken == v_u_74 then
			if p_u_72.Nametag and p_u_72.Nametag.Parent then
				local v75 = p_u_72.NPC
				if v75 then
					v75 = p_u_72.NPC:FindFirstChild("Head")
				end
				if not (v75 and v75:FindFirstChild("OverheadSpeech")) then
					p_u_72.Nametag.Enabled = true
				end
			else
				return
			end
		else
			return
		end
	end)
end
local function v_u_80(p76, p77)
	for v78, v79 in ipairs(p76.ActiveGuis) do
		if v79 == p77 then
			table.remove(p76.ActiveGuis, v78)
			return
		end
	end
end
function v_u_48.DisplayNPCText(p_u_81, p82, p83)
	-- upvalues: (ref) v_u_10, (copy) v_u_38, (copy) v_u_22, (copy) v_u_8, (copy) v_u_80
	local v84 = p_u_81.NPC:FindFirstChild("Head")
	if not v84 then
		return nil
	end
	p_u_81:_hideNametag()
	local v85 = v84:FindFirstChild("OverheadSpeech")
	if v85 then
		v85:Destroy()
	end
	local v_u_86 = v_u_10:Clone()
	v_u_86.Name = "OverheadSpeech"
	v_u_86.Adornee = v84
	v_u_86.Parent = v84
	p_u_81.ActiveNPCBubble = v_u_86
	local v87 = p_u_81.TypewriterDelay
	local function v88()
		-- upvalues: (copy) p_u_81
		return p_u_81.Cancelled
	end
	local function v89()
		-- upvalues: (copy) p_u_81
		return p_u_81.SkipRequested
	end
	local v90 = v_u_86:FindFirstChild("CONTENT")
	local v91
	if v90 then
		v91 = v90:FindFirstChild("CONTENT_SHADOW")
	else
		v91 = v90
	end
	if v90 and v91 then
		v_u_38(v90, v91, p82, v87, v88, v89)
	end
	local v92 = p_u_81.ActiveGuis
	table.insert(v92, v_u_86)
	if p83 then
		task.delay(p83, function()
			-- upvalues: (copy) v_u_86, (ref) v_u_22, (ref) v_u_8, (copy) p_u_81, (ref) v_u_80
			if v_u_86 and v_u_86.Parent then
				v_u_22(v_u_86, v_u_8.FadeOutTime)
				if p_u_81.ActiveNPCBubble == v_u_86 then
					p_u_81.ActiveNPCBubble = nil
				end
				v_u_80(p_u_81, v_u_86)
				p_u_81:_scheduleNametagRestore(v_u_8.FadeOutTime + 0.3)
			end
		end)
	end
	return v_u_86
end
function v_u_48.DisplayPlayerResponse(p_u_93, p94, p95, p96)
	-- upvalues: (ref) v_u_10, (copy) v_u_38, (copy) v_u_8, (copy) v_u_22
	local v97 = p94.Character
	if v97 then
		v97 = p94.Character:FindFirstChild("Head")
	end
	if not v97 then
		return nil
	end
	local v98 = v97:FindFirstChild("OverheadSpeech")
	if v98 then
		v98:Destroy()
	end
	local v_u_99 = v_u_10:Clone()
	v_u_99.Name = "OverheadSpeech"
	v_u_99.Adornee = v97
	v_u_99.Parent = v97
	local v100 = p_u_93.TypewriterDelay
	local function v101()
		-- upvalues: (copy) p_u_93
		return p_u_93.Cancelled
	end
	local function v102()
		-- upvalues: (copy) p_u_93
		return p_u_93.SkipRequested
	end
	local v103 = v_u_99:FindFirstChild("CONTENT")
	local v104
	if v103 then
		v104 = v103:FindFirstChild("CONTENT_SHADOW")
	else
		v104 = v103
	end
	if v103 and v104 then
		v_u_38(v103, v104, p95, v100, v101, v102)
	end
	local v105 = p_u_93.ActiveGuis
	table.insert(v105, v_u_99)
	task.delay(p96 or v_u_8.PlayerResponseDisplay, function()
		-- upvalues: (copy) v_u_99, (ref) v_u_22, (ref) v_u_8
		if v_u_99 and v_u_99.Parent then
			v_u_22(v_u_99, v_u_8.FadeOutTime)
		end
	end)
	return v_u_99
end
function v_u_48.DisplayPlayerChoices(p_u_106, p107, p108)
	-- upvalues: (copy) v_u_47, (copy) v_u_13, (copy) v_u_5, (copy) v_u_7, (copy) v_u_6
	local v109 = p107:WaitForChild("PlayerGui"):WaitForChild("Billboard", 5)
	if not v109 then
		return nil
	end
	local v110 = v109:FindFirstChild("Options")
	local v111
	if v110 then
		v111 = v110:FindFirstChild("ChoiceTemplate")
	else
		v111 = v110
	end
	if not v111 then
		return nil
	end
	for _, v112 in v110:GetChildren() do
		if v112.Name:match("^Choice_") then
			v112:Destroy()
		end
	end
	task.wait()
	if p_u_106.Cancelled then
		return nil
	end
	local v113 = {}
	local v_u_114 = nil
	for v115, v_u_116 in ipairs(p108) do
		local v117 = v111:Clone()
		v117.Name = "Choice_" .. v115
		v117.Visible = true
		v117.Parent = v110
		local v118 = v117:FindFirstChild("CONTENT")
		if v118 and v118:IsA("TextButton") then
			local v119 = ("%*. %*"):format(v115, v_u_116.Text)
			v118.Text = v119
			local v120 = v118:FindFirstChild("CONTENT_SHADOW")
			if v120 then
				v120.Text = v119
			end
			v_u_47(v117, v115 * 0.1)
			local v121 = v118.MouseButton1Click
			local function v122()
				-- upvalues: (ref) v_u_114, (copy) v_u_116, (ref) v_u_13
				if not v_u_114 then
					v_u_114 = v_u_116
					v_u_13:Play()
				end
			end
			table.insert(v113, v121:Connect(v122))
		end
	end
	local v_u_123 = false
	if v_u_5.GamepadEnabled then
		local v_u_124 = v110:FindFirstChild("Choice_1")
		if v_u_124 then
			v_u_124 = v_u_124:FindFirstChild("CONTENT")
		end
		task.delay(0.3, function()
			-- upvalues: (ref) v_u_114, (copy) p_u_106, (ref) v_u_7, (ref) v_u_6, (copy) v_u_124, (ref) v_u_123
			if not (v_u_114 or p_u_106.Cancelled) then
				pcall(function()
					-- upvalues: (ref) v_u_7, (ref) v_u_6, (ref) v_u_124, (ref) v_u_123
					v_u_7.AutoSelectGuiEnabled = false
					v_u_6:EnableGamepadCursor(v_u_124)
					v_u_123 = true
				end)
			end
		end)
	end
	while not (v_u_114 or p_u_106.Cancelled) do
		task.wait()
	end
	if v_u_123 then
		pcall(function()
			-- upvalues: (ref) v_u_6
			v_u_6:DisableGamepadCursor()
		end)
		v_u_7.AutoSelectGuiEnabled = true
	end
	for _, v125 in v113 do
		v125:Disconnect()
	end
	for _, v126 in v110:GetChildren() do
		if v126.Name:match("^Choice_") then
			v126:Destroy()
		end
	end
	if p_u_106.Cancelled then
		v_u_114 = nil
	end
	return v_u_114
end
function v_u_48._checkDistance(p127, p128)
	local v129 = p128.Character
	if v129 and v129.PrimaryPart then
		local v130 = p127.RootPart or p127.NPC
		local v131
		if v130:IsA("BasePart") then
			v131 = v130.Position
		elseif v130:IsA("Model") then
			v131 = v130:GetPivot().Position
		elseif v130:IsA("Attachment") then
			v131 = v130.WorldPosition
		else
			v131 = nil
		end
		if v131 then
			return (v129.PrimaryPart.Position - v131).Magnitude <= p127.MaxDistance
		else
			return false
		end
	else
		return false
	end
end
function v_u_48._waitForDuration(p132, p133)
	local v134 = tick()
	while tick() - v134 < p133 and not (p132.SkipRequested or p132.Cancelled) do
		task.wait()
	end
	if p132.SkipRequested then
		task.wait(0.1)
	end
end
function v_u_48.StartDialogue(p_u_135, p_u_136)
	-- upvalues: (copy) v_u_5
	if p_u_135.Active or p_u_135.NPC:GetAttribute("DisableDialogue") then
		return
	end
	p_u_135:ForceCleanup()
	p_u_135.Active = true
	p_u_135.CurrentPlayer = p_u_136
	p_u_135.Cancelled = false
	p_u_135.SkipRequested = false
	p_u_135.ProximityPrompt.Enabled = false
	if p_u_135.OnDialogueStart then
		p_u_135.OnDialogueStart(p_u_136)
	end
	p_u_135.SkipConnection = v_u_5.InputBegan:Connect(function(p137, p138)
		-- upvalues: (copy) p_u_135
		if p138 then
			return
		else
			local v139 = p137.UserInputType
			if v139 == Enum.UserInputType.MouseButton1 or v139 == Enum.UserInputType.Touch then
				p_u_135.SkipRequested = true
			elseif p137.KeyCode == Enum.KeyCode.ButtonA or p137.KeyCode == Enum.KeyCode.ButtonB then
				p_u_135.SkipRequested = true
			end
		end
	end)
	local v_u_140 = task.spawn(function()
		-- upvalues: (copy) p_u_135, (copy) p_u_136
		while p_u_135.Active do
			task.wait(0.5)
			if not p_u_135:_checkDistance(p_u_136) then
				p_u_135:EndDialogue()
				return
			end
		end
	end)
	p_u_135:_connect({
		["Disconnect"] = function()
			-- upvalues: (copy) v_u_140
			task.cancel(v_u_140)
		end
	})
	local v141 = p_u_135.Dialogue
	if p_u_135.RandomLine then
		v141 = #v141 > 0 and { v141[math.random(1, #v141)] } or v141
	end
	for _, v142 in ipairs(v141) do
		if p_u_135.Cancelled then
			break
		end
		p_u_135.SkipRequested = false
		if type(v142) == "string" then
			p_u_135:_processStringItem(v142)
		elseif type(v142) == "table" then
			p_u_135:_processTableItem(v142, p_u_136)
		end
	end
	if p_u_135.Active then
		p_u_135:EndDialogue()
	end
end
function v_u_48._processStringItem(p143, p144)
	local v145 = p143.DialogueDisplayTime
	local v146 = p143.DisplayTimePerCharacter
	local v147 = v145 + (utf8.len(p144) or #p144) * v146
	p143:DisplayNPCText(p144, v147)
	p143:_waitForDuration(v147)
end
function v_u_48._processTableItem(p148, p149, p150)
	-- upvalues: (copy) v_u_8
	if p149.Text then
		p148:DisplayNPCText(p149.Text)
		local v151 = tick()
		while tick() - v151 < 0.5 and not p148.SkipRequested do
			task.wait()
		end
	end
	if p149.Choices and #p149.Choices ~= 0 then
		local v152 = p148:DisplayPlayerChoices(p150, p149.Choices)
		if v152 then
			p148.SkipRequested = false
			local v153 = v152.Text
			local v154 = v_u_8.DisplayTimePerChar
			local v155 = (utf8.len(v153) or #v153) * v154 + 1
			p148:DisplayPlayerResponse(p150, v152.Text, v155)
			p148:_waitForDuration(v155)
			p148.SkipRequested = false
			task.wait(0.1)
			if v152.Run then
				pcall(v152.Run, p150, p148)
			end
		end
	else
		return
	end
end
function v_u_48.EndDialogue(p156)
	if p156.Active then
		p156.Cancelled = true
		p156.Active = false
		if p156.SkipConnection then
			p156.SkipConnection:Disconnect()
			p156.SkipConnection = nil
		end
		p156:ForceCleanup()
		if p156.OnDialogueEnd then
			p156.OnDialogueEnd()
		end
		task.wait(0.5)
		p156.ProximityPrompt.Enabled = true
	end
end
function v_u_48.ForceCleanup(p157)
	-- upvalues: (copy) v_u_22, (copy) v_u_8, (copy) v_u_9
	local v158 = p157.ActiveNPCBubble
	if v158 then
		v158 = p157.ActiveNPCBubble.Parent ~= nil
	end
	for _, v159 in p157.ActiveGuis do
		if v159 and v159.Parent then
			v_u_22(v159, v_u_8.FadeOutTime)
		end
	end
	p157.ActiveGuis = {}
	p157.ActiveNPCBubble = nil
	local v160 = v_u_9:FindFirstChild("PlayerGui")
	local v161 = v160 and v160:FindFirstChild("Billboard")
	if v161 then
		v161 = v160.Billboard:FindFirstChild("Options")
	end
	if v161 then
		for _, v162 in v161:GetChildren() do
			if v162.Name:match("^Choice_") then
				v162:Destroy()
			end
		end
	end
	local v163 = v_u_9.Character
	if v163 then
		v163 = v_u_9.Character:FindFirstChild("Head")
	end
	if v163 then
		v163 = v163:FindFirstChild("OverheadSpeech")
	end
	if v163 then
		v_u_22(v163, v_u_8.FadeOutTime)
	end
	if v158 then
		p157:_scheduleNametagRestore(v_u_8.FadeOutTime + 0.3)
	elseif p157.Nametag and p157.Nametag.Parent then
		p157.Nametag.Enabled = true
	end
end
function v_u_48.Destroy(p164)
	p164:EndDialogue()
	if p164.SkipConnection then
		p164.SkipConnection:Disconnect()
		p164.SkipConnection = nil
	end
	for _, v165 in p164.Connections do
		if v165.Disconnect then
			v165:Disconnect()
		end
	end
	if p164.Highlight then
		p164.Highlight:Destroy()
	end
	table.clear(p164.Connections)
	table.clear(p164.ActiveGuis)
end
function v_u_48.IsActive(p166)
	return p166.Active
end
return v_u_48