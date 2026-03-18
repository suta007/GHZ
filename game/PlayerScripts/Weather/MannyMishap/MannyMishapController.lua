local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = v_u_1.LocalPlayer
local v5 = v2:WaitForChild("RemoteEvents")
local v6 = v5:WaitForChild("MannyMishapConfig")
local v_u_7 = v5:WaitForChild("MannyMishapCollect")
local v8 = v2:WaitForChild("Plants"):WaitForChild("Models")
local v_u_9 = {
	{
		["Name"] = "Corn",
		["Model"] = v8:WaitForChild("Corn"):WaitForChild("FruitFolder"):WaitForChild("Fruit1"),
		["Points"] = 1,
		["Weight"] = 60
	},
	{
		["Name"] = "Apple",
		["Model"] = v8:WaitForChild("Apple"):WaitForChild("FruitFolder"):WaitForChild("Fruit1"),
		["Points"] = 2,
		["Weight"] = 30,
		["Rotation"] = CFrame.Angles(0, 0, 3.141592653589793)
	},
	{
		["Name"] = "Cabbage",
		["Model"] = v8:WaitForChild("Cabbage"):WaitForChild("Cabbage1"),
		["Points"] = 3,
		["Weight"] = 10
	}
}
local v_u_10 = {
	["Corn"] = Color3.fromRGB(255, 220, 80),
	["Apple"] = Color3.fromRGB(255, 80, 80),
	["Cabbage"] = Color3.fromRGB(100, 200, 80)
}
local v_u_11 = Color3.fromRGB(255, 255, 255)
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
local v_u_22 = 0
local v_u_23 = nil
local v_u_24 = nil
local function v_u_29()
	-- upvalues: (ref) v_u_23
	if v_u_23 then
		return v_u_23
	end
	local v25 = {}
	local v26 = workspace:FindFirstChild("MapPhysical")
	if v26 then
		local v27 = v26:FindFirstChild("Tree")
		local v28 = v26:FindFirstChild("Trees2")
		if v27 then
			table.insert(v25, v27)
		end
		if v28 then
			table.insert(v25, v28)
		end
	end
	v_u_23 = v25
	return v25
end
local function v_u_36(p30, p31, p32)
	-- upvalues: (copy) v_u_29
	local v33 = Vector3.new(p30, p32, p31)
	local v34 = RaycastParams.new()
	v34.FilterType = Enum.RaycastFilterType.Exclude
	v34.FilterDescendantsInstances = v_u_29()
	local v35 = workspace:Raycast(v33, Vector3.new(0, -500, 0), v34)
	if v35 then
		return v35.Position + Vector3.new(0, 3, 0)
	else
		return Vector3.new(p30, 3, p31)
	end
end
local function v_u_48(p37)
	-- upvalues: (copy) v_u_10, (copy) v_u_11
	local v38 = p37.Model:Clone()
	v38.Name = p37.Name .. "_Collectible"
	for _, v39 in v38:GetDescendants() do
		if v39.Name == "PlantAnchor" or v39.Name == "FruitAnchor" then
			v39:Destroy()
		end
	end
	local v40 = v38:GetPivot()
	local v41 = p37.Rotation or CFrame.new()
	for _, v42 in v38:GetDescendants() do
		if v42:IsA("BasePart") then
			local v43 = v40:ToObjectSpace(v42.CFrame)
			local v44 = v43.Position * 3
			v42.Size = v42.Size * 3
			v42.CFrame = v40 * v41 * CFrame.new(v44) * (v43 - v43.Position)
			v42.Anchored = true
			v42.CanCollide = false
			v42.CanTouch = false
		end
	end
	local v45 = Instance.new("Part")
	v45.Name = "Anchor"
	v45.Size = Vector3.new(7, 7, 7)
	v45.Transparency = 1
	v45.Anchored = true
	v45.CanCollide = false
	v45.CanQuery = false
	v45.CanTouch = true
	v45.CFrame = v38:GetPivot()
	v45.Parent = v38
	v38.PrimaryPart = v45
	local v46 = v_u_10[p37.Name] or v_u_11
	local v47 = Instance.new("Highlight")
	v47.FillColor = v46
	v47.OutlineColor = v46
	v47.FillTransparency = 0.7
	v47.OutlineTransparency = 0
	v47.Enabled = true
	v47.Adornee = v38
	v47.Parent = v38
	return v38
end
local function v_u_55(p49)
	-- upvalues: (ref) v_u_17
	local v50 = p49.Model
	if v50 and v50.Parent then
		local v51 = {}
		local v52 = {}
		for _, v53 in v50:GetDescendants() do
			if v53:IsA("BasePart") then
				table.insert(v51, v53)
				local v54 = v53.Transparency
				table.insert(v52, v54)
			end
		end
		v_u_17[v50] = {
			["Model"] = v50,
			["GroundPos"] = p49.GroundPos,
			["Parts"] = v51,
			["OriginalTransparencies"] = v52,
			["StartTime"] = workspace:GetServerTimeNow()
		}
	end
end
local function v_u_57(p56)
	-- upvalues: (ref) v_u_15, (ref) v_u_16, (copy) v_u_55
	if p56.TouchConnection then
		p56.TouchConnection:Disconnect()
		p56.TouchConnection = nil
	end
	if p56.DespawnThread then
		pcall(task.cancel, p56.DespawnThread)
		p56.DespawnThread = nil
	end
	if v_u_15[p56.Model] then
		v_u_16 = v_u_16 - 1
		v_u_15[p56.Model] = nil
	end
	if p56.Model and p56.Model.Parent then
		v_u_55(p56)
	end
end
local function v_u_60(p58, p59)
	-- upvalues: (ref) v_u_22, (copy) v_u_1, (copy) v_u_4, (copy) v_u_7, (ref) v_u_15, (ref) v_u_16
	if p59 and p59.Parent then
		if p58.isPickedUp then
			return
		elseif tick() - v_u_22 < 0.4 then
			return
		elseif p59.Parent:FindFirstChild("Humanoid") then
			if v_u_1:GetPlayerFromCharacter(p59.Parent) == v_u_4 then
				v_u_22 = tick()
				p58.isPickedUp = true
				if p58.TouchConnection then
					p58.TouchConnection:Disconnect()
					p58.TouchConnection = nil
				end
				if p58.DespawnThread then
					pcall(task.cancel, p58.DespawnThread)
					p58.DespawnThread = nil
				end
				v_u_7:FireServer(p58.FruitIndex)
				if v_u_15[p58.Model] then
					v_u_16 = v_u_16 - 1
					v_u_15[p58.Model] = nil
				end
				if p58.Model and p58.Model.Parent then
					p58.Model:Destroy()
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_68(p61, p62)
	local v63 = p61.Model
	local v64 = v63:FindFirstChildOfClass("Highlight")
	if v64 then
		local v65 = v63.PrimaryPart
		if v65 then
			local v66 = (v65.Position - p62).Magnitude
			if v66 > 125 then
				v64.Enabled = false
				return
			else
				v64.Enabled = true
				if v66 <= 20 then
					v64.FillTransparency = 0.7
					v64.OutlineTransparency = 0
				else
					local v67 = (v66 - 20) / 105
					v64.FillTransparency = 0.7 + 0.7 * v67
					v64.OutlineTransparency = v67
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_90()
	-- upvalues: (ref) v_u_21, (ref) v_u_14, (ref) v_u_13, (copy) v_u_9, (ref) v_u_12, (ref) v_u_16, (ref) v_u_18, (copy) v_u_48, (copy) v_u_36, (ref) v_u_15
	if not v_u_21 then
		return
	end
	v_u_14 = v_u_14 + 1
	local v69 = v_u_13:NextNumber() * 100
	local v70 = 0
	for _, v72 in ipairs(v_u_9) do
		v70 = v70 + v72.Weight
		if v69 <= v70 then
			goto l6
		end
	end
	local v72 = v_u_9[#v_u_9]
	::l6::
	local v73 = v_u_12.CeilingPositionX
	local v74 = v_u_12.CeilingPositionZ
	local v75 = v_u_12.CeilingPositionY
	local v76 = v_u_12.CeilingSizeX / 2
	local v77 = v_u_12.CeilingSizeZ / 2
	local v78 = v_u_12.CenterBias
	local v79 = v_u_13:NextNumber() - 0.5
	local v80 = v73 + (v79 >= 0 and 1 or -1) * (math.abs(v79) / 0.5) ^ v78 * 0.5 * v76 * 2
	local v81 = v_u_12.CenterBias
	local v82 = v_u_13:NextNumber() - 0.5
	local v83 = v74 + (v82 >= 0 and 1 or -1) * (math.abs(v82) / 0.5) ^ v81 * 0.5 * v77 * 2
	if v_u_16 >= v_u_12.MaxFruits then
		return
	elseif v_u_18 and v_u_18.Parent then
		local v84 = v_u_48(v72)
		if v84 then
			local v85 = Vector3.new(v80, v75, v83)
			local v86 = v_u_36(v80, v83, v75)
			local v87 = workspace:GetServerTimeNow()
			local v88 = {
				["Model"] = v84,
				["FruitIndex"] = v_u_14,
				["FruitType"] = v72.Name,
				["Points"] = v72.Points,
				["StartPos"] = v85,
				["GroundPos"] = v86,
				["isPickedUp"] = false,
				["isLanded"] = false,
				["FallStartTime"] = v87,
				["LandTime"] = nil,
				["TouchConnection"] = nil,
				["DespawnThread"] = nil
			}
			local v89 = CFrame.new(v85) * CFrame.Angles(0, 0, 0)
			v88.Model:PivotTo(v89)
			v84.Parent = v_u_18
			v_u_15[v84] = v88
			v_u_16 = v_u_16 + 1
		end
	else
		return
	end
end
local function v_u_93()
	-- upvalues: (ref) v_u_21, (ref) v_u_20, (ref) v_u_19, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_23, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_24
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
		for _, v91 in pairs(v_u_15) do
			if v91.TouchConnection then
				v91.TouchConnection:Disconnect()
			end
			if v91.DespawnThread then
				pcall(task.cancel, v91.DespawnThread)
			end
			if v91.Model and v91.Model.Parent then
				v91.Model:Destroy()
			end
		end
		v_u_15 = {}
		v_u_16 = 0
		for v92 in pairs(v_u_17) do
			if v92 and v92.Parent then
				v92:Destroy()
			end
		end
		v_u_17 = {}
		if v_u_18 and v_u_18.Parent then
			v_u_18:Destroy()
			v_u_18 = nil
		end
		v_u_23 = nil
		v_u_12 = nil
		v_u_13 = nil
		v_u_14 = 0
		v_u_24 = nil
	end
end
local function v_u_94()
	-- upvalues: (ref) v_u_21, (copy) v_u_93, (ref) v_u_12, (ref) v_u_13, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_17, (ref) v_u_23, (ref) v_u_24, (copy) v_u_9, (ref) v_u_18, (ref) v_u_19, (copy) v_u_3, (copy) v_u_4, (copy) v_u_60, (copy) v_u_57, (copy) v_u_68, (ref) v_u_20, (copy) v_u_90
	-- failed to decompile
end
v6.OnClientEvent:Connect(function(p95)
	-- upvalues: (copy) v_u_93, (copy) v_u_94
	if p95 == nil then
		v_u_93()
	else
		v_u_94(p95)
	end
end)