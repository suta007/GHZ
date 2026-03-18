local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("SoundService")
local v_u_4 = game:GetService("Workspace")
local v_u_5 = v2:WaitForChild("RemoteEvents"):WaitForChild("UseGear")
local v_u_6 = v1.LocalPlayer
local v_u_7 = v_u_6.Character or v_u_6.CharacterAdded:Wait()
local v_u_8 = v_u_6:GetMouse()
local v_u_9 = nil
local v_u_10 = {}
local v_u_11 = {}
local v_u_12 = nil
local v_u_13 = nil
v_u_7 = v_u_6.Character or v_u_6.CharacterAdded:Wait()
v_u_12 = v_u_7:WaitForChild("Right Arm")
v_u_13 = v_u_7:WaitForChild("Humanoid")
local v_u_14 = v3:WaitForChild("SFX"):WaitForChild("Gears"):WaitForChild("WateringCan")
local v_u_15 = {}
local v_u_16 = false
local v_u_17 = nil
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = nil
local v_u_21 = nil
local v_u_22 = nil
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local function v_u_32(p26, p_u_27)
	local v28 = p26:FindFirstChild("Watering Can")
	if v28 then
		local v29 = v28:FindFirstChild("Equip")
		if v29 then
			local v30 = v29:FindFirstChild("Splash")
			if v30 then
				for _, v_u_31 in v30:GetDescendants() do
					if v_u_31:IsA("ParticleEmitter") then
						coroutine.resume(coroutine.create(function()
							-- upvalues: (copy) v_u_31, (copy) p_u_27
							v_u_31.Enabled = true
							task.wait(p_u_27)
							v_u_31.Enabled = false
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
local function v_u_39(p33, p_u_34)
	local v35 = p33:FindFirstChild("Watering Can")
	if v35 then
		local v36 = v35:FindFirstChild("Nozzle")
		if v36 then
			local v37 = v36:FindFirstChild("Splash")
			if v37 then
				for _, v_u_38 in v37:GetDescendants() do
					if v_u_38:IsA("ParticleEmitter") then
						coroutine.resume(coroutine.create(function()
							-- upvalues: (copy) v_u_38, (copy) p_u_34
							v_u_38.Enabled = true
							task.wait(p_u_34)
							v_u_38.Enabled = false
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
local function v_u_51()
	-- upvalues: (ref) v_u_16, (ref) v_u_20, (copy) v_u_8, (copy) v_u_4, (ref) v_u_21, (ref) v_u_24, (ref) v_u_11, (ref) v_u_13, (ref) v_u_10, (copy) v_u_32, (ref) v_u_25, (copy) v_u_39, (copy) v_u_14, (copy) v_u_5, (ref) v_u_17
	if v_u_16 then
		if v_u_20 and not v_u_20() then
			return
		else
			local v40 = v_u_8.Hit
			if v40 then
				local v41 = {}
				for _, v42 in v_u_4:WaitForChild("Plots"):GetChildren() do
					if v42:IsA("Model") and v42:GetAttribute("Owner") then
						local v43 = v42:FindFirstChild("PlantableArea")
						if v43 then
							table.insert(v41, v43)
						end
					end
				end
				if #v41 == 0 then
					return
				else
					local v44 = RaycastParams.new()
					v44.FilterType = Enum.RaycastFilterType.Include
					v44.FilterDescendantsInstances = v41
					local v45 = v_u_4:Raycast(v40.Position + Vector3.new(0, 20, 0), Vector3.new(0, -50, 0), v44)
					if v45 then
						local v46 = v45.Position
						if v_u_21 then
							v_u_21()
						end
						local v47 = v_u_24
						local v48 = v_u_11[v47]
						if not v48 then
							local v49 = v_u_13:FindFirstChildOfClass("Animator")
							if not v49 then
								v49 = Instance.new("Animator")
								v49.Parent = v_u_13
							end
							v48 = v49:LoadAnimation(v47)
							v_u_11[v47] = v48
							local v50 = v_u_10
							table.insert(v50, v48)
						end
						v48:Play()
						v_u_32(v_u_25, 0.4)
						v_u_39(v_u_25, 0.4)
						v_u_14:Play()
						v_u_5:FireServer(v_u_17, {
							["position"] = v46
						})
					end
				end
			else
				return
			end
		end
	else
		return
	end
end
function v_u_15.Activate(p52, p_u_53, p54, p55)
	-- upvalues: (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_20, (ref) v_u_21, (ref) v_u_25, (ref) v_u_19, (ref) v_u_22, (ref) v_u_23, (ref) v_u_24, (copy) v_u_51, (ref) v_u_10, (ref) v_u_12, (ref) v_u_9, (ref) v_u_11, (ref) v_u_13, (copy) v_u_32
	v_u_16 = true
	v_u_17 = p52
	v_u_18 = p_u_53
	v_u_20 = p54
	v_u_21 = p55
	v_u_25 = p_u_53
	if v_u_19 then
		v_u_19:Disconnect()
	end
	v_u_22 = p_u_53:FindFirstChild("Idle")
	v_u_23 = p_u_53:FindFirstChild("Equip")
	v_u_24 = p_u_53:FindFirstChild("Pour")
	local v56 = p_u_53:FindFirstChild("Handle")
	v_u_19 = p_u_53.Activated:Connect(v_u_51)
	v_u_10 = {}
	local v57 = v_u_12:FindFirstChild("RightGrip")
	if v57 then
		v57:Destroy()
	end
	if not v_u_9 then
		v_u_9 = Instance.new("Motor6D")
		v_u_9.Name = "Handle"
		v_u_9.Part0 = v_u_12
		v_u_9.Part1 = v56
		v_u_9.C0 = CFrame.new(0, 0, 0) * CFrame.fromOrientation(0, 0, 0)
		v_u_9.C1 = CFrame.new()
		v_u_9.Parent = v_u_12
	end
	local v58 = v_u_23
	local v59 = v_u_11[v58]
	if not v59 then
		local v60 = v_u_13:FindFirstChildOfClass("Animator")
		if not v60 then
			v60 = Instance.new("Animator")
			v60.Parent = v_u_13
		end
		v59 = v60:LoadAnimation(v58)
		v_u_11[v58] = v59
		local v61 = v_u_10
		table.insert(v61, v59)
	end
	v59:Play()
	task.spawn(function()
		-- upvalues: (ref) v_u_16, (ref) v_u_32, (copy) p_u_53
		task.wait(0.2)
		if v_u_16 then
			v_u_32(p_u_53, 0.2)
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_16, (ref) v_u_11, (ref) v_u_22, (ref) v_u_13, (ref) v_u_10
		task.wait(0.2)
		if v_u_16 then
			local v62 = v_u_11[v_u_22]
			if not v62 then
				local v63 = v_u_13:FindFirstChildOfClass("Animator")
				if not v63 then
					v63 = Instance.new("Animator")
					v63.Parent = v_u_13
				end
				v62 = v63:LoadAnimation(v_u_22)
				v62.Priority = Enum.AnimationPriority.Idle
				v62.Looped = true
				v_u_11[v_u_22] = v62
				local v64 = v_u_10
				table.insert(v64, v62)
			end
			v62:Play()
		end
	end)
end
function v_u_15.Deactivate()
	-- upvalues: (ref) v_u_16, (ref) v_u_17, (ref) v_u_18, (ref) v_u_20, (ref) v_u_21, (ref) v_u_10, (ref) v_u_11, (ref) v_u_9, (ref) v_u_19
	v_u_16 = false
	v_u_17 = nil
	v_u_18 = nil
	v_u_20 = nil
	v_u_21 = nil
	for _, v65 in ipairs(v_u_10) do
		if v65 and v65.IsPlaying then
			v65:Stop()
		end
	end
	for _, v66 in v_u_10 do
		v66:Destroy()
	end
	v_u_10 = {}
	v_u_11 = {}
	if v_u_9 then
		v_u_9:Destroy()
		v_u_9 = nil
	end
	if v_u_19 then
		v_u_19:Disconnect()
		v_u_19 = nil
	end
end
v_u_6.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_15, (ref) v_u_7, (copy) v_u_6, (ref) v_u_12, (ref) v_u_13
	v_u_15.Deactivate()
	v_u_7 = v_u_6.Character or v_u_6.CharacterAdded:Wait()
	v_u_12 = v_u_7:WaitForChild("Right Arm")
	v_u_13 = v_u_7:WaitForChild("Humanoid")
end)
return v_u_15