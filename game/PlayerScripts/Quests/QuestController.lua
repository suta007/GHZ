local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = game:GetService("CollectionService")
local v_u_4 = v2.LocalPlayer
local v5 = v_u_4:WaitForChild("PlayerGui")
local v_u_6 = require(v1:WaitForChild("Quests"):WaitForChild("QuestManager"))
local v_u_7 = v1:WaitForChild("RemoteEvents")
local v_u_8 = v5:WaitForChild("Quests")
local v_u_9 = v_u_8.BG.ScrollingFrame
local v_u_10 = v_u_8.BG.RefreshingIn.Timer
local v_u_11 = "Daily"
local v_u_12 = nil
v_u_8.Enabled = false
print("[QuestController] Script loaded")
local function v_u_20()
	-- upvalues: (ref) v_u_12, (ref) v_u_11, (copy) v_u_9, (copy) v_u_6, (copy) v_u_10
	if v_u_12 then
		local v13 = v_u_12[v_u_11]
		for v14 = 1, 5 do
			local v15 = v_u_9:FindFirstChild((tostring(v14)))
			if v15 then
				local v16 = v13.Active[tostring(v14)]
				local v17 = v13.ResetCounts and (v13.ResetCounts[tostring(v14)] or 0) or 0
				v_u_6.UpdateEntry(v15, v16, v17, v_u_11)
				if v15:FindFirstChild("RefreshShadow") then
					v15.RefreshShadow.Visible = false
				end
			end
		end
		local v18 = workspace:GetServerTimeNow()
		local v19 = math.floor(v18)
		v_u_10.Text = v_u_11 == "Daily" and v_u_6.FormatDailyTimer(v19) or v_u_6.FormatWeeklyTimer(v19)
	end
end
local v_u_21 = v_u_12
local v_u_22 = v_u_11
for v_u_23 = 1, 5 do
	local v_u_24 = v_u_9:WaitForChild((tostring(v_u_23)))
	v_u_24.Claim.MouseButton1Click:Connect(function()
		-- upvalues: (copy) v_u_7, (ref) v_u_22, (copy) v_u_23
		local v25 = v_u_23
		v_u_7.ClaimQuest:FireServer(v_u_22, (tostring(v25)))
	end)
	if v_u_24:FindFirstChild("Refresh") then
		v_u_24.Refresh.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_24
			v_u_24.RefreshShadow.Visible = true
		end)
		v_u_24.RefreshShadow.PurchaseButton.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_7, (ref) v_u_22, (copy) v_u_23
			local v26 = v_u_23
			v_u_7.PurchaseSingleRefresh:FireServer(v_u_22, (tostring(v26)))
		end)
	end
end
v_u_8.BG.Header.Daily.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_22, (copy) v_u_20
	v_u_22 = "Daily"
	v_u_20()
end)
v_u_8.BG.Header.Weekly.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_22, (copy) v_u_20
	v_u_22 = "Weekly"
	v_u_20()
end)
v_u_7.UpdateQuests.OnClientEvent:Connect(function(p27)
	-- upvalues: (ref) v_u_21, (copy) v_u_20
	print("[QuestController] Received quest data from server")
	v_u_21 = p27
	v_u_20()
end)
for _, v28 in v3:GetTagged("QuestOpen") do
	print("[QuestController] Found QuestOpen prompt:", v28:GetFullName())
	v28.MaxActivationDistance = 15
	v28.RequiresLineOfSight = false
	v28.Triggered:Connect(function(p29)
		-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_7
		if p29 == v_u_4 then
			print("[QuestController] openUI called")
			v_u_8.Enabled = true
			v_u_7.RequestQuests:FireServer()
		end
	end)
	v28.PromptHidden:Connect(function()
		-- upvalues: (copy) v_u_8
		if v_u_8.Enabled then
			v_u_8.Enabled = false
		end
	end)
end
v3:GetInstanceAddedSignal("QuestOpen"):Connect(function(p30)
	-- upvalues: (copy) v_u_4, (copy) v_u_8, (copy) v_u_7
	print("[QuestController] Found QuestOpen prompt (late):", p30:GetFullName())
	p30.MaxActivationDistance = 15
	p30.RequiresLineOfSight = false
	p30.Triggered:Connect(function(p31)
		-- upvalues: (ref) v_u_4, (ref) v_u_8, (ref) v_u_7
		if p31 == v_u_4 then
			print("[QuestController] openUI called")
			v_u_8.Enabled = true
			v_u_7.RequestQuests:FireServer()
		end
	end)
	p30.PromptHidden:Connect(function()
		-- upvalues: (ref) v_u_8
		if v_u_8.Enabled then
			v_u_8.Enabled = false
		end
	end)
end)
task.spawn(function()
	-- upvalues: (copy) v_u_10, (ref) v_u_22, (copy) v_u_6
	while task.wait(1) do
		local v32 = workspace:GetServerTimeNow()
		local v33 = math.floor(v32)
		v_u_10.Text = v_u_22 == "Daily" and v_u_6.FormatDailyTimer(v33) or v_u_6.FormatWeeklyTimer(v33)
	end
end)