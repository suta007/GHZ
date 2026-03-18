local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("RunService")
local v_u_3 = require(game:GetService("ReplicatedStorage"):WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("TierHelper"))
local v_u_4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDataDefinitions"))
local v_u_5 = v_u_1.LocalPlayer
local v_u_6 = Color3.fromRGB(255, 255, 255)
local v_u_7 = {}
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = nil
local function v_u_22(p13, p14)
	-- upvalues: (copy) v_u_1
	local v15 = p13.Model
	local v16 = p13.Highlight
	if not (v15 and v15.Parent) then
		return false
	end
	local v17 = v15:FindFirstChild("Anchor") or v15.PrimaryPart
	if not v17 then
		return false
	end
	local v18 = #v_u_1:GetPlayers() / v_u_1.MaxPlayers
	local v19 = 125 / math.max(v18, 0.1)
	local v20 = (v17.Position - p14).Magnitude
	if v19 < v20 then
		v16.Enabled = false
		return true
	end
	v16.Enabled = true
	if v20 <= 20 then
		v16.FillTransparency = 0.7
		v16.OutlineTransparency = 0
	else
		local v21 = (v20 - 20) / (v19 - 20)
		v16.FillTransparency = 0.7 + 0.7 * v21
		v16.OutlineTransparency = v21
	end
	return true
end
local function v_u_26(p23)
	-- upvalues: (ref) v_u_7, (copy) v_u_4, (ref) v_u_6, (copy) v_u_3
	if not v_u_7[p23] then
		local v24 = p23:GetAttribute("SeedType")
		if v24 then
			v_u_6 = v_u_3:GetColor(v_u_4[v24].Rarity or "Common")
		end
		local v25 = Instance.new("Highlight")
		v25.FillColor = v_u_6
		v25.OutlineColor = v_u_6
		v25.FillTransparency = 0.7
		v25.OutlineTransparency = 0
		v25.Enabled = true
		v25.Adornee = p23
		v25.Parent = p23
		v_u_7[p23] = {
			["Model"] = p23,
			["Highlight"] = v25
		}
	end
end
local function v_u_28()
	-- upvalues: (ref) v_u_8, (copy) v_u_26
	if v_u_8 then
		for _, v27 in ipairs(v_u_8:GetChildren()) do
			if v27:IsA("Model") then
				v_u_26(v27)
			end
		end
	end
end
local function v_u_33(p29)
	-- upvalues: (ref) v_u_8, (copy) v_u_28, (ref) v_u_11, (copy) v_u_26, (ref) v_u_12, (ref) v_u_7
	v_u_8 = p29
	v_u_28()
	v_u_11 = p29.ChildAdded:Connect(function(p30)
		-- upvalues: (ref) v_u_26
		if p30:IsA("Model") then
			v_u_26(p30)
		end
	end)
	v_u_12 = p29.ChildRemoved:Connect(function(p31)
		-- upvalues: (ref) v_u_7
		if v_u_7[p31] then
			local v32 = v_u_7[p31]
			if not v32 then
				return
			end
			if v32.Highlight and v32.Highlight.Parent then
				v32.Highlight:Destroy()
			end
			v_u_7[p31] = nil
		end
	end)
end
local function v_u_36()
	-- upvalues: (ref) v_u_11, (ref) v_u_12, (ref) v_u_7, (ref) v_u_8
	if v_u_11 then
		v_u_11:Disconnect()
		v_u_11 = nil
	end
	if v_u_12 then
		v_u_12:Disconnect()
		v_u_12 = nil
	end
	for v34 in pairs(v_u_7) do
		local v35 = v_u_7[v34]
		if v35 then
			if v35.Highlight and v35.Highlight.Parent then
				v35.Highlight:Destroy()
			end
			v_u_7[v34] = nil
		end
	end
	v_u_7 = {}
	v_u_8 = nil
end
local function v_u_43()
	-- upvalues: (copy) v_u_5, (ref) v_u_7, (copy) v_u_22
	local v37 = v_u_5.Character
	local v38
	if v37 then
		local v39 = v37:FindFirstChild("HumanoidRootPart")
		if v39 then
			v38 = v39.Position
		else
			v38 = nil
		end
	else
		v38 = nil
	end
	if v38 then
		for v40, v41 in pairs(v_u_7) do
			if not v_u_22(v41, v38) then
				local v42 = v_u_7[v40]
				if v42 then
					if v42.Highlight and v42.Highlight.Parent then
						v42.Highlight:Destroy()
					end
					v_u_7[v40] = nil
				end
			end
		end
	end
end
(function()
	-- upvalues: (copy) v_u_33, (ref) v_u_9, (ref) v_u_10, (ref) v_u_8, (copy) v_u_36, (copy) v_u_2, (copy) v_u_43
	local v44 = workspace:FindFirstChild("SeedRainCollectibles")
	if v44 and v44:IsA("Folder") then
		v_u_33(v44)
	end
	v_u_9 = workspace.ChildAdded:Connect(function(p45)
		-- upvalues: (ref) v_u_33
		if p45.Name == "SeedRainCollectibles" and p45:IsA("Folder") then
			v_u_33(p45)
		end
	end)
	v_u_10 = workspace.ChildRemoved:Connect(function(p46)
		-- upvalues: (ref) v_u_8, (ref) v_u_36
		if p46 == v_u_8 then
			v_u_36()
		end
	end)
	v_u_2.RenderStepped:Connect(v_u_43)
end)()
return {}