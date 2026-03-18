local v_u_1 = game:GetService("Players")
local v2 = game:GetService("UserInputService")
local v_u_3 = game:GetService("SoundService")
local v4 = game:GetService("CollectionService")
local v5 = game:GetService("ReplicatedStorage")
local v_u_6 = v_u_1.LocalPlayer
local v_u_7 = false
local v_u_8 = false
local v_u_9 = false
local v_u_10 = {}
local v_u_11 = v5:WaitForChild("RemoteEvents"):WaitForChild("GoingUp")
v_u_6.CharacterAdded:Connect(function()
	-- upvalues: (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (copy) v_u_10, (copy) v_u_6
	v_u_7 = false
	v_u_8 = false
	v_u_9 = false
	table.clear(v_u_10)
	local v12 = v_u_6:FindFirstChild("PlayerGui")
	if v12 then
		local v13 = v12:FindFirstChild("Hud_UI")
		local v14 = v13 and v13:FindFirstChild("TopButtons")
		if v14 then
			v14.Visible = true
		end
		local v15 = v12:FindFirstChild("BackpackGui")
		if v15 then
			v15.Enabled = true
		end
	end
end)
local function v_u_31(p16)
	-- upvalues: (ref) v_u_8, (copy) v_u_6, (copy) v_u_10
	local v17 = p16:FindFirstChildOfClass("Humanoid")
	if v17 and p16:FindFirstChild("HumanoidRootPart") then
		v17.PlatformStand = true
		v17:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
		v17:SetAttribute("IsRagdolled", true)
		v_u_8 = true
		local v18 = v_u_6:FindFirstChild("PlayerGui")
		if v18 then
			local v19 = v18:FindFirstChild("Hud_UI")
			local v20 = v19 and v19:FindFirstChild("TopButtons")
			if v20 then
				v20.Visible = false
			end
			local v21 = v18:FindFirstChild("BackpackGui")
			if v21 then
				v21.Enabled = false
			end
		end
		for _, v22 in p16:GetDescendants() do
			if v22:IsA("Motor6D") and v22.Name ~= "RootJoint" then
				v22.Enabled = false
				local v23 = Instance.new("Attachment")
				v23.CFrame = v22.C0
				v23.Name = "RagdollAttachment"
				v23.Parent = v22.Part0
				local v24 = Instance.new("Attachment")
				v24.CFrame = v22.C1
				v24.Name = "RagdollAttachment"
				v24.Parent = v22.Part1
				local v25 = v22.Name == "Neck"
				local v26 = Instance.new("BallSocketConstraint")
				v26.Attachment0 = v23
				v26.Attachment1 = v24
				v26.Name = "RagdollConstraint"
				v26.LimitsEnabled = true
				v26.TwistLimitsEnabled = true
				v26.MaxFrictionTorque = 50
				v26.Restitution = 0
				v26.UpperAngle = v25 and 30 or 60
				v26.TwistLowerAngle = v25 and -40 or -30
				v26.TwistUpperAngle = v25 and 40 or 30
				v26.Parent = v22.Parent
				local v27 = v22.Part1
				local v28 = Instance.new("Part")
				v28.Name = "RagdollCollider"
				v28.Size = v27.Size / 1.7
				v28.Massless = true
				v28.CFrame = v27.CFrame
				v28.Transparency = 1
				local v29 = Instance.new("WeldConstraint")
				v29.Part0 = v28
				v29.Part1 = v27
				v29.Parent = v28
				v28.Parent = v27
				local v30 = v_u_10
				table.insert(v30, {
					["motor"] = v22,
					["att0"] = v23,
					["att1"] = v24,
					["socket"] = v26,
					["collider"] = v28
				})
			end
		end
	end
end
local function v_u_39(p32)
	-- upvalues: (copy) v_u_10, (ref) v_u_8, (copy) v_u_6
	local v33 = p32:FindFirstChildOfClass("Humanoid")
	if v33 then
		for _, v34 in v_u_10 do
			if v34.motor then
				v34.motor.Enabled = true
			end
			if v34.att0 then
				v34.att0:Destroy()
			end
			if v34.att1 then
				v34.att1:Destroy()
			end
			if v34.socket then
				v34.socket:Destroy()
			end
			if v34.collider then
				v34.collider:Destroy()
			end
		end
		table.clear(v_u_10)
		v33:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
		v33.PlatformStand = false
		v33:SetAttribute("IsRagdolled", false)
		v_u_8 = false
		local v35 = v_u_6:FindFirstChild("PlayerGui")
		if v35 then
			local v36 = v35:FindFirstChild("Hud_UI")
			local v37 = v36 and v36:FindFirstChild("TopButtons")
			if v37 then
				v37.Visible = true
			end
			local v38 = v35:FindFirstChild("BackpackGui")
			if v38 then
				v38.Enabled = true
			end
		end
	else
		return
	end
end
local function v41()
	-- upvalues: (ref) v_u_8, (copy) v_u_6, (copy) v_u_39, (ref) v_u_9, (copy) v_u_31
	if v_u_8 then
		local v40 = v_u_6.Character
		if v40 then
			v_u_39(v40)
			if v_u_9 then
				v_u_31(v40)
			end
		end
	else
		return
	end
end
v2.InputBegan:Connect(function(p42, _)
	-- upvalues: (ref) v_u_8, (copy) v_u_6, (copy) v_u_39, (ref) v_u_9, (copy) v_u_31
	if p42.KeyCode == Enum.KeyCode.Space or p42.KeyCode == Enum.KeyCode.ButtonA then
		if v_u_8 then
			local v43 = v_u_6.Character
			if v43 then
				v_u_39(v43)
				if v_u_9 then
					v_u_31(v43)
				end
			end
		else
			return
		end
	else
		return
	end
end)
v2.JumpRequest:Connect(v41)
local function v60(p_u_44)
	-- upvalues: (copy) v_u_1, (copy) v_u_6, (ref) v_u_7, (ref) v_u_8, (copy) v_u_31, (copy) v_u_11, (ref) v_u_9, (copy) v_u_3
	p_u_44.Touched:Connect(function(p45)
		-- upvalues: (ref) v_u_1, (ref) v_u_6, (ref) v_u_7, (ref) v_u_8, (copy) p_u_44, (ref) v_u_31, (ref) v_u_11, (ref) v_u_9, (ref) v_u_3
		if p45:IsA("BasePart") then
			if p45.Parent:FindFirstChildOfClass("Humanoid") then
				if v_u_1:GetPlayerFromCharacter(p45.Parent) == v_u_6 then
					local v46 = v_u_6.Character
					local v47 = v46:FindFirstChild("HumanoidRootPart")
					if v47 then
						if not (v_u_7 or v_u_8) then
							v_u_7 = true
							local v48 = p_u_44.Position
							local v49 = (v47.Position - v48) * Vector3.new(1, 0, 1)
							local v50 = v49.Magnitude
							local v51 = p_u_44.Size.X
							local v52 = p_u_44.Size.Z
							local v53 = v50 / (math.max(v51, v52) / 2)
							local v54 = math.clamp(v53, 0, 1) * 45
							local v55 = math.rad(v54)
							local v56 = v50 <= 0.01 and Vector3.new(1, 0, 0) or v49.Unit
							local v57 = math.cos(v55) * 2750
							local v58 = v56 * (math.sin(v55) * 2750) + Vector3.new(0, v57, 0)
							v_u_31(v46)
							v_u_11:FireServer()
							v_u_9 = true
							task.delay(1, function()
								-- upvalues: (ref) v_u_9
								v_u_9 = false
							end)
							v47:ApplyImpulse(v58)
							local v59 = v_u_3:FindFirstChild("SFX")
							if v59 then
								v59 = v59:FindFirstChild("Player")
							end
							if v59 then
								v59 = v59:FindFirstChild("WaterSplash")
							end
							if v59 then
								v59.TimePosition = 1
								v59:Play()
							end
							task.wait(1)
							v_u_7 = false
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	end)
end
local v_u_61 = v_u_9
local v_u_62 = v_u_8
local v_u_63 = v_u_7
for _, v_u_64 in v4:GetTagged("FountainRagdoll") do
	v_u_64.Touched:Connect(function(p65)
		-- upvalues: (copy) v_u_1, (copy) v_u_6, (ref) v_u_63, (ref) v_u_62, (copy) v_u_64, (copy) v_u_31, (copy) v_u_11, (ref) v_u_61, (copy) v_u_3
		if p65:IsA("BasePart") then
			if p65.Parent:FindFirstChildOfClass("Humanoid") then
				if v_u_1:GetPlayerFromCharacter(p65.Parent) == v_u_6 then
					local v66 = v_u_6.Character
					local v67 = v66:FindFirstChild("HumanoidRootPart")
					if v67 then
						if not (v_u_63 or v_u_62) then
							v_u_63 = true
							local v68 = v_u_64.Position
							local v69 = (v67.Position - v68) * Vector3.new(1, 0, 1)
							local v70 = v69.Magnitude
							local v71 = v_u_64.Size.X
							local v72 = v_u_64.Size.Z
							local v73 = v70 / (math.max(v71, v72) / 2)
							local v74 = math.clamp(v73, 0, 1) * 45
							local v75 = math.rad(v74)
							local v76 = v70 <= 0.01 and Vector3.new(1, 0, 0) or v69.Unit
							local v77 = math.cos(v75) * 2750
							local v78 = v76 * (math.sin(v75) * 2750) + Vector3.new(0, v77, 0)
							v_u_31(v66)
							v_u_11:FireServer()
							v_u_61 = true
							task.delay(1, function()
								-- upvalues: (ref) v_u_61
								v_u_61 = false
							end)
							v67:ApplyImpulse(v78)
							local v79 = v_u_3:FindFirstChild("SFX")
							if v79 then
								v79 = v79:FindFirstChild("Player")
							end
							if v79 then
								v79 = v79:FindFirstChild("WaterSplash")
							end
							if v79 then
								v79.TimePosition = 1
								v79:Play()
							end
							task.wait(1)
							v_u_63 = false
						end
					else
						return
					end
				else
					return
				end
			else
				return
			end
		else
			return
		end
	end)
end
v4:GetInstanceAddedSignal("FountainRagdoll"):Connect(v60)