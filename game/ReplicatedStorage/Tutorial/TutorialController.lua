local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = require(v2:WaitForChild("Maid"))
local v_u_5 = require(v2.Player.NotificationService)
local v_u_6 = require(v2:WaitForChild("PlotStreaming"):WaitForChild("PlotStreamingSignals"))
local v_u_7 = v1.LocalPlayer
local v_u_8 = v_u_7:WaitForChild("PlayerGui")
local v9 = v2:WaitForChild("RemoteEvents")
local v_u_10 = v9:WaitForChild("UpdateTutorialCompletion")
local v_u_11 = v9:WaitForChild("TutorialStepCompleted")
local v_u_12 = {}
v_u_12.__index = v_u_12
local v_u_13 = nil
function v_u_12.GetInstance()
	-- upvalues: (ref) v_u_13
	return v_u_13
end
function v_u_12.new()
	-- upvalues: (ref) v_u_13, (copy) v_u_12, (copy) v_u_7, (copy) v_u_4
	if v_u_13 then
		return v_u_13
	end
	local v14 = v_u_12
	local v_u_15 = setmetatable({}, v14)
	v_u_15.Completed = v_u_7:GetAttribute("TutorialCompleted") == true
	v_u_15.HasNotifiedCompletion = v_u_15.Completed
	v_u_15.ActiveMaid = v_u_4.new()
	v_u_15.OverlayMaid = v_u_4.new()
	v_u_15.ActiveTaskMessage = nil
	v_u_15.OverlayGui = nil
	v_u_15.TasksCompleted = {
		["TeleportedToShop"] = false,
		["BoughtFirstSeed"] = false,
		["TeleportedToGarden"] = false,
		["PlantedSeed"] = false,
		["HarvestedCrop"] = false,
		["SoldProduce"] = false,
		["OpenedQuestBoard"] = false
	}
	v_u_15:InitUI()
	v_u_7:GetAttributeChangedSignal("TutorialCompleted"):Connect(function()
		-- upvalues: (ref) v_u_7, (copy) v_u_15
		if v_u_7:GetAttribute("TutorialCompleted") == false and v_u_15.Completed then
			v_u_15:ResetTutorialState()
		end
	end)
	v_u_13 = v_u_15
	return v_u_15
end
function v_u_12.InitUI(p_u_16)
	-- upvalues: (copy) v_u_8
	local v17 = v_u_8:FindFirstChild("Tutorial")
	if v17 then
		p_u_16.UI = v17
		p_u_16.UI.DisplayOrder = 200
		local v18 = p_u_16.UI:FindFirstChild("Frame")
		if v18 then
			p_u_16.MainFrame = v18
			local v19 = p_u_16.MainFrame:FindFirstChild("Skip")
			if v19 then
				p_u_16.SkipButton = v19
				p_u_16.SkipButton.MouseButton1Click:Connect(function()
					-- upvalues: (copy) p_u_16
					p_u_16:CompleteTutorial(true)
				end)
			else
				warn("[TutorialController] Skip Button not found!")
			end
		else
			warn("[TutorialController] Tutorial Frame not found!")
			return
		end
	else
		warn("[TutorialController] Tutorial UI not found in PlayerGui!")
		return
	end
end
function v_u_12.ShowOverlay(p_u_20, p_u_21)
	-- upvalues: (copy) v_u_8
	p_u_20.OverlayMaid:DoCleaning()
	local v22 = Instance.new("ScreenGui")
	v22.Name = "TutorialOverlay"
	v22.DisplayOrder = 100
	v22.ResetOnSpawn = false
	v22.IgnoreGuiInset = false
	v22.Parent = v_u_8
	local v23 = Instance.new("Frame")
	v23.Name = "Background"
	v23.Position = UDim2.fromOffset(-200, -200)
	v23.Size = UDim2.new(1, 400, 1, 400)
	v23.BackgroundColor3 = Color3.new(0, 0, 0)
	v23.BackgroundTransparency = 0.4
	v23.BorderSizePixel = 0
	v23.Active = true
	v23.Parent = v22
	if p_u_21 and p_u_21.buttonInstance then
		local v24 = p_u_21.buttonInstance.AbsolutePosition
		local v25 = p_u_21.buttonInstance.AbsoluteSize
		local v_u_26 = p_u_21.buttonInstance:Clone()
		v_u_26.Position = UDim2.fromOffset(v24.X, v24.Y)
		v_u_26.Size = UDim2.fromOffset(v25.X, v25.Y)
		v_u_26.AnchorPoint = Vector2.new(0, 0)
		v_u_26.LayoutOrder = 0
		v_u_26.Parent = v22
		local v_u_27 = p_u_21.buttonInstance
		p_u_20.OverlayMaid:GiveTask(v_u_27:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
			-- upvalues: (copy) v_u_26, (copy) v_u_27
			v_u_26.Position = UDim2.fromOffset(v_u_27.AbsolutePosition.X, v_u_27.AbsolutePosition.Y)
		end))
		p_u_20.OverlayMaid:GiveTask(v_u_27:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			-- upvalues: (copy) v_u_26, (copy) v_u_27
			v_u_26.Size = UDim2.fromOffset(v_u_27.AbsoluteSize.X, v_u_27.AbsoluteSize.Y)
		end))
		if p_u_21.onActivated then
			v_u_26.MouseButton1Click:Connect(function()
				-- upvalues: (copy) p_u_21, (copy) p_u_20
				p_u_21.onActivated()
				p_u_20:DismissOverlay()
			end)
		end
	end
	p_u_20.OverlayGui = v22
	p_u_20.OverlayMaid:GiveTask(v22)
end
function v_u_12.DismissOverlay(p28)
	p28.OverlayMaid:DoCleaning()
	p28.OverlayGui = nil
end
function v_u_12.TeleportTo(_, p_u_29)
	-- upvalues: (copy) v_u_7
	local v30 = v_u_7.Character
	if v30 then
		local v31 = v30:FindFirstChild("HumanoidRootPart")
		if v31 then
			v31.Anchored = true
			pcall(function()
				-- upvalues: (ref) v_u_7, (copy) p_u_29
				v_u_7:RequestStreamAroundAsync(p_u_29)
			end)
			v31.CFrame = CFrame.new(p_u_29 + Vector3.new(0, 3, 0))
			v31.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			v31.Anchored = false
		end
	else
		return
	end
end
function v_u_12.GuideTo(p32, p33)
	-- upvalues: (copy) v_u_7
	local v34 = (v_u_7.Character or v_u_7.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart")
	local v35 = Instance.new("Attachment")
	v35.Parent = v34
	local v36 = Instance.new("Part")
	v36.Anchored = true
	v36.CanCollide = false
	v36.Transparency = 1
	v36.Position = p33
	v36.Parent = workspace
	local v37 = Instance.new("Attachment")
	v37.Parent = v36
	local v38 = Instance.new("Beam")
	v38.Attachment0 = v37
	v38.Attachment1 = v35
	v38.Width0 = 1
	v38.Width1 = 1
	v38.FaceCamera = true
	v38.Texture = "rbxassetid://72926261890531"
	v38.TextureMode = Enum.TextureMode.Wrap
	v38.TextureSpeed = -2
	v38.LightEmission = 1
	v38.Color = ColorSequence.new(Color3.new(1, 1, 1))
	v38.Parent = v34
	p32.ActiveMaid:GiveTask(v38)
	p32.ActiveMaid:GiveTask(v36)
	p32.ActiveMaid:GiveTask(v35)
	p32.ActiveMaid:GiveTask(v37)
end
function v_u_12.Notify(_, p_u_39, p_u_40)
	-- upvalues: (copy) v_u_5
	task.spawn(function()
		-- upvalues: (ref) v_u_5, (copy) p_u_39, (copy) p_u_40
		v_u_5.Notify(p_u_39, p_u_40 or 5)
	end)
end
function v_u_12.DismissActiveTaskMessage(p41)
	-- upvalues: (copy) v_u_5
	if p41.ActiveTaskMessage then
		local v42 = p41.ActiveTaskMessage
		p41.ActiveTaskMessage = nil
		v_u_5.Dismiss(v42)
	end
end
function v_u_12.CompleteTutorial(p43, p44)
	-- upvalues: (copy) v_u_11, (copy) v_u_10
	if not p43.Completed then
		p43.Completed = true
		p43:DismissActiveTaskMessage()
		p43:DismissOverlay()
		p43.ActiveMaid:DoCleaning()
		if not p43.HasNotifiedCompletion then
			p43.HasNotifiedCompletion = true
			if p44 then
				p43:Notify("No tutorial? Good luck!", 5)
			else
				p43:Notify("You completed the tutorial! Have fun!", 5)
			end
		end
		if p43.MainFrame then
			p43.MainFrame.Visible = false
		end
		if p44 then
			v_u_11:FireServer("Skipped")
		else
			v_u_11:FireServer("Completed")
		end
		v_u_10:FireServer(true)
	end
end
function v_u_12.ResetTutorialState(p45)
	p45.Completed = false
	p45.HasNotifiedCompletion = false
	p45:DismissActiveTaskMessage()
	p45:DismissOverlay()
	for v46 in pairs(p45.TasksCompleted) do
		p45.TasksCompleted[v46] = false
	end
	p45.ActiveMaid:DoCleaning()
	p45.OverlayMaid:DoCleaning()
	if p45.SkipButton then
		p45.SkipButton.Visible = true
	end
	p45:Run()
end
function v_u_12.ResetTutorial(p47)
	-- upvalues: (copy) v_u_10
	p47:ResetTutorialState()
	v_u_10:FireServer(false)
end
function v_u_12.CompleteTask(p48, p49)
	-- upvalues: (copy) v_u_11
	if p48.Completed then
		return
	end
	if p48.TasksCompleted[p49] == nil then
		return
	end
	if p48.TasksCompleted[p49] then
		return
	end
	p48.TasksCompleted[p49] = true
	v_u_11:FireServer(p49)
	local v50 = true
	for _, v51 in pairs(p48.TasksCompleted) do
		if not v51 then
			v50 = false
			break
		end
	end
	if v50 then
		p48:CompleteTutorial()
	else
		p48:UpdateActiveTask()
	end
end
function v_u_12.Run(p_u_52)
	-- upvalues: (copy) v_u_8, (copy) v_u_11
	if p_u_52.MainFrame and p_u_52.SkipButton then
		p_u_52.MainFrame.Visible = true
		if p_u_52.Completed then
			p_u_52.MainFrame.Visible = false
		else
			p_u_52.SkipButton.Visible = true
			task.spawn(function()
				-- upvalues: (ref) v_u_8, (copy) p_u_52, (ref) v_u_11
				local v53 = v_u_8:FindFirstChild("PlotSelector")
				if v53 and not v53:GetAttribute("FlowComplete") then
					v53:GetAttributeChangedSignal("FlowComplete"):Wait()
				end
				if not p_u_52.Completed then
					v_u_11:FireServer("Started")
					p_u_52:UpdateActiveTask()
				end
			end)
		end
	else
		warn("[TutorialController] Cannot run tutorial - UI not initialized!")
		return
	end
end
function v_u_12.UpdateActiveTask(p54)
	p54:DismissActiveTaskMessage()
	p54.ActiveMaid:DoCleaning()
	p54:DismissOverlay()
	if p54.TasksCompleted.TeleportedToShop then
		if p54.TasksCompleted.BoughtFirstSeed then
			if p54.TasksCompleted.TeleportedToGarden then
				if p54.TasksCompleted.PlantedSeed then
					if p54.TasksCompleted.HarvestedCrop then
						if p54.TasksCompleted.SoldProduce then
							if not p54.TasksCompleted.OpenedQuestBoard then
								p54:SetupQuestBoardTask()
							end
						else
							p54:SetupSellTask()
						end
					else
						p54:SetupHarvestTask()
						return
					end
				else
					p54:SetupPlantSeedTask()
					return
				end
			else
				p54:SetupTeleportToGardenTask()
				return
			end
		else
			p54:SetupBuyFirstSeedTask()
			return
		end
	else
		p54:SetupTeleportToShopTask()
		return
	end
end
function v_u_12.SetupTeleportToShopTask(p_u_55)
	-- upvalues: (copy) v_u_8
	p_u_55.ActiveTaskMessage = "Welcome to Garden Horizons! Head to the Seed Shop!"
	p_u_55:Notify("Welcome to Garden Horizons! Head to the Seed Shop!", 600)
	p_u_55:ShowOverlay({
		["buttonInstance"] = v_u_8:WaitForChild("Hud_UI"):WaitForChild("TopButtons"):WaitForChild("Seeds"),
		["promptText"] = "Teleport to the Seed Shop!",
		["onActivated"] = function()
			-- upvalues: (copy) p_u_55
			local v56 = workspace:WaitForChild("MapPhysical"):WaitForChild("Teleports"):FindFirstChild("SeedsTeleport")
			if v56 then
				p_u_55:TeleportTo(v56.Position)
			end
			p_u_55:CompleteTask("TeleportedToShop")
		end
	})
end
function v_u_12.SetupBuyFirstSeedTask(p_u_57)
	-- upvalues: (copy) v_u_3, (copy) v_u_8, (copy) v_u_7
	p_u_57.ActiveTaskMessage = "Open the Seed Shop!"
	p_u_57:Notify("Open the Seed Shop!", 600)
	local v58 = v_u_3:GetTagged("SeedShopNPC")[1]
	if v58 then
		p_u_57:GuideTo(v58:GetPivot().Position)
	else
		p_u_57.ActiveMaid:GiveTask(v_u_3:GetInstanceAddedSignal("SeedShopNPC"):Connect(function(p59)
			-- upvalues: (copy) p_u_57
			if not (p_u_57.Completed or p_u_57.TasksCompleted.BoughtFirstSeed) then
				p_u_57:GuideTo(p59:GetPivot().Position)
			end
		end))
	end
	local v_u_60 = v_u_8:WaitForChild("SeedShop")
	local v_u_61 = false
	local v_u_62 = {}
	local function v_u_66()
		-- upvalues: (copy) v_u_60, (copy) v_u_62
		local v63 = v_u_60:FindFirstChild("Frame")
		if v63 then
			v63 = v_u_60.Frame:FindFirstChild("ScrollingFrame")
		end
		if v63 then
			for _, v64 in v63:GetChildren() do
				if v64:IsA("Frame") and (v64.Name ~= "Carrot" and (v64.Name ~= "ItemTemplate" and (v64.Name ~= "ItemTemplate_Padding" and v64.Visible))) then
					v64.Visible = false
					local v65 = v_u_62
					table.insert(v65, v64)
				end
			end
		end
	end
	p_u_57.ActiveMaid:GiveTask(v_u_60:GetPropertyChangedSignal("Enabled"):Connect(function()
		-- upvalues: (copy) v_u_60, (ref) v_u_61, (copy) p_u_57, (copy) v_u_66, (copy) v_u_62
		if v_u_60.Enabled then
			if not v_u_61 then
				p_u_57:DismissActiveTaskMessage()
				p_u_57.ActiveTaskMessage = "Buy a Carrot Seed!"
				p_u_57:Notify("Buy a Carrot Seed!", 600)
				local v67 = v_u_60:FindFirstChild("Frame") and v_u_60.Frame:FindFirstChild("TopBar")
				if v67 then
					v67 = v_u_60.Frame.TopBar:FindFirstChild("Close")
				end
				if v67 then
					v67.Visible = false
				end
				v_u_66()
				return
			end
		else
			if v_u_61 then
				p_u_57:CompleteTask("BoughtFirstSeed")
				return
			end
			for _, v68 in v_u_62 do
				if v68 and v68.Parent then
					v68.Visible = true
				end
			end
			table.clear(v_u_62)
			local v69 = v_u_60:FindFirstChild("Frame") and v_u_60.Frame:FindFirstChild("TopBar")
			if v69 then
				v69 = v_u_60.Frame.TopBar:FindFirstChild("Close")
			end
			if v69 then
				v69.Visible = true
			end
		end
	end))
	p_u_57.ActiveMaid:GiveTask(function()
		-- upvalues: (copy) v_u_62, (copy) v_u_60
		for _, v70 in v_u_62 do
			if v70 and v70.Parent then
				v70.Visible = true
			end
		end
		table.clear(v_u_62)
		local v71 = v_u_60:FindFirstChild("Frame") and v_u_60.Frame:FindFirstChild("TopBar")
		if v71 then
			v71 = v_u_60.Frame.TopBar:FindFirstChild("Close")
		end
		if v71 then
			v71.Visible = true
		end
	end)
	local v72 = v_u_7:FindFirstChild("leaderstats")
	local v_u_73 = v72 and v72:FindFirstChild("Shillings")
	if v_u_73 then
		local v_u_74 = v_u_73.Value
		p_u_57.ActiveMaid:GiveTask(v_u_73:GetPropertyChangedSignal("Value"):Connect(function()
			-- upvalues: (copy) v_u_73, (copy) v_u_74, (ref) v_u_61, (copy) p_u_57, (copy) v_u_62, (copy) v_u_60
			if v_u_73.Value < v_u_74 and not v_u_61 then
				v_u_61 = true
				p_u_57:DismissActiveTaskMessage()
				for _, v75 in v_u_62 do
					if v75 and v75.Parent then
						v75.Visible = true
					end
				end
				table.clear(v_u_62)
				local v76 = v_u_60:FindFirstChild("Frame") and v_u_60.Frame:FindFirstChild("TopBar")
				if v76 then
					v76 = v_u_60.Frame.TopBar:FindFirstChild("Close")
				end
				if v76 then
					v76.Visible = true
				end
				if not v_u_60.Enabled then
					p_u_57:CompleteTask("BoughtFirstSeed")
				end
			end
		end))
	end
end
function v_u_12.SetupTeleportToGardenTask(p_u_77)
	-- upvalues: (copy) v_u_8, (copy) v_u_7, (copy) v_u_6
	p_u_77.ActiveTaskMessage = "Head to your Garden!"
	p_u_77:Notify("Head to your Garden!", 600)
	p_u_77:ShowOverlay({
		["buttonInstance"] = v_u_8:WaitForChild("Hud_UI"):WaitForChild("TopButtons"):WaitForChild("YourGarden"),
		["promptText"] = "Teleport to your Garden!",
		["onActivated"] = function()
			-- upvalues: (copy) p_u_77, (ref) v_u_7, (ref) v_u_6
			p_u_77:DismissActiveTaskMessage()
			for _, v78 in workspace:WaitForChild("Plots"):GetChildren() do
				if v78:GetAttribute("Owner") == v_u_7.UserId then
					local v79 = v78:FindFirstChild("Spawn")
					if v79 then
						v79 = v79:FindFirstChild("Spawn")
					end
					if v79 then
						v_u_6.FirePreloadPlot(v78)
						p_u_77:TeleportTo(v79.Position)
					end
					break
				end
			end
			p_u_77:CompleteTask("TeleportedToGarden")
		end
	})
end
function v_u_12.SetupPlantSeedTask(p_u_80)
	-- upvalues: (copy) v_u_7, (copy) v_u_3
	p_u_80.ActiveTaskMessage = "Plant your Carrot Seed!"
	p_u_80:Notify("Plant your Carrot Seed!", 600)
	local v81 = nil
	for _, v82 in workspace.Plots:GetChildren() do
		if v82:GetAttribute("Owner") == v_u_7.UserId then
			local v83 = v82:FindFirstChild("PlantableArea")
			if v83 then
				local v84 = v83:FindFirstChildWhichIsA("BasePart")
				if v84 then
					v81 = v84.Position
				end
			end
			v81 = v81 or v82:GetPivot().Position
			break
		end
	end
	if v81 then
		p_u_80:GuideTo(v81)
	end
	p_u_80.ActiveMaid:GiveTask(v_u_3:GetInstanceAddedSignal("Plant"):Connect(function(p_u_85)
		-- upvalues: (copy) p_u_80, (ref) v_u_7
		if not (p_u_80.Completed or p_u_80.TasksCompleted.PlantedSeed) then
			task.defer(function()
				-- upvalues: (copy) p_u_85, (ref) v_u_7, (ref) p_u_80
				if p_u_85:GetAttribute("OwnerUserId") == v_u_7.UserId and p_u_85:GetAttribute("PlantType") == "Carrot" then
					p_u_80:CompleteTask("PlantedSeed")
				end
			end)
		end
	end))
end
function v_u_12.SetupHarvestTask(p_u_86)
	-- upvalues: (copy) v_u_7, (copy) v_u_3
	p_u_86.ActiveTaskMessage = "Watch your Carrot grow!"
	p_u_86:Notify("Watch your Carrot grow!", 600)
	local v_u_87 = v_u_7:WaitForChild("Backpack")
	p_u_86.ActiveMaid:GiveTask(v_u_87.ChildAdded:Connect(function(p88)
		-- upvalues: (copy) p_u_86
		if p88:IsA("Tool") and p88:GetAttribute("HarvestedFrom") == "Carrot" then
			p_u_86:CompleteTask("HarvestedCrop")
		end
	end))
	local function v_u_91(p89)
		-- upvalues: (copy) p_u_86, (copy) v_u_87
		p_u_86:DismissActiveTaskMessage()
		p_u_86.ActiveTaskMessage = "Harvest your Carrot!"
		p_u_86:Notify("Harvest your Carrot!", 600)
		p_u_86.ActiveMaid:DoCleaning()
		p_u_86.ActiveMaid:GiveTask(v_u_87.ChildAdded:Connect(function(p90)
			-- upvalues: (ref) p_u_86
			if p90:IsA("Tool") and p90:GetAttribute("HarvestedFrom") == "Carrot" then
				p_u_86:CompleteTask("HarvestedCrop")
			end
		end))
		p_u_86:GuideTo(p89:GetPivot().Position)
	end
	local function v_u_96(p_u_92)
		-- upvalues: (copy) v_u_91, (copy) p_u_86
		local v93 = p_u_92:GetAttribute("RipenessStage")
		if v93 == "Ripe" or v93 == "Lush" then
			v_u_91(p_u_92)
		else
			local v_u_94 = nil
			v_u_94 = p_u_92:GetAttributeChangedSignal("RipenessStage"):Connect(function()
				-- upvalues: (copy) p_u_92, (ref) v_u_94, (ref) v_u_91
				local v95 = p_u_92:GetAttribute("RipenessStage")
				if v95 == "Ripe" or v95 == "Lush" then
					if v_u_94 then
						v_u_94:Disconnect()
					end
					v_u_91(p_u_92)
				end
			end)
			p_u_86.ActiveMaid:GiveTask(v_u_94)
		end
	end
	local v97 = nil
	for _, v98 in v_u_3:GetTagged("Plant") do
		if v98:GetAttribute("OwnerUserId") == v_u_7.UserId and v98:GetAttribute("PlantType") == "Carrot" then
			v97 = v98
			break
		end
	end
	if v97 then
		v_u_96(v97)
	else
		p_u_86.ActiveMaid:GiveTask(v_u_3:GetInstanceAddedSignal("Plant"):Connect(function(p_u_99)
			-- upvalues: (copy) p_u_86, (ref) v_u_7, (copy) v_u_96
			if not (p_u_86.Completed or p_u_86.TasksCompleted.HarvestedCrop) then
				task.defer(function()
					-- upvalues: (copy) p_u_99, (ref) v_u_7, (ref) v_u_96
					if p_u_99:GetAttribute("OwnerUserId") == v_u_7.UserId and p_u_99:GetAttribute("PlantType") == "Carrot" then
						v_u_96(p_u_99)
					end
				end)
			end
		end))
	end
end
function v_u_12.SetupSellTask(p_u_100)
	-- upvalues: (copy) v_u_8, (copy) v_u_3, (copy) v_u_7
	p_u_100.ActiveTaskMessage = "Sell your Carrot at the Sell Stand!"
	p_u_100:Notify("Sell your Carrot at the Sell Stand!", 600)
	p_u_100:ShowOverlay({
		["buttonInstance"] = v_u_8:WaitForChild("Hud_UI"):WaitForChild("TopButtons"):WaitForChild("Sell"),
		["promptText"] = "Teleport to the Sell Stand!",
		["onActivated"] = function()
			-- upvalues: (copy) p_u_100
			local v101 = workspace:WaitForChild("MapPhysical"):WaitForChild("Teleports"):FindFirstChild("SellTeleport")
			if v101 then
				p_u_100:TeleportTo(v101.Position)
			end
		end
	})
	local v102 = v_u_3:GetTagged("SellShopNPC")[1]
	if v102 then
		p_u_100:GuideTo(v102:GetPivot().Position)
	end
	local v103 = v_u_7:FindFirstChild("leaderstats")
	local v_u_104 = v103 and v103:FindFirstChild("Shillings")
	if v_u_104 then
		local v_u_105 = v_u_104.Value
		p_u_100.ActiveMaid:GiveTask(v_u_104:GetPropertyChangedSignal("Value"):Connect(function()
			-- upvalues: (copy) v_u_104, (copy) v_u_105, (copy) p_u_100
			local v106 = v_u_104.Value - v_u_105
			if v106 > 0 and v106 ~= 40 then
				p_u_100:CompleteTask("SoldProduce")
			end
		end))
	end
end
function v_u_12.SetupQuestBoardTask(p_u_107)
	-- upvalues: (copy) v_u_8
	p_u_107.ActiveTaskMessage = "Check out the Quest Board for goals and rewards!"
	p_u_107:Notify("Check out the Quest Board for goals and rewards!", 600)
	local v108 = workspace:FindFirstChild("MapPhysical")
	if v108 then
		v108 = workspace.MapPhysical:FindFirstChild("QuestBoard")
	end
	if v108 then
		p_u_107:GuideTo(v108:GetPivot().Position)
	end
	local v_u_109 = v_u_8:WaitForChild("Quests")
	p_u_107.ActiveMaid:GiveTask(v_u_109:GetPropertyChangedSignal("Enabled"):Connect(function()
		-- upvalues: (copy) v_u_109, (copy) p_u_107
		if v_u_109.Enabled and not p_u_107.TasksCompleted.OpenedQuestBoard then
			p_u_107:Notify("Complete quests to earn rewards and progress!", 5)
			task.delay(3, function()
				-- upvalues: (ref) p_u_107
				p_u_107:CompleteTask("OpenedQuestBoard")
			end)
		end
	end))
end
function v_u_12.SetupRemoteListeners(_) end
function v_u_12.IsHarvestAllowed(_)
	return true
end
return v_u_12