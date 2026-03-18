local v1 = game:GetService("Players")
local v_u_2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("ProximityPromptService")
local v5 = game:GetService("ReplicatedStorage")
local v6 = game:GetService("TextChatService")
local v7 = game:GetService("SoundService")
local v_u_8 = game:GetService("GuiService")
local v_u_9 = game:GetService("CollectionService")
local v_u_10 = v1.LocalPlayer
local v_u_11 = v_u_10:WaitForChild("PlayerGui")
local v_u_12 = v5:WaitForChild("RemoteEvents"):WaitForChild("HarvestFruit")
local v_u_13 = v6:WaitForChild("ChatInputBarConfiguration")
local v_u_14 = v7:WaitForChild("SFX"):WaitForChild("Player"):WaitForChild("Harvesting")
require(v5:WaitForChild("Tutorial"):WaitForChild("TutorialController"))
local v_u_15 = require(v5:WaitForChild("Player"):WaitForChild("NotificationService"))
local v_u_16 = require(v5:WaitForChild("PlotStreaming"):WaitForChild("PlotStreamingSignals"))
local v17 = require(v_u_10.PlayerScripts:WaitForChild("Gears"):WaitForChild("FavoriteToolController"))
local v_u_18 = v_u_11:WaitForChild("HarvestButton")
local v_u_19 = v_u_18:WaitForChild("HarvestButton")
local v_u_20 = v_u_19:WaitForChild("Icon")
local v_u_21 = false
local v_u_22 = false
local v_u_23 = 0
local v_u_24 = 0
local v_u_25 = 0
local v_u_26 = {}
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = 0
local v_u_30 = nil
local v_u_31 = {}
local v_u_32 = false
local v_u_33 = false
local v_u_34 = "PC"
local v_u_35 = {}
local v_u_36 = {}
local v_u_37 = false
local v_u_38 = 0
local v_u_39 = {}
if v_u_8:IsTenFootInterface() then
	v_u_34 = "Console"
elseif v_u_2.TouchEnabled then
	v_u_34 = "Mobile"
else
	v_u_34 = "PC"
end
v_u_2.LastInputTypeChanged:Connect(function(p40)
	-- upvalues: (ref) v_u_34, (copy) v_u_9, (ref) v_u_35, (ref) v_u_33, (copy) v_u_19
	if p40 == Enum.UserInputType.Touch then
		v_u_34 = "Mobile"
		for _, v41 in v_u_9:GetTagged("HarvestPrompt") do
			v41:SetAttribute("NoTouch", nil)
			if v_u_34 == "Mobile" then
				v41:SetAttribute("TapOnly", true)
			else
				v41:SetAttribute("TapOnly", nil)
			end
		end
		if v_u_34 == "Mobile" then
			if next(v_u_35) or v_u_33 then
				v_u_19.Visible = true
			else
				v_u_19.Visible = false
			end
		end
		if not v_u_33 then
			v_u_19.Visible = false
			return
		end
	elseif string.find(p40.Name, "Gamepad") then
		v_u_34 = "Console"
		for _, v42 in v_u_9:GetTagged("HarvestPrompt") do
			v42:SetAttribute("NoTouch", nil)
			if v_u_34 == "Mobile" then
				v42:SetAttribute("TapOnly", true)
			else
				v42:SetAttribute("TapOnly", nil)
			end
		end
		if v_u_34 == "Mobile" then
			if next(v_u_35) or v_u_33 then
				v_u_19.Visible = true
			else
				v_u_19.Visible = false
			end
		end
		if not v_u_33 then
			v_u_19.Visible = false
			return
		end
	elseif p40 == Enum.UserInputType.Keyboard or string.find(p40.Name, "Mouse") then
		v_u_34 = "PC"
		for _, v43 in v_u_9:GetTagged("HarvestPrompt") do
			v43:SetAttribute("NoTouch", nil)
			if v_u_34 == "Mobile" then
				v43:SetAttribute("TapOnly", true)
			else
				v43:SetAttribute("TapOnly", nil)
			end
		end
		if v_u_34 == "Mobile" then
			if next(v_u_35) or v_u_33 then
				v_u_19.Visible = true
			else
				v_u_19.Visible = false
			end
		end
		if not v_u_33 then
			v_u_19.Visible = false
		end
	end
end)
v_u_2.GamepadConnected:Connect(function()
	-- upvalues: (ref) v_u_34, (copy) v_u_9, (ref) v_u_35, (ref) v_u_33, (copy) v_u_19
	v_u_34 = "Console"
	for _, v44 in v_u_9:GetTagged("HarvestPrompt") do
		v44:SetAttribute("NoTouch", nil)
		if v_u_34 == "Mobile" then
			v44:SetAttribute("TapOnly", true)
		else
			v44:SetAttribute("TapOnly", nil)
		end
	end
	if v_u_34 == "Mobile" then
		if next(v_u_35) or v_u_33 then
			v_u_19.Visible = true
		else
			v_u_19.Visible = false
		end
	else
		if not v_u_33 then
			v_u_19.Visible = false
		end
		return
	end
end)
v_u_2.GamepadDisconnected:Connect(function()
	-- upvalues: (copy) v_u_8, (ref) v_u_34, (copy) v_u_9, (ref) v_u_35, (ref) v_u_33, (copy) v_u_19
	if not v_u_8:IsTenFootInterface() then
		v_u_34 = "PC"
		for _, v45 in v_u_9:GetTagged("HarvestPrompt") do
			v45:SetAttribute("NoTouch", nil)
			if v_u_34 == "Mobile" then
				v45:SetAttribute("TapOnly", true)
			else
				v45:SetAttribute("TapOnly", nil)
			end
		end
		if v_u_34 == "Mobile" then
			if next(v_u_35) or v_u_33 then
				v_u_19.Visible = true
			else
				v_u_19.Visible = false
			end
		end
		if not v_u_33 then
			v_u_19.Visible = false
		end
	end
end)
local function v51()
	-- upvalues: (copy) v_u_18, (copy) v_u_19, (copy) v_u_20
	local v46 = v_u_18.AbsoluteSize
	local v47 = v46.X
	local v48 = v46.Y
	local v49 = math.min(v47, v48) <= 500
	local v50 = v49 and 70 or 120
	v_u_19.Size = UDim2.new(0, v50, 0, v50)
	v_u_20.Size = UDim2.new(0, v50 * 0.5, 0, v50 * 0.6)
	if v49 then
		v_u_19.Position = UDim2.new(1, -(v50 * 1.5 - 10), 1, -v50 - 20 - v50 - 15)
	else
		v_u_19.Position = UDim2.new(1, -(v50 * 1.5 - 10), 1, -v50 * 1.75 - v50 - 15)
	end
end
v51()
v_u_18:GetPropertyChangedSignal("AbsoluteSize"):Connect(v51)
local function v_u_53()
	-- upvalues: (ref) v_u_31, (ref) v_u_32, (copy) v_u_12
	if #v_u_31 == 0 then
		v_u_32 = false
	else
		local v52 = v_u_31
		v_u_31 = {}
		v_u_32 = false
		v_u_12:FireServer(v52)
	end
end
local function v_u_59()
	-- upvalues: (copy) v_u_10
	local v54 = 0
	local v55 = v_u_10:FindFirstChild("Backpack")
	if v55 then
		for _, v56 in v55:GetChildren() do
			if v56:IsA("Tool") then
				v54 = v54 + 1
			end
		end
	end
	local v57 = v_u_10.Character
	if v57 then
		for _, v58 in v57:GetChildren() do
			if v58:IsA("Tool") then
				v54 = v54 + 1
			end
		end
	end
	return v54 >= 300
end
local function v_u_62(p60)
	-- upvalues: (copy) v_u_10
	if not (p60 and p60.Parent) then
		return false
	end
	local v61
	if p60 and p60.Parent then
		v61 = p60.Parent
		if not v61:IsA("Model") and (v61:IsA("BasePart") and v61.Parent:IsA("Model")) then
			v61 = v61.Parent
		end
	else
		v61 = nil
	end
	if not v61 then
		return false
	end
	if not v61:GetAttribute("OwnerUserId") and (v61.Parent and v61.Parent:IsA("Model")) then
		v61 = v61.Parent
	end
	return v61:GetAttribute("OwnerUserId") == v_u_10.UserId
end
local function v_u_64()
	-- upvalues: (copy) v_u_14, (copy) v_u_11
	local v_u_63 = v_u_14:Clone()
	v_u_63.PlaybackSpeed = 1 + (math.random() * 2 - 1) * 0.15
	v_u_63.Parent = v_u_11
	v_u_63:Play()
	v_u_63.Ended:Once(function()
		-- upvalues: (copy) v_u_63
		v_u_63:Destroy()
	end)
end
local function v_u_73()
	-- upvalues: (copy) v_u_10, (ref) v_u_35, (ref) v_u_26
	local v65 = v_u_10.Character
	if not v65 then
		return next(v_u_35)
	end
	local v66 = v65:FindFirstChild("HumanoidRootPart")
	if not v66 then
		return next(v_u_35)
	end
	local v67 = v66.Position
	local v68 = (1 / 0)
	local v69 = nil
	for v70 in v_u_35 do
		if not v_u_26[v70] and (v70 and v70.Parent) then
			local v71 = v70.Parent
			if v71:IsA("BasePart") then
				local v72 = (v71.Position - v67).Magnitude
				if v72 < v68 then
					v69 = v70
					v68 = v72
				end
			end
		end
	end
	return v69 or next(v_u_35)
end
local function v_u_79(p74)
	if not (p74 and p74.Parent) then
		return nil
	end
	local v75 = p74.Parent
	if v75:IsA("BasePart") then
		v75 = v75.Parent
	end
	if not (v75 and v75:IsA("Model")) then
		return nil
	end
	if v75:GetAttribute("HarvestablePlant") == true then
		local v76 = v75:GetAttribute("Uuid")
		return v76 and {
			["Uuid"] = v76
		} or nil
	end
	local v77 = v75.Parent
	if not (v77 and v77:IsA("Model")) then
		return nil
	end
	local v78 = v77:GetAttribute("Uuid")
	return v78 and {
		["Uuid"] = v78,
		["GrowthAnchorIndex"] = v75:GetAttribute("GrowthAnchorIndex")
	} or nil
end
local function v_u_89(p_u_80, p81)
	-- upvalues: (ref) v_u_26, (copy) v_u_62, (copy) v_u_59, (ref) v_u_38, (copy) v_u_15, (copy) v_u_79, (copy) v_u_16, (ref) v_u_25, (ref) v_u_31, (ref) v_u_32, (copy) v_u_53, (copy) v_u_64, (ref) v_u_28, (ref) v_u_37, (ref) v_u_39, (ref) v_u_35, (ref) v_u_27, (copy) v_u_73
	if p_u_80 and not v_u_26[p_u_80] then
		local v82 = p_u_80.Parent
		if v82 and v82:GetAttribute("Favorited") then
			return
		elseif v_u_62(p_u_80) then
			if v_u_59() then
				local v83 = os.clock()
				if v83 - v_u_38 >= 3 then
					v_u_38 = v83
					v_u_15.Notify("Your inventory is full! Sell or remove items to make space.", 4, Color3.fromRGB(255, 85, 85))
				end
			else
				if p_u_80 and p_u_80.Parent then
					local v84 = p_u_80.Parent
					if not v84:IsA("Model") and (v84:IsA("BasePart") and v84.Parent:IsA("Model")) then
						local _ = v84.Parent
					end
				end
				p_u_80.Enabled = false
				local v85 = v_u_79(p_u_80)
				local v_u_86
				if p_u_80 and p_u_80.Parent then
					v_u_86 = p_u_80.Parent
					if not v_u_86:IsA("Model") and (v_u_86:IsA("BasePart") and v_u_86.Parent:IsA("Model")) then
						v_u_86 = v_u_86.Parent
					end
				else
					v_u_86 = nil
				end
				if v_u_86 then
					v_u_86:SetAttribute("IsHarvested", true)
					if v85 then
						if v85.GrowthAnchorIndex then
							task.defer(v_u_16.FireLocalHarvestFruit, v85.Uuid, v85.GrowthAnchorIndex)
						else
							task.defer(v_u_16.FireLocalHarvestPlant, v85.Uuid)
						end
					end
				end
				v_u_25 = os.clock()
				v_u_26[p_u_80] = true
				if not p81 and v85 then
					local v87 = v_u_31
					table.insert(v87, v85)
					if not v_u_32 then
						v_u_32 = true
						task.delay(0.1, v_u_53)
					end
				end
				v_u_64()
				v_u_28 = nil
				task.delay(3, function()
					-- upvalues: (copy) p_u_80, (ref) v_u_26, (ref) v_u_37, (copy) v_u_86
					if p_u_80 and (p_u_80.Parent and (p_u_80:IsDescendantOf(workspace) and v_u_26[p_u_80])) then
						v_u_26[p_u_80] = nil
						if not v_u_37 then
							p_u_80.Enabled = true
						end
						if v_u_86 and v_u_86.Parent then
							v_u_86:SetAttribute("IsHarvested", nil)
						end
					end
				end)
				if v_u_39[p_u_80] then
					v_u_39[p_u_80]:Disconnect()
					v_u_39[p_u_80] = nil
				end
				v_u_39[p_u_80] = p_u_80.AncestryChanged:Connect(function()
					-- upvalues: (copy) p_u_80, (ref) v_u_26, (ref) v_u_35, (ref) v_u_39, (ref) v_u_27, (ref) v_u_73, (ref) v_u_28
					if not p_u_80:IsDescendantOf(workspace) then
						local v88 = p_u_80
						v_u_26[v88] = nil
						v_u_35[v88] = nil
						if v_u_39[v88] then
							v_u_39[v88]:Disconnect()
							v_u_39[v88] = nil
						end
						if v88 == v_u_27 then
							v_u_27 = v_u_73()
						end
						if v88 == v_u_28 then
							v_u_28 = nil
						end
					end
				end)
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_92()
	-- upvalues: (ref) v_u_21, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (ref) v_u_33, (ref) v_u_27, (ref) v_u_28, (ref) v_u_35, (ref) v_u_26, (ref) v_u_39, (ref) v_u_31, (ref) v_u_32, (copy) v_u_12, (ref) v_u_30, (copy) v_u_19
	v_u_21 = false
	v_u_22 = false
	v_u_23 = 0
	v_u_24 = 0
	v_u_33 = false
	v_u_27 = nil
	v_u_28 = nil
	v_u_35 = {}
	v_u_26 = {}
	for _, v90 in v_u_39 do
		v90:Disconnect()
	end
	v_u_39 = {}
	if #v_u_31 == 0 then
		v_u_32 = false
	else
		local v91 = v_u_31
		v_u_31 = {}
		v_u_32 = false
		v_u_12:FireServer(v91)
	end
	if v_u_30 then
		v_u_30:Destroy()
		v_u_30 = nil
	end
	v_u_19.Visible = false
end
local v_u_93 = {}
local function v_u_96()
	-- upvalues: (ref) v_u_37, (ref) v_u_93
	v_u_37 = false
	for v94 in v_u_93 do
		if v94 and v94.Parent then
			local v95 = v94.Parent
			if not (v95:IsA("Model") and v95:GetAttribute("Favorited") or v95:IsA("BasePart") and (v95.Parent and v95.Parent:GetAttribute("Favorited"))) then
				v94.Enabled = true
				v94.UIOffset = Vector2.new(0, 0)
			end
		end
	end
	v_u_93 = {}
end
local function v104(p_u_97)
	-- upvalues: (ref) v_u_34, (ref) v_u_37, (ref) v_u_26, (copy) v_u_62, (ref) v_u_93, (copy) v_u_10
	if p_u_97:IsA("ProximityPrompt") then
		p_u_97.HoldDuration = 0.01
		p_u_97:SetAttribute("NoTouch", nil)
		if v_u_34 == "Mobile" then
			p_u_97:SetAttribute("TapOnly", true)
		else
			p_u_97:SetAttribute("TapOnly", nil)
		end
		local v_u_98 = p_u_97.MaxActivationDistance
		p_u_97:SetAttribute("DefaultDistance", v_u_98)
		p_u_97.MaxActivationDistance = 0
		local v_u_99 = p_u_97.Parent
		if not (v_u_99 and v_u_99:IsA("Model")) and v_u_99 then
			v_u_99 = v_u_99.Parent
		end
		if v_u_99 and v_u_99:IsA("Model") then
			v_u_99:GetAttributeChangedSignal("Favorited"):Connect(function()
				-- upvalues: (copy) v_u_99, (copy) p_u_97, (ref) v_u_37, (ref) v_u_26
				if v_u_99:GetAttribute("Favorited") then
					p_u_97.Enabled = false
				elseif not (v_u_37 or v_u_26[p_u_97]) then
					p_u_97.Enabled = true
					p_u_97.UIOffset = Vector2.new(0, 0)
				end
			end)
		end
		task.defer(function()
			-- upvalues: (copy) p_u_97, (ref) v_u_62, (copy) v_u_98, (ref) v_u_37, (ref) v_u_93, (ref) v_u_10
			if p_u_97 and p_u_97.Parent then
				if v_u_62(p_u_97) then
					if v_u_37 then
						p_u_97.MaxActivationDistance = v_u_98
						local v100 = p_u_97
						if v100.Enabled then
							v_u_93[v100] = true
							v100.Enabled = false
							v100.UIOffset = Vector2.new(100000, 100000)
						end
					else
						local v101 = v_u_10.Character
						if v101 then
							for _, v102 in v101:GetChildren() do
								if v102:IsA("Tool") and v102:GetAttribute("GearName") == "Trowel" then
									p_u_97.MaxActivationDistance = v_u_98
									p_u_97.Enabled = false
									return
								end
							end
						end
						local v103 = p_u_97.Parent
						if v103 then
							if not v103:IsA("Model") then
								v103 = v103.Parent
							end
							if v103 and v103:GetAttribute("Favorited") then
								p_u_97.Enabled = false
								p_u_97.MaxActivationDistance = v_u_98
								return
							end
						end
						p_u_97.MaxActivationDistance = v_u_98
						return
					end
				else
					p_u_97.MaxActivationDistance = v_u_98
					p_u_97.Enabled = false
					return
				end
			else
				return
			end
		end)
	end
end
local v_u_105 = v_u_35
local v_u_106 = v_u_93
local v_u_107 = v_u_33
local v_u_108 = v_u_34
for _, v109 in v_u_9:GetTagged("HarvestPrompt") do
	v104(v109)
end
v_u_9:GetInstanceAddedSignal("HarvestPrompt"):Connect(v104)
local function v_u_158()
	-- upvalues: (ref) v_u_36, (copy) v_u_4, (copy) v_u_10, (copy) v_u_89, (copy) v_u_62, (ref) v_u_105, (ref) v_u_27, (ref) v_u_22, (ref) v_u_24, (ref) v_u_108, (ref) v_u_107, (copy) v_u_19, (copy) v_u_73, (copy) v_u_2, (copy) v_u_13, (ref) v_u_21, (ref) v_u_23, (ref) v_u_31, (ref) v_u_32, (copy) v_u_12, (copy) v_u_3, (ref) v_u_28, (ref) v_u_26, (ref) v_u_25, (ref) v_u_29, (ref) v_u_30
	local v110 = v_u_36
	local v111 = v_u_4.PromptTriggered
	local function v114(p112, p113)
		-- upvalues: (ref) v_u_10, (ref) v_u_89
		if p113 == v_u_10 then
			if p112.Name == "HarvestPrompt" then
				v_u_89(p112)
			end
		else
			return
		end
	end
	table.insert(v110, v111:Connect(v114))
	local v115 = v_u_36
	local v116 = v_u_4.PromptShown
	local function v121(p117)
		-- upvalues: (ref) v_u_62, (ref) v_u_105, (ref) v_u_27, (ref) v_u_22, (ref) v_u_24, (ref) v_u_108, (ref) v_u_107, (ref) v_u_19
		if p117.Name == "HarvestPrompt" then
			if v_u_62(p117) then
				local v118 = p117.Parent
				if v118 then
					if not v118:IsA("Model") then
						v118 = v118.Parent
					end
					if v118 and v118:GetAttribute("Favorited") then
						p117.Enabled = false
						return
					end
				end
				v_u_105[p117] = true
				v_u_27 = p117
				if v_u_22 then
					local v119
					if v_u_22 then
						local v120 = (os.clock() - v_u_24) / 2.5
						v119 = 0.4 - (1 - (1 - math.min(v120, 1)) ^ 2) * 0.30000000000000004
					else
						v119 = 0.4
					end
					p117.HoldDuration = v119
				end
				if v_u_108 == "Mobile" then
					if next(v_u_105) or v_u_107 then
						v_u_19.Visible = true
					else
						v_u_19.Visible = false
					end
				else
					if not v_u_107 then
						v_u_19.Visible = false
					end
					return
				end
			else
				p117.Enabled = false
				return
			end
		else
			return
		end
	end
	table.insert(v115, v116:Connect(v121))
	local v122 = v_u_36
	local v123 = v_u_4.PromptHidden
	local function v125(p124)
		-- upvalues: (ref) v_u_105, (ref) v_u_27, (ref) v_u_73, (ref) v_u_108, (ref) v_u_107, (ref) v_u_19
		if p124.Name == "HarvestPrompt" then
			v_u_105[p124] = nil
			if p124 == v_u_27 then
				v_u_27 = v_u_73()
			end
			task.delay(0.15, function()
				-- upvalues: (ref) v_u_105, (ref) v_u_108, (ref) v_u_107, (ref) v_u_19
				if not next(v_u_105) then
					if v_u_108 == "Mobile" then
						if next(v_u_105) or v_u_107 then
							v_u_19.Visible = true
						else
							v_u_19.Visible = false
						end
					end
					if not v_u_107 then
						v_u_19.Visible = false
					end
				end
			end)
		end
	end
	table.insert(v122, v123:Connect(v125))
	local v126 = v_u_36
	local v127 = v_u_19.MouseButton1Down
	local function v128()
		-- upvalues: (ref) v_u_2, (ref) v_u_13, (ref) v_u_107, (ref) v_u_21, (ref) v_u_23, (ref) v_u_22, (ref) v_u_27, (ref) v_u_108, (ref) v_u_89
		if not (v_u_2:GetFocusedTextBox() or v_u_13 and v_u_13.IsFocused) then
			v_u_107 = true
			v_u_21 = true
			v_u_23 = os.clock()
			v_u_22 = false
			if v_u_27 then
				if v_u_108 == "Mobile" then
					v_u_89(v_u_27)
					return
				end
				v_u_27:InputHoldBegin()
			end
		end
	end
	table.insert(v126, v127:Connect(v128))
	local v129 = v_u_36
	local v130 = v_u_19.MouseButton1Up
	local function v132()
		-- upvalues: (ref) v_u_107, (ref) v_u_21, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (ref) v_u_31, (ref) v_u_32, (ref) v_u_12, (ref) v_u_27, (ref) v_u_108, (ref) v_u_105, (ref) v_u_19
		v_u_107 = false
		v_u_21 = false
		v_u_22 = false
		v_u_23 = 0
		v_u_24 = 0
		if #v_u_31 == 0 then
			v_u_32 = false
		else
			local v131 = v_u_31
			v_u_31 = {}
			v_u_32 = false
			v_u_12:FireServer(v131)
		end
		if v_u_27 and v_u_108 ~= "Mobile" then
			v_u_27:InputHoldEnd()
		end
		if v_u_108 == "Mobile" then
			if next(v_u_105) or v_u_107 then
				v_u_19.Visible = true
			else
				v_u_19.Visible = false
			end
		else
			if not v_u_107 then
				v_u_19.Visible = false
			end
			return
		end
	end
	table.insert(v129, v130:Connect(v132))
	local v133 = v_u_36
	local v134 = v_u_2.InputBegan
	local function v136(p135, _)
		-- upvalues: (ref) v_u_2, (ref) v_u_13, (ref) v_u_21, (ref) v_u_23, (ref) v_u_22
		if not (v_u_2:GetFocusedTextBox() or v_u_13 and v_u_13.IsFocused) then
			if p135.KeyCode == Enum.KeyCode.E or p135.KeyCode == Enum.KeyCode.ButtonX then
				v_u_21 = true
				v_u_23 = os.clock()
				v_u_22 = false
			end
		end
	end
	table.insert(v133, v134:Connect(v136))
	local v137 = v_u_36
	local v138 = v_u_2.InputEnded
	local function v142(p139)
		-- upvalues: (ref) v_u_21, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (ref) v_u_31, (ref) v_u_32, (ref) v_u_12, (ref) v_u_107, (ref) v_u_27, (ref) v_u_108, (ref) v_u_105, (ref) v_u_19
		if p139.KeyCode == Enum.KeyCode.E or p139.KeyCode == Enum.KeyCode.ButtonX then
			v_u_21 = false
			v_u_22 = false
			v_u_23 = 0
			v_u_24 = 0
			if #v_u_31 == 0 then
				v_u_32 = false
			else
				local v140 = v_u_31
				v_u_31 = {}
				v_u_32 = false
				v_u_12:FireServer(v140)
			end
		end
		if v_u_107 and (p139.UserInputType == Enum.UserInputType.Touch or p139.UserInputType == Enum.UserInputType.MouseButton1) then
			v_u_107 = false
			v_u_21 = false
			v_u_22 = false
			v_u_23 = 0
			v_u_24 = 0
			if #v_u_31 == 0 then
				v_u_32 = false
			else
				local v141 = v_u_31
				v_u_31 = {}
				v_u_32 = false
				v_u_12:FireServer(v141)
			end
			if v_u_27 and v_u_108 ~= "Mobile" then
				v_u_27:InputHoldEnd()
			end
			if v_u_108 == "Mobile" then
				if next(v_u_105) or v_u_107 then
					v_u_19.Visible = true
				else
					v_u_19.Visible = false
				end
			end
			if not v_u_107 then
				v_u_19.Visible = false
			end
		end
	end
	table.insert(v137, v138:Connect(v142))
	local v143 = v_u_36
	local v144 = v_u_3.Heartbeat
	local function v151()
		-- upvalues: (ref) v_u_21, (ref) v_u_2, (ref) v_u_13, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (ref) v_u_28, (ref) v_u_26, (ref) v_u_25, (ref) v_u_29, (ref) v_u_89
		if v_u_21 and not (v_u_2:GetFocusedTextBox() or v_u_13 and v_u_13.IsFocused) then
			if v_u_22 then
				if v_u_28 and not v_u_26[v_u_28] then
					local v145 = v_u_28
					local v146
					if v_u_22 then
						local v147 = (os.clock() - v_u_24) / 2.5
						v146 = 0.4 - (1 - (1 - math.min(v147, 1)) ^ 2) * 0.30000000000000004
					else
						v146 = 0.4
					end
					v145.HoldDuration = v146
				end
				local v148 = os.clock() - v_u_25
				local v149
				if v_u_22 then
					local v150 = (os.clock() - v_u_24) / 2.5
					v149 = 0.4 - (1 - (1 - math.min(v150, 1)) ^ 2) * 0.30000000000000004
				else
					v149 = 0.4
				end
				if v148 >= v149 then
					if v_u_28 then
						if os.clock() - v_u_29 < 0.1 then
							return
						end
						v_u_89(v_u_28)
					end
				end
			else
				if os.clock() - v_u_23 >= 0.8 then
					v_u_22 = true
					v_u_24 = os.clock()
				end
				return
			end
		else
			return
		end
	end
	table.insert(v143, v144:Connect(v151))
	local v152 = v_u_36
	local v153 = v_u_3.RenderStepped
	local function v157()
		-- upvalues: (ref) v_u_22, (ref) v_u_73, (ref) v_u_27, (ref) v_u_28, (ref) v_u_29, (ref) v_u_30
		local v154
		if v_u_22 then
			v154 = v_u_73()
		else
			v154 = v_u_27
		end
		if v154 ~= v_u_28 then
			v_u_28 = v154
			v_u_29 = os.clock()
		end
		local v155 = v_u_28
		if v155 then
			local v156 = v_u_28
			if v156 and v156.Parent then
				v155 = v156.Parent
				if not v155:IsA("Model") and (v155:IsA("BasePart") and v155.Parent:IsA("Model")) then
					v155 = v155.Parent
				end
			else
				v155 = nil
			end
		end
		if v155 then
			if v_u_30 and not v_u_30:IsDescendantOf(game) then
				v_u_30 = nil
			end
			if not v_u_30 then
				v_u_30 = Instance.new("Highlight")
				v_u_30.DepthMode = Enum.HighlightDepthMode.Occluded
				v_u_30.FillColor = Color3.fromRGB(255, 255, 255)
				v_u_30.OutlineColor = Color3.fromRGB(255, 255, 255)
				v_u_30.FillTransparency = 0.9
				v_u_30.OutlineTransparency = 0
			end
			if v_u_30.Parent ~= v155 then
				v_u_30.Parent = v155
				return
			end
		elseif v_u_30 then
			v_u_30:Destroy()
			v_u_30 = nil
		end
	end
	table.insert(v152, v153:Connect(v157))
end
local function v_u_160()
	-- upvalues: (ref) v_u_36, (copy) v_u_92
	for _, v159 in v_u_36 do
		v159:Disconnect()
	end
	v_u_36 = {}
	v_u_92()
end
v17.OnStateChanged(function(p161)
	-- upvalues: (copy) v_u_160, (ref) v_u_37, (copy) v_u_9, (ref) v_u_106, (copy) v_u_158, (copy) v_u_96
	if p161 then
		v_u_160()
		v_u_37 = true
		for _, v162 in v_u_9:GetTagged("HarvestPrompt") do
			if v162.Enabled then
				v_u_106[v162] = true
				v162.Enabled = false
				v162.UIOffset = Vector2.new(100000, 100000)
			end
		end
	else
		v_u_158()
		v_u_96()
	end
end)
v_u_158()