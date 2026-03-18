local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local v_u_3 = game:GetService("UserService")
local v_u_4 = {}
local v5 = v2:WaitForChild("Plants"):WaitForChild("Definitions")
local v_u_6 = require(v5:WaitForChild("PlantDataDefinitions"))
local v_u_7 = require(v5:WaitForChild("PlantTraitLoreDefinitions"))
local v_u_8 = require(v5:WaitForChild("TierHelper"))
local v_u_9 = require(v2:WaitForChild("Economy"):WaitForChild("Formatter"):WaitForChild("NumberFormatter"))
local v_u_10 = require(v2:WaitForChild("FloraBook"):WaitForChild("FloraBlacklistDefinitions"))
local v_u_11 = v_u_1.LocalPlayer
local v_u_12 = v_u_11:WaitForChild("PlayerGui")
local v_u_13 = v_u_12:WaitForChild("FloraBook")
local v_u_14 = v_u_13:WaitForChild("Frame")
local v_u_15 = v_u_14:WaitForChild("BackCoverLeft"):WaitForChild("FrontPageLeft"):WaitForChild("PlantsTab")
local v_u_16 = v_u_14:WaitForChild("BackCoverRight"):WaitForChild("FrontPageRight"):WaitForChild("PlantsTab")
local v_u_17 = v_u_14:WaitForChild("BackCoverRight"):WaitForChild("FrontPageRight"):WaitForChild("StatsTab")
local v_u_18 = v_u_14:WaitForChild("BackCoverLeft"):WaitForChild("FrontPageLeft"):WaitForChild("StatsTab")
local v_u_19 = v_u_14:WaitForChild("BackCoverRight"):WaitForChild("FrontPageRight"):WaitForChild("FilterTab")
local v_u_20 = v_u_15:WaitForChild("FilterButton")
local v_u_21 = v_u_19:WaitForChild("Checkbox")
local v_u_22 = v_u_21:WaitForChild("CheckboxYes")
local v_u_23 = v_u_15:WaitForChild("SearchBar"):WaitForChild("TextBox")
local v_u_24 = v_u_15:WaitForChild("PlantsScrollBG"):WaitForChild("ScrollingFrame")
local v_u_25 = v_u_24:WaitForChild("Template")
v_u_25.Visible = false
local v_u_26 = v_u_16:WaitForChild("StarContainer")
local v_u_27 = Instance.new("Sound")
v_u_27.Name = "PageTurnSound"
v_u_27.SoundId = "rbxassetid://113265463769202"
v_u_27.Volume = 5
v_u_27.Parent = v_u_13
local v_u_28 = v2:WaitForChild("RemoteEvents"):WaitForChild("GetLeaderboard")
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = "Plants"
local v_u_32 = "Money"
local v_u_33 = 0
local v_u_34 = nil
local v_u_35 = false
local v_u_36 = "StarLowHigh"
local v_u_37 = nil
local v_u_38 = {
	["Common"] = 1,
	["Uncommon"] = 2,
	["Rare"] = 3,
	["Epic"] = 4,
	["Legendary"] = 5,
	["Mythical"] = 6,
	["Divine"] = 7,
	["Celestial"] = 8,
	["Transcendent"] = 9,
	["Eternal"] = 10
}
local v_u_39 = { Color3.fromRGB(255, 215, 0), Color3.fromRGB(192, 192, 192), Color3.fromRGB(205, 127, 50) }
local v_u_49 = {
	["Money"] = {
		["DisplayName"] = "Shillings",
		["LayoutOrder"] = 1,
		["Verb"] = "Earned",
		["Image"] = "rbxassetid://71397691923533",
		["Format"] = function(p40)
			-- upvalues: (copy) v_u_9
			return "$" .. v_u_9:FormatFull(p40)
		end,
		["StatsFormat"] = function(p41)
			-- upvalues: (copy) v_u_9
			return "$" .. v_u_9:FormatNumberShort(p41)
		end
	},
	["TotalMoneyEarned"] = {
		["DisplayName"] = "Total Earned",
		["LayoutOrder"] = 2,
		["Verb"] = "Earned",
		["Image"] = "rbxassetid://81109263810551",
		["Format"] = function(p42)
			-- upvalues: (copy) v_u_9
			return "$" .. v_u_9:FormatFull(p42)
		end,
		["StatsFormat"] = function(p43)
			-- upvalues: (copy) v_u_9
			return "$" .. v_u_9:FormatNumberShort(p43)
		end
	},
	["Playtime"] = {
		["DisplayName"] = "Playtime",
		["LayoutOrder"] = 3,
		["Verb"] = "Played",
		["Image"] = "rbxassetid://118102648220833",
		["Format"] = function(p44)
			-- upvalues: (copy) v_u_9
			return v_u_9:FormatTime(p44)
		end
	},
	["TotalHarvested"] = {
		["DisplayName"] = "Total Harvested",
		["LayoutOrder"] = 4,
		["Verb"] = "Harvested",
		["Image"] = "rbxassetid://90348801848397",
		["Format"] = function(p45)
			-- upvalues: (copy) v_u_9
			return v_u_9:FormatNumberShort(p45)
		end
	},
	["TotalPlanted"] = {
		["DisplayName"] = "Total Planted",
		["LayoutOrder"] = 5,
		["Verb"] = "Planted",
		["Image"] = "rbxassetid://110645489504890",
		["Format"] = function(p46)
			-- upvalues: (copy) v_u_9
			return v_u_9:FormatNumberShort(p46)
		end
	},
	["TotalShoveled"] = {
		["DisplayName"] = "Total Shoveled",
		["LayoutOrder"] = 5,
		["Verb"] = "Shoveled",
		["Image"] = "rbxassetid://97767528978295",
		["Format"] = function(p47)
			-- upvalues: (copy) v_u_9
			return v_u_9:FormatNumberShort(p47)
		end
	},
	["GardenLikes"] = {
		["DisplayName"] = "Total Likes",
		["LayoutOrder"] = 7,
		["Verb"] = "Liked",
		["Image"] = "rbxassetid://87312755453160",
		["Format"] = function(p48)
			-- upvalues: (copy) v_u_9
			return v_u_9:FormatNumberShort(p48)
		end
	}
}
local v_u_50 = {
	["Bronze"] = "rbxassetid://85649954163308",
	["Silver"] = "rbxassetid://133349792763705"
}
function v_u_4.RefreshPlantList(_)
	-- upvalues: (copy) v_u_23, (copy) v_u_24, (copy) v_u_25, (copy) v_u_6, (ref) v_u_34, (ref) v_u_35, (copy) v_u_38, (ref) v_u_36
	local v51 = string.lower(v_u_23.Text)
	local v52 = {}
	for _, v53 in ipairs(v_u_24:GetChildren()) do
		if v53:IsA("GuiObject") and v53 ~= v_u_25 then
			table.insert(v52, v53)
		end
	end
	for _, v54 in ipairs(v52) do
		local v55 = v54.Name
		local v56 = v_u_6[v55]
		local v57 = v54:GetAttribute("Discovered") or false
		local v58
		if v51 == "" then
			v58 = true
		elseif v57 then
			v58 = string.find(string.lower(v55), v51)
		else
			v58 = v57
		end
		local v59 = v_u_34 == nil and true or v56.Rarity == v_u_34
		local v60 = not v_u_35 and true or not v57
		if v58 then
			if not v59 then
				v60 = v59
			end
		else
			v60 = v58
		end
		v54.Visible = v60
	end
	table.sort(v52, function(p61, p62)
		-- upvalues: (ref) v_u_6, (ref) v_u_38, (ref) v_u_36
		local v63 = v_u_6[p61.Name]
		local v64 = v_u_6[p62.Name]
		local v65 = v_u_38[v63.Rarity] or 0
		local v66 = v_u_38[v64.Rarity] or 0
		if v_u_36 == "AZ" then
			return p61.Name < p62.Name
		elseif v_u_36 == "ZA" then
			return p61.Name > p62.Name
		elseif v_u_36 == "StarLowHigh" then
			if v65 == v66 then
				return p61.Name < p62.Name
			else
				return v65 < v66
			end
		elseif v_u_36 == "StarHighLow" then
			if v65 == v66 then
				return p61.Name < p62.Name
			else
				return v66 < v65
			end
		else
			return false
		end
	end)
	for v67, v68 in ipairs(v52) do
		v68.LayoutOrder = v67
	end
end
function v_u_4.SwitchToTab(_, p69)
	-- upvalues: (copy) v_u_15, (copy) v_u_16, (copy) v_u_19, (copy) v_u_17, (copy) v_u_18, (ref) v_u_31, (copy) v_u_4, (ref) v_u_32
	if p69 == "Stats" then
		v_u_15.Visible = false
		v_u_16.Visible = false
		v_u_19.Visible = false
		v_u_17.Visible = true
		v_u_18.Visible = true
		v_u_31 = "Stats"
		task.spawn(function()
			-- upvalues: (ref) v_u_4, (ref) v_u_32
			v_u_4:FetchRanks()
			v_u_4:DisplayLeaderboard(v_u_32)
		end)
	elseif p69 == "Plants" then
		v_u_15.Visible = true
		v_u_19.Visible = false
		v_u_16.Visible = true
		v_u_17.Visible = false
		v_u_18.Visible = false
		v_u_31 = "Plants"
	end
end
local function v_u_75(p70)
	if not p70 then
		return "...", "..."
	end
	local v71 = string.find(p70, "\n<i>", 1, true)
	if not v71 then
		return p70, "..."
	end
	local v72 = v71 - 1
	local v73 = string.sub(p70, 1, v72)
	local v74 = v71 + 1
	return v73, string.sub(p70, v74):gsub("<i>", ""):gsub("</i>", "")
end
local function v_u_81(p76, p77)
	-- upvalues: (copy) v_u_8, (copy) v_u_50
	if p76 then
		for _, v78 in ipairs(p76:GetChildren()) do
			if v78:IsA("ImageLabel") then
				v78:Destroy()
			end
		end
		local v79 = v_u_8:GetStars(p77)
		if v79 and v79.Number then
			for _ = 1, v79.Number do
				local v80 = Instance.new("ImageLabel")
				v80.BackgroundTransparency = 1
				v80.Size = UDim2.new(0.8, 0, 0.8, 0)
				v80.Image = v_u_50[v79.Color] or v_u_50.Bronze
				Instance.new("UIAspectRatioConstraint").Parent = v80
				v80.Parent = p76
			end
		end
	else
		return
	end
end
function v_u_4.IsDiscovered(_, p82)
	-- upvalues: (copy) v_u_24
	local v83 = v_u_24:FindFirstChild(p82)
	if v83 then
		return v83:GetAttribute("Discovered") or false
	else
		return false
	end
end
function v_u_4.SetPage(_, p84, p85, p86, p87)
	-- upvalues: (copy) v_u_4, (copy) v_u_16, (copy) v_u_13, (copy) v_u_19, (copy) v_u_6, (copy) v_u_7, (ref) v_u_37, (copy) v_u_27, (copy) v_u_75, (copy) v_u_81, (copy) v_u_26
	v_u_4:SwitchToTab("Plants")
	if p87 then
		v_u_16.Visible = false
		v_u_13.Enabled = p86
		return
	else
		v_u_16.Visible = true
		v_u_19.Visible = false
		local v88 = v_u_6[p84]
		local v89 = v_u_7.Info[p84]
		if v88 and v89 then
			if p85 and v_u_37 ~= p84 then
				v_u_27:Play()
			end
			v_u_37 = p84
			local v90, v91 = v_u_75(v89.Description)
			v_u_16.SeedName.Text = p84
			v_u_16.SeedNameOutline.Text = p84
			v_u_16.LoreDefinition.Text = v90
			v_u_16.Quote.Text = "\"" .. v91 .. "\""
			local v92 = v88.FruitBaseValue or (v88.PlantBaseValue or 0)
			local v93 = v88.FruitBaseWeight or (v88.PlantBaseWeight or 0)
			v_u_16.BasePrice.Value.Text = "$" .. tostring(v92)
			v_u_16.BaseWeight.Value.Text = tostring(v93) .. "kg"
			v_u_81(v_u_26, v88.Rarity)
			v_u_13.Enabled = p86
		end
	end
end
function v_u_4.DisplayLeaderboard(_, p94)
	-- upvalues: (copy) v_u_49, (ref) v_u_33, (ref) v_u_32, (copy) v_u_28, (copy) v_u_3, (copy) v_u_17, (copy) v_u_1, (copy) v_u_39
	if v_u_49[p94] then
		v_u_33 = v_u_33 + 1
		local v_u_95 = v_u_33
		v_u_32 = p94
		local v96 = v_u_28:InvokeServer(p94, "List")
		if v_u_33 == v_u_95 then
			if v96 and #v96 ~= 0 then
				local v_u_97 = {}
				for _, v98 in ipairs(v96) do
					local v99 = v98.UserId
					local v100 = tonumber(v99)
					table.insert(v_u_97, v100)
				end
				local v101, v102 = pcall(function()
					-- upvalues: (ref) v_u_3, (copy) v_u_97
					return v_u_3:GetUserInfosByUserIdsAsync(v_u_97)
				end)
				if v_u_33 == v_u_95 then
					local v103 = {}
					if v101 and v102 then
						for _, v104 in ipairs(v102) do
							local v105 = v104.Id
							v103[tostring(v105)] = v104
						end
					end
					local v_u_106 = v96[1]
					local v107 = v_u_106.UserId
					local v108 = v103[tostring(v107)]
					v_u_17:WaitForChild("StatName").Text = v_u_49[p94].DisplayName
					v_u_17:WaitForChild("StatVerb").Text = v_u_49[p94].Verb
					v_u_17:WaitForChild("StatVerbOuter").Text = v_u_49[p94].Verb
					v_u_17:WaitForChild("StatAmount").Text = v_u_49[p94].Format(v_u_106.Score)
					v_u_17:WaitForChild("StatAmountOuter").Text = v_u_49[p94].Format(v_u_106.Score)
					v_u_17:WaitForChild("DisplayName").Text = not v108 and "Unknown" or v108.DisplayName
					v_u_17:WaitForChild("DisplayNameShadow").Text = not v108 and "Unknown" or v108.DisplayName
					v_u_17:WaitForChild("UserName").Text = not v108 and "" or "@" .. v108.Username
					v_u_17:WaitForChild("PlayerImage").Image = ""
					task.spawn(function()
						-- upvalues: (ref) v_u_1, (copy) v_u_106, (ref) v_u_33, (copy) v_u_95, (ref) v_u_17
						local v109 = pcall
						local v110 = v_u_1.GetUserThumbnailAsync
						local v111 = v_u_1
						local v112 = v_u_106.UserId
						local v113, v114 = v109(v110, v111, tonumber(v112), Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
						if v_u_33 == v_u_95 then
							if v113 then
								v_u_17:WaitForChild("PlayerImage").Image = v114
							end
						end
					end)
					local v_u_115 = v_u_17:WaitForChild("ScrollBg"):WaitForChild("ScrollingFrame")
					for _, v116 in ipairs(v_u_115:GetChildren()) do
						if v116:IsA("ImageLabel") and v116.Name ~= "PlayerTemplate" then
							v116:Destroy()
						end
					end
					local v117 = v_u_115:WaitForChild("PlayerTemplate")
					v117.Visible = false
					for _, v_u_118 in ipairs(v96) do
						if v_u_33 ~= v_u_95 then
							return
						end
						local v119 = v_u_118.UserId
						local v120 = v103[tostring(v119)]
						local v_u_121 = v117:Clone()
						v_u_121.Name = "PlayerEntry"
						v_u_121.Visible = true
						local v122 = v_u_121:WaitForChild("Ranking")
						v122.Text = "#" .. v_u_118.Rank
						v122.TextColor3 = v_u_39[v_u_118.Rank] or Color3.fromRGB(255, 255, 255)
						v_u_121:WaitForChild("DisplayName").Text = not v120 and "Unknown" or v120.DisplayName
						v_u_121:WaitForChild("Username").Text = not v120 and "" or "@" .. v120.Username
						v_u_121:WaitForChild("StatAmount").Text = v_u_49[p94].Format(v_u_118.Score)
						v_u_121.Parent = v_u_115
						if v120 then
							task.spawn(function()
								-- upvalues: (ref) v_u_1, (copy) v_u_118, (ref) v_u_33, (copy) v_u_95, (copy) v_u_121
								local v123 = pcall
								local v124 = v_u_1.GetUserThumbnailAsync
								local v125 = v_u_1
								local v126 = v_u_118.UserId
								local v127, v128 = v123(v124, v125, tonumber(v126), Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
								if v_u_33 == v_u_95 then
									if v127 then
										v_u_121:WaitForChild("PlayerImage").Image = v128
									end
								end
							end)
						end
					end
					task.defer(function()
						-- upvalues: (copy) v_u_115
						local v129 = v_u_115:FindFirstChildWhichIsA("UIListLayout")
						local v130 = v_u_115:FindFirstChildWhichIsA("UIScale")
						if v129 then
							local v131 = not v130 and 1 or v130.Scale
							v_u_115.CanvasSize = UDim2.new(0, 0, 0, v129.AbsoluteContentSize.Y / v131)
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
end
v_u_4.StatsFrames = {}
function v_u_4.InitializeStats(p132)
	-- upvalues: (copy) v_u_18, (copy) v_u_49, (copy) v_u_4, (copy) v_u_1, (copy) v_u_11
	local v133 = v_u_18:WaitForChild("ScrollingFrame"):WaitForChild("StatsTemplate")
	v133.Visible = false
	for v_u_134, v135 in pairs(v_u_49) do
		local v136 = v133:Clone()
		v136.Parent = v_u_18.ScrollingFrame
		v136.Visible = true
		v136.Name = v_u_134
		v136:WaitForChild("StatImage").Image = v135.Image
		v136:WaitForChild("StatName").Text = v135.DisplayName
		v136.LayoutOrder = v135.LayoutOrder
		p132.StatsFrames[v_u_134] = v136
		v136:WaitForChild("OpenLeaderboard").Activated:Connect(function()
			-- upvalues: (ref) v_u_4, (copy) v_u_134
			v_u_4:DisplayLeaderboard(v_u_134)
		end)
	end
	v_u_18:WaitForChild("PlayerImage").Image = v_u_1:GetUserThumbnailAsync(v_u_11.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end
function v_u_4.UpdateStatValues(p137, p138)
	-- upvalues: (copy) v_u_49, (copy) v_u_24
	for v139, v140 in pairs(v_u_49) do
		local v141 = p137.StatsFrames[v139]
		if v141 then
			local v142 = (v140.StatsFormat or v140.Format)(p138.Data.FloraBook.Stats[v139] or (p138.Data[v139] or 0))
			v141:WaitForChild("StatNumber").Text = v142
			v141:WaitForChild("StatNumber"):WaitForChild("StatNumberStroke").Text = v142
		end
	end
	for v143, _ in pairs(p138.Data.FloraBook.Plants) do
		local v144 = v_u_24:FindFirstChild(v143)
		if v144 and p138.Data.FloraBook.Plants[v143].TotalHarvested > 0 then
			v144:SetAttribute("Discovered", true)
		end
	end
end
function v_u_4.FetchRanks(p145)
	-- upvalues: (copy) v_u_28
	local v146 = v_u_28:InvokeServer("_", "AllPlayerRanks")
	if v146 then
		for v147, v148 in pairs(v146) do
			local v149 = p145.StatsFrames[v147]
			if v149 then
				local v150 = v148.Score and v148.Score > 0 and (v148.Rank and "#" .. v148.Rank or "100+") or "100+"
				v149:WaitForChild("OpenLeaderboard"):WaitForChild("Ranking").Text = v150
			end
		end
	end
end
(function()
	-- upvalues: (copy) v_u_24, (copy) v_u_19, (copy) v_u_22, (copy) v_u_4, (copy) v_u_20, (copy) v_u_16, (ref) v_u_34, (copy) v_u_21, (ref) v_u_35, (ref) v_u_36, (copy) v_u_14, (copy) v_u_13, (ref) v_u_29, (copy) v_u_12, (ref) v_u_30, (copy) v_u_6, (copy) v_u_10, (copy) v_u_25, (copy) v_u_81, (copy) v_u_23
	v_u_24.AutomaticCanvasSize = Enum.AutomaticSize.Y
	v_u_19.Visible = false
	v_u_22.Visible = false
	v_u_4:InitializeStats()
	v_u_4:FetchRanks()
	v_u_20.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_19, (ref) v_u_16
		v_u_19.Visible = not v_u_19.Visible
		if v_u_19.Visible then
			v_u_16.Visible = false
		else
			v_u_16.Visible = true
		end
	end)
	for _, v_u_151 in ipairs({
		"Common",
		"Uncommon",
		"Rare",
		"Epic",
		"Legendary"
	}) do
		local v152 = v_u_19:FindFirstChild(v_u_151)
		if v152 then
			v152.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_34, (copy) v_u_151, (ref) v_u_4
				if v_u_34 == v_u_151 then
					v_u_34 = nil
				else
					v_u_34 = v_u_151
				end
				v_u_4:RefreshPlantList()
			end)
		end
	end
	v_u_21.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_35, (ref) v_u_22, (ref) v_u_4
		v_u_35 = not v_u_35
		v_u_22.Visible = v_u_35
		v_u_4:RefreshPlantList()
	end)
	v_u_22.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_35, (ref) v_u_22, (ref) v_u_4
		v_u_35 = not v_u_35
		v_u_22.Visible = v_u_35
		v_u_4:RefreshPlantList()
	end)
	local v153 = v_u_19:FindFirstChild("StarLowHigh")
	if v153 then
		v153.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_36, (ref) v_u_4
			v_u_36 = "StarLowHigh"
			v_u_4:RefreshPlantList()
		end)
	end
	local v154 = v_u_19:FindFirstChild("StarHighLow")
	if v154 then
		v154.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_36, (ref) v_u_4
			v_u_36 = "StarHighLow"
			v_u_4:RefreshPlantList()
		end)
	end
	if v_u_19:FindFirstChild("SortAZ") then
		v_u_19.SortAZ.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_36, (ref) v_u_4
			v_u_36 = "AZ"
			v_u_4:RefreshPlantList()
		end)
	end
	if v_u_19:FindFirstChild("SortZA") then
		v_u_19.SortZA.MouseButton1Click:Connect(function()
			-- upvalues: (ref) v_u_36, (ref) v_u_4
			v_u_36 = "ZA"
			v_u_4:RefreshPlantList()
		end)
	end
	local v155 = v_u_14:WaitForChild("BackCoverLeft"):WaitForChild("BackPageLeft")
	for _, v_u_156 in ipairs(v155:GetDescendants()) do
		if v_u_156:IsA("GuiButton") then
			v_u_156.Activated:Connect(function()
				-- upvalues: (ref) v_u_4, (copy) v_u_156
				v_u_4:SwitchToTab(v_u_156.Name)
			end)
		end
	end
	v_u_13:GetPropertyChangedSignal("Enabled"):Connect(function()
		-- upvalues: (ref) v_u_29, (ref) v_u_12, (ref) v_u_30, (ref) v_u_13
		if not v_u_29 then
			v_u_29 = v_u_12:FindFirstChild("BackpackGui")
		end
		local v157 = v_u_12:FindFirstChild("Hud_UI")
		if v157 then
			v157 = v157:FindFirstChild("TopButtons")
		end
		v_u_30 = v157
		if v_u_13.Enabled then
			if v_u_29 then
				v_u_29.Enabled = false
			end
			if v_u_30 then
				v_u_30.Visible = false
				return
			end
		else
			if v_u_29 then
				v_u_29.Enabled = true
			end
			if v_u_30 then
				v_u_30.Visible = true
			end
		end
	end)
	for v_u_158, v_u_159 in pairs(v_u_6) do
		if not v_u_10[v_u_158] then
			local v_u_160 = v_u_25:Clone()
			v_u_160.Name = v_u_158
			v_u_160.Visible = true
			v_u_160.Parent = v_u_24
			v_u_160:GetAttributeChangedSignal("Discovered"):Connect(function()
				-- upvalues: (copy) v_u_160, (copy) v_u_158, (copy) v_u_159, (ref) v_u_4
				if v_u_160:GetAttribute("Discovered") then
					local v161 = v_u_160:FindFirstChildWhichIsA("TextLabel") or v_u_160:FindFirstChild("NameLabel")
					if v161 then
						v161.Text = v_u_158
					end
					local v162 = v_u_160:FindFirstChildWhichIsA("ImageLabel") or v_u_160:FindFirstChild("Icon")
					if v162 then
						v162.Image = v_u_159.SeedAssetId
					end
					v_u_160.Activated:Connect(function()
						-- upvalues: (ref) v_u_4, (ref) v_u_158
						v_u_4:SetPage(v_u_158, true, true)
					end)
					if v_u_160:FindFirstChild("Scribbles") then
						v_u_160.Scribbles.Visible = false
					end
					if v_u_160:FindFirstChild("ScribblesLight") then
						v_u_160.ScribblesLight.Visible = false
					end
					v_u_4:RefreshPlantList()
				end
			end)
			local v163 = v_u_160:FindFirstChild("StarContainerScroller")
			if v163 then
				v_u_81(v163, v_u_159.Rarity)
			end
		end
	end
	v_u_23:GetPropertyChangedSignal("Text"):Connect(function()
		-- upvalues: (ref) v_u_4
		v_u_4:RefreshPlantList()
	end)
	v_u_4:RefreshPlantList()
	v_u_4:SetPage("Carrot", false, false)
end)()
return v_u_4