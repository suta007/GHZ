local v1 = game:GetService("Players")
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = v1.LocalPlayer
local v_u_6 = v_u_5.Character or v_u_5.CharacterAdded:Wait()
local v7 = script.Parent
local v_u_8 = v7:WaitForChild("Handle")
local v_u_9 = v7:WaitForChild("Dig")
local v_u_10 = v7:FindFirstChild("Idle")
local v_u_11 = v7:FindFirstChild("Equip")
local v_u_12 = {}
local v_u_13 = v_u_6:WaitForChild("Humanoid")
local v_u_14 = require(game:GetService("ReplicatedStorage"):WaitForChild("UI"):WaitForChild("ShovelConfirmationController"))
local v_u_15 = v_u_5:GetMouse()
local v_u_16 = game:GetService("SoundService"):WaitForChild("SFX"):WaitForChild("Player"):WaitForChild("Shovel")
v7:WaitForChild("ShovelHit")
local v_u_17 = v7:WaitForChild("ShovelHit")
local v_u_18 = v7:FindFirstChild("Hit")
local v_u_19 = Random.new()
local v_u_20 = false
local v_u_21 = false
local v_u_22 = false
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = {}
local v_u_27 = nil
local function v_u_31(p28, p29)
	for _, v30 in p28:GetDescendants() do
		if v30:IsA("ProximityPrompt") and v30.Name == "HarvestPrompt" then
			v30.Enabled = p29
		end
	end
end
local function v_u_36(p32, p33)
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_31
	for _, v34 in v_u_3:GetTagged("Plant") do
		if v34:GetAttribute("OwnerUserId") == v_u_5.UserId then
			if v34:GetAttribute("HarvestablePlant") and not (p33 and v34:GetAttribute("Favorited")) then
				v_u_31(v34, p32)
			end
			for _, v35 in v34:GetChildren() do
				if v35:IsA("Model") and not (p33 and v35:GetAttribute("Favorited")) then
					v_u_31(v35, p32)
				end
			end
		end
	end
end
local function v_u_45(p37)
	-- upvalues: (copy) v_u_5, (copy) v_u_31, (ref) v_u_20, (ref) v_u_26
	if p37:GetAttribute("OwnerUserId") == v_u_5.UserId then
		v_u_31(p37, false)
		for _, v38 in p37:GetChildren() do
			if v38:IsA("Model") then
				v_u_31(v38, false)
			end
		end
		local v43 = p37.ChildAdded:Connect(function(p_u_39)
			-- upvalues: (ref) v_u_20, (ref) v_u_31, (ref) v_u_26
			if v_u_20 then
				if p_u_39:IsA("Model") then
					v_u_31(p_u_39, false)
					local v_u_40 = nil
					v_u_40 = p_u_39:GetAttributeChangedSignal("FullyGrown"):Connect(function()
						-- upvalues: (ref) v_u_20, (ref) v_u_40, (copy) p_u_39, (ref) v_u_31
						if v_u_20 then
							if p_u_39:GetAttribute("FullyGrown") then
								v_u_31(p_u_39, false)
								v_u_40:Disconnect()
							end
						else
							v_u_40:Disconnect()
						end
					end)
					local v41 = v_u_26
					local v42 = v_u_40
					table.insert(v41, v42)
				end
			else
				return
			end
		end)
		local v44 = v_u_26
		table.insert(v44, v43)
	end
end
local function v_u_47()
	-- upvalues: (ref) v_u_26, (ref) v_u_27
	for _, v46 in v_u_26 do
		v46:Disconnect()
	end
	v_u_26 = {}
	if v_u_27 then
		v_u_27:Disconnect()
		v_u_27 = nil
	end
end
local function v_u_50(p48)
	-- upvalues: (copy) v_u_5
	if not p48 then
		return nil, nil
	end
	while p48 and p48 ~= workspace do
		if p48:IsA("Model") then
			if p48:GetAttribute("FruitSpawnTime") then
				local v49 = p48.Parent
				if v49 and (v49:IsA("Model") and (v49:GetAttribute("PlantType") and v49:GetAttribute("OwnerUserId") == v_u_5.UserId)) then
					return p48, "Fruit"
				else
					return nil, nil
				end
			end
			if p48:GetAttribute("PlantType") and p48:GetAttribute("OwnerUserId") == v_u_5.UserId then
				return p48, "Plant"
			end
		end
		p48 = p48.Parent
	end
	return nil, nil
end
local function v_u_52(p51)
	-- upvalues: (ref) v_u_24, (ref) v_u_23
	if not v_u_24 then
		v_u_24 = Instance.new("Highlight")
		v_u_24.Name = "ShovelHighlight"
		v_u_24.DepthMode = Enum.HighlightDepthMode.Occluded
		v_u_24.FillColor = Color3.fromRGB(255, 0, 0)
		v_u_24.OutlineColor = Color3.fromRGB(255, 255, 255)
		v_u_24.FillTransparency = 0.5
		v_u_24.OutlineTransparency = 1
	end
	if v_u_24.Parent ~= p51 then
		v_u_24.Parent = p51
	end
	v_u_23 = p51
end
local function v_u_56()
	-- upvalues: (ref) v_u_20, (ref) v_u_24, (ref) v_u_23, (copy) v_u_50, (copy) v_u_15, (copy) v_u_6, (copy) v_u_52
	if v_u_20 then
		local v53, _ = v_u_50(v_u_15.Target)
		if v53 then
			local v54 = v_u_6
			if v54 then
				v54 = v_u_6:FindFirstChild("HumanoidRootPart")
			end
			if v54 then
				local v55 = v53.PrimaryPart or v53:FindFirstChildWhichIsA("BasePart")
				if v55 and (v54.Position - v55.Position).Magnitude > 80 then
					if v_u_24 then
						v_u_24:Destroy()
						v_u_24 = nil
					end
					v_u_23 = nil
					return
				end
			end
			if v53 ~= v_u_23 then
				v_u_52(v53)
				return
			end
		else
			if v_u_24 then
				v_u_24:Destroy()
				v_u_24 = nil
			end
			v_u_23 = nil
		end
	else
		if v_u_24 then
			v_u_24:Destroy()
			v_u_24 = nil
		end
		v_u_23 = nil
	end
end
local function v_u_62(p57)
	-- upvalues: (copy) v_u_13, (ref) v_u_12
	local v58 = v_u_13:FindFirstChildOfClass("Animator")
	if not v58 then
		v58 = Instance.new("Animator")
		v58.Parent = v_u_13
	end
	local v_u_59 = v58:LoadAnimation(p57)
	local v60 = v_u_12
	table.insert(v60, v_u_59)
	v_u_59.Stopped:Connect(function()
		-- upvalues: (ref) v_u_12, (copy) v_u_59
		local v61 = table.find(v_u_12, v_u_59)
		if v61 then
			table.remove(v_u_12, v61)
		end
		v_u_59:Destroy()
	end)
	v_u_59:Play()
	return v_u_59
end
local function v_u_67(p63)
	-- upvalues: (copy) v_u_5, (copy) v_u_2
	local v_u_64 = Instance.new("Attachment")
	v_u_64.WorldPosition = p63
	v_u_64.Parent = workspace.Terrain
	local v_u_65 = Instance.new("BillboardGui")
	v_u_65.Size = UDim2.new(0, 80, 0, 40)
	v_u_65.StudsOffset = Vector3.new(0, 0, 0)
	v_u_65.AlwaysOnTop = true
	v_u_65.Adornee = v_u_64
	v_u_65.Parent = v_u_5.PlayerGui
	local v66 = Instance.new("TextLabel")
	v66.Size = UDim2.new(1, 0, 1, 0)
	v66.BackgroundTransparency = 1
	v66.Text = "-5"
	v66.TextColor3 = Color3.fromRGB(255, 60, 60)
	v66.TextStrokeTransparency = 0.5
	v66.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	v66.Font = Enum.Font.GothamBold
	v66.TextScaled = true
	v66.Parent = v_u_65
	v_u_2:Create(v_u_65, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["StudsOffset"] = Vector3.new(0, 3, 0)
	}):Play()
	v_u_2:Create(v66, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.2), {
		["TextTransparency"] = 1,
		["TextStrokeTransparency"] = 1
	}):Play()
	task.delay(0.8, function()
		-- upvalues: (copy) v_u_65, (copy) v_u_64
		v_u_65:Destroy()
		v_u_64:Destroy()
	end)
end
v7.Equipped:Connect(function()
	-- upvalues: (ref) v_u_21, (copy) v_u_13, (ref) v_u_20, (ref) v_u_12, (copy) v_u_6, (copy) v_u_8, (copy) v_u_62, (copy) v_u_11, (copy) v_u_10, (copy) v_u_36, (copy) v_u_3, (copy) v_u_45, (ref) v_u_27, (ref) v_u_25, (copy) v_u_4, (copy) v_u_56
	if v_u_21 then
		v_u_13:UnequipTools()
	else
		v_u_21 = true
		task.delay(0.3, function()
			-- upvalues: (ref) v_u_21
			v_u_21 = false
		end)
		v_u_20 = true
		v_u_12 = {}
		local v68 = v_u_6:FindFirstChild("Right Arm")
		if v68 then
			v68 = v_u_6["Right Arm"]:FindFirstChild("RightGrip")
		end
		local v69 = v68 or v_u_8:FindFirstChildWhichIsA("Weld")
		if v69 then
			v69.C1 = v69.C1 * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0)
		end
		v_u_62(v_u_11)
		local v70 = v_u_13:FindFirstChildOfClass("Animator")
		if not v70 then
			v70 = Instance.new("Animator")
			v70.Parent = v_u_13
		end
		local v_u_71 = v70:LoadAnimation(v_u_10)
		v_u_71.Priority = Enum.AnimationPriority.Idle
		v_u_71.Looped = true
		local v72 = v_u_12
		table.insert(v72, v_u_71)
		v_u_71.Stopped:Connect(function()
			-- upvalues: (ref) v_u_12, (copy) v_u_71
			local v73 = table.find(v_u_12, v_u_71)
			if v73 then
				table.remove(v_u_12, v73)
			end
			v_u_71:Destroy()
		end)
		v_u_71:Play()
		v_u_36(false, false)
		for _, v74 in v_u_3:GetTagged("Plant") do
			v_u_45(v74)
		end
		v_u_27 = v_u_3:GetInstanceAddedSignal("Plant"):Connect(function(p_u_75)
			-- upvalues: (ref) v_u_20, (ref) v_u_45
			if v_u_20 then
				task.defer(function()
					-- upvalues: (ref) v_u_20, (ref) v_u_45, (copy) p_u_75
					if v_u_20 then
						v_u_45(p_u_75)
					end
				end)
			end
		end)
		if v_u_25 then
			v_u_25:Disconnect()
			v_u_25 = nil
		end
		v_u_25 = v_u_4.Heartbeat:Connect(v_u_56)
	end
end)
v7.Unequipped:Connect(function()
	-- upvalues: (ref) v_u_20, (ref) v_u_12, (ref) v_u_25, (ref) v_u_24, (ref) v_u_23, (copy) v_u_47, (copy) v_u_36
	v_u_20 = false
	for _, v76 in ipairs(v_u_12) do
		if v76 and v76.IsPlaying then
			v76:Stop()
		end
	end
	v_u_12 = {}
	if v_u_25 then
		v_u_25:Disconnect()
		v_u_25 = nil
	end
	if v_u_24 then
		v_u_24:Destroy()
		v_u_24 = nil
	end
	v_u_23 = nil
	v_u_47()
	v_u_36(true, true)
end)
v7.Activated:Connect(function()
	-- upvalues: (copy) v_u_14, (copy) v_u_18, (copy) v_u_6, (copy) v_u_15, (ref) v_u_22, (copy) v_u_62, (copy) v_u_67, (copy) v_u_17, (copy) v_u_19, (copy) v_u_50, (copy) v_u_9, (copy) v_u_16
	if v_u_14:IsActive() then
		return
	end
	local v77 = workspace:GetAttribute("BossActive") and (v_u_18 and workspace:FindFirstChild("HeavyRainContent"))
	if v77 then
		local v78 = nil
		for _, v79 in v77:GetChildren() do
			if v79:IsA("Model") and v79:FindFirstChildOfClass("Humanoid") then
				v78 = v79
				break
			end
		end
		if v78 then
			local v80 = v_u_6
			if v80 then
				v80 = v_u_6:FindFirstChild("HumanoidRootPart")
			end
			local v81 = v78.PrimaryPart or v78:FindFirstChildWhichIsA("BasePart")
			if v80 and (v81 and (v80.Position - v81.Position).Magnitude <= 150) then
				local v82 = v_u_15.Target
				if v82 and v82:IsDescendantOf(v78) then
					if not v_u_22 then
						v_u_22 = true
						local v83 = v_u_62(v_u_18)
						v83.Looped = false
						v_u_67((v_u_6 and (v_u_6:FindFirstChild("HumanoidRootPart") and v_u_6.HumanoidRootPart.Position) or v82.Position) + Vector3.new(0, 2, 0))
						v_u_17.PlaybackSpeed = 0.9 + v_u_19:NextNumber() * 0.3
						v_u_17:Play()
						v83.Stopped:Wait()
						v_u_22 = false
					end
				end
			end
		end
	end
	local v84, v85 = v_u_50(v_u_15.Target)
	if v84 then
		local v86 = nil
		local v87
		if v85 == "Fruit" then
			v87 = v84.Parent
			if v87 then
				v87 = v87:GetAttribute("Uuid")
			end
			v86 = v84:GetAttribute("GrowthAnchorIndex")
			if not (v87 and v86) then
				return
			end
		else
			v87 = v84:GetAttribute("Uuid")
			if not v87 then
				return
			end
		end
		v_u_14:Show(v84, v85, v87, v86, function()
			-- upvalues: (ref) v_u_62, (ref) v_u_9, (ref) v_u_16
			local v88 = v_u_62(v_u_9)
			v88.Looped = false
			task.wait(0.4)
			v_u_16:Play()
			v88.Stopped:Wait()
		end)
	end
end)