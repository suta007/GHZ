local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
game:GetService("UserInputService")
local v3 = game:GetService("SoundService")
game:GetService("CollectionService")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = v2.LocalPlayer
local v_u_7 = v1:WaitForChild("RemoteEvents"):WaitForChild("PlantSeed")
local v_u_8 = require(v1:WaitForChild("Inventory"):WaitForChild("ItemInventory"))
local v_u_9 = v3:WaitForChild("SFX"):WaitForChild("Player"):WaitForChild("Planting")
local v_u_10 = v1:WaitForChild("Plants"):WaitForChild("PlantDirt")
local v_u_11 = v1:WaitForChild("Plants"):WaitForChild("Tools"):WaitForChild("Seeds")
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = Random.new()
local v_u_15 = 0
if not v_u_6.Character then
	v_u_6.CharacterAdded:Wait()
end
local v_u_16 = {}
local function v_u_22(p17)
	-- upvalues: (copy) v_u_6
	local v18 = v_u_6.Character
	local v19
	if v18 then
		local v20 = v18:FindFirstChildOfClass("Humanoid")
		if v20 then
			v19 = v20:FindFirstChildOfClass("Animator")
			if not v19 then
				v19 = Instance.new("Animator")
				v19.Parent = v20
			end
		else
			v19 = nil
		end
	else
		v19 = nil
	end
	if not v19 then
		return nil
	end
	local v_u_21 = v19:LoadAnimation(p17)
	v_u_21.Looped = false
	v_u_21.Stopped:Connect(function()
		-- upvalues: (copy) v_u_21
		v_u_21:Destroy()
	end)
	v_u_21:Play()
	return v_u_21
end
local function v_u_23()
	-- upvalues: (copy) v_u_9, (copy) v_u_14
	v_u_9.PlaybackSpeed = 0.9 + v_u_14:NextNumber() * 0.3
	v_u_9:Play()
end
local function v_u_102(p_u_24, p_u_25, p_u_26, p_u_27)
	-- upvalues: (copy) v_u_11, (copy) v_u_14, (copy) v_u_5, (copy) v_u_10, (copy) v_u_4
	if p_u_26 then
		p_u_26 = v_u_11:FindFirstChild(p_u_26 .. " Seed")
	end
	if p_u_26 then
		p_u_26 = p_u_26:Clone()
	end
	if p_u_26 then
		for _, v28 in p_u_26:GetDescendants() do
			if v28:IsA("BaseScript") or (v28:IsA("LocalScript") or v28:IsA("Script")) then
				v28:Destroy()
			end
		end
		for _, v29 in p_u_26:GetDescendants() do
			if v29:IsA("BasePart") then
				v29.Anchored = true
				v29.CanCollide = false
				v29.CanTouch = false
				v29.CastShadow = false
			end
		end
	end
	local v_u_30 = {}
	if p_u_26:IsA("Model") then
		for _, v31 in p_u_26:GetDescendants() do
			if v31:IsA("BasePart") then
				v_u_30[v31] = v31.Transparency
			end
		end
	else
		v_u_30[p_u_26] = p_u_26.Transparency
	end
	local v32 = p_u_26:FindFirstChild("Handle")
	if v32 and v32:IsA("BasePart") then
		v32.Transparency = 1
		v_u_30[v32] = 1
	end
	p_u_26.Parent = workspace
	local v_u_33
	if p_u_26:IsA("Model") then
		local v34
		v34, v_u_33 = p_u_26:GetBoundingBox()
	else
		v_u_33 = p_u_26.Size
	end
	local v35 = 3.5 + v_u_14:NextNumber() * 1.5
	local v36 = v_u_14:NextNumber(-0.15, 0.15)
	local v37 = v_u_14:NextNumber(-0.15, 0.15)
	local v_u_38 = CFrame.new(p_u_24 + Vector3.new(v36, v35, v37))
	local v39 = CFrame.new
	local v40 = v_u_33.Y * 0.5
	local v_u_41 = v39(p_u_24 + Vector3.new(0, v40, 0))
	if p_u_26:IsA("Model") then
		p_u_26:PivotTo(v_u_38)
	else
		p_u_26.CFrame = v_u_38
	end
	for v42, v43 in v_u_30 do
		v42.Transparency = v43 + (1 - v43) * 1
	end
	local v_u_44 = 0
	local v_u_45 = nil
	v_u_45 = v_u_5.Heartbeat:Connect(function(p46)
		-- upvalues: (ref) v_u_44, (copy) v_u_30, (ref) v_u_45
		local v47 = v_u_44 + p46
		v_u_44 = math.min(v47, 0.1)
		local v48 = 1 - v_u_44 / 0.1
		for v49, v50 in v_u_30 do
			v49.Transparency = v50 + (1 - v50) * v48
		end
		if v_u_44 >= 0.1 then
			v_u_45:Disconnect()
			for v51, v52 in v_u_30 do
				v51.Transparency = v52 + (1 - v52) * 0
			end
		end
	end)
	local v_u_53 = 0.22 + v_u_14:NextNumber() * 0.06
	local v_u_54 = 0
	local v_u_55 = nil
	v_u_55 = v_u_5.Heartbeat:Connect(function(p56)
		-- upvalues: (ref) v_u_54, (copy) v_u_53, (copy) v_u_38, (copy) v_u_41, (copy) p_u_26, (ref) v_u_55, (ref) v_u_14, (copy) p_u_25, (ref) v_u_10, (copy) p_u_24, (ref) v_u_4, (copy) v_u_33, (copy) p_u_27, (ref) v_u_5, (copy) v_u_30
		local v57 = v_u_54 + p56
		local v58 = v_u_53
		v_u_54 = math.min(v57, v58)
		local v59 = v_u_54 / v_u_53
		local v60 = v_u_38:Lerp(v_u_41, v59 * v59)
		if p_u_26:IsA("Model") then
			p_u_26:PivotTo(v60)
		else
			p_u_26.CFrame = v60
		end
		if v_u_53 <= v_u_54 then
			v_u_55:Disconnect()
			local v61 = v_u_41
			if p_u_26:IsA("Model") then
				p_u_26:PivotTo(v61)
			else
				p_u_26.CFrame = v61
			end
			local v62 = (1.2 + v_u_14:NextNumber() * 0.3) * p_u_25
			local v_u_63 = v_u_10:Clone()
			v_u_63.Anchored = true
			v_u_63.CanCollide = false
			v_u_63.CanTouch = false
			v_u_63.Size = Vector3.new(0.14, 0, 0)
			v_u_63.CFrame = CFrame.new(p_u_24 + Vector3.new(0, 0.06, 0)) * CFrame.Angles(0, v_u_14:NextNumber(0, 6.283185307179586), 1.5707963267948966)
			v_u_63.Parent = workspace
			v_u_4:Create(v_u_63, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				["Size"] = Vector3.new(0.16, v62, v62)
			}):Play()
			local v64 = Color3.fromHex("#694028")
			local v65 = v_u_14:NextNumber() * 4
			local v66 = math.floor(v65) + 6
			for v67 = 1, v66 do
				local v_u_68 = Instance.new("Part")
				v_u_68.Anchored = true
				v_u_68.CanCollide = false
				v_u_68.CanTouch = false
				v_u_68.CastShadow = false
				v_u_68.Material = Enum.Material.SmoothPlastic
				v_u_68.Color = v64
				local v69 = 0.07 + v_u_14:NextNumber() * 0.1
				v_u_68.Size = Vector3.new(v69, v69, v69)
				local v70 = v67 / v66 * 3.141592653589793 * 2 + v_u_14:NextNumber() * 0.8
				local v71 = 0.65 + v_u_14:NextNumber() * 0.85
				local v72 = p_u_24
				local v73 = math.cos(v70) * v71
				local v74 = math.sin(v70) * v71
				local v_u_75 = v72 + Vector3.new(v73, 0, v74)
				local v76 = v_u_75.X
				local v77 = p_u_24.Y + 0.35 + v_u_14:NextNumber() * 0.45
				local v78 = v_u_75.Z
				local v79 = Vector3.new(v76, v77, v78)
				v_u_68.CFrame = CFrame.new(v79)
				v_u_68.Parent = workspace
				local v80 = 0.18 + v_u_14:NextNumber() * 0.08
				v_u_4:Create(v_u_68, TweenInfo.new(v80, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["CFrame"] = CFrame.new(v_u_75)
				}):Play()
				task.delay(v80 + 1.3, function()
					-- upvalues: (copy) v_u_68, (copy) v_u_75, (ref) p_u_24, (ref) v_u_4, (ref) v_u_14
					if v_u_68.Parent then
						local v81 = v_u_75.X
						local v82 = p_u_24.Y - 0.05
						local v83 = v_u_75.Z
						local v84 = Vector3.new(v81, v82, v83)
						local v85 = v_u_4:Create(v_u_68, TweenInfo.new(0.2 + v_u_14:NextNumber() * 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
							["CFrame"] = CFrame.new(v84),
							["Transparency"] = 1
						})
						v85:Play()
						v85.Completed:Connect(function()
							-- upvalues: (ref) v_u_68
							v_u_68:Destroy()
						end)
					end
				end)
			end
			task.delay(1.8, function()
				-- upvalues: (copy) v_u_63, (ref) v_u_4
				if v_u_63.Parent then
					local v86 = v_u_4:Create(v_u_63, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						["Size"] = Vector3.new(0, 0, 0),
						["Transparency"] = 1
					})
					v86:Play()
					v86.Completed:Connect(function()
						-- upvalues: (ref) v_u_63
						v_u_63:Destroy()
					end)
				end
			end)
			local v87 = v_u_33.Y * 1.6
			local v88 = CFrame.new
			local v89 = p_u_24
			local v90 = -v87
			local v_u_91 = v88(v89 + Vector3.new(0, v90, 0))
			task.delay(0.45499999999999996, function()
				-- upvalues: (ref) p_u_27
				if p_u_27 then
					p_u_27()
				end
			end)
			local v_u_92 = 0
			local v_u_93 = nil
			v_u_93 = v_u_5.Heartbeat:Connect(function(p94)
				-- upvalues: (ref) v_u_92, (ref) v_u_41, (copy) v_u_91, (ref) p_u_26, (ref) v_u_30, (ref) v_u_93
				local v95 = v_u_92 + p94
				v_u_92 = math.min(v95, 0.7)
				local v96 = v_u_92 / 0.7
				local v97 = v96 * v96
				local v98 = v_u_41:Lerp(v_u_91, v97)
				if p_u_26:IsA("Model") then
					p_u_26:PivotTo(v98)
				else
					p_u_26.CFrame = v98
				end
				local v99 = v97 * 0.85
				for v100, v101 in v_u_30 do
					v100.Transparency = v101 + (1 - v101) * v99
				end
				if v_u_92 >= 0.7 then
					v_u_93:Disconnect()
					p_u_26:Destroy()
				end
			end)
		end
	end)
end
local function v_u_107()
	-- upvalues: (copy) v_u_6
	for _, v103 in workspace:WaitForChild("Plots"):GetChildren() do
		if v103:IsA("Model") and v103:GetAttribute("Owner") == v_u_6.UserId then
			local v104 = v103:FindFirstChild("PlantableArea")
			if not v104 then
				return {}
			end
			local v105 = {}
			for _, v106 in v104:GetChildren() do
				if v106:IsA("BasePart") then
					table.insert(v105, v106)
				end
			end
			return v105
		end
	end
	return {}
end
local function v_u_114()
	-- upvalues: (ref) v_u_16, (copy) v_u_6
	local v108 = workspace.CurrentCamera
	if not v108 then
		return nil
	end
	if #v_u_16 == 0 then
		return nil
	end
	local v109 = v_u_6:GetMouse()
	local v110 = RaycastParams.new()
	v110.FilterType = Enum.RaycastFilterType.Exclude
	v110.FilterDescendantsInstances = { v_u_6.Character }
	local v111 = v108:ScreenPointToRay(v109.X, v109.Y)
	local v112 = workspace:Raycast(v111.Origin, v111.Direction * 200, v110)
	if not v112 then
		return nil
	end
	for _, v113 in v_u_16 do
		if v112.Instance == v113 then
			return v112.Position
		end
	end
	return nil
end
local function v_u_120()
	-- upvalues: (ref) v_u_12, (ref) v_u_15, (copy) v_u_8, (copy) v_u_114, (copy) v_u_7, (copy) v_u_22, (copy) v_u_102, (copy) v_u_23
	if v_u_12 then
		if v_u_12:GetAttribute("IsCrate") then
			return
		else
			local v115 = tick()
			if v115 - v_u_15 < 0.1 then
				return
			else
				local v_u_116 = v_u_12:GetAttribute("PlantType")
				if v_u_116 then
					if v_u_8.getItemCount(v_u_12) <= 0 then
						v_u_12:Destroy()
						return
					else
						local v_u_117 = v_u_114()
						if v_u_117 then
							v_u_15 = v115
							task.spawn(function()
								-- upvalues: (ref) v_u_7, (copy) v_u_116, (copy) v_u_117, (ref) v_u_22, (ref) v_u_102, (copy) v_u_116, (ref) v_u_23
								local v118, _, _ = v_u_7:InvokeServer(v_u_116, v_u_117)
								if v118 then
									local v119 = Instance.new("Animation")
									v119.AnimationId = "rbxassetid://106933492379436"
									v_u_22(v119)
									v_u_102(v_u_117, 1, v_u_116, v_u_23)
								end
							end)
						end
					end
				else
					return
				end
			end
		end
	else
		return
	end
end
local v_u_121 = nil
local v_u_122 = nil
local function v_u_125(p_u_123)
	-- upvalues: (ref) v_u_121, (ref) v_u_122, (ref) v_u_12, (ref) v_u_16, (copy) v_u_107, (ref) v_u_13, (copy) v_u_120, (copy) v_u_6
	if p_u_123:GetAttribute("IsCrate") or p_u_123:GetAttribute("IsHarvested") then
		return
	else
		if v_u_121 then
			v_u_121:Disconnect()
			v_u_121 = nil
		end
		if v_u_122 then
			v_u_122:Disconnect()
			v_u_122 = nil
		end
		if p_u_123:GetAttribute("PlantType") then
			v_u_12 = p_u_123
			v_u_16 = v_u_107()
			if v_u_13 then
				v_u_13:Disconnect()
			end
			v_u_13 = p_u_123.Activated:Connect(v_u_120)
		else
			v_u_121 = p_u_123:GetAttributeChangedSignal("PlantType"):Connect(function()
				-- upvalues: (ref) v_u_121, (ref) v_u_122, (copy) p_u_123, (ref) v_u_6, (ref) v_u_12, (ref) v_u_16, (ref) v_u_107, (ref) v_u_13, (ref) v_u_120
				if v_u_121 then
					v_u_121:Disconnect()
					v_u_121 = nil
				end
				if v_u_122 then
					v_u_122:Disconnect()
					v_u_122 = nil
				end
				if p_u_123.Parent == v_u_6.Character and p_u_123:GetAttribute("PlantType") then
					local v124 = p_u_123
					v_u_12 = v124
					v_u_16 = v_u_107()
					if v_u_13 then
						v_u_13:Disconnect()
					end
					v_u_13 = v124.Activated:Connect(v_u_120)
				end
			end)
			v_u_122 = p_u_123.AncestryChanged:Once(function()
				-- upvalues: (copy) p_u_123, (ref) v_u_6, (ref) v_u_121, (ref) v_u_122
				if p_u_123.Parent ~= v_u_6.Character then
					if v_u_121 then
						v_u_121:Disconnect()
						v_u_121 = nil
					end
					if v_u_122 then
						v_u_122:Disconnect()
						v_u_122 = nil
					end
				end
			end)
		end
	end
end
local function v130(p126)
	-- upvalues: (ref) v_u_13, (ref) v_u_12, (ref) v_u_121, (ref) v_u_122, (copy) v_u_125, (ref) v_u_16
	if v_u_13 then
		v_u_13:Disconnect()
		v_u_13 = nil
	end
	v_u_12 = nil
	if v_u_121 then
		v_u_121:Disconnect()
		v_u_121 = nil
	end
	if v_u_122 then
		v_u_122:Disconnect()
		v_u_122 = nil
	end
	p126.ChildAdded:Connect(function(p127)
		-- upvalues: (ref) v_u_125
		if p127:IsA("Tool") then
			v_u_125(p127)
		end
	end)
	p126.ChildRemoved:Connect(function(p128)
		-- upvalues: (ref) v_u_12, (ref) v_u_13, (ref) v_u_16, (ref) v_u_121, (ref) v_u_122
		if p128:IsA("Tool") then
			if p128 == v_u_12 then
				if v_u_13 then
					v_u_13:Disconnect()
				end
				v_u_12 = nil
				v_u_16 = {}
			end
			if v_u_121 then
				v_u_121:Disconnect()
				v_u_121 = nil
			end
			if v_u_122 then
				v_u_122:Disconnect()
				v_u_122 = nil
			end
		end
	end)
	for _, v129 in ipairs(p126:GetChildren()) do
		if v129:IsA("Tool") then
			v_u_125(v129)
		end
	end
end
if v_u_6.Character then
	v130(v_u_6.Character)
end
v_u_6.CharacterAdded:Connect(v130)