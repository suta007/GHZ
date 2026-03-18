local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("SoundService")
local v_u_5 = v_u_1.LocalPlayer
local v6 = v2:WaitForChild("RemoteEvents")
local v7 = v6:WaitForChild("LuckyBlockRainConfig")
local v_u_8 = v6:WaitForChild("LuckyBlockRainCollect")
local v_u_9 = script:WaitForChild("LuckyBlock")
local v_u_10 = Color3.fromRGB(255, 215, 0)
local v_u_11 = 0
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = 0
local v_u_15 = {}
local v_u_16 = 0
local v_u_17 = {}
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = false
local v_u_22 = nil
local v_u_23 = nil
local function v_u_28()
	-- upvalues: (ref) v_u_22
	if v_u_22 then
		return v_u_22
	end
	local v24 = {}
	local v25 = workspace:FindFirstChild("MapPhysical")
	if v25 then
		local v26 = v25:FindFirstChild("Tree")
		local v27 = v25:FindFirstChild("Trees2")
		if v26 then
			table.insert(v24, v26)
		end
		if v27 then
			table.insert(v24, v27)
		end
	end
	v_u_22 = v24
	return v24
end
local function v_u_35(p29, p30, p31)
	-- upvalues: (copy) v_u_28
	local v32 = Vector3.new(p29, p31, p30)
	local v33 = RaycastParams.new()
	v33.FilterType = Enum.RaycastFilterType.Exclude
	v33.FilterDescendantsInstances = v_u_28()
	local v34 = workspace:Raycast(v32, Vector3.new(0, -500, 0), v33)
	if v34 then
		return v34.Position + Vector3.new(0, 3, 0)
	else
		return Vector3.new(p29, 3, p30)
	end
end
local function v_u_41(p36, p37)
	local v38 = p36:FindFirstChild("Fall")
	if v38 then
		for _, v39 in v38:GetChildren() do
			if v39:IsA("Attachment") and v39.Name == "Enable" then
				for _, v40 in v39:GetChildren() do
					if v40:IsA("ParticleEmitter") then
						v40.Enabled = p37
					end
				end
			end
		end
	end
end
local function v_u_47()
	-- upvalues: (copy) v_u_9, (copy) v_u_10, (copy) v_u_41
	local v42 = v_u_9:Clone()
	local v43 = v42:GetPivot()
	local v44 = Instance.new("Part")
	v44.Name = "Anchor"
	v44.Size = Vector3.new(7, 7, 7)
	v44.Transparency = 1
	v44.Anchored = true
	v44.CanCollide = false
	v44.CanQuery = false
	v44.CanTouch = true
	v44.CFrame = v43
	v44.Parent = v42
	v42.PrimaryPart = v44
	for _, v45 in v42:GetDescendants() do
		if v45:IsA("BasePart") and v45 ~= v44 then
			v45.Anchored = true
			v45.CanCollide = false
			v45.CanTouch = false
		end
	end
	local v46 = Instance.new("Highlight")
	v46.FillColor = v_u_10
	v46.OutlineColor = v_u_10
	v46.FillTransparency = 0.7
	v46.OutlineTransparency = 0
	v46.Enabled = true
	v46.Adornee = v42
	v46.Parent = v42
	v_u_41(v42, true)
	return v42
end
local function v_u_54(p48)
	-- upvalues: (ref) v_u_17
	local v49 = p48.Model
	if v49 and v49.Parent then
		local v50 = {}
		local v51 = {}
		for _, v52 in v49:GetDescendants() do
			if v52:IsA("BasePart") then
				table.insert(v50, v52)
				local v53 = v52.Transparency
				table.insert(v51, v53)
			end
		end
		v_u_17[v49] = {
			["Model"] = v49,
			["GroundPos"] = p48.GroundPos,
			["Parts"] = v50,
			["OriginalTransparencies"] = v51,
			["StartTime"] = workspace:GetServerTimeNow()
		}
	end
end
local function v_u_56(p55)
	-- upvalues: (ref) v_u_15, (ref) v_u_16, (copy) v_u_54
	if p55.TouchConnection then
		p55.TouchConnection:Disconnect()
		p55.TouchConnection = nil
	end
	if p55.DespawnThread then
		pcall(task.cancel, p55.DespawnThread)
		p55.DespawnThread = nil
	end
	if v_u_15[p55.Model] then
		v_u_16 = v_u_16 - 1
		v_u_15[p55.Model] = nil
	end
	if p55.Model and p55.Model.Parent then
		v_u_54(p55)
	end
end
local function v_u_59()
	-- upvalues: (copy) v_u_4
	local v57 = v_u_4:FindFirstChild("SFX") and (v_u_4.SFX:FindFirstChild("Weather") and v_u_4.SFX.Weather:FindFirstChild("Special"))
	if v57 then
		v57 = v_u_4.SFX.Weather.Special:FindFirstChild("LuckyBlockOpen")
	end
	if v57 then
		local v_u_58 = v57:Clone()
		v_u_58.Parent = v_u_4
		v_u_58:Play()
		v_u_58.Ended:Once(function()
			-- upvalues: (copy) v_u_58
			v_u_58:Destroy()
		end)
	end
end
local function v_u_75(p60)
	-- upvalues: (ref) v_u_15
	local v_u_61 = p60.Model
	if v_u_61 and v_u_61.Parent then
		local v62 = v_u_61:FindFirstChild("Fall")
		if v62 then
			v62:Destroy()
		end
		local v63 = v_u_61:FindFirstChild("Open")
		if v63 then
			local v64 = v63:FindFirstChild("Enabled")
			if v64 and v64:IsA("Attachment") then
				for _, v65 in v64:GetChildren() do
					if v65:IsA("ParticleEmitter") then
						v65.Enabled = false
					end
				end
			end
			local v66 = v63:FindFirstChild("spec1")
			if v66 and v66:IsA("ParticleEmitter") then
				v66.Enabled = false
			end
			local v67 = v63:FindFirstChild("stars")
			if v67 and v67:IsA("ParticleEmitter") then
				v67.Enabled = false
			end
			for _, v68 in v_u_61:GetDescendants() do
				if v68:IsA("BasePart") then
					v68.Transparency = 1
				end
			end
			local v69 = v_u_61:FindFirstChildOfClass("Highlight")
			if v69 then
				v69:Destroy()
			end
			local v70 = 0
			local v71 = v63:FindFirstChild("OpenEmit")
			if v71 and v71:IsA("Attachment") then
				for _, v72 in v71:GetChildren() do
					if v72:IsA("ParticleEmitter") then
						local v73 = v72.Rate
						v72:Emit((math.ceil(v73)))
						local v74 = v72.Lifetime.Max
						if v70 < v74 then
							v70 = v74
						end
					end
				end
			end
			task.delay(v70 + 0.5, function()
				-- upvalues: (copy) v_u_61, (ref) v_u_15
				if v_u_61 and v_u_61.Parent then
					v_u_61:Destroy()
				end
				v_u_15[v_u_61] = nil
			end)
		else
			if v_u_61.Parent then
				v_u_61:Destroy()
			end
			v_u_15[v_u_61] = nil
		end
	else
		return
	end
end
local function v_u_78(p76, p77)
	-- upvalues: (ref) v_u_11, (copy) v_u_1, (copy) v_u_5, (copy) v_u_8, (ref) v_u_15, (ref) v_u_16, (copy) v_u_59, (copy) v_u_75
	if p77 and p77.Parent then
		if p76.isPickedUp then
			return
		elseif tick() - v_u_11 < 0.4 then
			return
		elseif p77.Parent:FindFirstChild("Humanoid") then
			if v_u_1:GetPlayerFromCharacter(p77.Parent) == v_u_5 then
				v_u_11 = tick()
				p76.isPickedUp = true
				if p76.TouchConnection then
					p76.TouchConnection:Disconnect()
					p76.TouchConnection = nil
				end
				if p76.DespawnThread then
					pcall(task.cancel, p76.DespawnThread)
					p76.DespawnThread = nil
				end
				v_u_8:FireServer(p76.BlockIndex)
				if v_u_15[p76.Model] then
					v_u_16 = v_u_16 - 1
					v_u_15[p76.Model] = nil
				end
				v_u_59()
				v_u_75(p76)
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_86(p79, p80)
	local v81 = p79.Model
	local v82 = v81:FindFirstChildOfClass("Highlight")
	if v82 then
		local v83 = v81.PrimaryPart
		if v83 then
			local v84 = (v83.Position - p80).Magnitude
			if v84 > 125 then
				v82.Enabled = false
				return
			else
				v82.Enabled = true
				if v84 <= 20 then
					v82.FillTransparency = 0.7
					v82.OutlineTransparency = 0
				else
					local v85 = (v84 - 20) / 105
					v82.FillTransparency = 0.7 + 0.7 * v85
					v82.OutlineTransparency = v85
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_101()
	-- upvalues: (ref) v_u_21, (ref) v_u_14, (ref) v_u_12, (ref) v_u_13, (ref) v_u_16, (ref) v_u_18, (copy) v_u_47, (copy) v_u_35, (ref) v_u_15
	if v_u_21 then
		v_u_14 = v_u_14 + 1
		local v87 = v_u_12.CeilingSizeX / 2
		local v88 = v_u_12.CeilingSizeZ / 2
		local v89 = v_u_12.CeilingPositionX
		local v90 = v_u_12.CenterBias
		local v91 = v_u_13:NextNumber() - 0.5
		local v92 = v89 + (v91 >= 0 and 1 or -1) * (math.abs(v91) / 0.5) ^ v90 * 0.5 * v87 * 2
		local v93 = v_u_12.CeilingPositionZ
		local v94 = v_u_12.CenterBias
		local v95 = v_u_13:NextNumber() - 0.5
		local v96 = v93 + (v95 >= 0 and 1 or -1) * (math.abs(v95) / 0.5) ^ v94 * 0.5 * v88 * 2
		if v_u_16 >= v_u_12.MaxBlocks then
			return
		elseif v_u_18 and v_u_18.Parent then
			local v97 = v_u_47()
			if v97 then
				local v98 = v_u_12.CeilingPositionY
				local v99 = Vector3.new(v92, v98, v96)
				local v100 = {
					["Model"] = v97,
					["BlockIndex"] = v_u_14,
					["StartPos"] = v99,
					["GroundPos"] = v_u_35(v92, v96, v_u_12.CeilingPositionY),
					["isPickedUp"] = false,
					["isLanded"] = false,
					["FallStartTime"] = workspace:GetServerTimeNow(),
					["LandTime"] = nil,
					["TouchConnection"] = nil,
					["DespawnThread"] = nil
				}
				v97:PivotTo(CFrame.new(v99))
				v97.Parent = v_u_18
				v_u_15[v97] = v100
				v_u_16 = v_u_16 + 1
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_104()
	-- upvalues: (ref) v_u_21, (ref) v_u_20, (ref) v_u_19, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_22, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_23
	if v_u_21 or (v_u_20 or v_u_19) then
		v_u_21 = false
		v_u_21 = false
		if v_u_20 then
			pcall(task.cancel, v_u_20)
			v_u_20 = nil
		end
		if v_u_19 then
			v_u_19:Disconnect()
			v_u_19 = nil
		end
		for _, v102 in pairs(v_u_15) do
			if v102.TouchConnection then
				v102.TouchConnection:Disconnect()
			end
			if v102.DespawnThread then
				pcall(task.cancel, v102.DespawnThread)
			end
			if v102.Model and v102.Model.Parent then
				v102.Model:Destroy()
			end
		end
		v_u_15 = {}
		v_u_16 = 0
		for v103 in pairs(v_u_17) do
			if v103 and v103.Parent then
				v103:Destroy()
			end
		end
		v_u_17 = {}
		if v_u_18 and v_u_18.Parent then
			v_u_18:Destroy()
			v_u_18 = nil
		end
		v_u_22 = nil
		v_u_12 = nil
		v_u_13 = nil
		v_u_14 = 0
		v_u_23 = nil
	end
end
local function v_u_142(p105)
	-- upvalues: (ref) v_u_21, (copy) v_u_104, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_22, (ref) v_u_23, (ref) v_u_18, (ref) v_u_19, (copy) v_u_3, (copy) v_u_5, (copy) v_u_41, (copy) v_u_78, (copy) v_u_56, (copy) v_u_86, (ref) v_u_20, (copy) v_u_101
	if v_u_21 then
		v_u_104()
	end
	v_u_12 = p105
	v_u_13 = Random.new(v_u_12.Seed)
	v_u_14 = 0
	v_u_15 = {}
	v_u_16 = 0
	v_u_17 = {}
	v_u_21 = true
	v_u_22 = nil
	v_u_23 = nil
	local v106 = (workspace:GetServerTimeNow() - v_u_12.StartTime) / v_u_12.SpawnInterval
	local v107 = math.floor(v106)
	for _ = 1, math.max(0, v107) do
		v_u_14 = v_u_14 + 1
		local v108 = v_u_12.CenterBias
		local v109 = v_u_13:NextNumber() - 0.5
		local _ = (v109 >= 0 and 1 or -1) * (math.abs(v109) / 0.5) ^ v108 * 0.5
		local v110 = v_u_12.CenterBias
		local v111 = v_u_13:NextNumber() - 0.5
		local _ = (v111 >= 0 and 1 or -1) * (math.abs(v111) / 0.5) ^ v110 * 0.5
	end
	v_u_18 = Instance.new("Folder")
	v_u_18.Name = "LuckyBlockRainCollectibles"
	v_u_18.Parent = workspace
	v_u_19 = v_u_3.RenderStepped:Connect(function()
		-- upvalues: (ref) v_u_5, (ref) v_u_23, (ref) v_u_15, (ref) v_u_16, (ref) v_u_12, (ref) v_u_41, (ref) v_u_78, (ref) v_u_56, (ref) v_u_86, (ref) v_u_17
		local v112 = workspace:GetServerTimeNow()
		local v113 = v_u_5.Character
		local v114
		if v113 then
			local v115 = v113:FindFirstChild("HumanoidRootPart")
			if v115 then
				v114 = v115.Position
			else
				v114 = nil
			end
		else
			v114 = nil
		end
		local v116
		if v114 and (not v_u_23 or (v114 - v_u_23).Magnitude > 3) then
			v_u_23 = v114
			v116 = true
		else
			v116 = false
		end
		for v_u_117, v_u_118 in pairs(v_u_15) do
			if v_u_117 and v_u_117.Parent then
				if v_u_118.isLanded then
					if v114 and (v_u_118.GroundPos - v114).Magnitude <= 125 then
						local v119 = v112 - v_u_118.LandTime
						local v120 = v119 * 2.75
						local v121 = math.sin(v120) * 0.4
						v_u_117:PivotTo(CFrame.new(v_u_118.GroundPos + Vector3.new(0, v121, 0)) * CFrame.Angles(0, v119 * 1.5, 0))
					end
				elseif v_u_118.FallStartTime then
					local v122 = (v112 - v_u_118.FallStartTime) / v_u_12.FallDuration
					local v123 = math.min(v122, 1)
					local v124 = v123 * v123
					local v125 = v_u_118.StartPos:Lerp(v_u_118.GroundPos, v124)
					v_u_117:PivotTo(CFrame.new(v125))
					if v123 >= 1 and not v_u_118.isPickedUp then
						v_u_118.isLanded = true
						v_u_118.LandTime = v112
						v_u_41(v_u_117, false)
						task.delay(2, function()
							-- upvalues: (copy) v_u_117
							local v126 = v_u_117:FindFirstChild("Fall")
							if v126 and v126.Parent then
								v126:Destroy()
							end
						end)
						if not v_u_118.TouchConnection then
							v_u_118.TouchConnection = v_u_118.Model.PrimaryPart.Touched:Connect(function(p127)
								-- upvalues: (ref) v_u_78, (copy) v_u_118
								v_u_78(v_u_118, p127)
							end)
						end
						v_u_118.DespawnThread = task.delay(v_u_12.DespawnTime, function()
							-- upvalues: (copy) v_u_118, (ref) v_u_56
							if not v_u_118.isPickedUp then
								v_u_56(v_u_118)
							end
						end)
					end
				end
				if v116 and v114 then
					v_u_86(v_u_118, v114)
				end
			else
				v_u_16 = v_u_16 - 1
				v_u_15[v_u_117] = nil
			end
		end
		for v128, v129 in pairs(v_u_17) do
			if v128 and v128.Parent then
				local v130 = v112 - v129.StartTime
				local v131 = v130 / 0.6
				local v132 = math.min(v131, 1)
				local v133 = v130 * 2.75
				local v134 = math.sin(v133) * 0.4
				local v135 = v130 * 1.5
				local v136 = CFrame.new(v129.GroundPos + Vector3.new(0, v134, 0)) * CFrame.Angles(0, v135, 0)
				v129.Model:PivotTo(v136)
				for v137, v138 in ipairs(v129.Parts) do
					if v138.Parent then
						local v139 = v129.OriginalTransparencies[v137]
						v138.Transparency = v139 + (1 - v139) * v132
					end
				end
				if v132 >= 1 then
					v_u_17[v128] = nil
					if v128.Parent then
						v128:Destroy()
					end
				end
			else
				v_u_17[v128] = nil
			end
		end
	end)
	v_u_20 = task.spawn(function()
		-- upvalues: (ref) v_u_21, (ref) v_u_101, (ref) v_u_12
		while v_u_21 do
			local v140, v141 = pcall(v_u_101)
			if not v140 then
				warn("[LuckyBlockRain] spawnBlock failed:", v141)
			end
			task.wait(v_u_12.SpawnInterval)
		end
	end)
end
v7.OnClientEvent:Connect(function(p143)
	-- upvalues: (copy) v_u_104, (copy) v_u_142
	if p143 == nil then
		v_u_104()
	else
		v_u_142(p143)
	end
end)