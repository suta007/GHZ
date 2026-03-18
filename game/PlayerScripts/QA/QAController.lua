if game:GetService("RunService"):IsStudio() or game.PlaceId == 125175568976972 then
	local v1 = game:GetService("Players")
	local v2 = game:GetService("ReplicatedStorage")
	local v3 = v2:WaitForChild("RemoteEvents")
	local v_u_4 = v1.LocalPlayer:WaitForChild("PlayerGui")
	local v_u_5 = v_u_4:WaitForChild("QA", 15)
	if v_u_5 then
		local v6 = v2:WaitForChild("TopbarPlusReference")
		local v7 = require(v6.Value)
		if v7 then
			local v8 = v_u_5:WaitForChild("Background"):WaitForChild("ScrollingFrame")
			local function v_u_12()
				-- upvalues: (copy) v_u_4
				local v9 = v_u_4:FindFirstChild("RNGPack")
				if not v9 then
					return false
				end
				local v10 = 0
				for _, v11 in v9:GetChildren() do
					if v11:IsA("Frame") and v11.Name == "MainFrame" then
						v10 = v10 + 1
					end
				end
				return v10 > 1
			end
			local v_u_13 = v7.new()
			v_u_13:setLabel("QA")
			v_u_13:setName("QAButton")
			v_u_13:setCaption("Open QA Panel")
			v_u_13:autoDeselect(false)
			v_u_13.toggled:Connect(function(p14)
				-- upvalues: (copy) v_u_12, (copy) v_u_13, (copy) v_u_5
				if p14 and v_u_12() then
					v_u_13:deselect()
				else
					v_u_5.Enabled = p14
				end
			end)
			v_u_5:GetPropertyChangedSignal("Enabled"):Connect(function()
				-- upvalues: (copy) v_u_5, (copy) v_u_13
				if not v_u_5.Enabled then
					v_u_13:deselect()
				end
			end)
			local function v_u_19()
				-- upvalues: (copy) v_u_4
				local v15 = v_u_4:FindFirstChild("FloraBook")
				if v15 then
					local v16 = v15:FindFirstChild("Frame")
					if v16 then
						local v17 = v16:FindFirstChild("BackCoverLeft")
						if v17 then
							v17 = v17:FindFirstChild("FrontPageLeft")
						end
						if v17 then
							v17 = v17:FindFirstChild("PlantsTab")
						end
						if v17 then
							v17 = v17:FindFirstChild("PlantsScrollBG")
						end
						if v17 then
							v17 = v17:FindFirstChild("ScrollingFrame")
						end
						if v17 then
							for _, v18 in ipairs(v17:GetChildren()) do
								if v18:IsA("GuiObject") and v18.Name ~= "Template" then
									v18:SetAttribute("Discovered", true)
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
			for v20, v21 in pairs({
				["StarterItems"] = "GiveStarterItems",
				["WipePlot"] = "WipePlot",
				["WipeData"] = "WipePlayerData",
				["ResetQuests"] = "HardResetQuests",
				["ResetCodes"] = "ResetCodes",
				["GrowAll"] = "GrowAllQA",
				["ClearInventory"] = "ClearInventoryQA",
				["CropModels"] = "GiveCropModelsQA",
				["RemoveCropModels"] = "RemoveCropModelsQA"
			}) do
				local v22 = v8:FindFirstChild(v20)
				local v_u_23 = v3:FindFirstChild(v21)
				if v22 and v_u_23 then
					v22.MouseButton1Click:Connect(function()
						-- upvalues: (copy) v_u_23
						v_u_23:FireServer()
					end)
				end
			end
			local v24 = v8:FindFirstChild("ResetTutorial")
			if v24 then
				local v_u_25 = v3:WaitForChild("UpdateTutorialCompletion")
				v24.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_25
					v_u_25:FireServer(false)
				end)
			end
			local v26 = v8:FindFirstChild("DiscoverAll")
			if v26 then
				v26.MouseButton1Click:Connect(function()
					-- upvalues: (copy) v_u_19
					v_u_19()
				end)
			end
		end
	else
		return
	end
else
	game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("QA"):Destroy()
	script.Enabled = false
	return
end