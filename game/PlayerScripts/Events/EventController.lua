local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("Lighting")
local v_u_4 = game:GetService("TweenService")
local v_u_5 = game:GetService("RunService")
local v_u_6 = Random.new()
local v_u_7 = {}
local v_u_17 = {
	["ScreenDistortion"] = function(p8)
		-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_7
		if p8 then
			local v9 = Instance.new("BlurEffect")
			v9.Name = "EventScreenDistortion"
			v9.Size = 0
			v9.Parent = v_u_3
			v_u_4:Create(v9, TweenInfo.new(0.3), {
				["Size"] = 12
			}):Play()
			v_u_7.ScreenDistortion = v9
		else
			local v_u_10 = v_u_7.ScreenDistortion
			if v_u_10 then
				v_u_4:Create(v_u_10, TweenInfo.new(0.3), {
					["Size"] = 0
				}):Play()
				task.delay(0.3, function()
					-- upvalues: (copy) v_u_10
					if v_u_10.Parent then
						v_u_10:Destroy()
					end
				end)
				v_u_7.ScreenDistortion = nil
			end
		end
	end,
	["ScreenWhite"] = function(p11)
		-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_7
		if p11 then
			local v12 = Instance.new("ColorCorrectionEffect")
			v12.Name = "EventScreenWhite"
			v12.Brightness = 0
			v12.TintColor = Color3.new(1, 1, 1)
			v12.Parent = v_u_3
			v_u_4:Create(v12, TweenInfo.new(0.3), {
				["Brightness"] = 1
			}):Play()
			v_u_7.ScreenWhite = v12
		else
			local v_u_13 = v_u_7.ScreenWhite
			if v_u_13 then
				v_u_4:Create(v_u_13, TweenInfo.new(0.5), {
					["Brightness"] = 0
				}):Play()
				task.delay(0.5, function()
					-- upvalues: (copy) v_u_13
					if v_u_13.Parent then
						v_u_13:Destroy()
					end
				end)
				v_u_7.ScreenWhite = nil
			end
		end
	end,
	["AdminError"] = function(p14)
		-- upvalues: (copy) v_u_3, (copy) v_u_7, (copy) v_u_5, (copy) v_u_6
		if p14 then
			local v_u_15 = Instance.new("ColorCorrectionEffect")
			v_u_15.Name = "EventAdminError"
			v_u_15.Saturation = -0.8
			v_u_15.Contrast = 0.5
			v_u_15.Parent = v_u_3
			v_u_7.AdminError = v_u_15
			v_u_7.AdminErrorConnection = v_u_5.RenderStepped:Connect(function()
				-- upvalues: (copy) v_u_15, (ref) v_u_6
				if v_u_15.Parent then
					v_u_15.Brightness = v_u_6:NextNumber() * 0.3 - 0.15
				end
			end)
		else
			if v_u_7.AdminErrorConnection then
				v_u_7.AdminErrorConnection:Disconnect()
				v_u_7.AdminErrorConnection = nil
			end
			local v16 = v_u_7.AdminError
			if v16 then
				v16:Destroy()
				v_u_7.AdminError = nil
			end
		end
	end
}
local v_u_35 = {
	["Slam"] = function()
		-- upvalues: (copy) v_u_5, (copy) v_u_6
		local v_u_18 = workspace.CurrentCamera
		if v_u_18 then
			local v_u_19 = 0
			local v_u_20 = nil
			v_u_20 = v_u_5.RenderStepped:Connect(function(p21)
				-- upvalues: (ref) v_u_19, (ref) v_u_20, (ref) v_u_6, (copy) v_u_18
				v_u_19 = v_u_19 + p21
				if v_u_19 >= 0.5 then
					v_u_20:Disconnect()
				else
					local v22 = 1 - v_u_19 / 0.5
					local v23 = (v_u_6:NextNumber() - 0.5) * 2 * 2 * v22
					local v24 = (v_u_6:NextNumber() - 0.5) * 2 * 2 * v22
					v_u_18.CFrame = v_u_18.CFrame * CFrame.new(v23, v24, 0)
				end
			end)
		end
	end,
	["Ban"] = function()
		-- upvalues: (copy) v_u_1, (copy) v_u_4, (copy) v_u_3, (copy) v_u_7
		local v25 = v_u_1.LocalPlayer:FindFirstChild("PlayerGui")
		if v25 then
			local v26 = v25:FindFirstChild("TVSBanMessage")
			if v26 then
				v26.Enabled = true
				local v27 = v26:FindFirstChild("BanUI")
				if v27 then
					local v28 = v27:FindFirstChild("UIScale")
					if v28 then
						v28.Scale = 0
					end
					v27.Visible = true
					if v28 then
						v_u_4:Create(v28, TweenInfo.new(1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
							["Scale"] = 5
						}):Play()
					end
				end
				local v29 = Instance.new("BlurEffect")
				v29.Name = "BanBlur"
				v29.Size = 0
				v29.Parent = v_u_3
				v_u_4:Create(v29, TweenInfo.new(0.3), {
					["Size"] = 24
				}):Play()
				local v30 = v_u_1.LocalPlayer.Character
				if v30 then
					v30 = v30:FindFirstChild("HumanoidRootPart")
				end
				if v30 then
					v30.Anchored = true
				end
				v_u_7.BanScreen = v26
				v_u_7.BanBlur = v29
				v_u_7.BanHRP = v30
			end
		else
			return
		end
	end,
	["BanEnd"] = function()
		-- upvalues: (copy) v_u_7, (copy) v_u_4
		local v_u_31 = v_u_7.BanScreen
		if v_u_31 then
			local v32 = v_u_31:FindFirstChild("Slash")
			if v32 then
				v32.Position = UDim2.new(1.3, 0, -0.1, 0)
				v32.Visible = true
				v_u_4:Create(v32, TweenInfo.new(0.12, Enum.EasingStyle.Linear), {
					["Position"] = UDim2.new(0.5, 0, 0.5, 0)
				}):Play()
			end
			local v_u_33 = v_u_7.BanBlur
			if v_u_33 then
				v_u_4:Create(v_u_33, TweenInfo.new(0.5), {
					["Size"] = 0
				}):Play()
			end
			local v34 = v_u_7.BanHRP
			if v34 and v34.Parent then
				v34.Anchored = false
			end
			task.delay(1.5, function()
				-- upvalues: (copy) v_u_33, (copy) v_u_31, (ref) v_u_7
				if v_u_33 and v_u_33.Parent then
					v_u_33:Destroy()
				end
				if v_u_31 and v_u_31.Parent then
					v_u_31:Destroy()
				end
				v_u_7.BanScreen = nil
				v_u_7.BanBlur = nil
				v_u_7.BanHRP = nil
			end)
		end
	end
}
v2:WaitForChild("RemoteEvents"):WaitForChild("EventEffect").OnClientEvent:Connect(function(p36)
	-- upvalues: (copy) v_u_17, (copy) v_u_35, (copy) v_u_7
	if p36 and typeof(p36) == "table" then
		if p36.Type == "VFX" then
			local v37 = v_u_17[p36.Name]
			if v37 then
				v37(p36.Enabled)
				return
			end
		elseif p36.Type == "PlayerEffect" then
			local v38 = v_u_35[p36.Effect]
			if v38 then
				v38()
				return
			end
		elseif p36.Type == "Cleanup" then
			for v39, v40 in pairs(v_u_17) do
				if v_u_7[v39] then
					v40(false)
				end
			end
		end
	end
end)