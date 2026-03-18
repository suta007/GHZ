local v_u_1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("MarketplaceService")
local v_u_5 = game:GetService("ContentProvider")
local v_u_6 = game:GetService("RunService")
local v_u_7 = require(v2.Economy.Formatter.NumberFormatter)
local v8 = require(v2.RNGPacks.SeedPackDefinitions)
local v_u_9 = require(v2.Shop.Definitions.RobuxShopDefinitions)
local v_u_10 = require(v2.Shop.Definitions.DevProductDefinitions)
local v_u_11 = require(v2.Gamepasses.GamepassDefinitions)
local v_u_12 = require(v2.Plants.Definitions.PlantDataDefinitions)
local v_u_13 = require(v2.Plants.Definitions.TierHelper)
local v_u_14 = require(v2:WaitForChild("Player"):WaitForChild("NotificationService"))
local v_u_15 = game:GetService("PolicyService")
local v_u_16 = v3.LocalPlayer
local v_u_17 = v_u_16:WaitForChild("PlayerGui"):WaitForChild("RobuxShop")
local v_u_18 = v_u_17:WaitForChild("Frame"):WaitForChild("MainContent")
local v_u_19 = game:GetService("SoundService")
local v_u_20 = v_u_19:WaitForChild("SFX"):WaitForChild("UI")
local v_u_21 = v2:WaitForChild("RemoteEvents"):WaitForChild("PurchaseDevProduct")
local v_u_22 = v2:WaitForChild("RemoteEvents"):WaitForChild("PurchaseGiftDevProduct")
local v_u_23 = require(v2.Shop.GiftModalController)
local v_u_24 = {}
v_u_4.PromptProductPurchaseFinished:Connect(function(_, _, p25)
	-- upvalues: (copy) v_u_20, (copy) v_u_23
	if p25 then
		local v26 = v_u_20:WaitForChild("Buying")
		v26.PlaybackSpeed = math.random(90, 110) / 100
		v26:Play()
	end
	v_u_23:Close()
end)
local v_u_27 = {
	["Silver"] = "rbxassetid://104552524366406",
	["Bronze"] = "rbxassetid://75963437560225"
}
local function v_u_36(p28)
	local v29 = p28:gsub("#", "")
	local v30 = v29:sub(1, 2)
	local v31 = tonumber(v30, 16)
	local v32 = v29:sub(3, 4)
	local v33 = tonumber(v32, 16)
	local v34 = v29:sub(5, 6)
	local v35 = tonumber(v34, 16)
	if v31 and (v33 and v35) then
		return Color3.fromRGB(v31, v33, v35)
	else
		return nil
	end
end
local function v104(p37, p38)
	-- upvalues: (copy) v_u_9, (copy) v_u_18, (copy) v_u_16, (copy) v_u_12, (copy) v_u_13, (copy) v_u_27, (copy) v_u_6, (copy) v_u_5, (copy) v_u_36, (copy) v_u_1, (copy) v_u_10, (copy) v_u_4, (copy) v_u_19, (copy) v_u_21, (copy) v_u_14, (copy) v_u_24, (copy) v_u_23, (copy) v_u_22, (copy) v_u_7
	local v_u_39 = v_u_9[p37]
	if v_u_39 then
		local v40 = workspace:GetServerTimeNow()
		local v41 = math.floor(v40)
		if v_u_39.StartTime and v41 < v_u_39.StartTime then
			while true do
				local v42 = v_u_39.StartTime
				local v43 = workspace:GetServerTimeNow()
				local v44 = v42 - math.floor(v43)
				if v44 > 0 then
					task.wait((math.min(v44, 60)))
				end
				local v45 = workspace:GetServerTimeNow()
				if math.floor(v45) >= v_u_39.StartTime then
					goto l4
				end
			end
		end
		::l4::
		if v_u_39.EndTime then
			local v46 = workspace:GetServerTimeNow()
			if math.floor(v46) >= v_u_39.EndTime then
				return
			end
		end
	end
	local v_u_47 = v_u_18:WaitForChild("SeedPackTemplate"):Clone()
	v_u_47.Parent = v_u_18
	v_u_47.Name = p37
	v_u_47.LayoutOrder = v_u_39.LayoutOrder
	local v_u_48 = v_u_47:WaitForChild("HoverTooltip")
	local v_u_49 = nil
	local v_u_50 = v_u_16:GetMouse()
	local function v_u_58(p51, p52)
		-- upvalues: (ref) v_u_12, (ref) v_u_13, (copy) v_u_48, (ref) v_u_27, (ref) v_u_49, (ref) v_u_6, (copy) v_u_50
		local v53 = v_u_13:GetStars(v_u_12[p51].Rarity)
		local v54 = v_u_48:WaitForChild("StarContainer")
		for _, v55 in ipairs(v54:GetChildren()) do
			if v55:IsA("ImageLabel") then
				v55:Destroy()
			end
		end
		for _ = 1, v53.Number do
			local v56 = Instance.new("ImageLabel")
			v56.BackgroundTransparency = 1
			v56.Size = UDim2.new(0.2, 0, 1, 0)
			v56.Image = v_u_27[v53.Color] or v_u_27.Bronze
			Instance.new("UIAspectRatioConstraint").Parent = v56
			v56.Parent = v54
		end
		v_u_48:WaitForChild("SeedName").Text = p51
		v_u_48:WaitForChild("SeedOdds").Text = p52 .. "%"
		v_u_48.Visible = true
		if v_u_49 then
			v_u_49:Disconnect()
		end
		v_u_49 = v_u_6.RenderStepped:Connect(function()
			-- upvalues: (ref) v_u_48, (ref) v_u_49, (ref) v_u_50
			if v_u_48 and v_u_48.Parent then
				local v57 = v_u_48.Parent.AbsolutePosition
				v_u_48.Position = UDim2.fromOffset(v_u_50.X - v57.X - 10, v_u_50.Y - v57.Y + 20)
			elseif v_u_49 then
				v_u_49:Disconnect()
				v_u_49 = nil
			end
		end)
	end
	if v_u_39 and (v_u_39.BackgroundImage and v_u_39.BackgroundImage ~= "") then
		local v_u_59 = v_u_47.Image
		v_u_47.Image = v_u_39.BackgroundImage
		task.spawn(function()
			-- upvalues: (ref) v_u_5, (copy) v_u_39, (copy) v_u_47, (copy) v_u_59
			local v_u_60 = true
			pcall(function()
				-- upvalues: (ref) v_u_5, (ref) v_u_39, (ref) v_u_60
				v_u_5:PreloadAsync({ v_u_39.BackgroundImage }, function(_, p61)
					-- upvalues: (ref) v_u_60
					if p61 == Enum.AssetFetchStatus.Failure then
						v_u_60 = false
					end
				end)
			end)
			if not v_u_60 then
				v_u_47.Image = v_u_59
			end
		end)
	end
	local v_u_62
	if v_u_39 and (v_u_39.UIStroke and v_u_39.UIStroke ~= "") then
		local v63 = v_u_36(v_u_39.UIStroke)
		if v63 then
			v_u_62 = v_u_49
			for _, v64 in { v_u_47:WaitForChild("Header"), v_u_47:WaitForChild("LeavingIn"), v_u_47:WaitForChild("Timer") } do
				local v65 = v64:FindFirstChild("UIStroke")
				if v65 then
					v65.Color = v63
				end
			end
		else
			v_u_62 = v_u_49
		end
	else
		v_u_62 = v_u_49
	end
	local v66 = v_u_47:WaitForChild("SeedShowcase")
	local v67 = v66:WaitForChild("ItemTemplate")
	if v_u_39 and (v_u_39.ItemBackground and v_u_39.ItemBackground ~= "") then
		local v68 = v67.Image
		v67.Image = v_u_39.ItemBackground
		local v_u_69 = true
		pcall(function()
			-- upvalues: (ref) v_u_5, (copy) v_u_39, (ref) v_u_69
			v_u_5:PreloadAsync({ v_u_39.ItemBackground }, function(_, p70)
				-- upvalues: (ref) v_u_69
				if p70 == Enum.AssetFetchStatus.Failure then
					v_u_69 = false
				end
			end)
		end)
		if not v_u_69 then
			v67.Image = v68
		end
	end
	v_u_47:WaitForChild("Header").Text = p38.DisplayName
	for _, v_u_71 in p38.LootPool do
		local v72 = v67:Clone()
		v72.Parent = v66
		v72.Name = v_u_71.RewardId
		v72:WaitForChild("Odds").Text = v_u_71.Chance .. "%"
		v72.LayoutOrder = v_u_71.LayoutOrder
		if v_u_71.Type == "Seed" then
			v72:WaitForChild("ItemImage").Image = v_u_12[v_u_71.RewardId].SeedAssetId or ""
		end
		if v_u_71.Rare then
			local v73 = v72:WaitForChild("RareStroke")
			v73.Enabled = true
			local v74 = v72:WaitForChild("HighlightHolder"):WaitForChild("RareHighlight")
			v74.Visible = true
			v72:WaitForChild("Odds").TextColor3 = Color3.fromRGB(255, 255, 0)
			local v75 = TweenInfo.new(17, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, false)
			v_u_1:Create(v73:WaitForChild("UIGradient"), v75, {
				["Rotation"] = 360
			}):Play()
			v_u_1:Create(v74, v75, {
				["Rotation"] = 360
			}):Play()
		end
		v72.MouseEnter:Connect(function()
			-- upvalues: (copy) v_u_58, (copy) v_u_71
			v_u_58(v_u_71.RewardId, v_u_71.Chance)
		end)
		v72.MouseLeave:Connect(function()
			-- upvalues: (copy) v_u_48, (ref) v_u_62
			v_u_48.Visible = false
			if v_u_62 then
				v_u_62:Disconnect()
				v_u_62 = nil
			end
		end)
		v72.Visible = true
	end
	v67.Visible = false
	local v_u_76 = v_u_47:WaitForChild("SeedPack")
	if v_u_39 and (v_u_39.SeedPack and v_u_39.SeedPack ~= "") then
		local _ = v_u_76.Image
		v_u_76.Image = v_u_39.SeedPack
		task.spawn(function()
			-- upvalues: (ref) v_u_5, (copy) v_u_39, (copy) v_u_76
			local v_u_77 = true
			pcall(function()
				-- upvalues: (ref) v_u_5, (ref) v_u_39, (ref) v_u_77
				v_u_5:PreloadAsync({ v_u_39.SeedPack }, function(_, p78)
					-- upvalues: (ref) v_u_77
					if p78 == Enum.AssetFetchStatus.Failure then
						v_u_77 = false
					end
				end)
			end)
			if not v_u_77 then
				v_u_76.Visible = false
			end
		end)
	else
		v_u_76.Image = p38.Icon or ""
	end
	local v79 = v_u_10.PackTiers[p37]
	if v79 then
		for v80, v_u_81 in pairs(v79) do
			local v_u_82 = v_u_47:FindFirstChild("Buy" .. v80)
			if v_u_82 then
				v_u_82.Visible = true
				task.spawn(function()
					-- upvalues: (ref) v_u_4, (copy) v_u_81, (copy) v_u_82
					local v83, v84 = pcall(function()
						-- upvalues: (ref) v_u_4, (ref) v_u_81
						return v_u_4:GetProductInfoAsync(v_u_81.DevProductId, Enum.InfoType.Product)
					end)
					if v83 and v84 then
						v_u_82:WaitForChild("Buy").Text = ("<font size=\"20\"><font weight=\"100\"></font>%*%*</font>"):format(utf8.char(57346), v84.PriceInRobux)
					end
				end)
				v_u_82.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_19, (ref) v_u_21, (copy) v_u_81, (ref) v_u_14
					local v_u_85 = Instance.new("Sound")
					v_u_85.SoundId = "rbxassetid://137731492025967"
					v_u_85.Parent = v_u_19
					v_u_85:Play()
					v_u_85.Ended:Connect(function()
						-- upvalues: (copy) v_u_85
						v_u_85:Destroy()
					end)
					local v86, v87 = v_u_21:InvokeServer(v_u_81.DevProductId)
					if not v86 and v87 then
						v_u_14.Notify(v87, 3)
					end
				end)
			end
			local v_u_88 = v_u_47:FindFirstChild("Gift" .. v80)
			if v_u_88 and v_u_81.GiftDevProductId then
				v_u_88.Visible = true
				task.spawn(function()
					-- upvalues: (ref) v_u_4, (copy) v_u_81, (copy) v_u_88
					local v89, v90 = pcall(function()
						-- upvalues: (ref) v_u_4, (ref) v_u_81
						return v_u_4:GetProductInfoAsync(v_u_81.GiftDevProductId, Enum.InfoType.Product)
					end)
					local v91 = v_u_88:FindFirstChild("Buy")
					if v89 and (v90 and v91) then
						v91.Text = ("<font size=\"20\"><font weight=\"100\"></font>%*%*</font>"):format(utf8.char(57346), v90.PriceInRobux)
					end
				end)
				v_u_88.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_19, (ref) v_u_24, (ref) v_u_23, (ref) v_u_22, (copy) v_u_81, (ref) v_u_14
					local v_u_92 = Instance.new("Sound")
					v_u_92.SoundId = "rbxassetid://137731492025967"
					v_u_92.Parent = v_u_19
					v_u_92:Play()
					v_u_92.Ended:Connect(function()
						-- upvalues: (copy) v_u_92
						v_u_92:Destroy()
					end)
					v_u_24:Close()
					v_u_23:GetPlayer(function(p93)
						-- upvalues: (ref) v_u_22, (ref) v_u_81, (ref) v_u_14
						if p93 then
							local v94, v95 = v_u_22:InvokeServer(v_u_81.GiftDevProductId, p93)
							if not v94 and v95 then
								v_u_14.Notify(v95, 3)
							end
						end
					end)
				end)
			end
		end
	end
	if v_u_39 and v_u_39.EndTime then
		local v_u_96 = v_u_47:WaitForChild("Timer")
		task.spawn(function()
			-- upvalues: (copy) v_u_39, (copy) v_u_96, (ref) v_u_7, (copy) v_u_47
			while true do
				local v97 = workspace:GetServerTimeNow()
				if math.floor(v97) >= v_u_39.EndTime then
					break
				end
				local v98 = v_u_96
				local v99 = v_u_7
				local v100 = v_u_39.EndTime
				local v101 = workspace:GetServerTimeNow()
				v98.Text = v99:FormatTime(v100 - math.floor(v101))
				task.wait(1)
			end
			v_u_47:Destroy()
		end)
	else
		local v102 = v_u_47:FindFirstChild("LeavingIn")
		local v103 = v_u_47:FindFirstChild("Timer")
		if v102 then
			v102.Visible = false
		end
		if v103 then
			v103.Visible = false
		end
	end
	v_u_47.Visible = true
end
local function v131()
	-- upvalues: (copy) v_u_18, (copy) v_u_9, (copy) v_u_11, (copy) v_u_36, (copy) v_u_4, (copy) v_u_19, (copy) v_u_16
	local v_u_105 = v_u_18:WaitForChild("GamepassSection"):WaitForChild("GridSection")
	local v106 = v_u_105:WaitForChild("GamepassTemplate")
	local v107 = v_u_9.Gamepasses
	local v_u_108 = v_u_105:FindFirstChild("UIGridLayout")
	task.defer(function()
		-- upvalues: (copy) v_u_105, (copy) v_u_108
		local v109 = v_u_105.AbsoluteSize.X
		if v109 > 0 then
			local v110 = v109 * 0.49 / 1.642
			local v111 = math.round(v110)
			v_u_108.CellSize = UDim2.new(0.49, 0, 0, v111)
		end
	end)
	for v_u_112, v_u_113 in v_u_11 do
		if v_u_112 ~= "ById" then
			local v114 = v107[v_u_112]
			if v114 then
				local v115 = v106:Clone()
				v115.Parent = v_u_105
				v115.Name = v_u_112
				v115.LayoutOrder = v114.LayoutOrder
				v115.Image = v114.BackgroundImage
				v115:WaitForChild("GamepassIcon").Image = "rbxthumb://type=GamePass&id=" .. v_u_113.GamepassId .. "&w=150&h=150"
				local v116 = v115:WaitForChild("TitleText")
				v116.Text = v_u_113.Name
				local v117 = v115:WaitForChild("TitleTextShadow")
				v117.Text = v_u_113.Name
				local v118 = v_u_36(v114.TitleStroke)
				if v118 then
					local v119 = v116:FindFirstChild("UIStroke")
					if v119 then
						v119.Color = v118
					end
					local v120 = v117:FindFirstChild("UIStroke")
					if v120 then
						v120.Color = v118
					end
				end
				local v_u_121 = v115:WaitForChild("BioText")
				v_u_121.Text = ""
				task.spawn(function()
					-- upvalues: (ref) v_u_4, (copy) v_u_113, (copy) v_u_121, (copy) v_u_112
					local v122, v123 = pcall(function()
						-- upvalues: (ref) v_u_4, (ref) v_u_113
						return v_u_4:GetProductInfo(v_u_113.GamepassId, Enum.InfoType.GamePass)
					end)
					if v122 and v123 then
						v_u_121.Text = v123.Description
					else
						warn("[RobuxShopController] Failed to fetch gamepass info for " .. v_u_112 .. ": " .. tostring(v123))
					end
				end)
				local v124 = v_u_36(v114.DescriptionStroke)
				local v125 = v124 and v_u_121:FindFirstChild("UIStroke")
				if v125 then
					v125.Color = v124
				end
				local v_u_126 = v115:WaitForChild("Buy")
				task.spawn(function()
					-- upvalues: (ref) v_u_4, (copy) v_u_113, (copy) v_u_126, (copy) v_u_112
					local v127, v128 = pcall(function()
						-- upvalues: (ref) v_u_4, (ref) v_u_113
						return v_u_4:GetProductInfo(v_u_113.GamepassId, Enum.InfoType.GamePass)
					end)
					if v127 and v128 then
						local v129 = v_u_126:FindFirstChild("Buy")
						if v129 then
							v129.Text = string.format("<font size=\"20\"><font weight=\"100\"></font>%s%s</font>", utf8.char(57346), v128.PriceInRobux)
							return
						end
					else
						warn("[RobuxShopController] Failed to fetch gamepass price for " .. v_u_112 .. ": " .. tostring(v128))
					end
				end)
				v_u_126.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_19, (ref) v_u_4, (ref) v_u_16, (copy) v_u_113
					local v_u_130 = Instance.new("Sound")
					v_u_130.SoundId = "rbxassetid://137731492025967"
					v_u_130.Parent = v_u_19
					v_u_130:Play()
					v_u_130.Ended:Connect(function()
						-- upvalues: (copy) v_u_130
						v_u_130:Destroy()
					end)
					v_u_4:PromptGamePassPurchase(v_u_16, v_u_113.GamepassId)
				end)
				v115.Visible = true
			end
		end
	end
	v106.Visible = false
end
local v132 = true
local v133, v134 = pcall(function()
	-- upvalues: (copy) v_u_15, (copy) v_u_16
	return v_u_15:GetPolicyInfoForPlayerAsync(v_u_16)
end)
if v133 and v134 then
	v132 = v134.ArePaidRandomItemsRestricted
else
	warn("[RobuxShopController] PolicyService failed, defaulting to restricted: " .. tostring(v134))
end
if v132 then
	v_u_18:WaitForChild("PolicyMessage").Visible = true
else
	for v135, v136 in v8 do
		if v135:find("^Premium") then
			task.spawn(v104, v135, v136)
		end
	end
end
v131()
function v_u_24.Open(_)
	-- upvalues: (copy) v_u_17
	v_u_17.Enabled = true
end
function v_u_24.Close(_)
	-- upvalues: (copy) v_u_17
	v_u_17.Enabled = false
end
function v_u_24.Toggle(_)
	-- upvalues: (copy) v_u_17
	v_u_17.Enabled = not v_u_17.Enabled
end
return v_u_24