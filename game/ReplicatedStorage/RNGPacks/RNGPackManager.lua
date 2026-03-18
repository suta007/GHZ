local v_u_1 = {}
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("RunService")
local v5 = game:GetService("Players")
local v_u_6 = game:GetService("Lighting")
local v_u_7 = game:GetService("Workspace")
local v_u_8 = game:GetService("Debris")
local v_u_9 = game:GetService("SoundService")
local v_u_10 = game:GetService("GamepadService")
local v11 = v_u_2.Plants.Definitions
local v_u_12 = require(v11.TierHelper)
local v_u_13 = require(v11.PlantDataDefinitions)
local v_u_14 = require(v_u_2.RNGPacks.RNGPackHandler)
local v_u_15 = require(script.Parent.CutsceneManager)
local v_u_16 = {
	"BackpackGui",
	"Hud_UI",
	"WipeGardenButton",
	"ChangelogVersion",
	"ShillingsCurrency",
	"FriendBoost"
}
local v_u_17 = v_u_7.CurrentCamera
local v_u_18 = v5.LocalPlayer
local v_u_19 = 0
local v_u_20 = {}
local v_u_21 = false
local v_u_22 = 0
local v_u_23 = false
local function v_u_29(p24, p25)
	local v26 = math.random() * p25
	local v27 = 0
	for _, v28 in ipairs(p24) do
		v27 = v27 + (v28.Chance or 0)
		if v26 <= v27 then
			return v28
		end
	end
	return p24[1]
end
local function v_u_33(p30)
	-- upvalues: (copy) v_u_13
	local v31 = v_u_13[p30]
	local v32
	if v31 then
		v32 = v31.SeedAssetId
	else
		v32 = v31
	end
	if not v32 or ((v32 == 0 or (v32 == "0" or v32 == "rbxassetid://0")) and true or v32 == "") then
		v32 = "rbxassetid://6937742258"
	elseif tonumber(v32) then
		v32 = "rbxassetid://" .. v32
	end
	return {
		["Rarity"] = v31 and v31.Rarity or "Common",
		["Image"] = v32
	}
end
local function v_u_48(p34, p35)
	-- upvalues: (copy) v_u_12, (copy) v_u_3
	local v36 = v_u_12:GetTier(p35)
	if v36 then
		local v37 = v_u_12:GetColor(p35)
		local v38 = v36.gradient
		local v39 = p34:IsA("TextLabel") and "TextColor3" or "ImageColor3"
		if v38 then
			v37 = Color3.new(1, 1, 1) or v37
		end
		p34[v39] = v37
		local v40 = p34:FindFirstChildOfClass("UIGradient")
		if v38 then
			local v41 = v40 or Instance.new("UIGradient", p34)
			local v42 = {}
			for v43, v44 in ipairs(v38) do
				local v45 = ColorSequenceKeypoint.new
				local v46 = (v43 - 1) / (#v38 - 1)
				local v47 = Color3.fromHex
				table.insert(v42, v45(v46, v47(v44)))
			end
			v41.Color = ColorSequence.new(v42)
			v41.Enabled = true
			v_u_3:Create(v41, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
				["Offset"] = Vector2.new(1, 0)
			}):Play()
		elseif v40 then
			v40.Enabled = false
		end
	else
		return
	end
end
local function v_u_53(p49)
	-- upvalues: (copy) v_u_18, (copy) v_u_16
	local v50 = v_u_18:FindFirstChild("PlayerGui")
	if v50 then
		for _, v51 in ipairs(v_u_16) do
			local v52 = v50:FindFirstChild(v51)
			if v52 then
				v52.Enabled = p49
			end
		end
	end
end
local function v_u_59(p_u_54)
	-- upvalues: (ref) v_u_23, (copy) v_u_3
	if v_u_23 then
		return
	else
		local v_u_55 = p_u_54:FindFirstChild("SwooshGradient")
		if v_u_55 then
			v_u_23 = true
			v_u_55.Offset = Vector2.new(-1, 0)
			local v56 = v_u_3:Create(v_u_55, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
				["Offset"] = Vector2.new(1, 0)
			})
			v56:Play()
			local v_u_57 = p_u_54.TextColor3
			p_u_54.TextColor3 = Color3.fromRGB(0, 255, 0)
			v56.Completed:Connect(function()
				-- upvalues: (copy) v_u_55, (ref) v_u_3, (copy) p_u_54, (copy) v_u_57, (ref) v_u_23
				v_u_55.Offset = Vector2.new(-1, 0)
				local v58 = {
					["TextColor3"] = v_u_57
				}
				v_u_3:Create(p_u_54, TweenInfo.new(0.5), v58):Play()
				v_u_23 = false
			end)
		end
	end
end
local function v_u_70(p60, p61)
	-- upvalues: (copy) v_u_59
	local v62 = p61:FindFirstChild("PityCounter")
	if v62 and (p60 and #p60 ~= 0) then
		local v63 = nil
		for _, v64 in ipairs(p60) do
			if not v63 or (v64.Max > v63.Max or v64.Max == v63.Max and v64.RewardId < v63.RewardId) then
				v63 = v64
			end
		end
		if v63 then
			v62.Visible = true
			local v65 = v63.Current
			local v66 = tonumber(v65) or 0
			local v67 = v63.Max
			local v68 = tonumber(v67) or 0
			local v69 = v63.RewardId or "Unknown"
			if v68 <= v66 and v68 > 0 then
				v62.Text = string.format("%s: %d/%d", v69, v68, v68)
				v_u_59(v62)
			else
				v62.Text = string.format("%s: %d/%d", v69, v66, v68)
			end
		else
			v62.Visible = false
			return
		end
	else
		if v62 then
			v62.Visible = false
		end
		return
	end
end
local function v_u_79()
	-- upvalues: (ref) v_u_20, (copy) v_u_3
	local v71 = #v_u_20
	if v71 ~= 0 then
		for v72, v73 in ipairs(v_u_20) do
			v73.gui.AnchorPoint = Vector2.new(0.5, 0.5)
			v_u_3:Create(v73.gui, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
				["Position"] = UDim2.fromScale(0.5 + (v72 / (v71 + 1) - 0.5) * 0.9, 0.5)
			}):Play()
			local v74 = v73.gui:FindFirstChildOfClass("UIScale") or Instance.new("UIScale", v73.gui)
			local v75 = v_u_3
			local v76 = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			local v77 = {}
			local v78 = 0.9 / ((v71 - 1) * 0.6 + 1)
			v77.Scale = math.max(0.4, v78)
			v75:Create(v74, v76, v77):Play()
		end
	end
end
local function v_u_82()
	-- upvalues: (ref) v_u_20, (copy) v_u_17
	for _, v80 in ipairs(v_u_20) do
		if not v80.isEarlyTriggered then
			v80.isEarlyTriggered = true
			if v80.tween then
				v80.tween:Cancel()
			end
			if v80.cameraConnection then
				v80.cameraConnection:Disconnect()
			end
			if v80.holder and (v80.finalX and v80.originalY) then
				v80.holder.Position = UDim2.new(0, v80.finalX, v80.originalY.Scale, v80.originalY.Offset)
			end
			local v81 = v80.gui:FindFirstChild("Skip")
			if v81 then
				v81.Visible = false
			end
		end
	end
	v_u_17.FieldOfView = 70
end
local function v_u_107(p83, p84, p85, p86)
	-- upvalues: (copy) v_u_18, (copy) v_u_2, (copy) v_u_12, (copy) v_u_7, (copy) v_u_4, (copy) v_u_3, (copy) v_u_8
	local v87 = v_u_18.Character
	local v_u_88
	if v87 then
		v_u_88 = v87:FindFirstChild("HumanoidRootPart")
	else
		v_u_88 = v87
	end
	if v_u_88 then
		local v89 = p83:find("Seed") and p83 and p83 or p83 .. " Seed"
		local v90 = v_u_2.Plants and v_u_2.Plants.Tools
		if v90 then
			v90 = v_u_2.Plants.Tools.Seeds
		end
		if v90 then
			v90 = v90:FindFirstChild(v89)
		end
		if v90 then
			local v_u_91 = v90:Clone()
			local v92 = v_u_12:GetColor(p84)
			if v92 == Color3.new(0, 0, 0) then
				local v93 = v_u_12:GetTier(p84)
				if v93 and v93.gradient then
					v92 = Color3.fromHex(v93.gradient[1])
				end
			end
			if v_u_91:IsA("Model") then
				v_u_91:ScaleTo(v_u_91:GetScale() * 1.6)
			end
			local v94 = Instance.new("Highlight", v_u_91)
			v94.FillTransparency = 1
			v94.OutlineTransparency = 0
			v94.OutlineColor = v92
			for _, v95 in ipairs(v_u_91:GetDescendants()) do
				if v95:IsA("BasePart") then
					v95.Anchored = true
					v95.CanCollide = false
				end
			end
			local v_u_96 = v87.Head.Position + Vector3.new(0, 6, 0) + v_u_88.CFrame.RightVector * ((p85 - (p86 + 1) / 2) * 3)
			v_u_91:PivotTo(CFrame.new(v_u_96))
			v_u_91.Parent = v_u_7
			local v_u_97 = Instance.new("NumberValue")
			local v_u_98 = CFrame.identity
			local v99 = math.random(-4, 4)
			local v100 = math.random(-4, 4)
			local v101 = math.random
			local v_u_102 = Vector3.new(v99, v100, v101(-4, 4))
			local v_u_104 = v_u_4.RenderStepped:Connect(function(p103)
				-- upvalues: (copy) v_u_91, (copy) v_u_88, (ref) v_u_98, (copy) v_u_102, (copy) v_u_96, (copy) v_u_97
				if v_u_91 and (v_u_91.Parent and v_u_88) then
					v_u_98 = v_u_98 * CFrame.Angles(v_u_102.X * p103, v_u_102.Y * p103, v_u_102.Z * p103)
					v_u_91:PivotTo(CFrame.new(v_u_96:Lerp(v_u_88.Position, v_u_97.Value)) * v_u_98)
				end
			end)
			local v105 = v_u_3:Create(v_u_97, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				["Value"] = 1
			})
			v105:Play()
			v105.Completed:Connect(function()
				-- upvalues: (copy) v_u_104, (copy) v_u_88, (ref) v_u_8, (copy) v_u_91, (copy) v_u_97
				v_u_104:Disconnect()
				local v106 = Instance.new("Sound", v_u_88)
				v106.SoundId = "rbxassetid://70447807886059"
				v106.Volume = 0.8
				v106:Play()
				v_u_8:AddItem(v106, 2)
				v_u_91:Destroy()
				v_u_97:Destroy()
			end)
		else
			warn("Fly animation failed: Asset \'" .. v89 .. "\' not found")
		end
	else
		return
	end
end
local function v_u_153(p108, p109, p110)
	-- upvalues: (ref) v_u_19, (copy) v_u_53, (copy) v_u_17, (copy) v_u_3, (copy) v_u_6, (copy) v_u_33, (copy) v_u_48, (copy) v_u_4, (copy) v_u_107
	v_u_19 = v_u_19 + 1
	v_u_53(false)
	if p110 then
		local v111 = Instance.new("Sound", p109)
		v111.SoundId = "rbxassetid://1839901317"
		v111.Volume = 1.5
		v111:Play()
		v_u_17.FieldOfView = 100
		v_u_3:Create(v_u_17, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
			["FieldOfView"] = 70
		}):Play()
	end
	local v112 = v_u_6:FindFirstChild("ShowcaseBlur") or Instance.new("BlurEffect", v_u_6)
	v112.Name = "ShowcaseBlur"
	v112.Size = 0
	v_u_3:Create(v112, TweenInfo.new(0.5), {
		["Size"] = 15
	}):Play()
	local v_u_113 = {}
	for v114, v115 in ipairs(p108) do
		local v116 = v_u_33(v115.RewardId)
		local v117 = v114 / (#p108 + 1)
		local v118 = Instance.new("Frame", p109)
		local v119 = UDim2.fromScale(0.25, 0.35)
		local v120 = UDim2.fromScale(v117, 0.5)
		local v121 = Vector2.new(0.5, 0.5)
		v118.Size = v119
		v118.Position = v120
		v118.AnchorPoint = v121
		v118.BackgroundTransparency = 1
		local v122 = Instance.new("UIScale", v118)
		v122.Scale = 0
		local v123 = Instance.new("ImageLabel", v118)
		local v124 = UDim2.fromScale(1.6, 1.6)
		local v125 = UDim2.fromScale(0.5, 0.5)
		local v126 = Vector2.new(0.5, 0.5)
		v123.Name = "Shine"
		v123.Size = v124
		v123.Position = v125
		v123.AnchorPoint = v126
		v123.BackgroundTransparency = 1
		v123.Image = "rbxassetid://"
		v_u_48(v123, v116.Rarity)
		local v127 = Instance.new("ImageLabel", v118)
		local v128 = UDim2.fromScale(0.7, 0.7)
		local v129 = UDim2.fromScale(0.5, 0.45)
		local v130 = Vector2.new(0.5, 0.5)
		local v131 = v116.Image
		v127.Size = v128
		v127.Position = v129
		v127.AnchorPoint = v130
		v127.BackgroundTransparency = 1
		v127.ZIndex = 101
		v127.Image = v131
		Instance.new("UIAspectRatioConstraint", v127).AspectRatio = 1
		local v132 = Instance.new("TextLabel", v118)
		local v133 = UDim2.fromScale(1.2, 0.15)
		local v134 = UDim2.fromScale(0.5, 0.82)
		local v135 = Vector2.new(0.5, 0.5)
		v132.Size = v133
		v132.Position = v134
		v132.AnchorPoint = v135
		v132.BackgroundTransparency = 1
		v132.ZIndex = 102
		local v136 = v115.RewardId
		local v137 = Enum.Font.FredokaOne
		v132.Text = v136
		v132.TextScaled = true
		v132.Font = v137
		v132.TextColor3 = Color3.fromHex("#FFFFFF")
		local v138 = Instance.new("TextLabel", v118)
		local v139 = UDim2.fromScale(1.2, 0.12)
		local v140 = UDim2.fromScale(0.5, 0.95)
		local v141 = Vector2.new(0.5, 0.5)
		v138.Size = v139
		v138.Position = v140
		v138.AnchorPoint = v141
		v138.BackgroundTransparency = 1
		v138.ZIndex = 102
		local v142 = v116.Rarity:upper()
		local v143 = Enum.Font.GothamBold
		v138.Text = v142
		v138.TextScaled = true
		v138.Font = v143
		v_u_48(v138, v116.Rarity)
		local v144 = {
			["Gui"] = v118,
			["Scale"] = v122,
			["RewardId"] = v115.RewardId,
			["Rarity"] = v116.Rarity
		}
		table.insert(v_u_113, v144)
		v_u_3:Create(v122, TweenInfo.new(0.7, Enum.EasingStyle.Back), {
			["Scale"] = 1
		}):Play()
	end
	local v148 = v_u_4.RenderStepped:Connect(function(p145)
		-- upvalues: (copy) v_u_113
		for _, v146 in pairs(v_u_113) do
			local v147 = v146.Gui:FindFirstChild("Shine")
			if v147 then
				v147.Rotation = v147.Rotation + 60 * p145
			end
		end
	end)
	task.wait(2.5)
	for _, v149 in pairs(v_u_113) do
		v_u_3:Create(v149.Scale, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
			["Scale"] = 0
		}):Play()
	end
	v_u_19 = v_u_19 - 1
	if v_u_19 <= 0 then
		v_u_3:Create(v112, TweenInfo.new(0.5), {
			["Size"] = 0
		}):Play()
		v_u_53(true)
	end
	task.wait(0.6)
	for v150, v151 in ipairs(v_u_113) do
		task.spawn(v_u_107, v151.RewardId, v151.Rarity, v150, #v_u_113)
	end
	task.wait(0.7)
	task.wait(1)
	v148:Disconnect()
	for _, v152 in pairs(v_u_113) do
		v152.Gui:Destroy()
	end
end
local function v_u_167(p154, p155, p156, p157)
	-- upvalues: (copy) v_u_33, (copy) v_u_48, (copy) v_u_12
	local v158 = p157:Clone()
	v158.Visible = true
	v158.LayoutOrder = p155
	v158.Parent = p156
	local v159 = v_u_33(p154.RewardId)
	local v160 = v158:FindFirstChild("SeedItemFrame")
	if v160 then
		local v161 = v160:FindFirstChild("SeedIcon")
		if v161 and v161:IsA("ImageLabel") then
			v161.Image = v159.Image
			v161.Size = UDim2.fromScale(0.75, 0.75)
			v161.Position = UDim2.fromScale(0.5, 0.5)
			v161.AnchorPoint = Vector2.new(0.5, 0.5)
		end
	end
	local v162 = v158:FindFirstChild("TextLabel")
	if v162 then
		v162.RichText = true
		v162.Text = p154.RewardId
		v_u_48(v162, v159.Rarity)
		local v163 = v162:FindFirstChildOfClass("UIStroke")
		if v163 then
			local v164 = v_u_12:GetTier(v159.Rarity)
			if v164 then
				v164 = v164.gradient
			end
			if v164 then
				local v165 = Color3.fromHex(v164[1])
				v163.Color = Color3.new(v165.R * 0.5, v165.G * 0.5, v165.B * 0.5)
				return v158
			end
			local v166 = v162.TextColor3
			v163.Color = Color3.new(v166.R * 0.5, v166.G * 0.5, v166.B * 0.5)
		end
	end
	return v158
end
function v_u_1.RunSpinAnimation(p_u_168, p_u_169, p_u_170, p171)
	-- upvalues: (ref) v_u_20, (copy) v_u_79, (copy) v_u_10, (copy) v_u_29, (copy) v_u_167, (copy) v_u_3, (copy) v_u_9, (copy) v_u_4, (copy) v_u_82, (copy) v_u_17, (copy) v_u_8, (copy) v_u_15, (copy) v_u_53, (copy) v_u_153
	local v_u_172 = p171:Clone()
	local v173 = Vector2.new(0.5, 0.5)
	local v174 = UDim2.fromScale(0.5, 1.5)
	v_u_172.AnchorPoint = v173
	v_u_172.Position = v174
	v_u_172.Visible = true
	v_u_172.Parent = p_u_170
	local v_u_175 = v_u_172:FindFirstChild("Holder")
	local v176 = p_u_168.RewardId
	for _, v177 in ipairs(p_u_169) do
		if v177.RewardId == v176 then
			v_u_222 = v177.Rare == true
			::l7::
			local v_u_178 = {
				["gui"] = v_u_172,
				["winner"] = p_u_168,
				["isDone"] = false,
				["isEarlyTriggered"] = false,
				["isHighRarity"] = v_u_222
			}
			local v179 = v_u_20
			table.insert(v179, v_u_178)
			v_u_79()
			if #v_u_20 == 1 then
				pcall(function()
					-- upvalues: (ref) v_u_10
					v_u_10:EnableGamepadCursor(nil)
				end)
			end
			task.spawn(function()
				-- upvalues: (copy) v_u_172, (copy) v_u_175, (copy) p_u_169, (copy) p_u_168, (ref) v_u_29, (ref) v_u_167, (ref) v_u_3, (copy) v_u_178, (copy) v_u_222, (ref) v_u_9, (ref) v_u_4, (ref) v_u_82, (ref) v_u_17, (ref) v_u_8, (ref) v_u_20, (ref) v_u_10, (ref) v_u_15, (copy) p_u_170, (ref) v_u_53, (ref) v_u_153
				local v_u_180 = v_u_172:FindFirstChild("TickSound")
				local v181 = v_u_175:FindFirstChild("SeedContainer")
				v181.Visible = false
				for _, v182 in pairs(v_u_175:GetChildren()) do
					if v182:IsA("GuiObject") and v182 ~= v181 then
						v182:Destroy()
					end
				end
				local v183 = 0
				for _, v184 in ipairs(p_u_169) do
					v183 = v183 + (v184.Chance or 0)
				end
				for v185 = 1, 50 do
					v_u_167(v185 == 35 and p_u_168 or v_u_29(p_u_169, v183), v185, v_u_175, v181)
				end
				task.wait()
				local v186 = v181.AbsoluteSize.X > 0 and v181.AbsoluteSize.X or 200
				local v_u_187 = v186 + v_u_175:FindFirstChildOfClass("UIListLayout").Padding.Offset
				local v188 = v_u_172
				local v_u_189 = v188.AbsoluteSize.X > 0 and v188.AbsoluteSize.X or 800
				local v190 = v186 / 2
				local v191 = (math.random() * 2 - 1) * v190 * 0.3
				local v_u_192 = -(34 * v_u_187) + (v_u_189 / 2 - v186 / 2) - v191
				local v193 = v_u_175.Position.Y.Scale
				local v194 = v_u_175.Position.Y.Offset
				local v195 = v_u_3:Create(v_u_175, TweenInfo.new(7, Enum.EasingStyle.Quart), {
					["Position"] = UDim2.new(0, v_u_192, v193, v194)
				})
				local v196 = v_u_178
				local v197 = v_u_178
				local v198 = v_u_175
				v_u_178.tween = v195
				v196.finalX = v_u_192
				v197.holder = v198
				v_u_178.originalY = {
					["Scale"] = v193,
					["Offset"] = v194
				}
				local v_u_199 = -1
				local v_u_200
				if v_u_222 then
					v_u_200 = Instance.new("Sound", v_u_9)
					v_u_200.SoundId = "rbxassetid://7188240609"
					v_u_200.Volume = 0
					v_u_200.Looped = true
					v_u_200:Play()
				else
					v_u_200 = nil
				end
				v_u_178.cameraConnection = v_u_4.RenderStepped:Connect(function()
					-- upvalues: (ref) v_u_178, (ref) v_u_175, (copy) v_u_189, (copy) v_u_187, (ref) v_u_199, (copy) v_u_180, (ref) v_u_222, (copy) v_u_192, (ref) v_u_82, (ref) v_u_17, (ref) v_u_200
					if not v_u_178.isEarlyTriggered then
						local v201 = (-v_u_175.Position.X.Offset + v_u_189 / 2) / v_u_187
						local v202 = math.floor(v201)
						if v202 ~= v_u_199 then
							if v_u_199 ~= -1 and (v_u_199 < v202 and v_u_180) then
								v_u_180:Play()
							end
							v_u_199 = v202
						end
						if v_u_222 then
							local v203 = v_u_175.Position.X.Offset - v_u_192
							local v204 = math.abs(v203)
							local v205 = 1 - v204 / (v_u_187 * 8)
							local v206 = math.clamp(v205, 0, 1)
							local v207 = math.pow(v206, 2)
							if v204 < v_u_187 * 0.1 then
								v_u_82()
								return
							end
							if v207 > 0 then
								local v208 = v_u_17
								v208.CFrame = v208.CFrame * CFrame.new(math.random(-50, 50) / 1000 * v207, math.random(-50, 50) / 1000 * v207, 0)
								v_u_17.FieldOfView = 70 - v207 * 15
								if v_u_200 then
									v_u_200.Volume = v207
									v_u_200.PlaybackSpeed = v207 * 0.4 + 1
								end
							end
						end
					end
				end)
				local v209 = v_u_172:FindFirstChild("Skip")
				if v209 then
					v209.InputBegan:Connect(function(p210)
						-- upvalues: (ref) v_u_82
						if p210.UserInputType == Enum.UserInputType.MouseButton1 or p210.UserInputType == Enum.UserInputType.Touch then
							v_u_82()
						end
					end)
				end
				v195:Play()
				while v195.PlaybackState == Enum.PlaybackState.Playing and not v_u_178.isEarlyTriggered do
					task.wait()
				end
				if v_u_178.cameraConnection then
					v_u_178.cameraConnection:Disconnect()
				end
				if v_u_200 then
					v_u_3:Create(v_u_200, TweenInfo.new(1), {
						["Volume"] = 0
					}):Play()
					v_u_8:AddItem(v_u_200, 1)
				end
				v_u_178.isDone = true
				local v211 = true
				for _, v212 in ipairs(v_u_20) do
					if not v212.isDone then
						v211 = false
						break
					end
				end
				if v211 then
					local v213 = {}
					local v214 = {}
					local v215 = {}
					local v216 = false
					for _, v217 in ipairs(v_u_20) do
						local v218 = v217.winner
						table.insert(v213, v218)
						local v219 = v217.gui
						table.insert(v214, v219)
						if v217.isHighRarity then
							local v220 = v217.winner
							table.insert(v215, v220)
							v216 = true
						end
					end
					v_u_20 = {}
					task.wait(0.1)
					for _, v221 in ipairs(v214) do
						v221:Destroy()
					end
					pcall(function()
						-- upvalues: (ref) v_u_10
						v_u_10:DisableGamepadCursor()
					end)
					if #v215 > 0 then
						v_u_15.Play(v215[1], p_u_170, v_u_53)
					end
					v_u_153(v213, p_u_170, v216)
				end
			end)
			return
		end
	end
	local v_u_222 = false
	goto l7
end
function v_u_1.Initiate(p223, p224)
	-- upvalues: (ref) v_u_21, (ref) v_u_19, (ref) v_u_20, (ref) v_u_22, (copy) v_u_2, (copy) v_u_70, (copy) v_u_14, (copy) v_u_1
	if v_u_21 or (v_u_19 > 0 or #v_u_20 >= 3) then
		return
	elseif os.clock() - v_u_22 < 1 then
		return
	else
		local v225 = p224:FindFirstChild("MainFrame")
		if v225 then
			local v226 = v_u_2.RemoteEvents.RequestSpin
			v_u_21 = true
			local v227 = v226:InvokeServer()
			if v227 and v227.RewardId then
				v_u_22 = os.clock()
				v_u_70(v227.PityData, v225)
				local v228 = p223:GetAttribute("BaseName") or p223.Name
				local v229 = v_u_14.Packs[v228]
				if v229 then
					v_u_1.RunSpinAnimation(v227, v229.LootPool, p224, v225)
				end
			end
			v_u_21 = false
		end
	end
end
function v_u_1.ShowcaseRewards(p230, p231, p232)
	-- upvalues: (copy) v_u_153
	v_u_153(p230, p231, p232)
end
return v_u_1