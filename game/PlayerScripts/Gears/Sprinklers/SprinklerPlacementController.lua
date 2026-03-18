local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = game:GetService("CollectionService")
local v_u_6 = game:GetService("Workspace")
local v_u_7 = v_u_2:WaitForChild("RemoteEvents"):WaitForChild("UseGear")
local v_u_8 = v1.LocalPlayer
local v_u_9 = v_u_6.CurrentCamera
local v_u_10 = v_u_6:WaitForChild("Plots")
local v11 = {}
local v_u_12 = false
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = CFrame.new()
local v_u_20 = {}
local v_u_21 = v_u_3.TouchEnabled
if v_u_21 then
	v_u_21 = not v_u_3.KeyboardEnabled
end
local v_u_22
if v_u_21 then
	v_u_22 = require(v_u_2:WaitForChild("UI"):WaitForChild("SprinklerPlacementUI"))
else
	v_u_22 = nil
end
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local function v_u_29(p26)
	for _, v27 in p26:GetChildren() do
		if v27.Name == "GroundAnchor" and v27:IsA("BasePart") then
			return v27
		end
	end
	for _, v28 in p26:GetDescendants() do
		if v28.Name == "GroundAnchor" and v28:IsA("BasePart") then
			return v28
		end
	end
	return nil
end
local function v_u_34()
	-- upvalues: (copy) v_u_10
	local v30 = {}
	for _, v31 in v_u_10:GetChildren() do
		if v31:IsA("Model") and v31:GetAttribute("Owner") then
			local v32 = v31:FindFirstChild("PlantableArea")
			if v32 then
				for _, v33 in v32:GetChildren() do
					if v33:IsA("BasePart") then
						table.insert(v30, v33)
					end
				end
			end
		end
	end
	return v30
end
local function v_u_39()
	-- upvalues: (copy) v_u_3, (copy) v_u_9, (ref) v_u_14, (copy) v_u_8, (copy) v_u_6
	local v35 = v_u_3:GetMouseLocation()
	local v36 = v_u_9:ViewportPointToRay(v35.X, v35.Y)
	local v37 = RaycastParams.new()
	v37.FilterType = Enum.RaycastFilterType.Exclude
	v37.FilterDescendantsInstances = { v_u_14, v_u_8.Character }
	local v38 = v_u_6:Raycast(v36.Origin, v36.Direction * 1000, v37)
	if v38 then
		return v38.Position, v38.Instance
	else
		return nil, nil
	end
end
local function v_u_48()
	-- upvalues: (copy) v_u_6, (ref) v_u_20, (copy) v_u_3, (copy) v_u_8, (ref) v_u_14
	local v40 = v_u_6.CurrentCamera
	if not v40 then
		return nil
	end
	if #v_u_20 == 0 then
		return nil
	end
	local v41 = v_u_3:GetMouseLocation()
	local v42 = v40:ViewportPointToRay(v41.X, v41.Y)
	local v43 = RaycastParams.new()
	v43.FilterType = Enum.RaycastFilterType.Exclude
	local v44 = { v_u_8.Character }
	if v_u_14 then
		local v45 = v_u_14
		table.insert(v44, v45)
	end
	v43.FilterDescendantsInstances = v44
	local v46 = v_u_6:Raycast(v42.Origin, v42.Direction * 1000, v43)
	if not v46 then
		return nil
	end
	for _, v47 in v_u_20 do
		if v46.Instance == v47 then
			return v46.Position
		end
	end
	return nil
end
local function v_u_60(p49)
	-- upvalues: (copy) v_u_2, (copy) v_u_5, (copy) v_u_29, (ref) v_u_19, (copy) v_u_6
	local v50 = v_u_2:FindFirstChild("Gears")
	if not v50 then
		return nil
	end
	local v51 = v50:FindFirstChild("Models")
	if not v51 then
		return nil
	end
	local v52 = v51:FindFirstChild("Sprinklers")
	if not v52 then
		return nil
	end
	local v53 = v52:FindFirstChild(p49)
	if not v53 then
		return nil
	end
	local v54 = v53:Clone()
	for _, v55 in v_u_5:GetTags(v54) do
		v_u_5:RemoveTag(v54, v55)
	end
	for _, v56 in v54:GetDescendants() do
		for _, v57 in v_u_5:GetTags(v56) do
			v_u_5:RemoveTag(v56, v57)
		end
	end
	local v58 = v_u_29(v54)
	if v58 then
		v_u_19 = v54:GetPivot():ToObjectSpace(v58.CFrame)
	else
		v_u_19 = CFrame.new()
	end
	for _, v59 in v54:GetDescendants() do
		if v59:IsA("ParticleEmitter") then
			v59.Enabled = false
		end
	end
	v54:SetAttribute("ValidPlacement", false)
	v_u_5:AddTag(v54, "SprinklerPreview")
	v54.Parent = v_u_6
	return v54
end
local function v_u_65()
	-- upvalues: (ref) v_u_14, (copy) v_u_39, (ref) v_u_20, (ref) v_u_19
	if not v_u_14 then
		return
	end
	local v61, v62 = v_u_39()
	if not v61 then
		if v_u_14 then
			v_u_14:SetAttribute("ValidPlacement", false)
		end
	end
	local v63
	if v62 == nil then
		v63 = false
		::l8::
		if v_u_14 then
			v_u_14:SetAttribute("ValidPlacement", v63)
		end
		v_u_14:PivotTo(CFrame.new(v61) * v_u_19:Inverse())
		return
	else
		for _, v64 in v_u_20 do
			if v62 == v64 then
				v63 = true
				goto l8
			end
		end
		v63 = false
		goto l8
	end
end
local function v_u_66()
	-- upvalues: (ref) v_u_12, (copy) v_u_65
	if v_u_12 then
		v_u_65()
	end
end
local function v_u_68()
	-- upvalues: (ref) v_u_12, (ref) v_u_17, (copy) v_u_48, (ref) v_u_18, (copy) v_u_7, (ref) v_u_13
	if v_u_12 then
		if v_u_17 and not v_u_17() then
			return
		else
			local v67 = v_u_48()
			if v67 then
				if v_u_18 then
					v_u_18()
				end
				v_u_7:FireServer(v_u_13, {
					["position"] = v67
				})
			end
		end
	else
		return
	end
end
function v11.Activate(p69, p70, p71, p72)
	-- upvalues: (ref) v_u_12, (ref) v_u_13, (ref) v_u_17, (ref) v_u_18, (ref) v_u_20, (copy) v_u_34, (ref) v_u_14, (copy) v_u_60, (copy) v_u_21, (ref) v_u_23, (ref) v_u_22, (ref) v_u_24, (copy) v_u_3, (copy) v_u_6, (copy) v_u_8, (ref) v_u_19, (ref) v_u_25, (copy) v_u_7, (ref) v_u_15, (copy) v_u_68, (ref) v_u_16, (copy) v_u_4, (copy) v_u_66
	v_u_12 = true
	v_u_13 = p69
	v_u_17 = p71
	v_u_18 = p72
	v_u_20 = v_u_34()
	v_u_14 = v_u_60(p69)
	if v_u_21 then
		v_u_23 = nil
		if v_u_14 then
			v_u_14:PivotTo(CFrame.new(0, -1000, 0))
		end
		v_u_22.Open()
		v_u_24 = v_u_3.InputBegan:Connect(function(p73, p74)
			-- upvalues: (ref) v_u_12, (ref) v_u_14, (ref) v_u_6, (ref) v_u_8, (ref) v_u_20, (ref) v_u_23, (ref) v_u_19
			if p74 then
				return
			end
			if p73.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			if not (v_u_12 and v_u_14) then
				return
			end
			local v75 = v_u_6.CurrentCamera
			if not v75 then
				return
			end
			local v76 = p73.Position
			local v77 = v75:ScreenPointToRay(v76.X, v76.Y)
			local v78 = RaycastParams.new()
			v78.FilterType = Enum.RaycastFilterType.Exclude
			local v79 = { v_u_8.Character }
			if v_u_14 then
				local v80 = v_u_14
				table.insert(v79, v80)
			end
			v78.FilterDescendantsInstances = v79
			local v81 = v_u_6:Raycast(v77.Origin, v77.Direction * 1000, v78)
			if not v81 then
				return
			end
			local v82 = v81.Instance
			for _, v83 in v_u_20 do
				if v82 == v83 then
					v84 = true
					::l17::
					if v84 then
						v_u_23 = v81.Position
						if v_u_14 then
							v_u_14:SetAttribute("ValidPlacement", true)
						end
						v_u_14:PivotTo(CFrame.new(v_u_23) * v_u_19:Inverse())
					end
				end
			end
			local v84 = false
			goto l17
		end)
		v_u_25 = v_u_22.Confirm.Activated:Connect(function()
			-- upvalues: (ref) v_u_12, (ref) v_u_23, (ref) v_u_17, (ref) v_u_18, (ref) v_u_7, (ref) v_u_13, (ref) v_u_14
			if v_u_12 and v_u_23 then
				if not v_u_17 or v_u_17() then
					if v_u_18 then
						v_u_18()
					end
					v_u_7:FireServer(v_u_13, {
						["position"] = v_u_23
					})
					v_u_23 = nil
					if v_u_14 then
						v_u_14:SetAttribute("ValidPlacement", false)
					end
					if v_u_14 then
						v_u_14:PivotTo(CFrame.new(0, -1000, 0))
					end
				end
			else
				return
			end
		end)
	else
		if v_u_15 then
			v_u_15:Disconnect()
		end
		v_u_15 = p70.Activated:Connect(v_u_68)
		if v_u_16 then
			v_u_16:Disconnect()
		end
		v_u_16 = v_u_4.RenderStepped:Connect(v_u_66)
	end
end
function v11.Deactivate()
	-- upvalues: (ref) v_u_12, (ref) v_u_13, (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (ref) v_u_20, (ref) v_u_23, (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (ref) v_u_24, (ref) v_u_25, (copy) v_u_21, (ref) v_u_22
	v_u_12 = false
	v_u_13 = nil
	v_u_17 = nil
	v_u_18 = nil
	v_u_19 = CFrame.new()
	v_u_20 = {}
	v_u_23 = nil
	if v_u_14 then
		v_u_14:Destroy()
		v_u_14 = nil
	end
	if v_u_15 then
		v_u_15:Disconnect()
		v_u_15 = nil
	end
	if v_u_16 then
		v_u_16:Disconnect()
		v_u_16 = nil
	end
	if v_u_24 then
		v_u_24:Disconnect()
		v_u_24 = nil
	end
	if v_u_25 then
		v_u_25:Disconnect()
		v_u_25 = nil
	end
	if v_u_21 and v_u_22 then
		v_u_22.Close()
	end
end
return v11