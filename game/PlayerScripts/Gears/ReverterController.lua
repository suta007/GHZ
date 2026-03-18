local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("CollectionService")
local v_u_5 = game:GetService("Workspace")
local v_u_6 = require(v2:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDefinitions"))
local v_u_7 = require(v2:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("TierHelper"))
local v_u_8 = require(v2:WaitForChild("UI"):WaitForChild("ReverterConfirmationController"))
v2:WaitForChild("RemoteEvents"):WaitForChild("UseGear")
local v_u_9 = game:GetService("SoundService"):WaitForChild("SFX"):WaitForChild("Player"):WaitForChild("Shovel")
local v_u_10 = v1.LocalPlayer
local v_u_11 = Random.new()
local v_u_12 = {}
local v_u_13 = false
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = {}
local v_u_23 = nil
local v_u_24 = {}
local v_u_25 = {}
local function v_u_28(p26)
	for _, v27 in p26:GetDescendants() do
		if v27:IsA("ProximityPrompt") and v27.Name == "HarvestPrompt" then
			v27.Enabled = false
		end
	end
end
local function v_u_32(p29)
	-- upvalues: (copy) v_u_5, (copy) v_u_4, (copy) v_u_10
	local v30 = p29.Target
	if not v30 then
		return nil
	end
	while v30 and v30 ~= v_u_5 do
		if v30:IsA("Model") and v_u_4:HasTag(v30, "Plant") then
			if v30:GetAttribute("OwnerUserId") ~= v_u_10.UserId then
				return nil
			end
			if not v30:GetAttribute("FullyGrown") then
				return nil
			end
			if v30:GetAttribute("Favorited") then
				return nil
			end
			for _, v31 in v30:GetChildren() do
				if v31:IsA("Model") and v31:GetAttribute("Favorited") then
					return nil
				end
			end
			return v30
		end
		v30 = v30.Parent
	end
	return nil
end
local function v_u_39(p_u_33)
	-- upvalues: (ref) v_u_23, (copy) v_u_6, (copy) v_u_7
	if p_u_33 then
		if not v_u_23 then
			local v34 = Instance.new("Highlight")
			v34.DepthMode = Enum.HighlightDepthMode.Occluded
			v34.FillTransparency = 0.8
			v34.OutlineTransparency = 0
			v_u_23 = v34
		end
		if v_u_23.Parent ~= p_u_33 and not pcall(function()
			-- upvalues: (ref) v_u_23, (copy) p_u_33
			v_u_23.Parent = p_u_33
		end) then
			v_u_23:Destroy()
			local v35 = Instance.new("Highlight")
			v35.DepthMode = Enum.HighlightDepthMode.Occluded
			v35.FillTransparency = 0.8
			v35.OutlineTransparency = 0
			v_u_23 = v35
			v_u_23.Parent = p_u_33
		end
		local v36 = Color3.fromRGB(139, 195, 74)
		local v37 = p_u_33:GetAttribute("PlantType")
		if v37 then
			local v38 = v_u_6[v37]
			if v38 and v38.Rarity then
				v36 = v_u_7:GetColor(v38.Rarity) or v36
			end
		end
		v_u_23.FillColor = v36
		v_u_23.OutlineColor = v36
	elseif v_u_23 then
		v_u_23:Destroy()
		v_u_23 = nil
	end
end
local function v_u_49()
	-- upvalues: (ref) v_u_13, (ref) v_u_16, (copy) v_u_8, (copy) v_u_10, (copy) v_u_32, (ref) v_u_14, (ref) v_u_17, (ref) v_u_15, (ref) v_u_25, (ref) v_u_24, (copy) v_u_9, (copy) v_u_11
	if v_u_13 then
		if v_u_16() then
			if v_u_8:IsActive() then
				return
			else
				local v40 = v_u_32((v_u_10:GetMouse()))
				if v40 then
					local v41 = v40:GetAttribute("Uuid")
					if v41 then
						v_u_8:Show(v40, v_u_14, v41, function()
							-- upvalues: (ref) v_u_17, (ref) v_u_15, (ref) v_u_25, (ref) v_u_10, (ref) v_u_24, (ref) v_u_9, (ref) v_u_11
							v_u_17()
							local v42 = v_u_15
							if v42 then
								v42 = v_u_15:FindFirstChild("Use")
							end
							if v42 then
								local v43 = Enum.AnimationPriority.Action
								local v44 = v_u_25[v42]
								if v44 then
									::l6::
									if v43 then
										v44.Priority = v43
									end
									v44.Looped = false
									v44:Play()
									goto l4
								end
								local v45 = v_u_10.Character
								local v46
								if v45 then
									local v47 = v45:FindFirstChildOfClass("Humanoid")
									if v47 then
										v46 = v47:FindFirstChildOfClass("Animator")
										if not v46 then
											v46 = Instance.new("Animator")
											v46.Parent = v47
										end
									else
										v46 = nil
									end
								else
									v46 = nil
								end
								if v46 then
									v44 = v46:LoadAnimation(v42)
									v_u_25[v42] = v44
									local v48 = v_u_24
									table.insert(v48, v44)
									goto l6
								end
							end
							::l4::
							v_u_9.PlaybackSpeed = 0.9 + v_u_11:NextNumber() * 0.3
							v_u_9:Play()
						end)
					end
				else
					return
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_64(p50)
	-- upvalues: (copy) v_u_10, (copy) v_u_28, (ref) v_u_13, (ref) v_u_22
	if p50:GetAttribute("OwnerUserId") == v_u_10.UserId then
		v_u_28(p50)
		for _, v_u_51 in p50:GetChildren() do
			if v_u_51:IsA("Model") and not v_u_51:GetAttribute("FullyGrown") then
				local v_u_52 = nil
				v_u_52 = v_u_51:GetAttributeChangedSignal("FullyGrown"):Connect(function()
					-- upvalues: (ref) v_u_13, (ref) v_u_52, (copy) v_u_51, (ref) v_u_28
					if v_u_13 then
						if v_u_51:GetAttribute("FullyGrown") then
							v_u_28(v_u_51)
							v_u_52:Disconnect()
						end
					else
						v_u_52:Disconnect()
					end
				end)
				local v53 = v_u_22
				local v54 = v_u_52
				table.insert(v53, v54)
			end
		end
		local v62 = p50.ChildAdded:Connect(function(p_u_55)
			-- upvalues: (ref) v_u_13, (ref) v_u_28, (ref) v_u_22
			if v_u_13 then
				if p_u_55:IsA("Model") then
					v_u_28(p_u_55)
					local v57 = p_u_55.DescendantAdded:Connect(function(p56)
						-- upvalues: (ref) v_u_13
						if v_u_13 then
							if p56:IsA("ProximityPrompt") and p56.Name == "HarvestPrompt" then
								p56.Enabled = false
							end
						end
					end)
					local v58 = v_u_22
					table.insert(v58, v57)
					if not p_u_55:GetAttribute("FullyGrown") then
						local v_u_59 = nil
						v_u_59 = p_u_55:GetAttributeChangedSignal("FullyGrown"):Connect(function()
							-- upvalues: (ref) v_u_13, (ref) v_u_59, (copy) p_u_55, (ref) v_u_28
							if v_u_13 then
								if p_u_55:GetAttribute("FullyGrown") then
									v_u_28(p_u_55)
									v_u_59:Disconnect()
								end
							else
								v_u_59:Disconnect()
							end
						end)
						local v60 = v_u_22
						local v61 = v_u_59
						table.insert(v60, v61)
					end
				end
			else
				return
			end
		end)
		local v63 = v_u_22
		table.insert(v63, v62)
	end
end
function v_u_12.Activate(p65, p_u_66, p67, p68)
	-- upvalues: (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_25, (copy) v_u_10, (ref) v_u_24, (copy) v_u_4, (copy) v_u_64, (ref) v_u_18, (copy) v_u_49, (ref) v_u_19, (copy) v_u_3, (ref) v_u_23, (copy) v_u_32, (copy) v_u_39, (ref) v_u_20, (ref) v_u_21
	v_u_13 = true
	v_u_14 = p65
	v_u_15 = p_u_66
	v_u_16 = p67
	v_u_17 = p68
	local v69 = p_u_66:FindFirstChild("Equip")
	if v69 then
		local v70 = Enum.AnimationPriority.Action
		local v71 = v_u_25[v69]
		if v71 then
			::l4::
			if v70 then
				v71.Priority = v70
			end
			v71.Looped = false
			v71:Play()
			goto l2
		end
		local v72 = v_u_10.Character
		local v73
		if v72 then
			local v74 = v72:FindFirstChildOfClass("Humanoid")
			if v74 then
				v73 = v74:FindFirstChildOfClass("Animator")
				if not v73 then
					v73 = Instance.new("Animator")
					v73.Parent = v74
				end
			else
				v73 = nil
			end
		else
			v73 = nil
		end
		if v73 then
			v71 = v73:LoadAnimation(v69)
			v_u_25[v69] = v71
			local v75 = v_u_24
			table.insert(v75, v71)
			goto l4
		end
	end
	::l2::
	task.delay(0.2, function()
		-- upvalues: (ref) v_u_13, (copy) p_u_66, (ref) v_u_25, (ref) v_u_10, (ref) v_u_24
		if v_u_13 then
			local v76 = p_u_66:FindFirstChild("Idle")
			if v76 then
				local v77 = Enum.AnimationPriority.Idle
				local v78 = v_u_25[v76]
				if not v78 then
					local v79 = v_u_10.Character
					local v80
					if v79 then
						local v81 = v79:FindFirstChildOfClass("Humanoid")
						if v81 then
							v80 = v81:FindFirstChildOfClass("Animator")
							if not v80 then
								v80 = Instance.new("Animator")
								v80.Parent = v81
							end
						else
							v80 = nil
						end
					else
						v80 = nil
					end
					if not v80 then
						return
					end
					v78 = v80:LoadAnimation(v76)
					v_u_25[v76] = v78
					local v82 = v_u_24
					table.insert(v82, v78)
				end
				if v77 then
					v78.Priority = v77
				end
				v78.Looped = true
				v78:Play()
			end
		end
	end)
	for _, v83 in v_u_4:GetTagged("Plant") do
		v_u_64(v83)
	end
	v_u_18 = p_u_66.Activated:Connect(v_u_49)
	local v_u_84 = v_u_10:GetMouse()
	v_u_19 = v_u_3.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_13, (ref) v_u_23, (ref) v_u_32, (copy) v_u_84, (ref) v_u_39
		if v_u_13 then
			v_u_39((v_u_32(v_u_84)))
		elseif v_u_23 then
			v_u_23:Destroy()
			v_u_23 = nil
		end
	end)
	v_u_20 = v_u_4:GetInstanceAddedSignal("Plant"):Connect(function(p_u_85)
		-- upvalues: (ref) v_u_13, (ref) v_u_64
		if v_u_13 then
			task.defer(function()
				-- upvalues: (ref) v_u_13, (ref) v_u_64, (copy) p_u_85
				if v_u_13 then
					v_u_64(p_u_85)
				end
			end)
		end
	end)
	v_u_21 = v_u_4:GetInstanceAddedSignal("HarvestPrompt"):Connect(function(p86)
		-- upvalues: (ref) v_u_13, (ref) v_u_10
		if v_u_13 then
			if p86:IsA("ProximityPrompt") then
				local v87 = p86.Parent
				local v88 = 0
				while v87 and (v87 ~= workspace and v88 < 10) do
					local v89 = v87:GetAttribute("OwnerUserId")
					if v89 then
						if v89 == v_u_10.UserId then
							p86.Enabled = false
						end
						return
					end
					v87 = v87.Parent
					v88 = v88 + 1
				end
			end
		else
			return
		end
	end)
end
function v_u_12.Deactivate()
	-- upvalues: (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (ref) v_u_21, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (ref) v_u_25, (copy) v_u_4, (copy) v_u_10
	v_u_13 = false
	v_u_14 = nil
	v_u_15 = nil
	v_u_16 = nil
	v_u_17 = nil
	if v_u_18 then
		v_u_18:Disconnect()
		v_u_18 = nil
	end
	if v_u_19 then
		v_u_19:Disconnect()
		v_u_19 = nil
	end
	if v_u_20 then
		v_u_20:Disconnect()
		v_u_20 = nil
	end
	if v_u_21 then
		v_u_21:Disconnect()
		v_u_21 = nil
	end
	for _, v90 in v_u_22 do
		v90:Disconnect()
	end
	v_u_22 = {}
	if v_u_23 then
		v_u_23:Destroy()
		v_u_23 = nil
	end
	for _, v91 in v_u_24 do
		if v91 and v91.IsPlaying then
			v91:Stop()
		end
	end
	for _, v92 in v_u_24 do
		v92:Destroy()
	end
	v_u_24 = {}
	v_u_25 = {}
	for _, v93 in v_u_4:GetTagged("Plant") do
		if v93:GetAttribute("OwnerUserId") == v_u_10.UserId then
			for _, v94 in v93:GetDescendants() do
				if v94:IsA("ProximityPrompt") and (v94.Name == "HarvestPrompt" and not v94.Parent:GetAttribute("Favorited")) then
					v94.Enabled = true
				end
			end
		end
	end
end
v_u_10.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_12
	v_u_12.Deactivate()
end)
return v_u_12