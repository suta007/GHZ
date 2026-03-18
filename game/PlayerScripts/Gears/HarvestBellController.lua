local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
require(v1:WaitForChild("Player"):WaitForChild("NotificationService"))
local _ = require(v1:WaitForChild("Gears"):WaitForChild("Definitions"):WaitForChild("GearDefinitions")).Gears
local v5 = v1:WaitForChild("RemoteEvents")
local v_u_6 = v5:WaitForChild("UseGear")
local v7 = v5:WaitForChild("HarvestNotification")
local v_u_8 = game:GetService("SoundService"):WaitForChild("SFX"):WaitForChild("Gears"):WaitForChild("HarvestBell")
local v_u_9 = v2.LocalPlayer
local v_u_10 = v_u_9:GetMouse()
local v11 = {}
local v_u_12 = false
local v_u_13 = nil
local v_u_14 = nil
local v_u_15 = nil
local v_u_16 = nil
local v_u_17 = 0
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = {}
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = RaycastParams.new()
v_u_32.FilterType = Enum.RaycastFilterType.Exclude
local function v_u_33()
	-- upvalues: (ref) v_u_23, (copy) v_u_9, (ref) v_u_24, (ref) v_u_25, (copy) v_u_32
	v_u_23 = v_u_9.Character or v_u_9.CharacterAdded:Wait()
	v_u_24 = v_u_23:WaitForChild("Right Arm")
	v_u_25 = v_u_23:WaitForChild("Humanoid")
	v_u_32.FilterDescendantsInstances = { v_u_23 }
end
v_u_33()
v_u_9.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_33, (ref) v_u_26, (ref) v_u_20
	v_u_33()
	v_u_26 = nil
	v_u_20 = nil
end)
local function v_u_42(p34, p35)
	-- upvalues: (ref) v_u_22, (ref) v_u_21
	for _, v36 in v_u_22 do
		v36:Destroy()
	end
	v_u_22 = {}
	v_u_21 = nil
	if p35 then
		local v37 = Instance.new("Highlight")
		v37.Name = "BellHighlight"
		v37.Adornee = p34
		v37.FillColor = Color3.fromRGB(255, 255, 255)
		v37.OutlineColor = Color3.fromRGB(255, 255, 255)
		v37.FillTransparency = 0.75
		v37.OutlineTransparency = 0
		v37.Parent = p34
		local v38 = v_u_22
		table.insert(v38, v37)
	else
		for _, v39 in p34:GetChildren() do
			if v39:IsA("Model") and (v39:GetAttribute("FullyGrown") and not v39:GetAttribute("Favorited")) then
				local v40 = Instance.new("Highlight")
				v40.Name = "BellHighlight"
				v40.Adornee = v39
				v40.FillColor = Color3.fromRGB(255, 255, 255)
				v40.OutlineColor = Color3.fromRGB(255, 255, 255)
				v40.FillTransparency = 0.75
				v40.OutlineTransparency = 0
				v40.Parent = v39
				local v41 = v_u_22
				table.insert(v41, v40)
			end
		end
	end
	if #v_u_22 ~= 0 then
		v_u_21 = p34
	end
end
local function v_u_44(p43)
	if not p43 then
		return nil
	end
	while p43 and p43 ~= workspace do
		if p43:IsA("Model") and p43:GetAttribute("PlantType") then
			return p43
		end
		p43 = p43.Parent
	end
	return nil
end
local function v_u_55()
	-- upvalues: (ref) v_u_12, (copy) v_u_10, (copy) v_u_32, (copy) v_u_44, (copy) v_u_9, (ref) v_u_21, (ref) v_u_22, (copy) v_u_42
	if not v_u_12 then
		return
	end
	local v45 = v_u_10.UnitRay
	local v46 = workspace:Raycast(v45.Origin, v45.Direction * 1000, v_u_32)
	local v47
	if v46 then
		v47 = v46.Instance
	else
		v47 = nil
	end
	local v48 = v_u_44(v47)
	if v48 and (v48:GetAttribute("FullyGrown") and v48:GetAttribute("OwnerUserId") == v_u_9.UserId) then
		if v48:GetAttribute("HarvestablePlant") then
			if not v48:GetAttribute("Favorited") then
				if v48 ~= v_u_21 then
					for _, v49 in v_u_22 do
						v49:Destroy()
					end
					v_u_22 = {}
					v_u_21 = nil
					local v50 = Instance.new("Highlight")
					v50.Name = "BellHighlight"
					v50.Adornee = v48
					v50.FillColor = Color3.fromRGB(255, 255, 255)
					v50.OutlineColor = Color3.fromRGB(255, 255, 255)
					v50.FillTransparency = 0.75
					v50.OutlineTransparency = 0
					v50.Parent = v48
					local v51 = v_u_22
					table.insert(v51, v50)
					if #v_u_22 == 0 then
						return
					end
					v_u_21 = v48
				end
				return
			end
		else
			local v52 = false
			for _, v53 in v48:GetChildren() do
				if v53:IsA("Model") and (v53:GetAttribute("FullyGrown") and not v53:GetAttribute("Favorited")) then
					v52 = true
					break
				end
			end
			if v52 then
				if v48 ~= v_u_21 then
					v_u_42(v48, false)
				end
				return
			end
		end
	end
	if v_u_21 then
		for _, v54 in v_u_22 do
			v54:Destroy()
		end
		v_u_22 = {}
		v_u_21 = nil
	end
end
local function v_u_61(p56)
	local v57 = p56:FindFirstChild("Harvest Bell")
	if v57 then
		local v58 = v57:FindFirstChild("MeshPart")
		if v58 then
			local v59 = v58:FindFirstChild("Attachment")
			if v59 then
				for _, v_u_60 in v59:GetDescendants() do
					if v_u_60:IsA("ParticleEmitter") then
						coroutine.resume(coroutine.create(function()
							-- upvalues: (copy) v_u_60
							v_u_60:Emit(v_u_60:GetAttribute("EmitCount") or 10)
							v_u_60.Enabled = true
							task.wait(0.4)
							v_u_60.Enabled = false
						end))
					end
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_74(p62)
	-- upvalues: (ref) v_u_17, (ref) v_u_18, (ref) v_u_19, (copy) v_u_3, (copy) v_u_9
	v_u_17 = v_u_17 + p62
	local v63 = "You harvested " .. v_u_17 .. " produce!"
	if v_u_18 and v_u_18.Parent then
		local v64 = v_u_18:FindFirstChild("CONTENT")
		local v65
		if v64 then
			v65 = v64:FindFirstChild("CONTENT_SHADOW")
		else
			v65 = v64
		end
		if v64 then
			v64.Text = v63
			v64.MaxVisibleGraphemes = -1
		end
		if v65 then
			v65.Text = v63
			v65.MaxVisibleGraphemes = -1
		end
		if v_u_19 then
			task.cancel(v_u_19)
		end
		v_u_19 = task.delay(3, function()
			-- upvalues: (ref) v_u_18, (ref) v_u_3, (ref) v_u_17, (ref) v_u_19
			if v_u_18 and v_u_18.Parent then
				local v66 = v_u_18.Size
				local v67 = v_u_3:Create(v_u_18, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Size"] = UDim2.new(v66.X.Scale, v66.X.Offset, 0, 0)
				})
				v67:Play()
				v67.Completed:Wait()
				v_u_18:Destroy()
			end
			v_u_18 = nil
			v_u_17 = 0
			v_u_19 = nil
		end)
	else
		v_u_17 = p62
		local v68 = v_u_9:WaitForChild("PlayerGui"):WaitForChild("Notification"):WaitForChild("Frame")
		local v69 = v68:WaitForChild("NotificationTemplate"):Clone()
		v69.Parent = v68
		v69.Visible = true
		local v70 = v69:WaitForChild("CONTENT")
		local v71 = v70:WaitForChild("CONTENT_SHADOW")
		v70.Text = v63
		v70.MaxVisibleGraphemes = -1
		v71.Text = v63
		v71.MaxVisibleGraphemes = -1
		v_u_18 = v69
		v_u_19 = task.delay(3, function()
			-- upvalues: (ref) v_u_18, (ref) v_u_3, (ref) v_u_17, (ref) v_u_19
			if v_u_18 and v_u_18.Parent then
				local v72 = v_u_18.Size
				local v73 = v_u_3:Create(v_u_18, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Size"] = UDim2.new(v72.X.Scale, v72.X.Offset, 0, 0)
				})
				v73:Play()
				v73.Completed:Wait()
				v_u_18:Destroy()
			end
			v_u_18 = nil
			v_u_17 = 0
			v_u_19 = nil
		end)
	end
end
local function v_u_85()
	-- upvalues: (ref) v_u_12, (ref) v_u_15, (copy) v_u_10, (copy) v_u_32, (copy) v_u_44, (copy) v_u_9, (ref) v_u_23, (ref) v_u_16, (ref) v_u_26, (copy) v_u_8, (copy) v_u_61, (ref) v_u_28, (copy) v_u_6, (ref) v_u_13
	if not v_u_12 then
		return
	end
	if v_u_15 and not v_u_15() then
		return
	end
	local v75 = v_u_10.UnitRay
	local v76 = workspace:Raycast(v75.Origin, v75.Direction * 1000, v_u_32)
	local v77
	if v76 then
		v77 = v76.Instance
	else
		v77 = nil
	end
	if not v77 then
		return
	end
	local v78 = v_u_44(v77)
	if not v78 then
		return
	end
	if not v78:GetAttribute("FullyGrown") then
		return
	end
	if v78:GetAttribute("OwnerUserId") ~= v_u_9.UserId then
		return
	end
	if v78:GetAttribute("HarvestablePlant") then
		if v78:GetAttribute("Favorited") then
			return
		end
	else
		local v79 = false
		for _, v80 in v78:GetChildren() do
			if v80:IsA("Model") and (v80:GetAttribute("FullyGrown") and not v80:GetAttribute("Favorited")) then
				v79 = true
				break
			end
		end
		if not v79 then
			return
		end
	end
	local v81 = v_u_23
	if v81 then
		v81 = v_u_23:FindFirstChild("HumanoidRootPart")
	end
	if v81 then
		local v82 = v78:GetPivot().Position
		local v83 = v81.Position - v82
		if Vector2.new(v83.X, v83.Z).Magnitude > 25 then
			return
		else
			if v_u_16 then
				v_u_16()
			end
			if v_u_26 then
				v_u_26:Play()
			end
			task.wait(0.2)
			v_u_8:Play()
			v_u_61(v_u_28)
			local v84 = v78:GetAttribute("Uuid")
			if v84 then
				v_u_6:FireServer(v_u_13, {
					["targetUuid"] = v84
				})
			end
		end
	else
		return
	end
end
function v11.Activate(p86, p_u_87, p88, p89)
	-- upvalues: (ref) v_u_12, (ref) v_u_13, (ref) v_u_15, (ref) v_u_16, (ref) v_u_28, (copy) v_u_33, (ref) v_u_14, (copy) v_u_85, (ref) v_u_27, (ref) v_u_25, (ref) v_u_26, (ref) v_u_29, (ref) v_u_30, (ref) v_u_24, (ref) v_u_20, (ref) v_u_31, (copy) v_u_4, (copy) v_u_55
	v_u_12 = true
	v_u_13 = p86
	v_u_15 = p88
	v_u_16 = p89
	v_u_28 = p_u_87
	v_u_33()
	if v_u_14 then
		v_u_14:Disconnect()
	end
	v_u_14 = p_u_87.Activated:Connect(v_u_85)
	v_u_27 = p_u_87:FindFirstChild("Ring")
	if v_u_27 then
		local v90 = v_u_25:FindFirstChildOfClass("Animator")
		if not v90 then
			v90 = Instance.new("Animator")
			v90.Parent = v_u_25
		end
		v_u_26 = v90:LoadAnimation(v_u_27)
	end
	if v_u_29 then
		v_u_29:Disconnect()
	end
	if v_u_30 then
		v_u_30:Disconnect()
	end
	v_u_29 = p_u_87.Equipped:Connect(function()
		-- upvalues: (ref) v_u_24, (ref) v_u_20, (copy) p_u_87
		local v91 = v_u_24:FindFirstChild("RightGrip")
		if v91 then
			v91:Destroy()
		end
		if not v_u_20 then
			v_u_20 = Instance.new("Motor6D")
			v_u_20.Name = "Handle"
			v_u_20.Part0 = v_u_24
			v_u_20.Part1 = p_u_87:FindFirstChild("Handle")
			v_u_20.C0 = CFrame.new(0.073, -0.67, 0.324) * CFrame.fromOrientation(0, -1.5707963267948966, 1.5707963267948966)
			v_u_20.C1 = CFrame.new()
			v_u_20.Parent = v_u_24
		end
	end)
	v_u_30 = p_u_87.Unequipped:Connect(function()
		-- upvalues: (ref) v_u_20
		if v_u_20 then
			v_u_20:Destroy()
			v_u_20 = nil
		end
	end)
	if v_u_31 then
		v_u_31:Disconnect()
	end
	v_u_31 = v_u_4.RenderStepped:Connect(v_u_55)
end
function v11.Deactivate()
	-- upvalues: (ref) v_u_12, (ref) v_u_13, (ref) v_u_15, (ref) v_u_16, (ref) v_u_14, (ref) v_u_29, (ref) v_u_30, (ref) v_u_31, (ref) v_u_20, (ref) v_u_22, (ref) v_u_21, (ref) v_u_26
	v_u_12 = false
	v_u_13 = nil
	v_u_15 = nil
	v_u_16 = nil
	if v_u_14 then
		v_u_14:Disconnect()
		v_u_14 = nil
	end
	if v_u_29 then
		v_u_29:Disconnect()
		v_u_29 = nil
	end
	if v_u_30 then
		v_u_30:Disconnect()
		v_u_30 = nil
	end
	if v_u_31 then
		v_u_31:Disconnect()
		v_u_31 = nil
	end
	if v_u_20 then
		v_u_20:Destroy()
		v_u_20 = nil
	end
	for _, v92 in v_u_22 do
		v92:Destroy()
	end
	v_u_22 = {}
	v_u_21 = nil
	if v_u_26 then
		v_u_26:Stop()
		v_u_26:Destroy()
		v_u_26 = nil
	end
end
v7.OnClientEvent:Connect(function(p93)
	-- upvalues: (copy) v_u_74
	v_u_74(p93)
end)
return v11