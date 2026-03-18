local v_u_1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
game:GetService("UserInputService")
local v_u_4 = game:GetService("MarketplaceService")
local v_u_5 = v3.LocalPlayer
local v6 = require(v2.Gears.Definitions.GearDefinitions)
local v_u_7 = require(v2.Shop.ShopData.GearShopData)
local v_u_8 = require(v2:WaitForChild("UI"):WaitForChild("UIManager"))
local v_u_9 = require(v2:WaitForChild("Player"):WaitForChild("NotificationService"))
local v_u_10 = v_u_5:WaitForChild("PlayerGui"):WaitForChild("GearShop")
local v_u_11 = v2:WaitForChild("RemoteEvents")
local v_u_12 = {}
local v_u_13 = v_u_10:WaitForChild("Frame"):WaitForChild("ScrollingFrame")
local v_u_14 = v_u_10:WaitForChild("Frame"):WaitForChild("TopBar")
local v15 = v_u_13:WaitForChild("ItemTemplate")
local v16 = v_u_13:WaitForChild("ItemTemplate_Padding")
local v17 = require(v2.Plants.Definitions.TierHelper)
local v_u_18 = game:GetService("SoundService")
local v_u_19 = v_u_18:WaitForChild("SFX"):WaitForChild("UI")
local v_u_20 = require(v2.Economy.Formatter.NumberFormatter)
local v_u_21 = nil
local v_u_22 = 0
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = {}
v_u_14:WaitForChild("Close").MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_12
	v_u_12.Close()
end)
local v_u_26 = UDim2.new(1, 0, 0.155, 0)
local v_u_27 = UDim2.new(1, 0, 0.03, 0)
local v_u_28 = UDim2.new(0.5, 0, 0.5, 0)
local v_u_29 = UDim2.new(0.5, 0, 1.04, 0)
local v_u_30 = v2:WaitForChild("RemoteEvents"):WaitForChild("PurchaseShopItem")
local v_u_31 = v2:WaitForChild("RemoteEvents"):WaitForChild("PurchaseDevProduct")
local v_u_32 = v2:WaitForChild("RemoteEvents"):WaitForChild("PurchaseGiftDevProduct")
local v_u_33 = require(v2.Shop.GiftModalController)
v_u_4.PromptProductPurchaseFinished:Connect(function(_, _, p34)
	-- upvalues: (copy) v_u_19, (copy) v_u_33
	if p34 then
		local v35 = v_u_19:WaitForChild("Buying")
		v35.PlaybackSpeed = math.random(90, 110) / 100
		v35:Play()
	end
	v_u_33:Close()
end)
local v_u_36 = false
local v_u_37 = 0
local function v_u_47(p_u_38)
	-- upvalues: (ref) v_u_36, (ref) v_u_37, (copy) v_u_13, (copy) v_u_9, (copy) v_u_30, (copy) v_u_12, (copy) v_u_19
	if v_u_36 then
		if os.clock() - v_u_37 <= 5 then
			return
		end
		v_u_36 = false
	end
	local v39 = nil
	for _, v40 in ipairs(v_u_13:GetChildren()) do
		if v40:GetAttribute("ShopItemName") == p_u_38 then
			v39 = v40
			break
		end
	end
	if v39 then
		local v41 = v39:FindFirstChild("MainInfo")
		if v41 and (v41:FindFirstChild("NoStock") and v41.NoStock.Visible) then
			v_u_9.Notify("This gear is currently out of stock!", 3)
			return false
		end
	end
	if v_u_30 then
		v_u_36 = true
		v_u_37 = os.clock()
		v_u_12.IsPurchasing = true
		local v42, v43, v44 = pcall(function()
			-- upvalues: (ref) v_u_30, (copy) p_u_38
			return v_u_30:InvokeServer("GearShop", p_u_38)
		end)
		if v42 and (v43 and typeof(v43) == "table") then
			local v45 = v_u_19:WaitForChild("Buying")
			v45.PlaybackSpeed = math.random(90, 110) / 100
			v45:Play()
			v_u_12.RestockItems(v43)
		elseif v42 and not v43 then
			local v46 = v_u_19:FindFirstChild("FailedPurchase")
			if v46 then
				v46:Play()
			end
			if v44 == "Not enough shillings" then
				v_u_9.Notify("You do not have enough to purchase this!", 3)
			else
				v_u_9.Notify("Purchase failed! Reason: " .. v44, 3)
				print("[SeedShopController] Seed purchase failed: " .. v44)
			end
		end
		task.wait(0.03)
		v_u_36 = false
		task.defer(function()
			-- upvalues: (ref) v_u_12
			v_u_12.IsPurchasing = false
		end)
		return v43
	end
	warn("Buy remote not found!")
end
task.spawn(function()
	-- upvalues: (copy) v_u_10, (copy) v_u_14
	while true do
		if v_u_10.Enabled then
			local v48 = 300 - workspace:GetServerTimeNow() % 300
			local v49 = math.ceil(v48)
			local v50 = math.min(v49, 300)
			local v51 = v_u_14:WaitForChild("Timer")
			local v52 = string.format
			local v53 = v50 / 60
			v51.Text = v52("%d:%02d", math.floor(v53), v50 % 60)
		end
		task.wait(1)
	end
end)
workspace:GetAttributeChangedSignal("GearShop"):Connect(function()
	-- upvalues: (copy) v_u_14, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12
	local v54 = 300 - workspace:GetServerTimeNow() % 300
	local v55 = math.ceil(v54)
	local v56 = math.min(v55, 300)
	local v57 = v_u_14:WaitForChild("Timer")
	local v58 = string.format
	local v59 = v56 / 60
	v57.Text = v58("%d:%02d", math.floor(v59), v56 % 60)
	if v_u_10.Enabled then
		local v_u_60 = v_u_11:FindFirstChild("GetShopData")
		if v_u_60 and v_u_60:IsA("RemoteFunction") then
			task.spawn(function()
				-- upvalues: (copy) v_u_60, (ref) v_u_12
				local v61, v62 = pcall(function()
					-- upvalues: (ref) v_u_60
					return v_u_60:InvokeServer("GearShop")
				end)
				if v61 and (v62 and typeof(v62) == "table") then
					v_u_12.RestockItems(v62)
				end
			end)
		end
	end
end)
local function v_u_66()
	-- upvalues: (ref) v_u_23, (copy) v_u_1, (ref) v_u_24, (copy) v_u_27, (copy) v_u_28, (copy) v_u_25
	if v_u_23 then
		local v63 = {
			["Size"] = v_u_27
		}
		v_u_1:Create(v_u_24, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v63):Play()
		local v64 = {
			["Position"] = v_u_28
		}
		v_u_1:Create(v_u_23, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v64):Play()
		v_u_23 = nil
		v_u_24 = nil
	end
	for _, v65 in v_u_25 do
		v65()
	end
end
v_u_10:GetPropertyChangedSignal("Enabled"):Connect(function()
	-- upvalues: (copy) v_u_10, (ref) v_u_22, (ref) v_u_21, (copy) v_u_66
	if not v_u_10.Enabled then
		v_u_22 = v_u_22 + 1
		v_u_21 = nil
		v_u_66()
	end
end)
local v_u_67 = v_u_22
local v_u_68 = v_u_21
local v_u_69 = v_u_24
local v_u_70 = v_u_23
local v_u_71 = {}
for v_u_72, v_u_73 in pairs(v_u_7.ShopData) do
	local v_u_74 = v6.Gears[v_u_72]
	if v_u_74 then
		local v75 = v15:Clone()
		v75.Name = v_u_72
		v75:SetAttribute("ShopItemName", v_u_73.Name)
		v75.LayoutOrder = v_u_73.LayoutOrder
		v75.Visible = true
		v75.Parent = v_u_13
		local v_u_76 = v16:Clone()
		v_u_76.Name = v_u_72 .. "_Padding"
		v_u_76.LayoutOrder = v_u_73.LayoutOrder + 0.5
		v_u_76.Visible = true
		v_u_76.Parent = v_u_13
		if v_u_73.DisplayInShop == false then
			v75.Visible = false
			v_u_76.Visible = false
			v_u_71[v_u_72] = {
				["Card"] = v75,
				["Padding"] = v_u_76
			}
		end
		local v77 = v75:WaitForChild("MainInfo")
		local v_u_78 = v77:WaitForChild("InfoText")
		local v_u_79 = v77:WaitForChild("StockText")
		local v_u_80 = v77:WaitForChild("PriceText")
		local v_u_81 = v77:WaitForChild("Rarity")
		local v_u_82 = v77:WaitForChild("Stars")
		local v_u_83 = v77:WaitForChild("NoStock")
		v_u_78.Text = v_u_74.GearDescription
		v_u_78.Visible = false
		local v_u_84 = false
		v_u_79.Text = "..."
		v_u_83.Visible = true
		v77:WaitForChild("GearName").Text = v_u_73.Name
		v77:WaitForChild("GearNameShadow").Text = v_u_73.Name
		v77:WaitForChild("GearBox"):WaitForChild("ImageWrapper"):WaitForChild("GearImage").Image = v_u_74.IconAssetId
		v_u_80.Text = "$" .. v_u_20:FormatNumberShort(v_u_73.Price)
		v_u_81.Image = v17:GetImage(v_u_74.Rarity)
		local v85 = v17:GetStars(v_u_74.Rarity)
		local v86 = v85.Color
		local v87 = v_u_82:WaitForChild("Star")
		if v86 == "Bronze" then
			v87.Image = "rbxassetid://75963437560225"
		elseif v86 == "Silver" then
			v87.Image = "rbxassetid://104552524366406"
		end
		v87.Visible = false
		for _ = 1, v85.Number do
			local v88 = v87:Clone()
			v88.Visible = true
			v88.Parent = v_u_82
		end
		local v_u_89 = v75:WaitForChild("ButtonRow")
		v77.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_70, (copy) v_u_89, (copy) v_u_66, (copy) v_u_1, (copy) v_u_76, (copy) v_u_26, (copy) v_u_29, (ref) v_u_69
			local v90 = v_u_70 == v_u_89
			v_u_66()
			if not v90 then
				local v91 = {
					["Size"] = v_u_26
				}
				v_u_1:Create(v_u_76, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v91):Play()
				local v92 = {
					["Position"] = v_u_29
				}
				v_u_1:Create(v_u_89, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), v92):Play()
				v_u_70 = v_u_89
				v_u_69 = v_u_76
			end
		end)
		local v_u_93 = false
		local v_u_94 = v_u_89:WaitForChild("Buy")
		local v_u_95 = v_u_89:WaitForChild("Info")
		local v_u_96 = v_u_89:WaitForChild("Swap")
		v_u_94:SetAttribute("SkipClickSound", true)
		table.insert(v_u_25, function()
			-- upvalues: (ref) v_u_84, (copy) v_u_78, (copy) v_u_82, (copy) v_u_79, (copy) v_u_80, (copy) v_u_81, (copy) v_u_83
			v_u_84 = false
			v_u_78.Visible = false
			v_u_82.Visible = true
			v_u_79.Visible = true
			v_u_80.Visible = true
			v_u_81.Visible = true
			if v_u_79.Text == "NO STOCK" or v_u_79.Text == "..." then
				v_u_83.Visible = true
			end
		end)
		v_u_96.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_84, (copy) v_u_78, (copy) v_u_82, (copy) v_u_79, (copy) v_u_80, (copy) v_u_81, (copy) v_u_83, (ref) v_u_93, (copy) v_u_94, (copy) v_u_95, (copy) v_u_96, (copy) v_u_20, (copy) v_u_73, (copy) v_u_74, (copy) v_u_72, (copy) v_u_4
			v_u_84 = false
			v_u_78.Visible = false
			v_u_82.Visible = true
			v_u_79.Visible = true
			v_u_80.Visible = true
			v_u_81.Visible = true
			if v_u_79.Text == "NO STOCK" or v_u_79.Text == "..." then
				v_u_83.Visible = true
			end
			if v_u_93 then
				v_u_94:SetAttribute("Robux", false)
				v_u_95:SetAttribute("Robux", false)
				v_u_96:SetAttribute("Robux", false)
				v_u_80.Text = "$" .. v_u_20:FormatNumberShort(v_u_73.Price)
				v_u_93 = false
				return
			elseif v_u_74.DevProductId and v_u_74.DevProductId ~= 0 then
				v_u_94:SetAttribute("Robux", true)
				v_u_95:SetAttribute("Robux", true)
				v_u_96:SetAttribute("Robux", true)
				local v97, v98 = pcall(function()
					-- upvalues: (ref) v_u_4, (ref) v_u_74
					return v_u_4:GetProductInfoAsync(v_u_74.DevProductId, Enum.InfoType.Product)
				end)
				if v97 and v98 then
					v_u_80.Text = "R$" .. (v98.PriceInRobux or "???")
				else
					v_u_80.Text = "R$???"
				end
				v_u_93 = true
			else
				warn("[GearShopController] No valid DevProductId for " .. v_u_72)
			end
		end)
		local v_u_99 = nil
		local v_u_100 = nil
		local v_u_101 = false
		local v_u_102 = false
		local function v_u_106()
			-- upvalues: (ref) v_u_102, (copy) v_u_79, (copy) v_u_47, (copy) v_u_73
			v_u_102 = true
			local v103 = string.match
			local v104 = v_u_79.Text
			local v105 = tonumber(v103(v104, "%d+")) or 0
			if v105 > 0 then
				for _ = 1, v105 do
					if not (v_u_102 and v_u_47(v_u_73.Name)) then
						break
					end
					task.wait(0.01)
				end
			end
			v_u_102 = false
		end
		local function v_u_107()
			-- upvalues: (ref) v_u_101, (ref) v_u_102, (ref) v_u_99, (ref) v_u_100, (copy) v_u_1, (copy) v_u_94
			v_u_101 = false
			v_u_102 = false
			if v_u_99 then
				task.cancel(v_u_99)
				v_u_99 = nil
			end
			if v_u_100 then
				v_u_100:Cancel()
				v_u_100 = nil
			end
			v_u_1:Create(v_u_94, TweenInfo.new(0.1), {
				["ImageColor3"] = Color3.fromRGB(255, 255, 255)
			}):Play()
		end
		v_u_94.MouseButton1Down:Connect(function()
			-- upvalues: (copy) v_u_94, (copy) v_u_107, (ref) v_u_101, (ref) v_u_100, (copy) v_u_1, (ref) v_u_99, (copy) v_u_106
			if not v_u_94:GetAttribute("Robux") then
				v_u_107()
				v_u_101 = true
				v_u_100 = v_u_1:Create(v_u_94, TweenInfo.new(1, Enum.EasingStyle.Linear), {
					["ImageColor3"] = Color3.fromRGB(150, 150, 150)
				})
				v_u_100:Play()
				v_u_99 = task.delay(1, function()
					-- upvalues: (ref) v_u_101, (ref) v_u_99, (ref) v_u_106, (ref) v_u_1, (ref) v_u_94
					if v_u_101 then
						v_u_101 = false
						v_u_99 = nil
						v_u_106()
						v_u_1:Create(v_u_94, TweenInfo.new(0.1), {
							["ImageColor3"] = Color3.fromRGB(255, 255, 255)
						}):Play()
					end
				end)
			end
		end)
		v_u_94.MouseButton1Up:Connect(function()
			-- upvalues: (copy) v_u_94, (copy) v_u_74, (copy) v_u_18, (copy) v_u_31, (copy) v_u_9, (ref) v_u_101, (copy) v_u_107, (copy) v_u_47, (copy) v_u_73
			if v_u_94:GetAttribute("Robux") then
				if v_u_74.DevProductId and v_u_74.DevProductId ~= 0 then
					local v108 = Instance.new("Sound")
					v108.SoundId = "rbxassetid://137731492025967"
					v108.Parent = v_u_18
					v108:Play()
					game:GetService("Debris"):AddItem(v108, 5)
					local v109, v110 = v_u_31:InvokeServer(v_u_74.DevProductId)
					if not v109 and v110 then
						v_u_9.Notify(v110, 3)
					end
				end
			else
				local v111 = v_u_101
				v_u_107()
				if v111 then
					v_u_47(v_u_73.Name)
				end
			end
		end)
		v_u_94.MouseLeave:Connect(function()
			-- upvalues: (copy) v_u_107
			v_u_107()
		end)
		v_u_94:GetAttributeChangedSignal("Robux"):Connect(function()
			-- upvalues: (copy) v_u_94
			if v_u_94:GetAttribute("Robux") then
				v_u_94.Image = "rbxassetid://87553275013007"
				v_u_94.HoverImage = "rbxassetid://107011311707936"
				v_u_94.PressedImage = "rbxassetid://137100187853306"
			else
				v_u_94.Image = "rbxassetid://122264295069788"
				v_u_94.HoverImage = "rbxassetid://130636510940265"
				v_u_94.PressedImage = "rbxassetid://136340403955008"
			end
		end)
		v_u_95:GetAttributeChangedSignal("Robux"):Connect(function()
			-- upvalues: (copy) v_u_95
			if v_u_95:GetAttribute("Robux") then
				v_u_95.Image = "rbxassetid://75477531354755"
				v_u_95.HoverImage = "rbxassetid://126397457032598"
				v_u_95.PressedImage = "rbxassetid://136658938466586"
			else
				v_u_95.Image = "rbxassetid://74292943235840"
				v_u_95.HoverImage = "rbxassetid://82610052593615"
				v_u_95.PressedImage = "rbxassetid://81006866457458"
			end
		end)
		v_u_96:GetAttributeChangedSignal("Robux"):Connect(function()
			-- upvalues: (copy) v_u_96
			if v_u_96:GetAttribute("Robux") then
				v_u_96.Image = "rbxassetid://113575341580793"
				v_u_96.HoverImage = "rbxassetid://96238525071191"
				v_u_96.PressedImage = "rbxassetid://104743726543626"
			else
				v_u_96.Image = "rbxassetid://82138218952724"
				v_u_96.HoverImage = "rbxassetid://121013230790255"
				v_u_96.PressedImage = "rbxassetid://88736875800088"
			end
		end)
		v_u_95.MouseButton1Click:Connect(function()
			-- upvalues: (copy) v_u_95, (copy) v_u_12, (copy) v_u_33, (copy) v_u_32, (copy) v_u_74, (copy) v_u_9, (ref) v_u_84, (copy) v_u_82, (copy) v_u_79, (copy) v_u_80, (copy) v_u_81, (copy) v_u_78, (copy) v_u_83
			if v_u_95:GetAttribute("Robux") then
				v_u_12.Close()
				v_u_33:GetPlayer(function(p112)
					-- upvalues: (ref) v_u_32, (ref) v_u_74, (ref) v_u_9
					if p112 then
						local v113, v114 = v_u_32:InvokeServer(v_u_74.GiftId, p112)
						if not v113 and v114 then
							v_u_9.Notify(v114, 3)
						end
					end
				end)
				return
			else
				v_u_84 = not v_u_84
				v_u_82.Visible = not v_u_84
				v_u_79.Visible = not v_u_84
				v_u_80.Visible = not v_u_84
				v_u_81.Visible = not v_u_84
				v_u_78.Visible = v_u_84
				if v_u_84 then
					v_u_83.Visible = false
				elseif v_u_79.Text == "NO STOCK" or v_u_79.Text == "..." then
					v_u_83.Visible = true
				end
			end
		end)
	end
end
v15.Visible = false
v16.Visible = false
function v_u_12.Open()
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12, (copy) v_u_5, (ref) v_u_68, (ref) v_u_67
	v_u_8:CloseAllExclusive("GearShop")
	v_u_10.Enabled = true
	local v_u_115 = v_u_11:FindFirstChild("GetShopData")
	if v_u_115 and v_u_115:IsA("RemoteFunction") then
		task.spawn(function()
			-- upvalues: (copy) v_u_115, (ref) v_u_12
			local v116, v117 = pcall(function()
				-- upvalues: (ref) v_u_115
				return v_u_115:InvokeServer("GearShop")
			end)
			if v116 and (v117 and typeof(v117) == "table") then
				v_u_12.RestockItems(v117)
			end
		end)
	end
	if v_u_5.Character and v_u_5.Character:FindFirstChild("HumanoidRootPart") then
		v_u_68 = v_u_5.Character.HumanoidRootPart.Position
	end
	v_u_67 = v_u_67 + 1
	local v_u_118 = v_u_67
	task.spawn(function()
		-- upvalues: (ref) v_u_10, (copy) v_u_118, (ref) v_u_67, (ref) v_u_5, (ref) v_u_68, (ref) v_u_12
		while v_u_10.Enabled and v_u_118 == v_u_67 do
			if v_u_5.Character and (v_u_5.Character:FindFirstChild("HumanoidRootPart") and (v_u_68 and (v_u_5.Character.HumanoidRootPart.Position - v_u_68).Magnitude > 7)) then
				v_u_12.Close()
				return
			end
			task.wait(0.2)
		end
	end)
end
function v_u_12.Close()
	-- upvalues: (copy) v_u_10, (ref) v_u_67, (ref) v_u_68, (copy) v_u_66, (copy) v_u_25
	v_u_10.Enabled = false
	v_u_67 = v_u_67 + 1
	v_u_68 = nil
	v_u_66()
	for _, v119 in v_u_25 do
		v119()
	end
end
function v_u_12.RestockItems(p120)
	-- upvalues: (copy) v_u_13
	if p120 and p120.Items then
		for _, v121 in v_u_13:GetChildren() do
			if v121.Name ~= "ItemTemplate" and (not string.find(v121.Name, "_Padding") and v121:IsA("Frame")) then
				local v122 = v121:FindFirstChild("MainInfo")
				if v122 then
					local v123 = v122:FindFirstChild("StockText")
					local v124 = v122:FindFirstChild("NoStock")
					local v125 = v122:FindFirstChild("InfoText")
					local v126 = v121:GetAttribute("ShopItemName")
					if v126 and (p120.Items[v126] and p120.Items[v126].Amount > 0) then
						if v123 then
							v123.Text = p120.Items[v126].Amount .. "x"
						end
						if v124 then
							v124.Visible = not v125.Visible and false
						end
					else
						if v123 then
							v123.Text = "NO STOCK"
						end
						if v124 then
							v124.Visible = not v125.Visible and true
						end
					end
				end
			end
		end
	end
end
v_u_11:WaitForChild("OpenShop").OnClientEvent:Connect(function(p127, p128)
	-- upvalues: (copy) v_u_12, (copy) v_u_11
	if p127 == "GearShop" then
		if p128 then
			v_u_12.RestockItems(p128)
		else
			local v_u_129 = v_u_11:FindFirstChild("GetShopData")
			if v_u_129 and v_u_129:IsA("RemoteFunction") then
				local v130, v131 = pcall(function()
					-- upvalues: (copy) v_u_129
					return v_u_129:InvokeServer("GearShop")
				end)
				if v130 and (v131 and typeof(v131) == "table") then
					v_u_12.RestockItems(v131)
				end
			end
		end
		v_u_12.Open()
	end
end)
local v132 = require(v2:WaitForChild("Update"):WaitForChild("UpdateService"))
local function v139()
	-- upvalues: (copy) v_u_71, (copy) v_u_7, (copy) v_u_11, (copy) v_u_12
	for v133, v134 in v_u_71 do
		local v135 = v_u_7.ShopData[v133]
		if v135 and v135.DisplayInShop ~= false then
			v134.Card.Visible = true
			v134.Padding.Visible = true
		end
	end
	local v_u_136 = v_u_11:FindFirstChild("GetShopData")
	if v_u_136 and v_u_136:IsA("RemoteFunction") then
		task.spawn(function()
			-- upvalues: (copy) v_u_136, (ref) v_u_12
			local v137, v138 = pcall(function()
				-- upvalues: (ref) v_u_136
				return v_u_136:InvokeServer("GearShop")
			end)
			if v137 and (v138 and typeof(v138) == "table") then
				v_u_12.RestockItems(v138)
			end
		end)
	end
end
v132.OnUpdate:Connect(v139)
if v132:IsUpdateLive() and next(v_u_71) then
	v139()
end
return v_u_12