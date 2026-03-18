local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = v1.LocalPlayer
local v5 = v2:WaitForChild("RemoteEvents")
local v6 = v5:WaitForChild("OfflineGrowthNotify")
local v_u_7 = v5:WaitForChild("OfflineGrowthApply")
local v_u_8 = v5:WaitForChild("OfflineGrowthComplete")
local v9 = v4:WaitForChild("PlayerGui"):WaitForChild("OfflineGrowth")
local v_u_10 = v9:WaitForChild("WhiteOverlay")
local v_u_11 = v9:WaitForChild("MessageLabel")
local function v_u_14(p12)
	-- upvalues: (copy) v_u_11, (copy) v_u_3
	v_u_11.Text = p12
	v_u_11.TextTransparency = 1
	v_u_11.TextStrokeTransparency = 1
	v_u_11.Visible = true
	local v13 = v_u_3:Create(v_u_11, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["TextTransparency"] = 0,
		["TextStrokeTransparency"] = 0.3
	})
	v13:Play()
	v13.Completed:Wait()
end
local function v_u_16()
	-- upvalues: (copy) v_u_3, (copy) v_u_11
	local v15 = v_u_3:Create(v_u_11, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		["TextTransparency"] = 1,
		["TextStrokeTransparency"] = 1
	})
	v15:Play()
	v15.Completed:Wait()
	v_u_11.Visible = false
end
local function v_u_18()
	-- upvalues: (copy) v_u_10, (copy) v_u_3
	v_u_10.BackgroundTransparency = 1
	v_u_10.Visible = true
	local v17 = v_u_3:Create(v_u_10, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		["BackgroundTransparency"] = 0
	})
	v17:Play()
	v17.Completed:Wait()
end
local function v_u_20()
	-- upvalues: (copy) v_u_3, (copy) v_u_10
	local v19 = v_u_3:Create(v_u_10, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		["BackgroundTransparency"] = 1
	})
	v19:Play()
	v19.Completed:Wait()
	v_u_10.Visible = false
end
v6.OnClientEvent:Connect(function(_)
	-- upvalues: (copy) v_u_14, (copy) v_u_16, (copy) v_u_18, (copy) v_u_7, (copy) v_u_8, (copy) v_u_20
	task.wait(3)
	v_u_14("Your garden grew while you were away!")
	task.wait(2.5)
	v_u_16()
	task.wait(0.3)
	v_u_14("This is what it looked like before...")
	task.wait(2)
	v_u_16()
	v_u_18()
	v_u_7:FireServer()
	local v_u_21 = false
	local v_u_22 = nil
	v_u_22 = v_u_8.OnClientEvent:Connect(function()
		-- upvalues: (ref) v_u_21, (ref) v_u_22
		v_u_21 = true
		if v_u_22 then
			v_u_22:Disconnect()
			v_u_22 = nil
		end
	end)
	local v23 = v_u_22
	local v24 = 0
	while not v_u_21 and v24 < 10 do
		task.wait(0.1)
		v24 = v24 + 0.1
	end
	if v23 then
		v23:Disconnect()
	end
	task.wait(0.5)
	v_u_20()
	v_u_14("And this is what it looks like now!")
	task.wait(2.5)
	v_u_16()
end)
print("[OfflineGrowthController] Initialized")