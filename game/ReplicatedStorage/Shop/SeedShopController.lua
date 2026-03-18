local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
game:GetService("UserInputService")
local v_u_4 = game:GetService("MarketplaceService")
local v_u_5 = v3.LocalPlayer
local v6 = require(v_u_2.Plants.Definitions.PlantDataDefinitions)
local v_u_7 = require(v_u_2.Shop.ShopData.SeedShopData)
local v_u_8 = require(v_u_2:WaitForChild("UI"):WaitForChild("UIManager"))
local v_u_9 = require(v_u_2:WaitForChild("UI"):WaitForChild("FloraBookController"))
local v_u_10 = require(v_u_2:WaitForChild("Player"):WaitForChild("NotificationService"))
local v_u_11 = v_u_5:WaitForChild("PlayerGui"):WaitForChild("SeedShop")
local v_u_12 = v_u_2:WaitForChild("RemoteEvents")
local v_u_13 = {}
local v_u_14 = v_u_11:WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local v_u_15 = v_u_11:WaitForChild("Frame"):WaitForChild("TopBar")
local v16 = v_u_14:WaitForChild("ItemTemplate")
local v17 = v_u_14:WaitForChild("ItemTemplate_Padding")
local v18 = require(v_u_2.Plants.Definitions.TierHelper)
local v_u_19 = game:GetService("SoundService")
local v_u_20 = v_u_19:WaitForChild("SFX"):WaitForChild("UI")
local v_u_21 = require(v_u_2.Economy.Formatter.NumberFormatter)
local v_u_22 = nil
local v_u_23 = 0
local v_u_24 = nil
local v_u_25 = nil
v_u_15:WaitForChild("Close").MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_13
	v_u_13.Close()
end)
local v_u_26 = UDim2.new(1, 0, 0.155, 0)
local v_u_27 = UDim2.new(1, 0, 0.03, 0)
local v_u_28 = UDim2.new(0.5, 0, 0.5, 0)
local v_u_29 = UDim2.new(0.5, 0, 1.04, 0)
local v_u_30 = v_u_2:WaitForChild("RemoteEvents"):WaitForChild("PurchaseShopItem")
local v_u_31 = v_u_2:WaitForChild("RemoteEvents"):WaitForChild("PurchaseDevProduct")
local v_u_32 = v_u_2:WaitForChild("RemoteEvents"):WaitForChild("PurchaseGiftDevProduct")
local v_u_33 = require(v_u_2.Shop.GiftModalController)
v_u_4.PromptProductPurchaseFinished:Connect(function(_, _, p34)
	-- upvalues: (copy) v_u_20, (copy) v_u_33
	if p34 then
		local v35 = v_u_20:WaitForChild("Buying")
		v35.PlaybackSpeed = math.random(90, 110) / 100
		v35:Play()
	end
	v_u_33:Close()
end)
local v_u_36 = false
local v_u_37 = 0
local function v_u_47(p_u_38)
	-- upvalues: (ref) v_u_36, (ref) v_u_37, (copy) v_u_14, (copy) v_u_10, (copy) v_u_30, (copy) v_u_13, (copy) v_u_20
	if v_u_36 then
		if os.clock() - v_u_37 <= 5 then
			return
		end
		v_u_36 = false
	end
	local v39 = nil
	for _, v40 in ipairs(v_u_14:GetChildren()) do
		if v40:GetAttribute("ShopItemName") == p_u_38 then
			v39 = v40
			break
		end
	end
	if v39 then
		local v41 = v39:FindFirstChild("MainInfo")
		if v41 and (v41:FindFirstChild("NoStock") and v41.NoStock.Visible) then
			v_u_10.Notify("This seed is currently out of stock!", 3)
			return false
		end
	end
	if v_u_30 then
		v_u_36 = true
		v_u_37 = os.clock()
		v_u_13.IsPurchasing = true
		local v42, v43, v44 = pcall(function()
			-- upvalues: (ref) v_u_30, (copy) p_u_38
			return v_u_30:InvokeServer("SeedShop", p_u_38)
		end)
		if v42 and (v43 and typeof(v43) == "table") then
			local v45 = v_u_20:WaitForChild("Buying")
			v45.PlaybackSpeed = math.random(90, 110) / 100
			v45:Play()
			v_u_13.RestockItems(v43)
		elseif v42 and not v43 then
			local v46 = v_u_20:FindFirstChild("FailedPurchase")
			if v46 then
				v46:Play()
			end
			if v44 == "Not enough shillings" then
				v_u_10.Notify("You do not have enough to purchase this!", 3)
			else
				v_u_10.Notify("Purchase failed! Reason: " .. v44, 3)
				print("[SeedShopController] Seed purchase failed: " .. v44)
			end
		end
		task.wait(0.03)
		v_u_36 = false
		task.defer(function()
			-- upvalues: (ref) v_u_13
			v_u_13.IsPurchasing = false
		end)
		return v43
	end
	warn("Buy remote not found!")
end
task.spawn(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_15
	while true do
		if v_u_11.Enabled then
			local v48 = 300 - workspace:GetServerTimeNow() % 300
			local v49 = math.ceil(v48)
			local v50 = math.min(v49, 300)
			local v51 = v_u_15:WaitForChild("Timer")
			local v52 = string.format
			local v53 = v50 / 60
			v51.Text = v52("%d:%02d", math.floor(v53), v50 % 60)
		end
		task.wait(1)
	end
end)
workspace:GetAttributeChangedSignal("SeedShop"):Connect(function()
	-- upvalues: (copy) v_u_15, (copy) v_u_11, (copy) v_u_12, (copy) v_u_13
	local v54 = 300 - workspace:GetServerTimeNow() % 300
	local v55 = math.ceil(v54)
	local v56 = math.min(v55, 300)
	local v57 = v_u_15:WaitForChild("Timer")
	local v58 = string.format
	local v59 = v56 / 60
	v57.Text = v58("%d:%02d", math.floor(v59), v56 % 60)
	if v_u_11.Enabled then
		local v_u_60 = v_u_12:FindFirstChild("GetShopData")
		if v_u_60 and v_u_60:IsA("RemoteFunction") then
			task.spawn(function()
				-- upvalues: (copy) v_u_60, (ref) v_u_13
				local v61, v62 = pcall(function()
					-- upvalues: (ref) v_u_60
					return v_u_60:InvokeServer("SeedShop")
				end)
				if v61 and (v62 and typeof(v62) == "table") then
					v_u_13.RestockItems(v62)
				end
			end)
		end
	end
end)
local function v_u_65()
	-- upvalues: (ref) v_u_24, (copy) v_u_1, (ref) v_u_25, (copy) v_u_27, (copy) v_u_28
	if v_u_24 then
		local v63 = {
			["Size"] = v_u_27
		}
		v_u_1:Create(v_u_25, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v63):Play()
		local v64 = {
			["Position"] = v_u_28
		}
		v_u_1:Create(v_u_24, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v64):Play()
		v_u_24 = nil
		v_u_25 = nil
	end
end
local v_u_66 = v_u_24
local v_u_67 = v_u_25
local v_u_68 = {}
for v_u_69, v_u_70 in pairs(v_u_7.ShopData) do
	local v_u_71 = v6[v_u_69]
	if v_u_71 then
		local v72 = v16:Clone()
		v72.Name = v_u_69
		v72:SetAttribute("ShopItemName", v_u_70.Name)
		v72.LayoutOrder = v_u_70.LayoutOrder
		v72.Parent = v_u_14
		local v_u_73 = v17:Clone()
		v_u_73.Name = v_u_69 .. "_Padding"
		v_u_73.LayoutOrder = v_u_70.LayoutOrder + 0.5
		v_u_73.Parent = v_u_14
		if v_u_70.DisplayInShop == false then
			v72.Visible = false
			v_u_73.Visible = false
			v_u_68[v_u_69] = {
				["Card"] = v72,
				["Padding"] = v_u_73
			}
		end
		local v_u_74 = v72:WaitForChild("MainInfo")
		v_u_74:WaitForChild("StockText").Text = "..."
		v_u_74:WaitForChild("NoStock").Visible = true
		local v_u_75 = v_u_74:WaitForChild("StockText")
		v_u_74:WaitForChild("SeedName").Text = v_u_70.Name
		v_u_74:WaitForChild("SeedNameShadow").Text = v_u_70.Name
		local v_u_76 = v_u_74:WaitForChild("SeedBox"):WaitForChild("ImageWrapper"):WaitForChild("SeedImage")
		v_u_76.Image = v_u_71.SeedAssetId
		local v_u_77 = nil
		local v_u_78 = nil
		local v_u_79 = false
		v72.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_77, (copy) v_u_1, (copy) v_u_76, (ref) v_u_79, (ref) v_u_78, (copy) v_u_71
			v_u_77 = v_u_1:Create(v_u_76, TweenInfo.new(0.07, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
				["Rotation"] = 7
			})
			v_u_77:Play()
			if not v_u_79 then
				v_u_78 = task.delay(1, function()
					-- upvalues: (ref) v_u_79, (ref) v_u_76, (ref) v_u_71, (ref) v_u_1
					v_u_79 = true
					v_u_76.Image = v_u_71.ProduceAssetId or v_u_71.SeedAssetId
					local v_u_80 = UDim2.new(0.9, 0, 0.9, 0)
					local v81 = {
						["Size"] = UDim2.new(1.125, 0, 1.125, 0)
					}
					local v82 = v_u_1:Create(v_u_76, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), v81)
					v82:Play()
					v82.Completed:Connect(function()
						-- upvalues: (ref) v_u_1, (ref) v_u_76, (copy) v_u_80
						local v83 = {
							["Size"] = v_u_80
						}
						v_u_1:Create(v_u_76, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), v83):Play()
					end)
				end)
			end
		end)
		v72.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_78, (ref) v_u_77, (ref) v_u_79, (copy) v_u_76, (copy) v_u_71
			if v_u_78 then
				task.cancel(v_u_78)
			end
			if v_u_77 then
				v_u_77:Cancel()
				v_u_77 = nil
			end
			v_u_79 = false
			v_u_76.Rotation = 0
			v_u_76.Size = UDim2.new(0.9, 0, 0.9, 0)
			v_u_76.Image = v_u_71.SeedAssetId
		end)
		v_u_74:WaitForChild("PriceText").Text = "$" .. v_u_21:FormatNumberShort(v_u_70.Price)
		v_u_74:WaitForChild("Rarity").Image = v18:GetImage(v_u_71.Rarity)
		local v84 = v18:GetStars(v_u_71.Rarity)
		local v85 = v84.Color
		local v86 = v_u_74:WaitForChild("Stars"):WaitForChild("Star")
		if v85 == "Bronze" then
			v86.Image = "rbxassetid://75963437560225"
		elseif v85 == "Silver" then
			v86.Image = "rbxassetid://104552524366406"
		end
		v86.Visible = false
		for _ = 1, v84.Number do
			local v87 = v86:Clone()
			v87.Visible = true
			v87.Parent = v_u_74:WaitForChild("Stars")
		end
		local v_u_88 = v72:WaitForChild("ButtonRow")
		v_u_74.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_66, (copy) v_u_88, (copy) v_u_65, (copy) v_u_1, (copy) v_u_73, (copy) v_u_26, (copy) v_u_29, (ref) v_u_67
			local v89 = v_u_66 == v_u_88
			v_u_65()
			if not v89 then
				local v90 = {
					["Size"] = v_u_26
				}
				v_u_1:Create(v_u_73, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v90):Play()
				local v91 = {
					["Position"] = v_u_29
				}
				v_u_1:Create(v_u_88, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v91):Play()
				v_u_66 = v_u_88
				v_u_67 = v_u_73
			end
		end)
		local v_u_92 = false
		local v_u_93 = v_u_88:WaitForChild("Buy")
		local v_u_94 = v_u_88:WaitForChild("Info")
		local v_u_95 = v_u_88:WaitForChild("Swap")
		v_u_93:SetAttribute("SkipClickSound", true)
		v_u_95.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_92, (copy) v_u_93, (copy) v_u_94, (copy) v_u_95, (copy) v_u_74, (copy) v_u_21, (copy) v_u_70, (copy) v_u_71, (copy) v_u_69, (copy) v_u_4
			if v_u_92 then
				v_u_93:SetAttribute("Robux", false)
				v_u_94:SetAttribute("Robux", false)
				v_u_95:SetAttribute("Robux", false)
				v_u_74:WaitForChild("PriceText").Text = "$" .. v_u_21:FormatNumberShort(v_u_70.Price)
				v_u_92 = false
				return
			elseif v_u_71.DevProductId and v_u_71.DevProductId ~= 0 then
				v_u_93:SetAttribute("Robux", true)
				v_u_94:SetAttribute("Robux", true)
				v_u_95:SetAttribute("Robux", true)
				local v96, v97 = pcall(function()
					-- upvalues: (ref) v_u_4, (ref) v_u_71
					return v_u_4:GetProductInfoAsync(v_u_71.DevProductId, Enum.InfoType.Product)
				end)
				if v96 and v97 then
					v_u_74:WaitForChild("PriceText").Text = "R$" .. (v97.PriceInRobux or "???")
				else
					v_u_74:WaitForChild("PriceText").Text = "R$???"
				end
				v_u_92 = true
			else
				warn("[SeedShopController] No valid DevProductId for " .. v_u_69)
			end
		end)
		local v_u_98 = nil
		local v_u_99 = nil
		local v_u_100 = false
		local v_u_101 = false
		local function v_u_105()
			-- upvalues: (ref) v_u_101, (copy) v_u_75, (copy) v_u_11, (copy) v_u_47, (copy) v_u_70
			v_u_101 = true
			local v102 = string.match
			local v103 = v_u_75.Text
			local v104 = tonumber(v102(v103, "%d+")) or 0
			if v104 > 0 then
				for _ = 1, v104 do
					if not (v_u_101 and (v_u_11.Enabled and v_u_47(v_u_70.Name))) then
						break
					end
					task.wait(0.01)
				end
			end
			v_u_101 = false
		end
		local function v_u_106()
			-- upvalues: (ref) v_u_100, (ref) v_u_101, (ref) v_u_98, (ref) v_u_99, (copy) v_u_1, (copy) v_u_93
			v_u_100 = false
			v_u_101 = false
			if v_u_98 then
				task.cancel(v_u_98)
				v_u_98 = nil
			end
			if v_u_99 then
				v_u_99:Cancel()
				v_u_99 = nil
			end
			v_u_1:Create(v_u_93, TweenInfo.new(0.1), {
				["ImageColor3"] = Color3.fromRGB(255, 255, 255)
			}):Play()
		end
		v_u_93.MouseButton1Down:Connect(function()
			-- upvalues: (copy) v_u_93, (copy) v_u_106, (ref) v_u_100, (ref) v_u_99, (copy) v_u_1, (ref) v_u_98, (copy) v_u_105
			if not v_u_93:GetAttribute("Robux") then
				v_u_106()
				v_u_100 = true
				v_u_99 = v_u_1:Create(v_u_93, TweenInfo.new(1, Enum.EasingStyle.Linear), {
					["ImageColor3"] = Color3.fromRGB(150, 150, 150)
				})
				v_u_99:Play()
				v_u_98 = task.delay(1, function()
					-- upvalues: (ref) v_u_100, (ref) v_u_98, (ref) v_u_105, (ref) v_u_1, (ref) v_u_93
					if v_u_100 then
						v_u_100 = false
						v_u_98 = nil
						v_u_105()
						v_u_1:Create(v_u_93, TweenInfo.new(0.1), {
							["ImageColor3"] = Color3.fromRGB(255, 255, 255)
						}):Play()
					end
				end)
			end
		end)
		v_u_93.MouseButton1Up:Connect(function()
			-- upvalues: (copy) v_u_93, (copy) v_u_71, (copy) v_u_19, (copy) v_u_31, (copy) v_u_10, (ref) v_u_100, (copy) v_u_106, (copy) v_u_47, (copy) v_u_70, (copy) v_u_2, (copy) v_u_69
			if v_u_93:GetAttribute("Robux") then
				if v_u_71.DevProductId and v_u_71.DevProductId ~= 0 then
					local v107 = Instance.new("Sound")
					v107.SoundId = "rbxassetid://137731492025967"
					v107.Parent = v_u_19
					v107:Play()
					game:GetService("Debris"):AddItem(v107, 5)
					local v108, v109 = v_u_31:InvokeServer(v_u_71.DevProductId)
					if not v108 and v109 then
						v_u_10.Notify(v109, 3)
					end
				end
			else
				local v110 = v_u_100
				v_u_106()
				if v110 then
					v_u_47(v_u_70.Name)
					task.defer(function()
						-- upvalues: (ref) v_u_2, (ref) v_u_69
						local v111 = require(v_u_2.Tutorial.TutorialController).GetInstance()
						if v111 and not v111.Completed then
							if v_u_69 == "Carrot" and not v111.TasksCompleted.BoughtFirstSeed then
								v111:CompleteTask("BoughtFirstSeed")
								return
							end
							if not v111.TasksCompleted.BoughtNextSeed then
								v111:CompleteTask("BoughtNextSeed")
							end
						end
					end)
				end
			end
		end)
		v_u_93.MouseLeave:Connect(function()
			-- upvalues: (copy) v_u_106
			v_u_106()
		end)
		v_u_93:GetAttributeChangedSignal("Robux"):Connect(function()
			-- upvalues: (copy) v_u_93
			if v_u_93:GetAttribute("Robux") then
				v_u_93.Image = "rbxassetid://87553275013007"
				v_u_93.HoverImage = "rbxassetid://107011311707936"
				v_u_93.PressedImage = "rbxassetid://137100187853306"
			else
				v_u_93.Image = "rbxassetid://122264295069788"
				v_u_93.HoverImage = "rbxassetid://130636510940265"
				v_u_93.PressedImage = "rbxassetid://136340403955008"
			end
		end)
		v_u_94:GetAttributeChangedSignal("Robux"):Connect(function()
			-- upvalues: (copy) v_u_94
			if v_u_94:GetAttribute("Robux") then
				v_u_94.Image = "rbxassetid://75477531354755"
				v_u_94.HoverImage = "rbxassetid://126397457032598"
				v_u_94.PressedImage = "rbxassetid://136658938466586"
			else
				v_u_94.Image = "rbxassetid://74292943235840"
				v_u_94.HoverImage = "rbxassetid://82610052593615"
				v_u_94.PressedImage = "rbxassetid://81006866457458"
			end
		end)
		v_u_95:GetAttributeChangedSignal("Robux"):Connect(function()
			-- upvalues: (copy) v_u_95
			if v_u_95:GetAttribute("Robux") then
				v_u_95.Image = "rbxassetid://113575341580793"
				v_u_95.HoverImage = "rbxassetid://96238525071191"
				v_u_95.PressedImage = "rbxassetid://104743726543626"
			else
				v_u_95.Image = "rbxassetid://82138218952724"
				v_u_95.HoverImage = "rbxassetid://121013230790255"
				v_u_95.PressedImage = "rbxassetid://88736875800088"
			end
		end)
		v_u_94.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_94, (copy) v_u_9, (copy) v_u_69, (copy) v_u_13, (copy) v_u_33, (copy) v_u_32, (copy) v_u_71, (copy) v_u_10
			if v_u_94:GetAttribute("Robux") then
				v_u_33:GetPlayer(function(p112)
					-- upvalues: (ref) v_u_32, (ref) v_u_71, (ref) v_u_10
					if p112 then
						local v113, v114 = v_u_32:InvokeServer(v_u_71.GiftId, p112)
						if not v113 and v114 then
							v_u_10.Notify(v114, 3)
						end
					end
				end)
			else
				local v115 = v_u_9:IsDiscovered(v_u_69)
				v_u_13.Close()
				v_u_9:SetPage(v_u_69, true, true, not v115)
			end
		end)
	end
end
v16.Visible = false
v17.Visible = false
function v_u_13.Open()
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_12, (copy) v_u_13, (copy) v_u_5, (ref) v_u_22, (ref) v_u_23
	v_u_8:CloseAllExclusive("SeedShop")
	v_u_11.Enabled = true
	local v_u_116 = v_u_12:FindFirstChild("GetShopData")
	if v_u_116 and v_u_116:IsA("RemoteFunction") then
		task.spawn(function()
			-- upvalues: (copy) v_u_116, (ref) v_u_13
			local v117, v118 = pcall(function()
				-- upvalues: (ref) v_u_116
				return v_u_116:InvokeServer("SeedShop")
			end)
			if v117 and (v118 and typeof(v118) == "table") then
				v_u_13.RestockItems(v118)
			end
		end)
	end
	if v_u_5.Character and v_u_5.Character:FindFirstChild("HumanoidRootPart") then
		v_u_22 = v_u_5.Character.HumanoidRootPart.Position
	end
	v_u_23 = v_u_23 + 1
	local v_u_119 = v_u_23
	task.spawn(function()
		-- upvalues: (ref) v_u_11, (copy) v_u_119, (ref) v_u_23, (ref) v_u_5, (ref) v_u_22, (ref) v_u_13
		while v_u_11.Enabled and v_u_119 == v_u_23 do
			if v_u_5.Character and (v_u_5.Character:FindFirstChild("HumanoidRootPart") and (v_u_22 and (v_u_5.Character.HumanoidRootPart.Position - v_u_22).Magnitude > 7)) then
				v_u_13.Close()
				return
			end
			task.wait(0.2)
		end
	end)
end
function v_u_13.Close()
	-- upvalues: (copy) v_u_11, (ref) v_u_23, (ref) v_u_22, (copy) v_u_65
	v_u_11.Enabled = false
	v_u_23 = v_u_23 + 1
	v_u_22 = nil
	v_u_65()
end
function v_u_13.RestockItems(p120)
	-- upvalues: (copy) v_u_14
	if p120 and p120.Items then
		for _, v121 in v_u_14:GetChildren() do
			if v121.Name ~= "ItemTemplate" and (not string.find(v121.Name, "_Padding") and v121:IsA("Frame")) then
				local v122 = v121:FindFirstChild("MainInfo")
				if v122 then
					local v123 = v122:FindFirstChild("StockText")
					local v124 = v122:FindFirstChild("NoStock")
					local v125 = v121:GetAttribute("ShopItemName")
					if v125 and (p120.Items[v125] and p120.Items[v125].Amount > 0) then
						if v123 then
							v123.Text = p120.Items[v125].Amount .. "x"
						end
						if v124 then
							v124.Visible = false
						end
					else
						if v124 then
							v124.Visible = true
						end
						if v123 then
							v123.Text = "NO STOCK"
						end
					end
				end
			end
		end
	end
end
v_u_12:WaitForChild("OpenShop").OnClientEvent:Connect(function(p126, p127)
	-- upvalues: (copy) v_u_13, (copy) v_u_12
	if p126 == "SeedShop" then
		if p127 then
			v_u_13.RestockItems(p127)
		else
			local v_u_128 = v_u_12:FindFirstChild("GetShopData")
			if v_u_128 and v_u_128:IsA("RemoteFunction") then
				local v129, v130 = pcall(function()
					-- upvalues: (copy) v_u_128
					return v_u_128:InvokeServer("SeedShop")
				end)
				if v129 and (v130 and typeof(v130) == "table") then
					v_u_13.RestockItems(v130)
				end
			end
		end
		v_u_13.Open()
	end
end)
local v131 = require(v_u_2:WaitForChild("Update"):WaitForChild("UpdateService"))
local function v138()
	-- upvalues: (copy) v_u_68, (copy) v_u_7, (copy) v_u_12, (copy) v_u_13
	for v132, v133 in v_u_68 do
		local v134 = v_u_7.ShopData[v132]
		if v134 and v134.DisplayInShop ~= false then
			v133.Card.Visible = true
			v133.Padding.Visible = true
		end
	end
	local v_u_135 = v_u_12:FindFirstChild("GetShopData")
	if v_u_135 and v_u_135:IsA("RemoteFunction") then
		task.spawn(function()
			-- upvalues: (copy) v_u_135, (ref) v_u_13
			local v136, v137 = pcall(function()
				-- upvalues: (ref) v_u_135
				return v_u_135:InvokeServer("SeedShop")
			end)
			if v136 and (v137 and typeof(v137) == "table") then
				v_u_13.RestockItems(v137)
			end
		end)
	end
end
v131.OnUpdate:Connect(v138)
if v131:IsUpdateLive() and next(v_u_68) then
	v138()
end
return v_u_13