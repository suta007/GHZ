local v1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Players")
local v_u_5 = game:GetService("RunService")
local v_u_6 = game:GetService("SoundService")
local v_u_7 = nil
local v_u_8 = nil
local v_u_9 = nil
local v_u_10 = false
local v_u_11 = nil
local v_u_12 = nil
local v_u_13 = nil
local v_u_14 = nil
local function v_u_15()
	-- upvalues: (ref) v_u_9, (copy) v_u_3
	if v_u_9 then
		v_u_3:Create(v_u_9, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			["BackgroundTransparency"] = 0
		}):Play()
		task.wait(1)
		v_u_3:Create(v_u_9, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["BackgroundTransparency"] = 1
		}):Play()
	end
end
local function v_u_24(p16, p17)
	-- upvalues: (copy) v_u_4
	if typeof(p16) == "Vector3" then
		if typeof(p17) == "number" then
			local v18 = v_u_4.LocalPlayer.Character
			if v18 then
				local v19 = v18:FindFirstChild("HumanoidRootPart")
				if v19 then
					if p17 >= (v19.Position - p16).Magnitude then
						local v20 = v19.Position - p16
						local v21 = (v20.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or v20.Unit) * 80 + Vector3.new(0, 40, 0)
						local v_u_22 = Instance.new("Attachment")
						v_u_22.Parent = v19
						local v_u_23 = Instance.new("LinearVelocity")
						v_u_23.MaxForce = (1 / 0)
						v_u_23.VectorVelocity = v21
						v_u_23.Attachment0 = v_u_22
						v_u_23.RelativeTo = Enum.ActuatorRelativeTo.World
						v_u_23.Parent = v19
						task.delay(0.3, function()
							-- upvalues: (copy) v_u_23, (copy) v_u_22
							pcall(function()
								-- upvalues: (ref) v_u_23, (ref) v_u_22
								v_u_23:Destroy()
								v_u_22:Destroy()
							end)
						end)
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
end
local function v_u_33(p25, p26)
	-- upvalues: (copy) v_u_4
	if typeof(p25) == "Vector3" then
		if typeof(p26) == "number" then
			local v27 = v_u_4.LocalPlayer.Character
			if v27 then
				local v28 = v27:FindFirstChild("HumanoidRootPart")
				if v28 then
					if p26 >= (v28.Position - p25).Magnitude then
						local v29 = v28.Position - p25
						local v30 = (v29.Magnitude <= 0.01 and Vector3.new(1, 0, 0) or v29.Unit) * 50 + Vector3.new(0, 80, 0)
						local v_u_31 = Instance.new("Attachment")
						v_u_31.Parent = v28
						local v_u_32 = Instance.new("LinearVelocity")
						v_u_32.MaxForce = (1 / 0)
						v_u_32.VectorVelocity = v30
						v_u_32.Attachment0 = v_u_31
						v_u_32.RelativeTo = Enum.ActuatorRelativeTo.World
						v_u_32.Parent = v28
						task.delay(0.5, function()
							-- upvalues: (copy) v_u_32, (copy) v_u_31
							pcall(function()
								-- upvalues: (ref) v_u_32, (ref) v_u_31
								v_u_32:Destroy()
								v_u_31:Destroy()
							end)
						end)
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
end
local function v_u_40()
	-- upvalues: (ref) v_u_11, (copy) v_u_4, (ref) v_u_12, (ref) v_u_13, (copy) v_u_5
	if v_u_11 and v_u_11.Enabled then
		return
	else
		local v34 = v_u_4.LocalPlayer:FindFirstChild("PlayerGui")
		if v34 then
			local v35 = v34:WaitForChild("BossHealthBar", 10)
			if v35 then
				v_u_11 = v35
				v_u_12 = v35.Container.BarBackground.BarFill
				v_u_12.Size = UDim2.new(1, 0, 1, 0)
				v35.Enabled = true
				v_u_13 = v_u_5.Heartbeat:Connect(function()
					-- upvalues: (ref) v_u_13, (ref) v_u_11, (ref) v_u_12
					if workspace:GetAttribute("BossActive") then
						if v_u_12 then
							local v36 = workspace:GetAttribute("BossFightStart")
							local v37 = workspace:GetAttribute("BossDuration")
							if v36 and (v37 and v37 > 0) then
								local v38 = 1 - (workspace:GetServerTimeNow() - v36) / v37
								local v39 = math.clamp(v38, 0, 1)
								v_u_12.Size = UDim2.new(v39, 0, 1, 0)
							end
						else
							return
						end
					else
						if v_u_13 then
							v_u_13:Disconnect()
							v_u_13 = nil
						end
						if v_u_11 then
							v_u_11.Enabled = false
							v_u_11 = nil
							v_u_12 = nil
						end
						return
					end
				end)
			end
		else
			return
		end
	end
end
function v1.Start(_)
	-- upvalues: (ref) v_u_10, (copy) v_u_4, (ref) v_u_8, (ref) v_u_9, (ref) v_u_14, (copy) v_u_40, (copy) v_u_2, (ref) v_u_7, (copy) v_u_15, (copy) v_u_24, (copy) v_u_33, (copy) v_u_6
	v_u_10 = true
	local v41 = Instance.new("ScreenGui")
	v41.Name = "BossFlash"
	v41.IgnoreGuiInset = true
	v41.DisplayOrder = 100
	v41.ResetOnSpawn = false
	local v42 = Instance.new("Frame")
	v42.Size = UDim2.new(1, 0, 1, 0)
	v42.BackgroundColor3 = Color3.new(1, 1, 1)
	v42.BackgroundTransparency = 1
	v42.BorderSizePixel = 0
	v42.ZIndex = 999
	v42.Parent = v41
	v41.Parent = v_u_4.LocalPlayer.PlayerGui
	v_u_8 = v41
	v_u_9 = v42
	v_u_14 = workspace:GetAttributeChangedSignal("BossActive"):Connect(function()
		-- upvalues: (ref) v_u_40
		if workspace:GetAttribute("BossActive") then
			v_u_40()
		end
	end)
	if workspace:GetAttribute("BossActive") then
		v_u_40()
	end
	v_u_7 = v_u_2:WaitForChild("RemoteEvents"):WaitForChild("WeatherEvent").OnClientEvent:Connect(function(p43, p44)
		-- upvalues: (ref) v_u_10, (ref) v_u_15, (ref) v_u_24, (ref) v_u_33, (ref) v_u_6
		if p43 == "BossEvent" then
			if v_u_10 then
				if p44 and p44.Type then
					if p44.Type == "FlashWhite" then
						task.spawn(v_u_15)
						return
					elseif p44.Type == "Knockback" then
						task.spawn(v_u_24, p44.Origin, p44.Radius)
						return
					elseif p44.Type == "Launch" then
						task.spawn(v_u_33, p44.Origin, p44.Radius)
						return
					elseif p44.Type == "Roar" then
						task.spawn(function()
							-- upvalues: (ref) v_u_6
							local v45 = v_u_6:FindFirstChild("SFX") and v_u_6.SFX:FindFirstChild("Weather")
							if v45 then
								v45 = v_u_6.SFX.Weather:FindFirstChild("Special")
							end
							if v45 then
								local v46 = v45:FindFirstChild("BigRoar")
								if v46 then
									v46:Play()
								end
							end
						end)
					elseif p44.Type == "BeamSFX" then
						task.spawn(function()
							-- upvalues: (ref) v_u_6
							local v47 = v_u_6:FindFirstChild("SFX") and v_u_6.SFX:FindFirstChild("Weather")
							if v47 then
								v47 = v_u_6.SFX.Weather:FindFirstChild("Special")
							end
							if v47 then
								local v48 = v47:FindFirstChild("CthulhuBeam")
								if v48 then
									v48:Play()
								end
							end
						end)
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
function v1.Stop(_)
	-- upvalues: (ref) v_u_10, (ref) v_u_7, (ref) v_u_8, (ref) v_u_9, (ref) v_u_13, (ref) v_u_11, (ref) v_u_12, (copy) v_u_4, (ref) v_u_14
	v_u_10 = false
	if v_u_7 then
		v_u_7:Disconnect()
		v_u_7 = nil
	end
	if v_u_8 then
		v_u_8:Destroy()
		v_u_8 = nil
		v_u_9 = nil
	end
	if v_u_13 then
		v_u_13:Disconnect()
		v_u_13 = nil
	end
	if v_u_11 then
		v_u_11.Enabled = false
		v_u_11 = nil
		v_u_12 = nil
	end
	local v49 = v_u_4.LocalPlayer:FindFirstChild("PlayerGui")
	local v50 = v49 and v49:FindFirstChild("BossHealthBar")
	if v50 then
		v50.Enabled = false
	end
	if v_u_14 then
		v_u_14:Disconnect()
		v_u_14 = nil
	end
end
return v1