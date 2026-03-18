local v_u_1 = {
	["Version"] = "1.5.2",
	["OpenClose"] = nil,
	["IsOpen"] = false,
	["StateChanged"] = Instance.new("BindableEvent"),
	["SelectedSlotChanged"] = Instance.new("BindableEvent"),
	["ModuleName"] = "Backpack",
	["KeepVRTopbarOpen"] = true,
	["VRIsExclusive"] = true,
	["VRClosesNonExclusive"] = true
}
local v_u_2 = 60
local v_u_3 = script:GetAttribute("TextSize")
local v_u_4 = script:GetAttribute("BackgroundTransparency")
local v_u_5 = script:GetAttribute("BackgroundColor")
local v_u_6 = script:GetAttribute("DraggableColor")
local v_u_7 = script:GetAttribute("EquippedColor")
local v_u_8 = script:GetAttribute("SlotLockedTransparency")
local v_u_9 = script:GetAttribute("BorderColor")
local v_u_10 = script:GetAttribute("SlotFavoritedColor")
local v_u_11 = Instance.new("Sound")
local v_u_12 = Instance.new("Sound")
local v13 = { Enum.KeyCode.Backquote, Enum.KeyCode.DPadUp }
local v_u_14 = script:GetAttribute("FullSlots")
local v15 = script:GetAttribute("EmptySlots")
local v16 = script:GetAttribute("MiniSlots")
local v17 = script:GetAttribute("SearchBoxColor")
local v18 = script:GetAttribute("SearchTextColor")
local v19 = script:GetAttribute("SearchBoxTransparency")
local v_u_20 = game:GetService("GamepadService")
local v_u_21 = nil
local function v25()
	local v22 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	local v23 = Instance.new("Frame", v22)
	v23.BackgroundTransparency = 1
	v23.Size = UDim2.new(1, 0, 1, 0)
	local v24 = v23.AbsoluteSize
	v22:Destroy()
	return v24
end
local v_u_26 = Enum.KeyCode.Zero.Value
local v_u_27 = Enum.KeyCode.Backspace.Value
local v28 = script:WaitForChild("Icon")
local v_u_29 = {
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true
}
local v_u_30 = game:GetService("UserInputService")
local v31 = game:GetService("Players")
local v_u_32 = game:GetService("ReplicatedStorage")
local v33 = game:GetService("StarterGui")
local v_u_34 = game:GetService("GuiService")
local v35 = v31.LocalPlayer.PlayerGui
local v36 = v_u_32:FindFirstChild("TopbarPlusReference")
local v_u_37 = false
if v36 then
	v28 = v36.Value
end
local v_u_38 = Instance.new("ScreenGui", v35)
v_u_38.DisplayOrder = 120
v_u_38.IgnoreGuiInset = true
v_u_38.ResetOnSpawn = false
v_u_38.Name = "BackpackGui"
v_u_38.ResetOnSpawn = false
local v_u_39 = game:GetService("ContextActionService")
game:GetService("RunService")
local v_u_40 = game:GetService("VRService")
local v_u_41 = require(script.Utility)
require(script.GameTranslator)
require(v28.Themes)
local v42 = require(v28)
local v_u_43 = v_u_34:IsTenFootInterface()
if v_u_43 then
	v_u_2 = 100
	v_u_3 = 24
end
local v_u_44 = false
local v45 = v_u_30.TouchEnabled
if v45 then
	v45 = v25().X < 1024
end
local v_u_46 = v31.LocalPlayer
local v_u_47 = nil
local v_u_48 = nil
local v_u_49 = nil
local v_u_50 = nil
local v_u_51 = nil
local v_u_52 = nil
local v_u_53 = nil
local v_u_54 = nil
local v_u_55 = v_u_46.Character or v_u_46.CharacterAdded:Wait()
local v_u_56 = v_u_55:FindFirstChildOfClass("Humanoid")
local v_u_57 = v_u_46:WaitForChild("Backpack")
local v_u_58 = v42.new()
v_u_58:setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "deselected")
v_u_58:setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "selected")
v_u_58:bindToggleKey(v13[1], v13[2])
v_u_58:bindToggleKey(Enum.KeyCode.ButtonL3)
v_u_58:bindToggleKey(Enum.KeyCode.ButtonL3)
v_u_58:setName("InventoryIcon")
v_u_58:setImageScale(1.12)
v_u_58:setOrder(-5)
v_u_58:setEnabled(false)
v_u_58:setCaption("Toggle the backpack.")
v_u_58.deselectWhenOtherIconSelected = false
local v_u_59 = {}
local v_u_60 = nil
local v_u_61 = {}
local v_u_62 = {}
local v_u_63 = {}
local v_u_64 = 0
local v_u_65 = false
local v_u_66 = false
local v_u_67 = false
local v_u_68 = false
local v_u_69 = {}
local v_u_70 = false
local v_u_71 = 0
local v_u_72 = v_u_40.VREnabled
if v_u_72 and v15 then
	v_u_14 = v15
elseif v45 then
	v_u_14 = v16 or v_u_14
end
local v_u_73 = v_u_72 and 3 or (v45 and 2 or 4)
local v_u_74 = nil
local v_u_75 = {}
local v_u_76 = {}
local v_u_77 = {}
local v_u_78 = nil
local v_u_79 = nil
local v_u_80 = nil
local v_u_81 = nil
local v_u_82 = 0
local v_u_83 = {
	["active"] = false,
	["tool"] = nil,
	["startPos"] = nil,
	["inputType"] = nil,
	["suppressClick"] = false
}
local v_u_84 = nil
local function v_u_88(p85, p86)
	-- upvalues: (ref) v_u_3
	local v87 = Instance.new(p85)
	v87.Name = p86
	v87.BackgroundColor3 = Color3.new(0, 0, 0)
	v87.BackgroundTransparency = 1
	v87.BorderColor3 = Color3.new(0, 0, 0)
	v87.BorderSizePixel = 0
	v87.Size = UDim2.new(1, 0, 1, 0)
	if p85:match("Text") then
		v87.TextColor3 = Color3.new(1, 1, 1)
		v87.Text = ""
		v87.FontFace = script:GetAttribute("LabelFont")
		v87.TextSize = v_u_3
		v87.TextWrapped = true
		if p85 == "TextButton" then
			v87.FontFace = script:GetAttribute("SlotFont")
		end
	end
	return v87
end
local function v_u_94()
	-- upvalues: (ref) v_u_49, (copy) v_u_14, (ref) v_u_64, (ref) v_u_59
	local v89 = v_u_49.Visible
	local v90 = v89 and v_u_14 or v_u_64
	local _ = v90 >= 1
	local v91 = 0
	for v92 = 1, v_u_14 do
		local v93 = v_u_59[v92]
		if v93.Tool or v89 then
			v91 = v91 + 1
			v93:Readjust(v91, v90)
			v93.Frame.Visible = true
		else
			v93.Frame.Visible = false
		end
	end
end
local v_u_95 = nil
local function v96()
	-- upvalues: (ref) v_u_48, (copy) v_u_14, (ref) v_u_2, (ref) v_u_49, (copy) v_u_73, (copy) v_u_72, (ref) v_u_51, (copy) v_u_94, (ref) v_u_95
	v_u_48.Size = UDim2.new(0, 5 + v_u_14 * (v_u_2 + 5), 0, v_u_2 + 5 + 5)
	v_u_48.Position = UDim2.new(0.5, -v_u_48.Size.X.Offset / 2, 1, -v_u_48.Size.Y.Offset)
	v_u_49.Size = UDim2.new(0, v_u_48.Size.X.Offset, 0, v_u_48.Size.Y.Offset * v_u_73 + 40 + (v_u_72 and 80 or 0))
	v_u_49.Position = UDim2.new(0.5, -v_u_49.Size.X.Offset / 2, 1, v_u_48.Position.Y.Offset - v_u_49.Size.Y.Offset)
	v_u_51.Size = UDim2.new(1, v_u_51.ScrollBarThickness + 1, 1, -40 - (v_u_72 and 80 or 0))
	v_u_51.Position = UDim2.new(0, 0, 0, 40 + (v_u_72 and 40 or 0))
	v_u_94()
	if v_u_95 then
		v_u_95()
	end
end
local function v_u_127()
	-- upvalues: (ref) v_u_76, (ref) v_u_75, (copy) v_u_61, (ref) v_u_79, (ref) v_u_80, (copy) v_u_1
	v_u_76 = {}
	local v97 = {}
	for _, v98 in ipairs(v_u_75) do
		if v98.Tool and (v98.Tool.Parent and not v_u_61[v98.Tool]) then
			table.insert(v97, v98)
		end
	end
	v_u_75 = v97
	if v_u_79 and next(v_u_79) then
		local v99 = {}
		for _, v100 in ipairs(v_u_75) do
			local v101 = v100.Tool
			if not v_u_80 or v_u_1:GetToolGroup(v101) == v_u_80 then
				local v102 = 0
				local v103 = v102
				for v104 in pairs(v_u_79) do
					local v105 = v101.Name
					local v106 = v104:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
					local _, v107 = v105:lower():gsub(v106, "")
					v102 = v103 + v107
					if v101:IsA("Tool") then
						local v108 = v101.ToolTip or ""
						local v109 = v104:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
						local _, v110 = v108:lower():gsub(v109, "")
						v102 = v102 + v110
					end
					local v111 = v101:GetAttribute("Mutation") or ""
					local v112 = v104:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
					local _, v113 = v111:lower():gsub(v112, "")
					v102 = v102 + v113
					local v114 = v101:GetAttribute("Variant") or ""
					local v115 = v104:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
					local _, v116 = v114:lower():gsub(v115, "")
					v102 = v102 + v116
					local v117 = v101:GetAttribute("RipenessStage") or ""
					local v118 = v104:gsub("([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1")
					local _, v119 = v117:lower():gsub(v118, "")
					v102 = v102 + v119
					v103 = v102
				end
				if v103 > 0 then
					table.insert(v99, {
						["item"] = v100,
						["hits"] = v103
					})
				end
			end
		end
		table.sort(v99, function(p120, p121)
			return p120.hits > p121.hits
		end)
		for _, v122 in ipairs(v99) do
			local v123 = v_u_76
			local v124 = v122.item
			table.insert(v123, v124)
		end
	else
		for _, v125 in ipairs(v_u_75) do
			if not v_u_80 or v_u_1:GetToolGroup(v125.Tool) == v_u_80 then
				local v126 = v_u_76
				table.insert(v126, v125)
			end
		end
	end
end
local function v_u_158()
	-- upvalues: (ref) v_u_51, (ref) v_u_52, (ref) v_u_127, (ref) v_u_2, (ref) v_u_76, (copy) v_u_73, (copy) v_u_77, (ref) v_u_53, (ref) v_u_54
	if not (v_u_51 and v_u_52) then
		return
	end
	v_u_127()
	local v128
	if v_u_51 then
		local v129 = (v_u_51.AbsoluteSize.X - 10 + 5) / (v_u_2 + 5)
		local v130 = math.floor(v129)
		v128 = math.max(1, v130)
	else
		v128 = 4
	end
	local v131 = v_u_2 + 5
	local v132 = #v_u_76
	local v133 = v132 / v128
	local v134 = math.ceil(v133)
	local v135 = v134 > 0 and ((v134 - 1) * v131 + v_u_2 or 0) or 0
	v_u_51.CanvasSize = UDim2.new(0, 0, 0, v135)
	local v136 = v_u_51.CanvasPosition.Y
	local v137 = v_u_51.AbsoluteSize.Y
	if v137 < 1 then
		v137 = v_u_73 * v131
	end
	local v138 = v136 / v131
	local v139 = math.floor(v138)
	local v140 = (v136 + v137) / v131
	local v141 = math.ceil(v140) - 1
	local v142 = math.max(0, v139)
	local v143 = v134 - 1
	local v144 = math.min(v143, v141)
	local v145 = v142 * v128 + 1
	local v146 = (v144 + 1) * v128
	local v147 = math.min(v132, v146)
	for _, v148 in ipairs(v_u_77) do
		v148:Hide()
	end
	local v149 = 0
	for v150 = v145, v147 do
		local v151 = v_u_76[v150]
		if v151 and v151.Tool then
			v149 = v149 + 1
			if v149 > 80 then
				break
			end
			local v152 = v_u_77[v149]
			local v153 = (v150 - 1) / v128
			local v154 = math.floor(v153)
			local v155 = (v150 - 1) % v128
			v152.Frame.Position = UDim2.new(0, v155 * (v_u_2 + 5), 0, v154 * v131)
			v152:Display(v151, v150)
		end
	end
	if v_u_53 and v_u_54 then
		local v156 = v_u_51.CanvasPosition.Y > 0
		local v157 = v_u_51.CanvasPosition.Y < v_u_51.CanvasSize.Y.Offset - v_u_51.AbsoluteWindowSize.Y
		v_u_53.Visible = v156
		v_u_54.Visible = v157
	end
end
v_u_95 = function()
	-- upvalues: (ref) v_u_158
	v_u_158()
end
local function v_u_163(p159)
	-- upvalues: (copy) v_u_61, (ref) v_u_75, (ref) v_u_95
	if not v_u_61[p159] then
		for _, v160 in ipairs(v_u_75) do
			if v160.Tool == p159 then
				return
			end
		end
		local v161 = {
			["Tool"] = p159,
			["Favorited"] = p159:GetAttribute("Favorited") and true or false
		}
		local v162 = v_u_75
		table.insert(v162, v161)
		v_u_95()
	end
end
local function v_u_167(p164)
	-- upvalues: (ref) v_u_75, (ref) v_u_95
	for v165, v166 in ipairs(v_u_75) do
		if v166.Tool == p164 then
			table.remove(v_u_75, v165)
			v_u_95()
			return
		end
	end
end
local function v230(p168, p169)
	-- upvalues: (copy) v_u_88, (copy) v_u_5, (copy) v_u_9, (ref) v_u_2, (copy) v_u_8, (copy) v_u_10, (ref) v_u_55, (copy) v_u_7, (copy) v_u_20, (ref) v_u_84, (copy) v_u_77, (copy) v_u_32, (ref) v_u_75, (ref) v_u_95, (copy) v_u_83, (ref) v_u_81, (ref) v_u_82, (ref) v_u_60, (ref) v_u_167, (copy) v_u_94, (ref) v_u_56, (copy) v_u_12, (ref) v_u_78, (ref) v_u_21, (ref) v_u_57, (copy) v_u_11, (copy) v_u_1
	local v_u_170 = {
		["Tool"] = nil,
		["DataIndex"] = nil,
		["Favorited"] = false,
		["HighlightFrame"] = nil
	}
	local v_u_171 = v_u_88("TextButton", "PoolSlot_" .. p169)
	local v172 = Instance.new("UIStroke")
	v172.Parent = v_u_171
	v172.Thickness = 0
	local v173 = Instance.new("UICorner")
	v173.CornerRadius = script:GetAttribute("CornerRadius")
	v173.Parent = v_u_171
	v_u_171.BackgroundColor3 = v_u_5
	v172.Color = v_u_9
	v_u_171.Text = ""
	v_u_171.AutoButtonColor = false
	v_u_171.BorderSizePixel = 0
	v_u_171.Size = UDim2.new(0, v_u_2, 0, v_u_2)
	v_u_171.Active = true
	v_u_171.Selectable = false
	v_u_171.Draggable = false
	v_u_171.BackgroundTransparency = v_u_8
	v_u_171.Visible = false
	v_u_171.Parent = p168
	local v_u_174 = v_u_88("ImageLabel", "Icon")
	v_u_174.Size = UDim2.new(0.8, 0, 0.8, 0)
	v_u_174.Position = UDim2.new(0.1, 0, 0.1, 0)
	v_u_174.Parent = v_u_171
	local v_u_175 = v_u_88("TextLabel", "ToolName")
	v_u_175.Size = UDim2.new(1, -2, 1, -2)
	v_u_175.Position = UDim2.new(0, 1, 0, 1)
	v_u_175.Parent = v_u_171
	v_u_175.ZIndex = 2
	v_u_170.Frame = v_u_171
	v_u_170.ToolIcon = v_u_174
	v_u_170.ToolName = v_u_175
	function v_u_170.Display(p176, p177, p178)
		-- upvalues: (copy) v_u_174, (copy) v_u_175, (copy) v_u_171, (ref) v_u_10, (ref) v_u_5, (ref) v_u_55, (ref) v_u_88, (ref) v_u_7, (ref) v_u_8
		if p177 and p177.Tool then
			p176.Tool = p177.Tool
			p176.DataIndex = p178
			p176.Favorited = p177.Favorited or false
			local v179 = p177.Tool
			local v180 = v179.TextureId
			v_u_174.Image = v180
			if v180 == "" then
				v_u_175.Visible = true
				v_u_175.Text = v179.Name
			else
				v_u_175.Visible = false
				v_u_175.Text = ""
			end
			local v181 = v_u_171:FindFirstChild("FavoriteIcon")
			if p176.Favorited then
				if not v181 then
					script.FavoriteIcon:Clone().Parent = v_u_171
				end
				v_u_171.BackgroundColor3 = v_u_10
			else
				if v181 then
					v181:Destroy()
				end
				v_u_171.BackgroundColor3 = v_u_5
			end
			if v179 then
				v179 = v179.Parent == v_u_55
			end
			if v179 then
				if not p176.HighlightFrame then
					p176.HighlightFrame = v_u_88("Frame", "Equipped")
					local v182 = Instance.new("UICorner")
					v182.CornerRadius = script:GetAttribute("CornerRadius")
					v182.Parent = p176.HighlightFrame
					local v183 = Instance.new("UIStroke")
					v183.Color = v_u_7
					v183.Thickness = 3
					v183.Parent = p176.HighlightFrame
				end
				p176.HighlightFrame.Parent = v_u_171
			elseif p176.HighlightFrame then
				p176.HighlightFrame.Parent = nil
			end
			v_u_171.BackgroundTransparency = v_u_8
			v_u_171.Visible = true
		else
			p176:Hide()
		end
	end
	function v_u_170.Hide(p184)
		-- upvalues: (copy) v_u_171, (copy) v_u_174, (copy) v_u_175
		v_u_171.Visible = false
		p184.Tool = nil
		p184.DataIndex = nil
		p184.Favorited = false
		v_u_174.Image = ""
		v_u_175.Text = ""
		v_u_175.Visible = true
		if p184.HighlightFrame then
			p184.HighlightFrame.Parent = nil
		end
		local v185 = v_u_171:FindFirstChild("FavoriteIcon")
		if v185 then
			v185:Destroy()
		end
	end
	local function v_u_199()
		-- upvalues: (copy) v_u_170, (ref) v_u_20, (ref) v_u_84, (ref) v_u_77, (ref) v_u_32, (ref) v_u_75, (ref) v_u_95
		local v186 = v_u_170.Tool
		if v_u_20.GamepadCursorEnabled then
			if not v_u_84 then
				return
			end
			local v187 = v_u_84.X
			local v188 = v_u_84.Y
			local v189 = (1 / 0)
			local v190 = nil
			for _, v191 in ipairs(v_u_77) do
				if v191.Tool and v191.Frame.Visible then
					local v192 = v191.Frame.AbsolutePosition
					local v193 = v191.Frame.AbsoluteSize
					local v194 = v192.X + v193.X / 2
					local v195 = v192.Y + v193.Y / 2
					local v196 = (v187 - v194) * (v187 - v194) + (v188 - v195) * (v188 - v195)
					if v196 < v189 then
						v190 = v191.Tool
						v189 = v196
					end
				end
			end
			if v190 ~= v_u_170.Tool then
				return
			end
		end
		if not v186 then
			return
		end
		if v186:GetAttribute("Type") ~= "Plants" then
			return
		end
		local v197 = v_u_32:FindFirstChild("RemoteEvents")
		if v197 then
			v197 = v_u_32.RemoteEvents:FindFirstChild("ToggleFavorite")
		end
		if v197 then
			v197:FireServer(v186)
		end
		for _, v198 in ipairs(v_u_75) do
			if v198.Tool == v186 then
				v198.Favorited = not v198.Favorited
				break
			end
		end
		v_u_95()
	end
	v_u_171.MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_83, (copy) v_u_170, (ref) v_u_20, (ref) v_u_84, (ref) v_u_77, (ref) v_u_81, (ref) v_u_82, (ref) v_u_60, (ref) v_u_167, (ref) v_u_94, (ref) v_u_95, (ref) v_u_55, (ref) v_u_56, (ref) v_u_12, (ref) v_u_78, (ref) v_u_21, (ref) v_u_57, (ref) v_u_11, (ref) v_u_1
		if v_u_83.suppressClick then
			return
		else
			local v200 = v_u_170.Tool
			if v_u_20.GamepadCursorEnabled then
				if not v_u_84 then
					return
				end
				local v201 = v_u_84.X
				local v202 = v_u_84.Y
				local v203 = (1 / 0)
				local v204 = nil
				for _, v205 in ipairs(v_u_77) do
					if v205.Tool and v205.Frame.Visible then
						local v206 = v205.Frame.AbsolutePosition
						local v207 = v205.Frame.AbsoluteSize
						local v208 = v206.X + v207.X / 2
						local v209 = v206.Y + v207.Y / 2
						local v210 = (v201 - v208) * (v201 - v208) + (v202 - v209) * (v202 - v209)
						if v210 < v203 then
							v204 = v205.Tool
							v203 = v210
						end
					end
				end
				if v204 ~= v_u_170.Tool then
					return
				end
			end
			if v200 then
				local v211 = tick()
				if v200 == v_u_81 and (v211 - v_u_82 < 0.5 and v_u_60) then
					v_u_167(v200)
					v_u_60:Fill(v200)
					v_u_94()
					v_u_81 = nil
					v_u_82 = 0
					v_u_95()
					return
				else
					v_u_81 = v200
					v_u_82 = v211
					local v212
					if v200 then
						v212 = v200.Parent == v_u_55
					else
						v212 = v200
					end
					if v212 then
						if v_u_56 then
							v_u_56:UnequipTools()
						end
						v_u_12:Play()
						v_u_78 = nil
						v_u_21 = nil
					elseif v200.Parent == v_u_57 then
						v_u_11:Play()
						if v_u_56 and v_u_56.Health > 0 then
							if v_u_56 then
								v_u_56:UnequipTools()
							end
							v200.Parent = v_u_55
						end
						v_u_78 = v200
						v_u_21 = nil
					end
					v_u_95()
					if v_u_78 then
						local v213 = {
							["SlotNumber"] = -1,
							["Tool"] = v_u_78,
							["IsEquipped"] = true
						}
						v_u_1.SelectedSlotChanged:Fire(v213)
						return
					elseif v_u_21 then
						v_u_1.SelectedSlotChanged:Fire({
							["SlotNumber"] = v_u_21.Index,
							["Tool"] = v_u_21.Tool,
							["IsEquipped"] = v_u_21:IsEquipped()
						})
					else
						v_u_1.SelectedSlotChanged:Fire(nil)
					end
				end
			else
				return
			end
		end
	end)
	v_u_171.MouseButton2Click:Connect(v_u_199)
	local v_u_214 = nil
	v_u_171.InputBegan:Connect(function(p215)
		-- upvalues: (ref) v_u_20, (ref) v_u_84, (ref) v_u_83, (copy) v_u_170, (ref) v_u_77, (ref) v_u_214
		if p215.UserInputType == Enum.UserInputType.MouseButton1 or p215.UserInputType == Enum.UserInputType.Touch then
			if v_u_20.GamepadCursorEnabled then
				v_u_84 = p215.Position
			end
			if v_u_83.tool then
				return
			end
			local v216 = v_u_170.Tool
			local v217 = p215.Position.X
			local v218 = p215.Position.Y
			if v_u_20.GamepadCursorEnabled then
				if not v_u_84 then
					return
				end
				local v219 = v_u_84.X
				local v220 = v_u_84.Y
				v218 = v220
				v217 = v219
				local v221 = (1 / 0)
				local v222 = nil
				for _, v223 in ipairs(v_u_77) do
					if v223.Tool and v223.Frame.Visible then
						local v224 = v223.Frame.AbsolutePosition
						local v225 = v223.Frame.AbsoluteSize
						local v226 = v224.X + v225.X / 2
						local v227 = v224.Y + v225.Y / 2
						local v228 = (v219 - v226) * (v219 - v226) + (v220 - v227) * (v220 - v227)
						if v228 < v221 then
							v222 = v223.Tool
							v221 = v228
						end
					end
				end
				if v222 ~= v_u_170.Tool then
					return
				end
			end
			if not v216 then
				return
			end
			v_u_83.tool = v216
			v_u_83.startPos = Vector2.new(v217, v218)
			v_u_83.inputType = p215.UserInputType
			v_u_83.active = false
			v_u_83.suppressClick = false
		end
		if p215.UserInputType == Enum.UserInputType.Touch then
			v_u_214 = tick()
		end
	end)
	v_u_171.InputEnded:Connect(function(p229)
		-- upvalues: (ref) v_u_214, (ref) v_u_83, (copy) v_u_199
		if p229.UserInputType == Enum.UserInputType.Touch and v_u_214 then
			if not v_u_83.active and tick() - v_u_214 >= 0.5 then
				v_u_199()
			end
			v_u_214 = nil
		end
	end)
	return v_u_170
end
local function v370(p231, p232)
	-- upvalues: (ref) v_u_59, (copy) v_u_40, (copy) v_u_8, (copy) v_u_10, (copy) v_u_6, (copy) v_u_5, (ref) v_u_48, (ref) v_u_2, (copy) v_u_32, (ref) v_u_167, (copy) v_u_14, (ref) v_u_49, (copy) v_u_30, (ref) v_u_64, (ref) v_u_66, (ref) v_u_44, (copy) v_u_39, (copy) v_u_61, (ref) v_u_60, (ref) v_u_55, (ref) v_u_74, (copy) v_u_88, (copy) v_u_7, (ref) v_u_56, (copy) v_u_12, (ref) v_u_21, (ref) v_u_78, (ref) v_u_57, (copy) v_u_11, (copy) v_u_1, (copy) v_u_9, (copy) v_u_83, (copy) v_u_20, (ref) v_u_84, (ref) v_u_163, (copy) v_u_62, (copy) v_u_26, (copy) v_u_63, (copy) v_u_58
	local v233 = p232 or #v_u_59 + 1
	local v_u_234 = {
		["Tool"] = nil,
		["Index"] = v233,
		["Frame"] = nil,
		["Favorited"] = false
	}
	local v_u_235 = nil
	local v_u_236 = nil
	local v_u_237 = nil
	local v_u_238 = nil
	local v_u_239 = nil
	local v_u_240 = nil
	local v_u_241 = nil
	local function v_u_242()
		-- upvalues: (ref) v_u_40, (ref) v_u_235, (ref) v_u_8, (copy) v_u_234, (ref) v_u_10, (ref) v_u_6, (ref) v_u_5
		local _ = v_u_40.VREnabled
		v_u_235.SelectionImageObject = nil
		v_u_235.BackgroundTransparency = v_u_235.Draggable and 0 or v_u_8
		if v_u_234.Favorited then
			v_u_235.BackgroundColor3 = v_u_10
		else
			v_u_235.BackgroundColor3 = v_u_235.Draggable and v_u_6 or v_u_5
		end
	end
	function v_u_234.Readjust(_, p243, p244)
		-- upvalues: (ref) v_u_48, (ref) v_u_2, (ref) v_u_235
		local v245 = v_u_48.Size.X.Offset / 2
		local v246 = v_u_2 + 5
		local v247 = p243 - (p244 / 2 + 0.5)
		v_u_235.Position = UDim2.new(0, v245 - v_u_2 / 2 + v246 * v247, 0, 5)
	end
	function v_u_234.Favorite(_)
		-- upvalues: (copy) v_u_234, (ref) v_u_32, (ref) v_u_235, (ref) v_u_5, (ref) v_u_10
		if v_u_234.Tool then
			if v_u_234.Tool:GetAttribute("Type") == "Plants" then
				local v248 = v_u_32:FindFirstChild("RemoteEvents")
				if v248 then
					v248 = v_u_32.RemoteEvents:FindFirstChild("ToggleFavorite")
				end
				if v248 then
					v248:FireServer(v_u_234.Tool)
				end
				if v_u_234.Favorited then
					local v249 = v_u_235:FindFirstChild("FavoriteIcon")
					if v249 then
						v249:Destroy()
					end
					v_u_235.BackgroundColor3 = v_u_5
					v_u_234.Favorited = false
				else
					v_u_234.Favorited = true
					script.FavoriteIcon:Clone().Parent = v_u_235
					v_u_235.BackgroundColor3 = v_u_10
				end
			else
				return
			end
		else
			return
		end
	end
	function v_u_234.Fill(p250, p_u_251)
		-- upvalues: (ref) v_u_167, (copy) v_u_234, (ref) v_u_235, (ref) v_u_10, (ref) v_u_236, (ref) v_u_237, (ref) v_u_240, (ref) v_u_238, (ref) v_u_14, (ref) v_u_49, (ref) v_u_30, (ref) v_u_64, (ref) v_u_66, (ref) v_u_44, (ref) v_u_39, (ref) v_u_61, (ref) v_u_60, (ref) v_u_59
		if not p_u_251 then
			return p250:Clear()
		end
		v_u_167(p_u_251)
		p250.Tool = p_u_251
		if p_u_251:GetAttribute("Favorited") then
			v_u_234.Favorited = true
			script.FavoriteIcon:Clone().Parent = v_u_235
			v_u_235.BackgroundColor3 = v_u_10
		end
		local function v_u_254()
			-- upvalues: (copy) p_u_251, (ref) v_u_236, (ref) v_u_237, (ref) v_u_240
			local v252 = p_u_251.TextureId
			v_u_236.Image = v252
			if v252 ~= "" then
				v_u_237.Visible = false
			end
			v_u_237.Text = p_u_251.Name
			if v_u_240 and p_u_251:IsA("Tool") then
				v_u_240.Text = p_u_251.ToolTip
				local v253 = v_u_240.TextBounds.X + 24
				v_u_240.Size = UDim2.new(0, v253, 0, 24)
				v_u_240.Position = UDim2.new(0.5, -v253 / 2, 0, -28)
			end
		end
		v_u_254()
		if v_u_238 then
			v_u_238:disconnect()
			v_u_238 = nil
		end
		v_u_238 = p_u_251.Changed:connect(function(p255)
			-- upvalues: (copy) v_u_254
			if p255 == "TextureId" or (p255 == "Name" or p255 == "ToolTip") then
				v_u_254()
			end
		end)
		local v256 = p250.Index <= v_u_14
		if v_u_49.Visible and not v_u_30.VREnabled then
			v_u_235.Draggable = true
		end
		p250:UpdateEquipView()
		if v256 then
			v_u_64 = v_u_64 + 1
			if v_u_66 and (v_u_64 >= 1 and not v_u_44) then
				v_u_44 = true
				v_u_39:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
			end
		end
		v_u_61[p_u_251] = p250
		for v257 = 1, v_u_14 do
			v258 = v_u_59[v257]
			if not v258.Tool then
				goto l22
			end
		end
		local v258 = nil
		::l22::
		v_u_60 = v258
	end
	function v_u_234.Clear(p259)
		-- upvalues: (ref) v_u_238, (ref) v_u_235, (ref) v_u_236, (ref) v_u_237, (ref) v_u_240, (ref) v_u_14, (ref) v_u_64, (ref) v_u_44, (ref) v_u_39, (ref) v_u_61, (ref) v_u_60, (ref) v_u_59
		if not p259.Tool then
			return
		end
		if v_u_238 then
			v_u_238:disconnect()
			v_u_238 = nil
		end
		p259.Favorited = false
		local v260 = v_u_235:FindFirstChild("FavoriteIcon")
		if v260 then
			v260:Destroy()
		end
		v_u_236.Image = ""
		v_u_237.Text = ""
		if v_u_240 then
			v_u_240.Text = ""
			v_u_240.Visible = false
		end
		v_u_235.Draggable = false
		p259:UpdateEquipView(true)
		if p259.Index <= v_u_14 then
			v_u_64 = v_u_64 - 1
			if v_u_64 < 1 then
				v_u_44 = false
				v_u_39:UnbindAction("RBXHotbarEquip")
			end
		end
		v_u_61[p259.Tool] = nil
		p259.Tool = nil
		for v261 = 1, v_u_14 do
			v262 = v_u_59[v261]
			if not v262.Tool then
				::l16::
				v_u_60 = v262
				return
			end
		end
		local v262 = nil
		goto l16
	end
	function v_u_234.UpdateEquipView(p263, p264)
		-- upvalues: (ref) v_u_55, (ref) v_u_74, (copy) v_u_234, (ref) v_u_239, (ref) v_u_88, (ref) v_u_235, (ref) v_u_7, (copy) v_u_242
		if not p264 then
			local v265 = p263.Tool
			if v265 then
				v265 = v265.Parent == v_u_55
			end
			if v265 then
				v_u_74 = v_u_234
				if not v_u_239 then
					v_u_239 = v_u_88("Frame", "Equipped")
					v_u_239.ZIndex = v_u_235.ZIndex
					local v266 = Instance.new("UICorner")
					v266.CornerRadius = script:GetAttribute("CornerRadius")
					v266.Parent = v_u_239
					local v267 = Instance.new("UIStroke")
					v267.Color = v_u_7
					v267.Thickness = 3
					v267.Parent = v_u_239
				end
				v_u_239.Parent = v_u_235
				::l10::
				v_u_242()
				return
			end
		end
		if v_u_239 then
			v_u_239.Parent = nil
		end
		goto l10
	end
	function v_u_234.IsEquipped(p268)
		-- upvalues: (ref) v_u_55
		local v269 = p268.Tool
		if v269 then
			v269 = v269.Parent == v_u_55
		end
		return v269
	end
	function v_u_234.Swap(p270, p271)
		-- upvalues: (ref) v_u_10
		local v272 = p270.Tool
		local v273 = p271.Tool
		local v274 = p270.Favorited
		local v275 = p271.Favorited
		p270:Clear()
		if v273 then
			p271:Clear()
			p270:Fill(v273)
			p270.Favorited = v275
			if v275 then
				if not p270.Frame:FindFirstChild("FavoriteIcon") then
					script.FavoriteIcon:Clone().Parent = p270.Frame
				end
				p270.Frame.BackgroundColor3 = v_u_10
			end
		end
		if v272 then
			p271:Fill(v272)
			p271.Favorited = v274
			if v274 then
				if not p271.Frame:FindFirstChild("FavoriteIcon") then
					script.FavoriteIcon:Clone().Parent = p271.Frame
				end
				p271.Frame.BackgroundColor3 = v_u_10
				return
			end
		else
			p271:Clear()
		end
	end
	function v_u_234.TurnNumber(_, p276)
		-- upvalues: (ref) v_u_241
		if v_u_241 then
			v_u_241.Visible = p276
		end
	end
	function v_u_234.SetClickability(p277, p278)
		-- upvalues: (ref) v_u_30, (ref) v_u_235, (copy) v_u_242
		if p277.Tool then
			if v_u_30.VREnabled then
				v_u_235.Draggable = false
			else
				v_u_235.Draggable = not p278
			end
			v_u_242()
		end
	end
	function v_u_234.Select(_)
		-- upvalues: (copy) v_u_234, (ref) v_u_55, (ref) v_u_56, (ref) v_u_12, (ref) v_u_21, (ref) v_u_78, (ref) v_u_57, (ref) v_u_11, (ref) v_u_1
		local v279 = v_u_234.Tool
		if v279 then
			local v280
			if v279 then
				v280 = v279.Parent == v_u_55
			else
				v280 = v279
			end
			if v280 then
				if v_u_56 then
					v_u_56:UnequipTools()
				end
				v_u_12:Play()
				v_u_21 = nil
				v_u_78 = nil
			elseif v279.Parent == v_u_57 then
				v_u_11:Play()
				if v_u_56 and v_u_56.Health > 0 then
					if v_u_56 then
						v_u_56:UnequipTools()
					end
					v279.Parent = v_u_55
				end
				v_u_21 = v_u_234
				v_u_78 = nil
			end
			if v_u_21 then
				v_u_1.SelectedSlotChanged:Fire({
					["SlotNumber"] = v_u_21.Index,
					["Tool"] = v_u_21.Tool,
					["IsEquipped"] = v_u_21:IsEquipped()
				})
				return
			end
			v_u_1.SelectedSlotChanged:Fire(nil)
		end
	end
	v_u_235 = v_u_88("TextButton", v233)
	local v_u_281 = Instance.new("UIStroke")
	v_u_281.Parent = v_u_235
	local v282 = Instance.new("UICorner")
	v282.CornerRadius = script:GetAttribute("CornerRadius")
	v282.Parent = v_u_235
	v_u_281.Thickness = 0
	v_u_235.BackgroundColor3 = v_u_5
	v_u_281.Color = v_u_9
	v_u_235.Text = ""
	v_u_235.AutoButtonColor = false
	v_u_235.BorderSizePixel = 0
	v_u_235.Size = UDim2.new(0, v_u_2, 0, v_u_2)
	v_u_235.Active = true
	v_u_235.Draggable = false
	v_u_235.BackgroundTransparency = v_u_8
	local v_u_283 = false
	v_u_235.MouseButton1Click:connect(function()
		-- upvalues: (ref) v_u_83, (ref) v_u_283, (copy) v_u_234, (ref) v_u_20, (ref) v_u_84, (ref) v_u_14, (ref) v_u_59
		if v_u_83.suppressClick then
			return
		elseif v_u_283 then
			v_u_283 = false
		else
			local v284 = v_u_234
			if v_u_20.GamepadCursorEnabled then
				if not v_u_84 then
					return
				end
				local v285 = v_u_84.X
				local v286 = v_u_84.Y
				local v287 = (1 / 0)
				local v288 = nil
				for v289 = 1, v_u_14 do
					local v290 = v_u_59[v289]
					if v290 and (v290.Frame and v290.Frame.Visible) then
						local v291 = v290.Frame.AbsolutePosition
						local v292 = v290.Frame.AbsoluteSize
						local v293 = v291.X + v292.X / 2
						local v294 = v291.Y + v292.Y / 2
						local v295 = (v285 - v293) * (v285 - v293) + (v286 - v294) * (v286 - v294)
						if v295 < v287 then
							v288 = v290
							v287 = v295
						end
					end
				end
				if v288 ~= v_u_234 then
					return
				end
			end
			changeSlot(v284)
		end
	end)
	v_u_235.MouseButton2Click:connect(function()
		-- upvalues: (copy) v_u_234
		v_u_234:Favorite()
	end)
	local v_u_296 = nil
	v_u_235.InputBegan:connect(function(p297)
		-- upvalues: (ref) v_u_296, (ref) v_u_20, (ref) v_u_84
		if p297.UserInputType == Enum.UserInputType.Touch then
			v_u_296 = tick()
		elseif p297.UserInputType == Enum.UserInputType.MouseButton1 and v_u_20.GamepadCursorEnabled then
			v_u_84 = p297.Position
			v_u_296 = tick()
		end
	end)
	v_u_235.InputEnded:connect(function(p298)
		-- upvalues: (ref) v_u_296, (ref) v_u_20, (ref) v_u_84, (ref) v_u_83, (ref) v_u_283, (copy) v_u_234, (ref) v_u_14, (ref) v_u_59
		if (p298.UserInputType == Enum.UserInputType.Touch or p298.UserInputType == Enum.UserInputType.MouseButton1) and v_u_296 then
			if v_u_20.GamepadCursorEnabled then
				v_u_84 = p298.Position
			end
			if v_u_83.tool or v_u_83.suppressClick then
				v_u_296 = nil
				return
			end
			if tick() - v_u_296 >= 0.5 then
				v_u_283 = true
				local v299 = v_u_234
				if v_u_20.GamepadCursorEnabled then
					if not v_u_84 then
						v_u_296 = nil
						return
					end
					local v300 = v_u_84.X
					local v301 = v_u_84.Y
					local v302 = (1 / 0)
					local v303 = nil
					for v304 = 1, v_u_14 do
						local v305 = v_u_59[v304]
						if v305 and (v305.Frame and v305.Frame.Visible) then
							local v306 = v305.Frame.AbsolutePosition
							local v307 = v305.Frame.AbsoluteSize
							local v308 = v306.X + v307.X / 2
							local v309 = v306.Y + v307.Y / 2
							local v310 = (v300 - v308) * (v300 - v308) + (v301 - v309) * (v301 - v309)
							if v310 < v302 then
								v303 = v305
								v302 = v310
							end
						end
					end
					if v303 ~= v_u_234 then
						v_u_296 = nil
						return
					end
				end
				v299:Favorite()
			end
			v_u_296 = nil
		end
	end)
	v_u_234.Frame = v_u_235
	local v311 = v_u_88("Frame", "SelectionObjectClipper")
	v311.Visible = false
	v311.Parent = v_u_235
	local v312 = v_u_88("ImageLabel", "Selector")
	v312.Size = UDim2.new(1, 0, 1, 0)
	v312.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
	v312.ScaleType = Enum.ScaleType.Slice
	v312.SliceCenter = Rect.new(12, 12, 52, 52)
	v312.Parent = v311
	v_u_236 = v_u_88("ImageLabel", "Icon")
	v_u_236.Size = UDim2.new(0.8, 0, 0.8, 0)
	v_u_236.Position = UDim2.new(0.1, 0, 0.1, 0)
	v_u_236.Parent = v_u_235
	v_u_237 = v_u_88("TextLabel", "ToolName")
	v_u_237.Size = UDim2.new(1, -2, 1, -2)
	v_u_237.Position = UDim2.new(0, 1, 0, 1)
	v_u_237.Parent = v_u_235
	v_u_237.ZIndex = 2
	v_u_234.Frame.LayoutOrder = v_u_234.Index
	v_u_240 = v_u_88("TextLabel", "ToolTip")
	v_u_240.ZIndex = 2
	v_u_240.FontFace = script:GetAttribute("ToolTipFont")
	v_u_240.TextWrapped = false
	v_u_240.TextYAlignment = Enum.TextYAlignment.Center
	v_u_240.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
	v_u_240.BackgroundTransparency = 0
	v_u_240.Visible = false
	v_u_240.Parent = v_u_235
	local v313 = Instance.new("UICorner")
	v313.CornerRadius = script:GetAttribute("CornerRadius")
	v313.Parent = v_u_240
	v_u_235.MouseEnter:connect(function(p314, p315)
		-- upvalues: (ref) v_u_240, (ref) v_u_20, (ref) v_u_14, (ref) v_u_59, (copy) v_u_234
		local v316 = v_u_240
		if v_u_20.GamepadCursorEnabled then
			if not p314 then
				return
			end
			local v317 = (1 / 0)
			local v318 = nil
			for v319 = 1, v_u_14 do
				local v320 = v_u_59[v319]
				if v320 and (v320.Frame and v320.Frame.Visible) then
					local v321 = v320.Frame.AbsolutePosition
					local v322 = v320.Frame.AbsoluteSize
					local v323 = v321.X + v322.X / 2
					local v324 = v321.Y + v322.Y / 2
					local v325 = (p314 - v323) * (p314 - v323) + (p315 - v324) * (p315 - v324)
					if v325 < v317 then
						v318 = v320
						v317 = v325
					end
				end
			end
			if v318 ~= v_u_234 then
				return
			end
		end
		if v316.Text ~= "" then
			for v326 = 1, v_u_14 do
				local v327 = v_u_59[v326]
				if v327 and v327.Frame then
					local v328 = v327.Frame:FindFirstChild("ToolTip")
					if v328 and v328 ~= v316 then
						v328.Visible = false
					end
				end
			end
			v316.Visible = true
		end
	end)
	v_u_235.MouseLeave:connect(function()
		-- upvalues: (ref) v_u_240
		v_u_240.Visible = false
	end)
	v_u_235.MouseMoved:connect(function(p329, p330)
		-- upvalues: (ref) v_u_20, (ref) v_u_14, (ref) v_u_59, (copy) v_u_234, (ref) v_u_240
		if v_u_20.GamepadCursorEnabled then
			local v331 = (1 / 0)
			local v332 = nil
			for v333 = 1, v_u_14 do
				local v334 = v_u_59[v333]
				if v334 and (v334.Frame and v334.Frame.Visible) then
					local v335 = v334.Frame.AbsolutePosition
					local v336 = v334.Frame.AbsoluteSize
					local v337 = v335.X + v336.X / 2
					local v338 = v335.Y + v336.Y / 2
					local v339 = (p329 - v337) * (p329 - v337) + (p330 - v338) * (p330 - v338)
					if v339 < v331 then
						v332 = v334
						v331 = v339
					end
				end
			end
			if v332 == v_u_234 then
				if v_u_240.Text ~= "" then
					for v340 = 1, v_u_14 do
						local v341 = v_u_59[v340]
						if v341 and v341.Frame then
							local v342 = v341.Frame:FindFirstChild("ToolTip")
							if v342 and v342 ~= v_u_240 then
								v342.Visible = false
							end
						end
					end
					v_u_240.Visible = true
				end
			end
		else
			return
		end
	end)
	function v_u_234.MoveToInventory(p343)
		-- upvalues: (copy) v_u_234, (ref) v_u_14, (ref) v_u_163, (ref) v_u_55, (ref) v_u_56
		if v_u_234.Index <= v_u_14 then
			local v344 = v_u_234.Tool
			p343:Clear()
			v_u_163(v344)
			if v344 then
				v344 = v344.Parent == v_u_55
			end
			if v344 and v_u_56 then
				v_u_56:UnequipTools()
			end
		end
	end
	if v233 < 10 or v233 == v_u_14 then
		local v345 = v233 < 10 and (v233 or 0) or 0
		v_u_241 = v_u_88("TextLabel", "Number")
		v_u_241.Text = v345
		v_u_241.Size = UDim2.new(0, 15, 0, 15)
		v_u_241.Visible = false
		v_u_241.Parent = v_u_235
		v_u_62[v_u_26 + v345] = v_u_234.Select
	end
	local v_u_346 = v_u_235.Position
	local v_u_347 = 0
	local v_u_348 = nil
	v_u_235.DragBegin:connect(function(p349)
		-- upvalues: (ref) v_u_63, (ref) v_u_235, (ref) v_u_346, (copy) v_u_281, (ref) v_u_58, (ref) v_u_236, (ref) v_u_237, (ref) v_u_241, (ref) v_u_239, (ref) v_u_348
		v_u_63[v_u_235] = true
		v_u_346 = p349
		v_u_281.Thickness = 2
		v_u_58:lock()
		v_u_235.ZIndex = 2
		v_u_236.ZIndex = 2
		v_u_237.ZIndex = 2
		v_u_235.Parent.ZIndex = 2
		if v_u_241 then
			v_u_241.ZIndex = 2
		end
		if v_u_239 then
			v_u_239.ZIndex = 2
			for _, v350 in pairs(v_u_239:GetChildren()) do
				if not (v350:IsA("UICorner") or v350:IsA("UIStroke")) then
					v350.ZIndex = 2
				end
			end
		end
		v_u_348 = v_u_235.Parent
	end)
	v_u_235.DragStopped:connect(function(p351, p352)
		-- upvalues: (ref) v_u_235, (ref) v_u_346, (ref) v_u_348, (copy) v_u_281, (ref) v_u_58, (ref) v_u_236, (ref) v_u_237, (ref) v_u_241, (ref) v_u_239, (ref) v_u_63, (copy) v_u_234, (ref) v_u_49, (ref) v_u_48, (ref) v_u_14, (ref) v_u_59, (ref) v_u_347
		local v353 = tick()
		v_u_235.Position = v_u_346
		v_u_235.Parent = v_u_348
		v_u_281.Thickness = 0
		v_u_58:unlock()
		v_u_235.ZIndex = 1
		v_u_236.ZIndex = 1
		v_u_237.ZIndex = 1
		v_u_348.ZIndex = 1
		if v_u_241 then
			v_u_241.ZIndex = 1
		end
		if v_u_239 then
			v_u_239.ZIndex = 1
			for _, v354 in pairs(v_u_239:GetChildren()) do
				if not (v354:IsA("UICorner") or v354:IsA("UIStroke")) then
					v354.ZIndex = 1
				end
			end
		end
		v_u_63[v_u_235] = nil
		if v_u_234.Tool then
			local v355 = v_u_49
			local v356 = v355.AbsolutePosition
			local v357 = v355.AbsoluteSize
			local v358
			if v356.X < p351 and (p351 <= v356.X + v357.X and v356.Y < p352) then
				v358 = p352 <= v356.Y + v357.Y
			else
				v358 = false
			end
			if v358 then
				v_u_234:MoveToInventory()
			else
				local v359 = v_u_48
				local v360 = v359.AbsolutePosition
				local v361 = v359.AbsoluteSize
				local v362
				if v360.X < p351 and (p351 <= v360.X + v361.X and v360.Y < p352) then
					v362 = p352 <= v360.Y + v361.Y
				else
					v362 = false
				end
				if v362 then
					local v363 = { (1 / 0), nil }
					for v364 = 1, v_u_14 do
						local v365 = v_u_59[v364]
						local v366 = v365.Frame
						local v367 = Vector2.new(p351, p352)
						local v368 = (v366.AbsolutePosition + v366.AbsoluteSize / 2 - v367).magnitude
						if v368 < v363[1] then
							v363 = { v368, v365 }
						end
					end
					local v369 = v363[2]
					if v369 ~= v_u_234 then
						v_u_234:Swap(v369)
					end
				else
					v_u_234:MoveToInventory()
				end
			end
			v_u_347 = v353
		end
	end)
	v_u_235.Parent = p231
	v_u_59[v233] = v_u_234
	return v_u_234
end
local v_u_371 = {}
local v_u_372 = {
	["Seeds"] = {},
	["Plants"] = {},
	["Tools"] = {}
}
local v_u_373 = {
	["Seeds"] = "rbxassetid://78047925319433",
	["Plants"] = "rbxassetid://79092290424282",
	["Tools"] = "rbxassetid://133028792779710"
}
local v_u_374 = nil
local v_u_375 = {}
function v_u_1.SetToolGroup(_, p376, p377)
	-- upvalues: (ref) v_u_371, (ref) v_u_372
	local v378 = v_u_371[p376]
	if v378 then
		local v379 = v_u_372[v378]
		if v379 then
			for v380, v381 in v379 do
				if v381 == p376 then
					table.remove(v379, v380)
					break
				end
			end
		end
	end
	v_u_371[p376] = p377
	if not v_u_372[p377] then
		v_u_372[p377] = {}
	end
	local v382 = v_u_372[p377]
	table.insert(v382, p376)
	if RefreshGroupButtons then
		RefreshGroupButtons()
	end
end
function v_u_1.RemoveToolGroup(_, p383)
	-- upvalues: (ref) v_u_371, (ref) v_u_372
	local v384 = v_u_371[p383]
	if v384 then
		local v385 = v_u_372[v384]
		if v385 then
			for v386, v387 in v385 do
				if v387 == p383 then
					table.remove(v385, v386)
					break
				end
			end
		end
		v_u_371[p383] = nil
	end
	if RefreshGroupButtons then
		RefreshGroupButtons()
	end
end
function v_u_1.ClearAllGroups(_)
	-- upvalues: (ref) v_u_371, (ref) v_u_372
	v_u_371 = {}
	v_u_372 = {}
	if RefreshGroupButtons then
		RefreshGroupButtons()
	end
end
function v_u_1.GetToolGroup(_, p388)
	-- upvalues: (ref) v_u_371
	return v_u_371[p388]
end
function v_u_1.GetAllGroups(_)
	-- upvalues: (ref) v_u_372
	local v389 = {}
	for v390, _ in v_u_372 do
		table.insert(v389, v390)
	end
	return v389
end
function v_u_1.GetToolsInGroup(_, p391)
	-- upvalues: (ref) v_u_372
	return v_u_372[p391] or {}
end
local function v_u_403(p392)
	-- upvalues: (ref) v_u_55, (ref) v_u_56, (copy) v_u_1, (ref) v_u_71, (ref) v_u_65, (copy) v_u_61, (ref) v_u_46, (ref) v_u_60, (ref) v_u_59, (ref) v_u_163, (ref) v_u_57, (copy) v_u_94, (ref) v_u_75, (ref) v_u_95, (ref) v_u_49
	if not p392:IsA("Tool") then
		if p392:IsA("Humanoid") and p392.Parent == v_u_55 then
			v_u_56 = p392
		end
		return
	end
	p392.CanBeDropped = false
	local v393 = p392:GetAttribute("Type")
	if v393 then
		v_u_1:SetToolGroup(p392, v393)
	end
	if p392.Parent == v_u_55 then
		v_u_71 = tick()
	end
	if not v_u_65 and (p392.Parent == v_u_55 and not v_u_61[p392]) then
		local v394 = v_u_46:FindFirstChild("StarterGear")
		if v394 and v394:FindFirstChild(p392.Name) then
			v_u_65 = true
			local v395 = v_u_60
			if v395 then
				for v396 = v395.Index, 1, -1 do
					local v397 = v_u_59[v396]
					local v398 = v396 - 1
					if v398 > 0 then
						v_u_59[v398]:Swap(v397)
					else
						v397:Fill(p392)
					end
				end
			else
				v_u_163(p392)
			end
			for _, v399 in pairs(v_u_55:GetChildren()) do
				if v399:IsA("Tool") and v399 ~= p392 then
					v399.Parent = v_u_57
				end
			end
			v_u_94()
			return
		end
	end
	local v400 = v_u_61[p392]
	if v400 then
		v400:UpdateEquipView()
		return
	end
	local v401 = false
	for _, v402 in ipairs(v_u_75) do
		if v402.Tool == p392 then
			v401 = true
			break
		end
	end
	if v401 then
		v_u_95()
	elseif v_u_60 then
		v_u_60:Fill(p392)
		if not v_u_49.Visible then
			v_u_94()
			return
		end
	else
		v_u_163(p392)
	end
end
local function v_u_407(p404)
	-- upvalues: (ref) v_u_71, (ref) v_u_55, (ref) v_u_57, (copy) v_u_61, (ref) v_u_49, (copy) v_u_94, (ref) v_u_167
	if p404:IsA("Tool") then
		v_u_71 = tick()
		local v405 = p404.Parent
		if v405 ~= v_u_55 and v405 ~= v_u_57 then
			local v406 = v_u_61[p404]
			if v406 then
				v406:Clear()
				if not v_u_49.Visible then
					v_u_94()
					return
				end
			else
				v_u_167(p404)
			end
		end
	else
		return
	end
end
local function v429(p408)
	-- upvalues: (copy) v_u_14, (ref) v_u_59, (ref) v_u_75, (ref) v_u_76, (ref) v_u_95, (ref) v_u_69, (ref) v_u_55, (copy) v_u_407, (copy) v_u_403, (ref) v_u_57, (ref) v_u_46, (copy) v_u_94
	for v409 = 1, v_u_14 do
		local v410 = v_u_59[v409]
		if v410.Tool then
			v410:Clear()
		end
	end
	v_u_75 = {}
	v_u_76 = {}
	v_u_95()
	for _, v411 in pairs(v_u_69) do
		v411:Disconnect()
	end
	v_u_69 = {}
	v_u_55 = p408
	local v412 = v_u_69
	local v413 = p408.ChildRemoved
	local v414 = v_u_407
	table.insert(v412, v413:Connect(v414))
	local v415 = v_u_69
	local v416 = p408.ChildAdded
	local v417 = v_u_403
	table.insert(v415, v416:Connect(v417))
	for _, v418 in pairs(p408:GetChildren()) do
		v_u_403(v418)
	end
	local v_u_419 = p408:FindFirstChildOfClass("Humanoid") or p408:WaitForChild("Humanoid")
	if v_u_419 then
		local v420 = v_u_69
		local v421 = v_u_419.Died
		table.insert(v420, v421:Connect(function()
			-- upvalues: (copy) v_u_419
			v_u_419:UnequipTools()
		end))
	end
	v_u_57 = v_u_46:WaitForChild("Backpack")
	local v422 = v_u_69
	local v423 = v_u_57.ChildRemoved
	local v424 = v_u_407
	table.insert(v422, v423:Connect(v424))
	local v425 = v_u_69
	local v426 = v_u_57.ChildAdded
	local v427 = v_u_403
	table.insert(v425, v426:Connect(v427))
	task.wait(0.1)
	for _, v428 in pairs(v_u_57:GetChildren()) do
		if v428:IsA("Tool") then
			v_u_403(v428)
		end
	end
	v_u_94()
end
local function v435(p430, p431)
	-- upvalues: (copy) v_u_30, (ref) v_u_67, (ref) v_u_66, (copy) v_u_27, (copy) v_u_62, (ref) v_u_49, (copy) v_u_58
	local v432 = v_u_30:GetFocusedTextBox()
	if not v432 then
		if not (v432 or p431) then
			local v433 = p430.UserInputType == Enum.UserInputType.Keyboard and (not v432 and (not v_u_67 and (v_u_66 or p430.KeyCode.Value == v_u_27 and not v432))) and v_u_62[p430.KeyCode.Value]
			if v433 then
				v433(p431)
			end
			local v434 = p430.UserInputType
			if not p431 and (not v432 and (v434 == Enum.UserInputType.MouseButton1 or v434 == Enum.UserInputType.Touch)) and v_u_49.Visible then
				v_u_58:deselect()
			end
		end
	end
end
local function v439(p436)
	-- upvalues: (copy) v_u_30, (copy) v_u_14, (ref) v_u_59
	if p436 == "KeyboardEnabled" or p436 == "VREnabled" then
		local v437 = v_u_30.KeyboardEnabled
		if v437 then
			v437 = not v_u_30.VREnabled
		end
		for v438 = 1, v_u_14 do
			v_u_59[v438]:TurnNumber(v437)
		end
	end
end
local v_u_440 = nil
local v_u_441 = nil
local function v_u_442() end
local _ = Vector2.new(0, 0)
function unbindAllGamepadEquipActions()
	-- upvalues: (copy) v_u_39
	v_u_39:UnbindAction("RBXBackpackHasGamepadFocus")
	v_u_39:UnbindAction("RBXCloseInventory")
end
function changeToolFunc(_, p443, p_u_444)
	-- upvalues: (ref) v_u_440, (ref) v_u_441, (ref) v_u_56, (copy) v_u_14, (ref) v_u_59, (ref) v_u_74
	if p443 == Enum.UserInputState.Begin then
		if v_u_440 and (v_u_440.KeyCode == Enum.KeyCode.ButtonR1 and p_u_444.KeyCode == Enum.KeyCode.ButtonL1 or v_u_440.KeyCode == Enum.KeyCode.ButtonL1 and p_u_444.KeyCode == Enum.KeyCode.ButtonR1) and tick() - v_u_441 <= 0.06 then
			if v_u_56 then
				v_u_56:UnequipTools()
			end
			v_u_440 = p_u_444
			v_u_441 = tick()
		else
			v_u_440 = p_u_444
			v_u_441 = tick()
			delay(0.06, function()
				-- upvalues: (ref) v_u_440, (copy) p_u_444, (ref) v_u_14, (ref) v_u_59, (ref) v_u_56, (ref) v_u_74
				if v_u_440 == p_u_444 then
					local v445 = p_u_444.KeyCode == Enum.KeyCode.ButtonL1 and -1 or 1
					for v446 = 1, v_u_14 do
						if v_u_59[v446]:IsEquipped() then
							local v447 = v445 + v446
							local v448 = false
							if v_u_14 < v447 then
								v447 = 1
								v448 = true
							elseif v447 < 1 then
								v447 = v_u_14
								v448 = true
							end
							local v449 = v447
							while not v_u_59[v447].Tool do
								v447 = v447 + v445
								if v447 == v449 then
									return
								end
								if v_u_14 < v447 then
									v447 = 1
									v448 = true
								elseif v447 < 1 then
									v447 = v_u_14
									v448 = true
								end
							end
							if v448 then
								if v_u_56 then
									v_u_56:UnequipTools()
								end
								v_u_74 = nil
							else
								v_u_59[v447]:Select()
							end
						end
					end
					if v_u_74 and v_u_74.Tool then
						v_u_74:Select()
					else
						for v450 = v445 == -1 and (v_u_14 or 1) or 1, v445 == -1 and 1 or v_u_14, v445 do
							if v_u_59[v450].Tool then
								v_u_59[v450]:Select()
								return
							end
						end
					end
				else
					return
				end
			end)
		end
	else
		return
	end
end
function getGamepadSwapSlot()
	-- upvalues: (copy) v_u_14, (ref) v_u_59
	for v451 = 1, v_u_14 do
		if v_u_59[v451].Frame:WaitForChild("UIStroke").Thickness > 0 then
			return v_u_59[v451]
		end
	end
end
function changeSlot(p_u_452)
	-- upvalues: (copy) v_u_40, (ref) v_u_49, (copy) v_u_34, (ref) v_u_50, (ref) v_u_2, (ref) v_u_48, (copy) v_u_14, (ref) v_u_64, (ref) v_u_59
	local v453 = not v_u_40.VREnabled or v_u_49.Visible
	if p_u_452.Frame == v_u_34.SelectedObject and v453 then
		local v454 = getGamepadSwapSlot()
		if not v454 then
			local v_u_455 = UDim2.new(0, v_u_2, 0, v_u_2)
			local v456 = v_u_48.Size.X.Offset / 2
			local v457 = v_u_2 + 5
			local v458 = v_u_49.Visible
			local v459 = v458 and v_u_14 or v_u_64
			local v460 = 0
			for v461 = 1, v_u_14 do
				local v462 = v_u_59[v461]
				if v462.Tool or v458 then
					v460 = v460 + 1
				end
				if v462 == p_u_452 then
					break
				end
			end
			local v463 = v460 - (v459 / 2 + 0.5)
			local v_u_464 = UDim2.new(0, v456 - v_u_2 / 2 + v457 * v463, 0, 5)
			p_u_452.Frame.Size = v_u_455
			p_u_452.Frame.Position = v_u_464
			p_u_452.Frame:TweenSizeAndPosition(v_u_455 + UDim2.new(0, 10, 0, 10), v_u_464 - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function()
				-- upvalues: (copy) p_u_452, (copy) v_u_455, (copy) v_u_464
				p_u_452.Frame:TweenSizeAndPosition(v_u_455, v_u_464, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true)
			end)
			p_u_452.Frame:WaitForChild("UIStroke").Thickness = 3
			v_u_50.SelectionImageObject.Visible = true
			return
		end
		v454.Frame:WaitForChild("UIStroke").Thickness = 0
		if v454 ~= p_u_452 then
			p_u_452:Swap(v454)
			v_u_50.SelectionImageObject.Visible = false
			return
		end
	else
		p_u_452:Select()
		v_u_50.SelectionImageObject.Visible = false
	end
end
function vrMoveSlotToInventory()
	-- upvalues: (copy) v_u_40, (ref) v_u_50
	if v_u_40.VREnabled then
		local v465 = getGamepadSwapSlot()
		if v465 and v465.Tool then
			v465.Frame:WaitForChild("UIStroke").Thickness = 0
			v465:MoveToInventory()
			v_u_50.SelectionImageObject.Visible = false
		end
	end
end
function enableGamepadInventoryControl()
	-- upvalues: (ref) v_u_49, (copy) v_u_58, (copy) v_u_39, (copy) v_u_442, (copy) v_u_20, (ref) v_u_48, (copy) v_u_30, (copy) v_u_34
	local function v468(_, p466, _)
		-- upvalues: (ref) v_u_49, (ref) v_u_58
		if p466 == Enum.UserInputState.Begin then
			local v467 = getGamepadSwapSlot()
			if v467 then
				v467.Frame:WaitForChild("UIStroke").Thickness = 0
			elseif v_u_49.Visible then
				v_u_58:deselect()
			end
		else
			return
		end
	end
	v_u_39:BindAction("RBXBackpackHasGamepadFocus", v_u_442, false, Enum.UserInputType.Gamepad1)
	v_u_39:BindAction("RBXCloseInventory", v468, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)
	v_u_20:EnableGamepadCursor(v_u_48:FindFirstChild("1"))
	if not v_u_30.VREnabled then
		v_u_34.SelectedObject = v_u_48:FindFirstChild("1")
	end
end
function disableGamepadInventoryControl()
	-- upvalues: (copy) v_u_20, (copy) v_u_14, (ref) v_u_59, (copy) v_u_34, (ref) v_u_47
	unbindAllGamepadEquipActions()
	v_u_20:DisableGamepadCursor()
	for v469 = 1, v_u_14 do
		local v470 = v_u_59[v469]
		if v470 and v470.Frame then
			v470.Frame:WaitForChild("UIStroke").Thickness = 0
		end
	end
	if v_u_34.SelectedObject and v_u_34.SelectedObject:IsDescendantOf(v_u_47) then
		v_u_34.SelectedObject = nil
	end
end
function gamepadDisconnected()
	-- upvalues: (ref) v_u_70
	v_u_70 = false
	disableGamepadInventoryControl()
end
function gamepadConnected()
	-- upvalues: (ref) v_u_70, (ref) v_u_64, (ref) v_u_66, (ref) v_u_44, (copy) v_u_39, (ref) v_u_49
	v_u_70 = true
	if v_u_64 >= 1 and (v_u_66 and not v_u_44) then
		v_u_44 = true
		v_u_39:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end
	if v_u_49.Visible then
		enableGamepadInventoryControl()
	end
end
local function v476(p471, p472)
	-- upvalues: (copy) v_u_88
	local v473 = v_u_88("ImageButton", p471)
	v473.Size = UDim2.new(0, 40, 0, 40)
	v473.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"
	local v474 = v_u_88("ImageLabel", "Icon")
	v474.Size = UDim2.new(0.5, 0, 0.5, 0)
	v474.Position = UDim2.new(0.25, 0, 0.25, 0)
	v474.Image = p472
	v474.Parent = v473
	local v475 = v_u_88("ImageLabel", "Selection")
	v475.Size = UDim2.new(0.9, 0, 0.9, 0)
	v475.Position = UDim2.new(0.05, 0, 0.05, 0)
	v475.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
	v473.SelectionImageObject = v475
	return v473, v474, v475
end
local v477 = v_u_88("Frame", "Backpack")
v477.Visible = false
v477.Parent = v_u_38
local v478 = v_u_88("Frame", "Hotbar")
v478.Parent = v477
local v_u_479 = v_u_75
local v_u_480 = v_u_79
local v_u_481 = v_u_78
local v_u_482 = v_u_80
local v_u_483 = v_u_158
local v_u_484 = v_u_95
local v_u_485 = v_u_163
local v_u_486 = v_u_167
local v_u_487 = v477
local v_u_488 = v478
for v489 = 1, v_u_14 do
	local v490 = v370(v_u_488, v489)
	v490.Frame.Visible = false
	if not v_u_60 then
		local v491 = v490
		v_u_60 = v491
	end
end
v_u_58.selected:Connect(function()
	-- upvalues: (copy) v_u_34, (copy) v_u_1
	if not v_u_34.MenuIsOpen then
		v_u_1.OpenClose()
	end
end)
v_u_58.deselected:Connect(function()
	-- upvalues: (ref) v_u_49, (copy) v_u_1
	if v_u_49.Visible then
		v_u_1.OpenClose()
	end
end)
v_u_30.InputBegan:Connect(function(p492)
	-- upvalues: (ref) v_u_49, (copy) v_u_58
	if p492.KeyCode == Enum.KeyCode.ButtonL3 and v_u_49.Visible then
		v_u_58:deselect()
	end
end)
function v_u_1.DrawUI(_) end
LeftBumperButton = v_u_88("ImageLabel", "LeftBumper")
LeftBumperButton.Size = UDim2.new(0, 40, 0, 40)
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2)
RightBumperButton = v_u_88("ImageLabel", "RightBumper")
RightBumperButton.Size = UDim2.new(0, 40, 0, 40)
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2)
local v493 = v_u_88("Frame", "Inventory")
local v494 = Instance.new("UICorner")
v494.CornerRadius = script:GetAttribute("CornerRadius")
v494.Parent = v493
v493.BackgroundTransparency = v_u_4
v493.BackgroundColor3 = v_u_5
v493.Active = true
v493.Visible = false
v493.Parent = v_u_487
local v495 = v_u_88("TextButton", "VRInventorySelector")
v495.Position = UDim2.new(0, 0, 0, 0)
v495.Size = UDim2.new(1, 0, 1, 0)
v495.BackgroundTransparency = 1
v495.Text = ""
v495.Parent = v493
local v_u_496 = v_u_88("TextLabel", "GroupTitle")
v_u_496.Size = UDim2.new(0, 100, 0, 20)
v_u_496.Position = UDim2.new(0, 8, 0, 8)
v_u_496.Text = "All Items"
v_u_496.TextXAlignment = Enum.TextXAlignment.Left
v_u_496.FontFace = script:GetAttribute("LabelFont")
v_u_496.TextSize = 32
v_u_496.TextColor3 = script:GetAttribute("TextColor")
v_u_496.BackgroundTransparency = 1
v_u_496.ZIndex = 2
v_u_496.Parent = v493
local v497 = v_u_88("ImageLabel", "Selector")
v497.Size = UDim2.new(1, 0, 1, 0)
v497.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
v497.ScaleType = Enum.ScaleType.Slice
v497.SliceCenter = Rect.new(12, 12, 52, 52)
v497.Visible = false
v495.SelectionImageObject = v497
v495.MouseButton1Click:Connect(function()
	vrMoveSlotToInventory()
end)
local v498 = v_u_88("ScrollingFrame", "ScrollingFrame")
v498.Selectable = false
v498.CanvasSize = UDim2.new(0, 0, 0, 0)
v498.Parent = v493
local v499 = v_u_88("Frame", "UIGridFrame")
v499.Selectable = false
v499.Size = UDim2.new(1, -10, 1, 0)
v499.Position = UDim2.new(0, 5, 0, 0)
v499.Parent = v498
local v_u_500 = v493
local v_u_501 = v498
local v502 = v499
for v503 = 1, 80 do
	local v504 = v230(v502, v503)
	table.insert(v_u_77, v504)
end
v_u_501.Changed:Connect(function(p505)
	-- upvalues: (ref) v_u_483
	if p505 == "CanvasPosition" or (p505 == "AbsoluteSize" or p505 == "AbsoluteWindowSize") then
		v_u_483()
	end
end)
local v_u_506 = v_u_88("Frame", "DragGhost")
v_u_506.Size = UDim2.new(0, v_u_2, 0, v_u_2)
v_u_506.BackgroundColor3 = v_u_5
v_u_506.BackgroundTransparency = v_u_8
v_u_506.ZIndex = 10
v_u_506.Visible = false
v_u_506.Parent = v_u_38
local v507 = Instance.new("UICorner")
v507.CornerRadius = script:GetAttribute("CornerRadius")
v507.Parent = v_u_506
local v508 = Instance.new("UIStroke")
v508.Color = v_u_9
v508.Thickness = 2
v508.Parent = v_u_506
local v_u_509 = v_u_88("ImageLabel", "Icon")
v_u_509.Size = UDim2.new(0.8, 0, 0.8, 0)
v_u_509.Position = UDim2.new(0.1, 0, 0.1, 0)
v_u_509.ZIndex = 10
v_u_509.Parent = v_u_506
local v_u_510 = v_u_88("TextLabel", "ToolName")
v_u_510.Size = UDim2.new(1, -2, 1, -2)
v_u_510.Position = UDim2.new(0, 1, 0, 1)
v_u_510.ZIndex = 11
v_u_510.Parent = v_u_506
local v_u_511 = v_u_34:GetGuiInset().Y
v_u_30.InputChanged:Connect(function(p512)
	-- upvalues: (copy) v_u_83, (copy) v_u_29, (copy) v_u_20, (copy) v_u_30, (copy) v_u_511, (copy) v_u_506, (ref) v_u_2, (copy) v_u_509, (copy) v_u_510
	if v_u_83.tool then
		local v513 = nil
		local v514 = false
		if p512.UserInputType == Enum.UserInputType.MouseMovement or p512.UserInputType == Enum.UserInputType.Touch then
			v513 = p512.Position
			v514 = true
		elseif (v_u_29[p512.UserInputType] or p512.KeyCode == Enum.KeyCode.Thumbstick1) and v_u_20.GamepadCursorEnabled then
			local v515 = v_u_30:GetMouseLocation()
			local v516 = v515.X
			local v517 = v515.Y - v_u_511
			v513 = Vector3.new(v516, v517, 0)
			v514 = true
		end
		if v514 and v513 then
			if v_u_83.active and v_u_506.Visible then
				v_u_506.Position = UDim2.new(0, v513.X - v_u_2 / 2, 0, v513.Y - v_u_2 / 2 + v_u_511)
				return
			elseif v_u_83.startPos then
				if (Vector2.new(v513.X, v513.Y) - v_u_83.startPos).Magnitude > 10 then
					v_u_83.active = true
					v_u_83.suppressClick = true
					local v518 = v_u_83.tool
					v_u_509.Image = v518.TextureId
					if v518.TextureId == "" then
						v_u_510.Visible = true
						v_u_510.Text = v518.Name
					else
						v_u_510.Visible = false
					end
					v_u_506.Position = UDim2.new(0, v513.X - v_u_2 / 2, 0, v513.Y - v_u_2 / 2 + v_u_511)
					v_u_506.Visible = true
				end
			end
		else
			return
		end
	else
		return
	end
end)
v_u_30.InputEnded:Connect(function(p519)
	-- upvalues: (copy) v_u_83, (copy) v_u_29, (copy) v_u_506, (copy) v_u_30, (copy) v_u_511, (ref) v_u_488, (copy) v_u_14, (ref) v_u_59, (ref) v_u_486, (ref) v_u_485, (copy) v_u_94, (ref) v_u_484
	if v_u_83.tool then
		local v520 = false
		local v521
		if p519.UserInputType == Enum.UserInputType.MouseButton1 or p519.UserInputType == Enum.UserInputType.Touch then
			v521 = p519.UserInputType == v_u_83.inputType and true or v520
		else
			v521 = v_u_29[p519.UserInputType] and v_u_83.inputType == Enum.UserInputType.MouseButton1 and true or v520
		end
		if v521 then
			if v_u_83.active then
				v_u_506.Visible = false
				local v522 = v_u_30:GetMouseLocation()
				local v523 = v522.X
				local v524 = v522.Y - v_u_511
				local v525 = v_u_83.tool
				local v526 = v_u_488
				local v527 = v526.AbsolutePosition
				local v528 = v526.AbsoluteSize
				local v529
				if v527.X < v523 and (v523 <= v527.X + v528.X and v527.Y < v524) then
					v529 = v524 <= v527.Y + v528.Y
				else
					v529 = false
				end
				if v529 then
					local v530 = { (1 / 0), nil }
					for v531 = 1, v_u_14 do
						local v532 = v_u_59[v531]
						if v532.Frame.Visible then
							local v533 = v532.Frame
							local v534 = Vector2.new(v523, v524)
							local v535 = (v533.AbsolutePosition + v533.AbsoluteSize / 2 - v534).magnitude
							if v535 < v530[1] then
								v530 = { v535, v532 }
							end
						end
					end
					local v536 = v530[2]
					if v536 and v525 then
						if v536.Tool then
							local v537 = v536.Tool
							v536:Clear()
							v_u_486(v525)
							v536:Fill(v525)
							v_u_485(v537)
						else
							v_u_486(v525)
							v536:Fill(v525)
						end
						v_u_94()
						v_u_484()
					end
				end
			end
			v_u_83.tool = nil
			v_u_83.startPos = nil
			v_u_83.inputType = nil
			v_u_83.active = false
			if v_u_83.suppressClick then
				task.delay(0.05, function()
					-- upvalues: (ref) v_u_83
					v_u_83.suppressClick = false
				end)
			end
		end
	else
		return
	end
end)
local v538 = v476("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
v538.Size = UDim2.new(0, 34, 0, 34)
v538.Position = UDim2.new(0.5, -v538.Size.X.Offset / 2, 0, 43)
v538.Icon.Position = v538.Icon.Position - UDim2.new(0, 0, 0, 2)
v538.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_501, (ref) v_u_2
	local v539 = v_u_501
	local v540 = Vector2.new
	local v541 = v_u_501.CanvasPosition.X
	local v542 = v_u_501.CanvasSize.Y.Offset - v_u_501.AbsoluteWindowSize.Y
	local v543 = v_u_501.CanvasPosition.Y - (v_u_2 + 5)
	local v544 = math.max(0, v543)
	v539.CanvasPosition = v540(v541, (math.min(v542, v544)))
end)
local v545 = v476("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")
v545.Rotation = 180
v545.Icon.Position = v545.Icon.Position - UDim2.new(0, 0, 0, 2)
v545.Size = UDim2.new(0, 34, 0, 34)
v545.Position = UDim2.new(0.5, -v545.Size.X.Offset / 2, 1, -v545.Size.Y.Offset - 3)
v545.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_501, (ref) v_u_2
	local v546 = v_u_501
	local v547 = Vector2.new
	local v548 = v_u_501.CanvasPosition.X
	local v549 = v_u_501.CanvasSize.Y.Offset - v_u_501.AbsoluteWindowSize.Y
	local v550 = v_u_501.CanvasPosition.Y + (v_u_2 + 5)
	local v551 = math.max(0, v550)
	v546.CanvasPosition = v547(v548, (math.min(v549, v551)))
end)
v96()
local v_u_552 = v_u_41:Create("Frame")({
	["Name"] = "GamepadHintsFrame",
	["Size"] = UDim2.new(0, v_u_488.Size.X.Offset, 0, v_u_43 and 95 or 60),
	["BackgroundTransparency"] = 1,
	["Visible"] = false,
	["Parent"] = v_u_487
})
local function v560(p553, p554, p555)
	-- upvalues: (copy) v_u_41, (copy) v_u_552, (copy) v_u_43
	local v556 = v_u_41:Create("Frame")({
		["Name"] = "HintFrame",
		["Size"] = UDim2.new(1, 0, 1, -5),
		["Position"] = UDim2.new(0, 0, 0, 0),
		["BackgroundTransparency"] = 1,
		["Parent"] = v_u_552
	})
	local v557 = v_u_41:Create("ImageLabel")
	local v558 = {
		["Name"] = "HintImage",
		["Size"] = v_u_43 and UDim2.new(0, 90, 0, 90) or UDim2.new(0, 60, 0, 60),
		["BackgroundTransparency"] = 1
	}
	if v_u_43 then
		p553 = p554 or p553
	end
	v558.Image = p553
	v558.Parent = v556
	v557(v558)
	local v559 = v_u_41:Create("TextLabel")({
		["Name"] = "HintText",
		["Position"] = UDim2.new(0, v_u_43 and 100 or 70, 0, 0),
		["Size"] = UDim2.new(1, -(v_u_43 and 100 or 70), 1, 0),
		["Font"] = Enum.Font.SourceSansBold,
		["FontSize"] = v_u_43 and Enum.FontSize.Size36 or Enum.FontSize.Size24,
		["BackgroundTransparency"] = 1,
		["Text"] = p555,
		["TextColor3"] = Color3.new(1, 1, 1),
		["TextXAlignment"] = Enum.TextXAlignment.Left,
		["TextWrapped"] = true,
		["Parent"] = v556
	})
	Instance.new("UITextSizeConstraint", v559).MaxTextSize = v559.TextSize
end
local function v_u_566()
	-- upvalues: (copy) v_u_552, (ref) v_u_488, (copy) v_u_43, (ref) v_u_500
	v_u_552.Size = UDim2.new(v_u_488.Size.X.Scale, v_u_488.Size.X.Offset, 0, v_u_43 and 95 or 60)
	v_u_552.Position = UDim2.new(v_u_488.Position.X.Scale, v_u_488.Position.X.Offset, v_u_500.Position.Y.Scale, v_u_500.Position.Y.Offset - v_u_552.Size.Y.Offset)
	local v561 = v_u_552:GetChildren()
	local v562 = 0
	for v563 = 1, #v561 do
		v561[v563].Size = UDim2.new(1, 0, 1, -5)
		v561[v563].Position = UDim2.new(0, 0, 0, 0)
		v562 = v562 + (v561[v563].HintText.Position.X.Offset + v561[v563].HintText.TextBounds.X)
	end
	local v564 = (v_u_552.AbsoluteSize.X - v562) / (#v561 - 1)
	for v565 = 1, #v561 do
		v561[v565].Position = v565 == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v561[v565 - 1].Position.X.Offset + v561[v565 - 1].Size.X.Offset + v564, 0, 0)
		v561[v565].Size = UDim2.new(0, v561[v565].HintText.Position.X.Offset + v561[v565].HintText.TextBounds.X, 1, -5)
	end
end
v560("rbxasset://textures/ui/Settings/Help/XButtonDark.png", "rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png", "Remove From Hotbar")
v560("rbxasset://textures/ui/Settings/Help/AButtonDark.png", "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png", "Select/Swap")
v560("rbxasset://textures/ui/Settings/Help/BButtonDark.png", "rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png", "Close Backpack")
local v_u_567 = v_u_88("Frame", "Search")
local v568 = Instance.new("UICorner")
v568.CornerRadius = UDim.new(0, 4)
v568.Parent = v_u_567
v_u_567.BackgroundColor3 = v17
v_u_567.BackgroundTransparency = v19
v_u_567.Size = UDim2.new(0, 190, 0, 30)
v_u_567.Position = UDim2.new(1, -v_u_567.Size.X.Offset - 5, 0, 5)
v_u_567.Parent = v_u_500
local v569 = Instance.new("UIStroke")
v569.Color = Color3.fromRGB(73, 77, 90)
v569.Thickness = 2
v569.Parent = v_u_567
local v_u_570 = v_u_88("TextBox", "TextBox")
v_u_570.PlaceholderText = "Search"
v_u_570.TextColor3 = v18
v_u_570.ClearTextOnFocus = false
v_u_570.FontSize = Enum.FontSize.Size24
v_u_570.TextXAlignment = Enum.TextXAlignment.Left
v_u_570.PlaceholderColor3 = script:GetAttribute("SearchPlaceholderColor")
local v571 = Instance.new("ImageLabel")
v571.Parent = v_u_567
v571.BackgroundTransparency = 1
v571.Size = UDim2.fromScale(1, 1)
v571.SizeConstraint = Enum.SizeConstraint.RelativeYY
v571.Parent = v_u_567
v571.Image = "rbxassetid://16884179038"
v571.ImageRectSize = Vector2.new(108, 108)
v571.ImageRectOffset = Vector2.new(798, 660)
local v572 = Instance.new("UIPadding")
v572.Parent = v_u_570
v572.PaddingLeft = UDim.new(0, 8)
v_u_570.Size = v_u_567.Size - UDim2.fromOffset(34, 0)
v_u_570.Position = UDim2.new(0, 0 + (v571.AbsoluteSize.X + 30), 0, 0)
v_u_570.Parent = v_u_567
local v_u_573 = v_u_88("TextButton", "X")
local v574 = Instance.new("UICorner")
v574.CornerRadius = script:GetAttribute("CornerRadius")
v574.Parent = v_u_573
v_u_573.Font = Enum.Font.Arial
v_u_573.Text = "x"
v_u_573.ZIndex = 10
v_u_573.TextColor3 = v_u_7
v_u_573.FontSize = Enum.FontSize.Size24
v_u_573.TextYAlignment = Enum.TextYAlignment.Bottom
v_u_573.BackgroundColor3 = v17
v_u_573.BackgroundTransparency = 0
v_u_573.Size = UDim2.new(0, v_u_567.Size.Y.Offset - 10, 0, v_u_567.Size.Y.Offset - 10)
v_u_573.Position = UDim2.new(1, -v_u_573.Size.X.Offset - 10, 0.5, -v_u_573.Size.Y.Offset / 2)
v_u_573.Visible = false
v_u_573.BorderSizePixel = 0
v_u_573.Parent = v_u_567
local function v_u_577()
	-- upvalues: (copy) v_u_570, (ref) v_u_68, (ref) v_u_480, (ref) v_u_484, (copy) v_u_573, (ref) v_u_501
	local v575 = {}
	for v576 in v_u_570.Text:gmatch("%S+") do
		v575[v576:lower()] = true
	end
	if next(v575) then
		v_u_480 = v575
		v_u_68 = true
		v_u_501.CanvasPosition = Vector2.new(0, 0)
		v_u_484()
		v_u_573.ZIndex = 3
	elseif v_u_68 then
		v_u_68 = false
		v_u_480 = nil
		v_u_484()
		v_u_573.ZIndex = 0
	end
end
v_u_573.MouseButton1Click:Connect(function()
	-- upvalues: (ref) v_u_68, (ref) v_u_480, (ref) v_u_484, (copy) v_u_573, (copy) v_u_570
	if v_u_68 then
		v_u_68 = false
		v_u_480 = nil
		v_u_484()
		v_u_573.ZIndex = 0
	end
	v_u_570.Text = ""
end)
v_u_570.Changed:Connect(function(p578)
	-- upvalues: (copy) v_u_570, (ref) v_u_68, (ref) v_u_480, (ref) v_u_484, (copy) v_u_573, (copy) v_u_577
	if p578 == "Text" then
		local v579 = v_u_570.Text
		if v579 == "" then
			if v_u_68 then
				v_u_68 = false
				v_u_480 = nil
				v_u_484()
				v_u_573.ZIndex = 0
			end
		elseif v579 ~= "Search" then
			v_u_577()
		end
		v_u_573.Visible = false
	end
end)
v_u_570.FocusLost:Connect(function(p580)
	-- upvalues: (copy) v_u_577
	if p580 then
		v_u_577()
	end
end)
v_u_1.StateChanged.Event:Connect(function(p581)
	-- upvalues: (ref) v_u_68, (ref) v_u_480, (ref) v_u_484, (copy) v_u_573, (copy) v_u_570, (ref) v_u_500, (copy) v_u_58
	if not p581 then
		if v_u_68 then
			v_u_68 = false
			v_u_480 = nil
			v_u_484()
			v_u_573.ZIndex = 0
		end
		v_u_570.Text = ""
		if not v_u_500.Visible then
			v_u_58:deselect()
		end
	end
end)
v_u_62[Enum.KeyCode.Escape.Value] = function(p582)
	-- upvalues: (ref) v_u_68, (ref) v_u_480, (ref) v_u_484, (copy) v_u_573, (copy) v_u_570, (ref) v_u_500, (copy) v_u_58
	if p582 then
		if v_u_68 then
			v_u_68 = false
			v_u_480 = nil
			v_u_484()
			v_u_573.ZIndex = 0
		end
		v_u_570.Text = ""
	elseif v_u_500.Visible then
		v_u_58:deselect()
	end
end
v_u_30.LastInputTypeChanged:Connect(function(p583)
	-- upvalues: (copy) v_u_30, (copy) v_u_567
	if p583 == Enum.UserInputType.Gamepad1 and not v_u_30.VREnabled then
		v_u_567.Visible = false
	else
		v_u_567.Visible = true
	end
end)
v_u_34.MenuOpened:Connect(function()
	-- upvalues: (ref) v_u_500, (copy) v_u_58
	if v_u_500.Visible then
		v_u_58:deselect()
	end
end)
local function v_u_586(_, p584, _)
	-- upvalues: (copy) v_u_34, (copy) v_u_14, (ref) v_u_59
	if p584 == Enum.UserInputState.Begin then
		if v_u_34.SelectedObject then
			for v585 = 1, v_u_14 do
				if v_u_59[v585].Frame == v_u_34.SelectedObject and v_u_59[v585].Tool then
					v_u_59[v585]:MoveToInventory()
					return
				end
			end
		end
	else
		return
	end
end
v33:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
function v_u_1.OpenClose()
	-- upvalues: (ref) v_u_37, (copy) v_u_63, (ref) v_u_500, (copy) v_u_94, (ref) v_u_488, (copy) v_u_14, (ref) v_u_59, (ref) v_u_484, (ref) v_u_70, (copy) v_u_29, (copy) v_u_30, (copy) v_u_566, (copy) v_u_552, (copy) v_u_39, (copy) v_u_586, (copy) v_u_1
	if v_u_37 then
		if not next(v_u_63) then
			v_u_500.Visible = not v_u_500.Visible
			local v587 = v_u_500.Visible
			v_u_94()
			v_u_488.Active = not v_u_488.Active
			for v588 = 1, v_u_14 do
				v_u_59[v588]:SetClickability(not v587)
			end
		end
		if v_u_500.Visible then
			v_u_484()
			if v_u_70 then
				if v_u_29[v_u_30:GetLastInputType()] then
					v_u_566()
					v_u_552.Visible = not v_u_30.VREnabled
				end
				enableGamepadInventoryControl()
			end
		else
			if v_u_70 then
				v_u_552.Visible = false
			end
			disableGamepadInventoryControl()
		end
		if v_u_500.Visible then
			v_u_39:BindAction("RBXRemoveSlot", v_u_586, false, Enum.KeyCode.ButtonX)
		else
			v_u_39:UnbindAction("RBXRemoveSlot")
		end
		v_u_1.IsOpen = v_u_500.Visible
		v_u_1.StateChanged:Fire(v_u_500.Visible)
	end
end
while not v_u_46 do
	task.wait()
	v_u_46 = v31.LocalPlayer
end
v_u_46.CharacterAdded:Connect(v429)
if v_u_46.Character then
	v429(v_u_46.Character)
end
v_u_30.InputBegan:Connect(v435)
v_u_30.TextBoxFocused:Connect(function()
	-- upvalues: (ref) v_u_67
	v_u_67 = true
end)
v_u_30.TextBoxFocusReleased:Connect(function()
	-- upvalues: (ref) v_u_67
	v_u_67 = false
end)
v_u_62[v_u_27] = function()
	-- upvalues: (ref) v_u_56
	if v_u_56 then
		v_u_56:UnequipTools()
	end
end
v_u_30.Changed:Connect(v439)
v439("KeyboardEnabled")
if v_u_30:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
	gamepadConnected()
end
v_u_30.GamepadConnected:Connect(function(p589)
	if p589 == Enum.UserInputType.Gamepad1 then
		gamepadConnected()
	end
end)
v_u_30.GamepadDisconnected:Connect(function(p590)
	if p590 == Enum.UserInputType.Gamepad1 then
		gamepadDisconnected()
	end
end)
function v_u_1.SetBackpackEnabled(_, p591)
	-- upvalues: (ref) v_u_37, (copy) v_u_58, (ref) v_u_66, (copy) v_u_38, (ref) v_u_487, (ref) v_u_64, (ref) v_u_44, (copy) v_u_39
	v_u_37 = p591
	v_u_58:setEnabled(p591)
	v_u_66 = p591
	v_u_38.Enabled = p591
	v_u_487.Visible = p591
	if p591 then
		if v_u_64 >= 1 and (v_u_66 and not v_u_44) then
			v_u_44 = true
			v_u_39:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
			return
		end
	else
		disableGamepadInventoryControl()
		v_u_44 = false
		v_u_39:UnbindAction("RBXHotbarEquip")
	end
end
function v_u_1.IsOpened(_)
	-- upvalues: (copy) v_u_1
	return v_u_1.IsOpen
end
function v_u_1.GetBackpackEnabled(_)
	-- upvalues: (ref) v_u_37
	return v_u_37
end
function v_u_1.GetStateChangedEvent(_)
	-- upvalues: (copy) v_u_1
	return v_u_1.StateChanged
end
local function v_u_593(p592)
	-- upvalues: (ref) v_u_482, (ref) v_u_501, (ref) v_u_484
	v_u_482 = p592
	v_u_501.CanvasPosition = Vector2.new(0, 0)
	v_u_484()
end
function RefreshGroupButtons()
	-- upvalues: (ref) v_u_374, (ref) v_u_375, (copy) v_u_1, (copy) v_u_496, (copy) v_u_4, (copy) v_u_5, (ref) v_u_593, (copy) v_u_373
	if v_u_374 then
		for _, v594 in v_u_375 do
			v594:Destroy()
		end
		v_u_375 = {}
		local v595 = v_u_1:GetAllGroups()
		if #v595 == 0 then
			v_u_496.Visible = false
		else
			v_u_496.Visible = true
			local v596 = 0
			local v597 = Instance.new("ImageButton")
			v597.Name = "AllGroups"
			v597.Size = UDim2.new(0, 48, 0, 48)
			v597.Position = UDim2.new(0, 0, 0, v596)
			v597.BackgroundTransparency = v_u_4
			v597.Image = "rbxassetid://95214470320628"
			v597.Parent = v_u_374
			v597.BackgroundColor3 = v_u_5
			v597.MouseButton1Click:Connect(function()
				-- upvalues: (ref) v_u_593, (ref) v_u_496
				v_u_593(nil)
				v_u_496.Text = "All Items"
			end)
			local v598 = Instance.new("UICorner")
			v598.CornerRadius = script:GetAttribute("CornerRadius")
			v598.Parent = v597
			local v599 = v_u_375
			table.insert(v599, v597)
			local v600 = v596 + 48 + 8
			for _, v_u_601 in v595 do
				local v602 = Instance.new("ImageButton")
				v602.Name = "Group_" .. tostring(v_u_601)
				v602.Size = UDim2.new(0, 48, 0, 48)
				v602.Position = UDim2.new(0, 0, 0, v600)
				v602.BackgroundTransparency = v_u_4
				v602.BackgroundColor3 = v_u_5
				v602.Image = v_u_373[v_u_601] or ""
				v602.Parent = v_u_374
				local v603 = Instance.new("UIPadding")
				v603.PaddingLeft = UDim.new(0, 8)
				v603.PaddingRight = UDim.new(0, 8)
				v603.PaddingTop = UDim.new(0, 8)
				v603.PaddingBottom = UDim.new(0, 8)
				v603.Parent = v602
				v602.MouseButton1Click:Connect(function()
					-- upvalues: (ref) v_u_593, (copy) v_u_601, (ref) v_u_496
					v_u_593(v_u_601)
					v_u_496.Text = v_u_601
				end)
				local v604 = Instance.new("UICorner")
				v604.CornerRadius = script:GetAttribute("CornerRadius")
				v604.Parent = v602
				if not v_u_373[v_u_601] then
					local v605 = Instance.new("TextLabel")
					v605.Parent = v602
					v605.Size = UDim2.new(1, 0, 1, 0)
					v605.BackgroundTransparency = 1
					v605.Text = v_u_601
					v605.TextColor3 = script:GetAttribute("TextColor")
					v605.TextSize = 18
					v605.FontFace = script:GetAttribute("LabelFont")
					v605.TextXAlignment = Enum.TextXAlignment.Center
					v605.TextYAlignment = Enum.TextYAlignment.Center
					v605.TextTruncate = Enum.TextTruncate.AtEnd
					v605.TextWrapped = true
				end
				local v606 = v_u_375
				table.insert(v606, v602)
				v600 = v600 + 48 + 8
			end
		end
	else
		return
	end
end
function v_u_1.SetGroupIcon(_, p607, p608)
	-- upvalues: (copy) v_u_373
	v_u_373[p607] = p608
	if RefreshGroupButtons then
		RefreshGroupButtons()
	end
end
function v_u_1.GetGroupIcon(_, p609)
	-- upvalues: (copy) v_u_373
	return v_u_373[p609]
end
local v610 = Instance.new("ScrollingFrame")
v610.Name = "GroupButtonBar"
v610.CanvasSize = UDim2.new(0, 0, 0, 0)
v610.AutomaticSize = Enum.AutomaticSize.Y
v610.Size = UDim2.new(0, 56, 1, 0)
v610.Position = UDim2.new(0, -56, 0, 0)
v610.BackgroundTransparency = 1
v610.Parent = v_u_500
RefreshGroupButtons()
function v_u_1.GetEquipSound(_)
	-- upvalues: (copy) v_u_11
	return v_u_11
end
function v_u_1.GetUnequipSound(_)
	-- upvalues: (copy) v_u_12
	return v_u_12
end
function v_u_1.GetSlot(_, p611)
	-- upvalues: (copy) v_u_14, (ref) v_u_59, (ref) v_u_479, (ref) v_u_55
	if p611 <= v_u_14 then
		local v612 = v_u_59[p611]
		return {
			["SlotNumber"] = v612.Index,
			["Tool"] = v612.Tool,
			["IsEquipped"] = v612:IsEquipped()
		}
	end
	local v613 = v_u_479[p611 - v_u_14]
	if not v613 then
		return nil
	end
	local v614 = {
		["SlotNumber"] = p611,
		["Tool"] = v613.Tool
	}
	local v615 = v613.Tool
	if v615 then
		v615 = v615.Parent == v_u_55
	end
	v614.IsEquipped = v615
	return v614
end
function v_u_1.GetAllSlots(_)
	-- upvalues: (copy) v_u_14, (ref) v_u_59, (ref) v_u_479, (ref) v_u_55
	local v616 = {}
	for v617 = 1, v_u_14 do
		local v618 = v_u_59[v617]
		local v619 = {
			["SlotNumber"] = v618.Index,
			["Tool"] = v618.Tool,
			["IsEquipped"] = v618:IsEquipped()
		}
		table.insert(v616, v619)
	end
	for v620, v621 in ipairs(v_u_479) do
		local v622 = {
			["SlotNumber"] = v_u_14 + v620,
			["Tool"] = v621.Tool
		}
		local v623 = v621.Tool
		if v623 then
			v623 = v623.Parent == v_u_55
		end
		v622.IsEquipped = v623
		table.insert(v616, v622)
	end
	return v616
end
function v_u_1.GetSlotsTable(_)
	-- upvalues: (ref) v_u_59
	return v_u_59
end
function v_u_1.SetSlots(_, p624)
	-- upvalues: (ref) v_u_59
	v_u_59 = p624
end
function v_u_1.GetEquippedSlot(_)
	-- upvalues: (ref) v_u_21, (ref) v_u_481, (ref) v_u_55
	if v_u_21 then
		return {
			["SlotNumber"] = v_u_21.Index,
			["Tool"] = v_u_21.Tool,
			["IsEquipped"] = v_u_21:IsEquipped()
		}
	end
	if v_u_481 then
		local v625 = v_u_481
		if v625 then
			v625 = v625.Parent == v_u_55
		end
		if v625 then
			return {
				["SlotNumber"] = -1,
				["Tool"] = v_u_481,
				["IsEquipped"] = true
			}
		end
	end
	return nil
end
function v_u_1.IsSlotEquipped(_, p626)
	-- upvalues: (copy) v_u_14, (ref) v_u_59, (ref) v_u_479, (ref) v_u_55
	if p626 <= v_u_14 then
		return v_u_59[p626]:IsEquipped()
	end
	local v627 = v_u_479[p626 - v_u_14]
	if not v627 then
		return false
	end
	local v628 = v627.Tool
	if v628 then
		v628 = v628.Parent == v_u_55
	end
	return v628
end
function v_u_1.GetInventoryData(_)
	-- upvalues: (ref) v_u_479
	return v_u_479
end
return v_u_1