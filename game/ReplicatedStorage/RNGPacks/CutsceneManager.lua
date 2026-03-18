local v1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("ContentProvider")
local v_u_5 = game:GetService("TweenService")
local v_u_6 = game:GetService("Players")
local v_u_7 = game:GetService("SoundService")
local v_u_8 = game:GetService("Debris")
local v_u_9 = workspace.CurrentCamera
local v_u_10 = {
	"FriendBoost",
	"Hud_UI",
	"Notification",
	"QA",
	"ShillingsCurrency",
	"WeatherDisplay",
	"BackpackGui",
	"ChangelogVersion"
}
local v_u_11 = Instance.new("Animation")
v_u_11.AnimationId = "rbxassetid://78500849377174"
local v_u_12 = Instance.new("Animation")
v_u_12.AnimationId = "rbxassetid://117587421557642"
local function v_u_17(p13)
	-- upvalues: (copy) v_u_6, (copy) v_u_10
	local v14 = v_u_6.LocalPlayer:FindFirstChild("PlayerGui")
	if v14 then
		for _, v15 in ipairs(v_u_10) do
			local v16 = v14:FindFirstChild(v15)
			if v16 then
				v16.Enabled = p13
			end
		end
	end
end
local function v_u_22(p18, p19, p20, p21)
	-- upvalues: (copy) v_u_5, (copy) v_u_9
	v_u_5:Create(v_u_9, TweenInfo.new(p19, p20 or Enum.EasingStyle.Quad, p21 or Enum.EasingDirection.Out), {
		["FieldOfView"] = p18
	}):Play()
end
local function v_u_27(p23, p24)
	if p23 then
		local v25 = p24 and 0 or 1
		for _, v26 in ipairs(p23:GetDescendants()) do
			if v26:IsA("BasePart") then
				v26.Transparency = v25
			elseif v26:IsA("Decal") or v26:IsA("Texture") then
				v26.Transparency = v25
			end
		end
	end
end
local function v_u_30(p28)
	if p28 then
		for _, v29 in ipairs(p28:GetDescendants()) do
			if v29:IsA("ParticleEmitter") then
				v29:Emit((v29:GetAttribute("EmitCount")))
			end
		end
	end
end
local function v_u_34(p31, p32)
	if p31 then
		for _, v33 in ipairs(p31:GetDescendants()) do
			if v33:IsA("ParticleEmitter") then
				v33.Enabled = p32
			end
		end
	end
end
function v1.Play(p_u_35, _, _)
	-- upvalues: (copy) v_u_17, (copy) v_u_7, (copy) v_u_2, (copy) v_u_11, (copy) v_u_12, (copy) v_u_4, (copy) v_u_3, (copy) v_u_27, (copy) v_u_9, (copy) v_u_8, (copy) v_u_22, (copy) v_u_34, (copy) v_u_30
	v_u_17(false)
	local v36 = v_u_7:FindFirstChild("Music")
	if v36 then
		v36 = v_u_7.Music:FindFirstChild("BackgroundMusic")
	end
	local v37 = v_u_2:WaitForChild("CutsceneRareSeed", 5)
	if v37 then
		local v38 = v37:Clone()
		v38.Parent = workspace
		local v39 = v38:FindFirstChild("seven\'s cam vfx rig", true)
		local v_u_40 = v_u_2:WaitForChild("Plants"):WaitForChild("Tools"):WaitForChild("Seeds")
		if v38 and v39 then
			local v_u_41 = v38:FindFirstChild("SeedNPCcutscene", true)
			local v_u_42 = v38:FindFirstChild("SlamDown", true)
			local v_u_43 = v39:FindFirstChild("Torso")
			local v_u_44
			if v_u_41 then
				v_u_44 = v_u_41:FindFirstChild("Left Arm")
			else
				v_u_44 = v_u_41
			end
			local v_u_45
			if v_u_41 then
				v_u_45 = v_u_41:FindFirstChild("HumanoidRootPart")
			else
				v_u_45 = v_u_41
			end
			local v_u_46
			if v_u_41 then
				v_u_46 = v_u_41:FindFirstChild("Model")
			else
				v_u_46 = v_u_41
			end
			local v_u_47
			if v_u_44 then
				v_u_47 = v_u_44:FindFirstChild("Attachment")
			else
				v_u_47 = v_u_44
			end
			local v_u_48
			if v_u_44 then
				v_u_48 = v_u_44:FindFirstChild("LeftGripAttachment")
			else
				v_u_48 = v_u_44
			end
			local v49 = v_u_41:FindFirstChildWhichIsA("Animator", true)
			local v50 = v39:FindFirstChildWhichIsA("Animator", true)
			if v49 and v50 then
				local v51 = v49:LoadAnimation(v_u_11)
				local v52 = v50:LoadAnimation(v_u_12)
				v51.Looped = false
				v52.Looped = false
				pcall(function()
					-- upvalues: (ref) v_u_4, (ref) v_u_11, (ref) v_u_12
					v_u_4:PreloadAsync({ v_u_11, v_u_12 })
				end)
				v51:Play()
				v52:Play()
				v51:AdjustSpeed(0)
				v52:AdjustSpeed(0)
				v_u_3.Heartbeat:Wait()
				v_u_3.Heartbeat:Wait()
				v_u_27(v_u_46, false)
				local v53 = v_u_9.CameraType
				local v54 = v_u_9.CFrame
				local v55 = v_u_9.FieldOfView
				v_u_9.FieldOfView = 75
				v_u_9.CFrame = v_u_43.CFrame
				v_u_9.CameraType = Enum.CameraType.Scriptable
				if v36 then
					v36.Volume = 0
				end
				local v56 = Instance.new("Sound")
				v56.SoundId = "rbxassetid://80989828342918"
				v56.Parent = workspace
				v56:Play()
				v_u_8:AddItem(v56, 30)
				local v57 = v_u_3.RenderStepped:Connect(function()
					-- upvalues: (copy) v_u_43, (ref) v_u_9
					if v_u_43 then
						v_u_9.CFrame = v_u_43.CFrame
					end
				end)
				v51:AdjustSpeed(1)
				v52:AdjustSpeed(1)
				local v58 = v52.Length > 0 and (v52.Length or 4.5) or 4.5
				task.delay(1, function()
					-- upvalues: (ref) v_u_22
					v_u_22(68, 0.6)
				end)
				task.delay(2.2, function()
					-- upvalues: (ref) v_u_22
					v_u_22(55, 0.5)
				end)
				task.delay(v58 - 0.2, function()
					-- upvalues: (ref) v_u_22
					v_u_22(60, 0.1)
					task.delay(0.1, function()
						-- upvalues: (ref) v_u_22
						v_u_22(42, 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
					end)
				end)
				task.spawn(function()
					-- upvalues: (copy) v_u_45, (ref) v_u_34
					if v_u_45 then
						v_u_34(v_u_45, true)
						task.wait(1)
						v_u_34(v_u_45, false)
					end
				end)
				task.delay(0.4, function()
					-- upvalues: (ref) v_u_27, (copy) v_u_46
					v_u_27(v_u_46, true)
				end)
				task.delay(2.6, function()
					-- upvalues: (copy) v_u_42, (ref) v_u_30
					if v_u_42 then
						v_u_30((v_u_42:FindFirstChild("Wind")))
					end
				end)
				local v_u_59 = nil
				task.delay(v58 - 0.2, function()
					-- upvalues: (ref) v_u_30, (copy) v_u_47, (copy) p_u_35, (copy) v_u_40, (copy) v_u_44, (copy) v_u_48, (ref) v_u_59, (copy) v_u_41
					v_u_30(v_u_47)
					local v60 = v_u_40:FindFirstChild(p_u_35.RewardId .. " Seed")
					if v60 and (v_u_44 and v_u_48) then
						v_u_59 = v60:Clone()
						local v61 = v_u_59:FindFirstChild("Handle") or v_u_59:FindFirstChildWhichIsA("BasePart")
						if v61 then
							v_u_59.Parent = v_u_41
							v61.CFrame = v_u_48.WorldCFrame * CFrame.Angles(3.141592653589793, -1.5707963267948966, 0)
							local v62 = Instance.new("WeldConstraint")
							v62.Part0 = v61
							v62.Part1 = v_u_44
							v62.Parent = v61
						end
					end
				end)
				v52.Stopped:Wait()
				v57:Disconnect()
				v51:Play()
				v51.TimePosition = v51.Length - 0.05
				v51:AdjustSpeed(0)
				v_u_22(36, 3, Enum.EasingStyle.Sine)
				task.wait(1.6)
				v_u_9.CameraType = v53
				v_u_9.CFrame = v54
				v_u_9.FieldOfView = v55
				if v_u_59 then
					v_u_59:Destroy()
				end
				v_u_34(v39, false)
				v_u_27(v_u_46, false)
				v51:Stop()
				v52:Stop()
				v38:Destroy()
				if v36 then
					v36.Volume = 1
				end
				v_u_17(true)
			else
				v38:Destroy()
				v_u_17(true)
			end
		else
			if v38 then
				v38:Destroy()
			end
			v_u_17(true)
			return
		end
	else
		warn("CutsceneRareSeed not found in ReplicatedStorage")
		v_u_17(true)
		return
	end
end
return v1