local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = v1.LocalPlayer
local v_u_6 = v2:WaitForChild("RemoteEvents"):WaitForChild("UseGear")
local v_u_7 = v2:WaitForChild("Gears"):WaitForChild("FavoriteIndicator")
local v8 = {}
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = {}
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = false
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = {}
local v_u_22 = nil
local function v_u_26(p23, p24)
	for _, v25 in p23:GetDescendants() do
		if v25:IsA("ProximityPrompt") and v25.Name == "HarvestPrompt" then
			v25.Enabled = p24
		end
	end
end
local function v_u_32(p27, p28, p29)
	-- upvalues: (copy) v_u_3, (copy) v_u_5, (copy) v_u_26
	for _, v30 in v_u_3:GetTagged("Plant") do
		if v30:GetAttribute("OwnerUserId") == v_u_5.UserId then
			if v30:GetAttribute("HarvestablePlant") and (not p28 or (not v30:GetAttribute("Favorited") or v30 == p29)) then
				v_u_26(v30, p27)
			end
			for _, v31 in v30:GetChildren() do
				if v31:IsA("Model") and (not p28 or (not v31:GetAttribute("Favorited") or v31 == p29)) then
					v_u_26(v31, p27)
				end
			end
		end
	end
end
local function v_u_36()
	-- upvalues: (ref) v_u_9, (ref) v_u_10, (ref) v_u_11
	for _, v33 in v_u_9 do
		v33:Destroy()
	end
	v_u_9 = {}
	for _, v34 in v_u_10 do
		v34:Disconnect()
	end
	v_u_10 = {}
	for _, v35 in v_u_11 do
		v35:Disconnect()
	end
	v_u_11 = {}
end
local function v_u_40(p37)
	-- upvalues: (copy) v_u_5
	local v38 = p37.Target
	if not v38 then
		return nil
	end
	while v38 and v38 ~= workspace do
		if v38:IsA("Model") and v38:GetAttribute("FullyGrown") then
			if v38:GetAttribute("HarvestablePlant") then
				if v38:GetAttribute("OwnerUserId") == v_u_5.UserId then
					return v38
				else
					return nil
				end
			else
				local v39 = v38.Parent
				if v39 and (v39:IsA("Model") and v39:GetAttribute("OwnerUserId") == v_u_5.UserId) then
					return v38
				else
					return nil
				end
			end
		end
		v38 = v38.Parent
	end
	return nil
end
local function v_u_42(p41)
	-- upvalues: (ref) v_u_15
	if p41 then
		if not v_u_15 then
			v_u_15 = Instance.new("Highlight")
			v_u_15.DepthMode = Enum.HighlightDepthMode.Occluded
			v_u_15.FillColor = Color3.fromRGB(255, 215, 0)
			v_u_15.OutlineColor = Color3.fromRGB(218, 165, 32)
			v_u_15.FillTransparency = 0.8
			v_u_15.OutlineTransparency = 0
		end
		if v_u_15.Parent ~= p41 then
			v_u_15.Parent = p41
			return
		end
	elseif v_u_15 then
		v_u_15:Destroy()
		v_u_15 = nil
	end
end
local function v_u_53(p_u_43)
	-- upvalues: (ref) v_u_9, (copy) v_u_7, (ref) v_u_17, (ref) v_u_10
	if p_u_43:IsA("Model") then
		if p_u_43:GetAttribute("FullyGrown") then
			if p_u_43:GetAttribute("Favorited") then
				local v44 = not v_u_9[p_u_43] and (p_u_43:FindFirstChild("Handle") or (p_u_43.PrimaryPart or p_u_43:FindFirstChildWhichIsA("BasePart")))
				if v44 then
					local v45 = v_u_7:Clone()
					v45.Name = "FavoriteIndicator"
					v45.Adornee = v44
					v45.Parent = p_u_43
					v_u_9[p_u_43] = v45
				end
			else
				local v46 = v_u_9[p_u_43]
				if v46 then
					v46:Destroy()
					v_u_9[p_u_43] = nil
				end
			end
			local v51 = p_u_43:GetAttributeChangedSignal("Favorited"):Connect(function()
				-- upvalues: (ref) v_u_17, (copy) p_u_43, (ref) v_u_9, (ref) v_u_7
				if v_u_17 then
					local v47 = p_u_43
					if v47:GetAttribute("Favorited") then
						if v_u_9[v47] then
							return
						else
							local v48 = v47:FindFirstChild("Handle") or (v47.PrimaryPart or v47:FindFirstChildWhichIsA("BasePart"))
							if v48 then
								local v49 = v_u_7:Clone()
								v49.Name = "FavoriteIndicator"
								v49.Adornee = v48
								v49.Parent = v47
								v_u_9[v47] = v49
							end
						end
					else
						local v50 = v_u_9[v47]
						if v50 then
							v50:Destroy()
							v_u_9[v47] = nil
						end
					end
				else
					return
				end
			end)
			local v52 = v_u_10
			table.insert(v52, v51)
		end
	else
		return
	end
end
local function v_u_56(p54)
	-- upvalues: (copy) v_u_5, (copy) v_u_53
	if p54:GetAttribute("OwnerUserId") == v_u_5.UserId then
		if p54:GetAttribute("HarvestablePlant") and p54:GetAttribute("FullyGrown") then
			v_u_53(p54)
		end
		for _, v55 in p54:GetChildren() do
			if v55:IsA("Model") and v55:GetAttribute("FullyGrown") then
				v_u_53(v55)
			end
		end
	end
end
local function v_u_64()
	-- upvalues: (copy) v_u_3, (copy) v_u_56, (copy) v_u_5, (ref) v_u_17, (copy) v_u_53, (copy) v_u_26, (ref) v_u_10, (ref) v_u_11
	for _, v57 in v_u_3:GetTagged("Plant") do
		v_u_56(v57)
		if v57:GetAttribute("OwnerUserId") == v_u_5.UserId then
			local v62 = v57.ChildAdded:Connect(function(p_u_58)
				-- upvalues: (ref) v_u_17, (ref) v_u_53, (ref) v_u_26, (ref) v_u_10
				if v_u_17 then
					if p_u_58:IsA("Model") then
						local v_u_59 = nil
						v_u_59 = p_u_58:GetAttributeChangedSignal("FullyGrown"):Connect(function()
							-- upvalues: (ref) v_u_17, (ref) v_u_59, (copy) p_u_58, (ref) v_u_53, (ref) v_u_26
							if v_u_17 then
								if p_u_58:GetAttribute("FullyGrown") then
									v_u_53(p_u_58)
									v_u_26(p_u_58, false)
									v_u_59:Disconnect()
								end
							else
								v_u_59:Disconnect()
							end
						end)
						local v60 = v_u_10
						local v61 = v_u_59
						table.insert(v60, v61)
						if p_u_58:GetAttribute("FullyGrown") then
							v_u_53(p_u_58)
							v_u_26(p_u_58, false)
							v_u_59:Disconnect()
						end
					end
				else
					return
				end
			end)
			local v63 = v_u_11
			table.insert(v63, v62)
		end
	end
end
function v8.IsActive()
	-- upvalues: (ref) v_u_17
	return v_u_17
end
function v8.OnStateChanged(p65)
	-- upvalues: (copy) v_u_21
	local v66 = v_u_21
	table.insert(v66, p65)
end
function v8.Activate(p67, p68, p69, p70)
	-- upvalues: (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (copy) v_u_21, (copy) v_u_64, (copy) v_u_32, (ref) v_u_12, (copy) v_u_3, (copy) v_u_56, (copy) v_u_5, (copy) v_u_53, (copy) v_u_26, (ref) v_u_10, (ref) v_u_11, (ref) v_u_13, (copy) v_u_40, (ref) v_u_22, (copy) v_u_6, (ref) v_u_14, (copy) v_u_4, (ref) v_u_16, (copy) v_u_42
	v_u_17 = true
	v_u_18 = p67
	v_u_19 = p69
	v_u_20 = p70
	for _, v71 in v_u_21 do
		v71(true)
	end
	v_u_64()
	v_u_32(false, false)
	v_u_12 = v_u_3:GetInstanceAddedSignal("Plant"):Connect(function(p_u_72)
		-- upvalues: (ref) v_u_17, (ref) v_u_56, (ref) v_u_5, (ref) v_u_53, (ref) v_u_26, (ref) v_u_10, (ref) v_u_11
		if v_u_17 then
			task.defer(function()
				-- upvalues: (ref) v_u_17, (ref) v_u_56, (copy) p_u_72, (ref) v_u_5, (ref) v_u_53, (ref) v_u_26, (ref) v_u_10, (ref) v_u_11
				if v_u_17 then
					v_u_56(p_u_72)
					local v73 = p_u_72
					if v73:GetAttribute("OwnerUserId") == v_u_5.UserId then
						local v78 = v73.ChildAdded:Connect(function(p_u_74)
							-- upvalues: (ref) v_u_17, (ref) v_u_53, (ref) v_u_26, (ref) v_u_10
							if v_u_17 then
								if p_u_74:IsA("Model") then
									local v_u_75 = nil
									v_u_75 = p_u_74:GetAttributeChangedSignal("FullyGrown"):Connect(function()
										-- upvalues: (ref) v_u_17, (ref) v_u_75, (copy) p_u_74, (ref) v_u_53, (ref) v_u_26
										if v_u_17 then
											if p_u_74:GetAttribute("FullyGrown") then
												v_u_53(p_u_74)
												v_u_26(p_u_74, false)
												v_u_75:Disconnect()
											end
										else
											v_u_75:Disconnect()
										end
									end)
									local v76 = v_u_10
									local v77 = v_u_75
									table.insert(v76, v77)
									if p_u_74:GetAttribute("FullyGrown") then
										v_u_53(p_u_74)
										v_u_26(p_u_74, false)
										v_u_75:Disconnect()
									end
								end
							else
								return
							end
						end)
						local v79 = v_u_11
						table.insert(v79, v78)
					end
				else
					return
				end
			end)
		end
	end)
	local v_u_80 = v_u_5:GetMouse()
	v_u_13 = p68.Activated:Connect(function()
		-- upvalues: (ref) v_u_19, (ref) v_u_40, (copy) v_u_80, (ref) v_u_22, (ref) v_u_6, (ref) v_u_18, (ref) v_u_20
		if v_u_19() then
			local v81 = v_u_40(v_u_80)
			if v81 then
				local v82 = nil
				local v83 = nil
				if v81:GetAttribute("HarvestablePlant") then
					v82 = v81:GetAttribute("Uuid")
				else
					v83 = v81:GetAttribute("GrowthAnchorIndex")
					local v84 = v81.Parent
					if v84 and v84:IsA("Model") then
						v82 = v84:GetAttribute("Uuid")
					end
				end
				if v82 then
					v_u_22 = v81
					v_u_6:FireServer(v_u_18, {
						["PlantUuid"] = v82,
						["GrowthAnchorIndex"] = v83
					})
					v_u_20()
				end
			else
				return
			end
		else
			return
		end
	end)
	v_u_14 = v_u_4.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_40, (copy) v_u_80, (ref) v_u_16, (ref) v_u_42
		local v85 = v_u_40(v_u_80)
		v_u_16 = v85
		v_u_42(v85)
	end)
end
function v8.Deactivate()
	-- upvalues: (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (copy) v_u_21, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (copy) v_u_32, (ref) v_u_22, (copy) v_u_36
	v_u_17 = false
	v_u_18 = nil
	v_u_19 = nil
	v_u_20 = nil
	for _, v86 in v_u_21 do
		v86(false)
	end
	if v_u_12 then
		v_u_12:Disconnect()
		v_u_12 = nil
	end
	if v_u_13 then
		v_u_13:Disconnect()
		v_u_13 = nil
	end
	if v_u_14 then
		v_u_14:Disconnect()
		v_u_14 = nil
	end
	if v_u_15 then
		v_u_15:Destroy()
		v_u_15 = nil
	end
	v_u_16 = nil
	v_u_32(true, true, v_u_22)
	v_u_22 = nil
	v_u_36()
end
return v8