local v1 = game:GetService("Players")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("UserInputService")
local v_u_5 = game:GetService("CollectionService")
local v_u_6 = game:GetService("Workspace")
game:GetService("TweenService")
local v_u_7 = require(v_u_2:WaitForChild("Plants"):WaitForChild("AnchorService"))
local v_u_8 = require(v_u_2:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDefinitions"))
local v_u_9 = require(v_u_2:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("TierHelper"))
local v_u_10 = require(v_u_2:WaitForChild("UI"):WaitForChild("TrowelController"))
local v_u_11 = v_u_10.RotateRight.Image
local v_u_12 = v_u_10.RotateLeft.Image
local v13 = v_u_2:WaitForChild("RemoteEvents")
local v_u_14 = v13:WaitForChild("TrowelAction")
local v_u_15 = v13:WaitForChild("TrowelCancel")
v13:WaitForChild("Notification")
local v_u_16 = game:GetService("SoundService"):WaitForChild("SFX"):WaitForChild("Player"):WaitForChild("Shovel")
local v_u_17 = game:GetService("SoundService"):WaitForChild("SFX"):WaitForChild("Player"):WaitForChild("Planting")
local v_u_18 = v1.LocalPlayer
local v_u_19 = Random.new()
local v_u_20 = v_u_4.TouchEnabled
if v_u_20 then
	v_u_20 = not v_u_4.KeyboardEnabled
end
local v_u_21 = {}
local v_u_22 = false
local v_u_23 = false
local v_u_24 = false
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = nil
local v_u_28 = nil
local v_u_29 = nil
local v_u_30 = nil
local v_u_31 = nil
local v_u_32 = 0
local v_u_33 = nil
local v_u_34 = nil
local v_u_35 = nil
local v_u_36 = nil
local v_u_37 = nil
local v_u_38 = nil
local v_u_39 = nil
local v_u_40 = {}
local v_u_41 = {}
local v_u_42 = false
local v_u_43 = false
local v_u_44 = {}
local v_u_45 = nil
local v_u_46 = nil
local v_u_47 = nil
local v_u_48 = nil
local v_u_49 = {}
local v_u_50 = {}
local v_u_51 = nil
local function v_u_56(p52)
	-- upvalues: (copy) v_u_6, (copy) v_u_5, (copy) v_u_18, (copy) v_u_8
	local v53 = p52.Target
	if not v53 then
		return nil
	end
	while v53 and v53 ~= v_u_6 do
		if v53:IsA("Model") and v_u_5:HasTag(v53, "Plant") then
			if v53:GetAttribute("OwnerUserId") == v_u_18.UserId then
				local v54 = v53:GetAttribute("PlantType")
				if v54 then
					local v55 = v_u_8[v54]
					if v55 then
						if v55.isSingleHarvest or v55.fruitTemplate then
							return v53
						else
							return nil
						end
					else
						return nil
					end
				else
					return nil
				end
			else
				return nil
			end
		end
		v53 = v53.Parent
	end
	return nil
end
local function v_u_61(p57)
	-- upvalues: (ref) v_u_45, (copy) v_u_8, (copy) v_u_9
	if p57 then
		if not v_u_45 then
			v_u_45 = Instance.new("Highlight")
			v_u_45.DepthMode = Enum.HighlightDepthMode.Occluded
			v_u_45.FillTransparency = 0.8
			v_u_45.OutlineTransparency = 0
		end
		if v_u_45.Parent ~= p57 then
			v_u_45.Parent = p57
		end
		local v58 = Color3.fromRGB(139, 195, 74)
		local v59 = p57:GetAttribute("PlantType")
		if v59 then
			local v60 = v_u_8[v59]
			if v60 and v60.Rarity then
				v58 = v_u_9:GetColor(v60.Rarity) or v58
			end
		end
		v_u_45.FillColor = v58
		v_u_45.OutlineColor = v58
	elseif v_u_45 then
		v_u_45:Destroy()
		v_u_45 = nil
	end
end
local function v_u_89(p62, p63)
	-- upvalues: (copy) v_u_5, (copy) v_u_18, (ref) v_u_30, (copy) v_u_7
	local v64 = p62.X
	local v65 = p62.Y
	local v66 = p62.Z
	local v67 = Vector3.new(v64, v65, v66)
	for _ = 1, 3 do
		local v68 = false
		for _, v69 in v_u_5:GetTagged("Plant") do
			if v69:IsA("Model") and (v69:GetAttribute("OwnerUserId") == v_u_18.UserId and v69:GetAttribute("Uuid") ~= v_u_30) then
				local v70 = v69:GetAttribute("PlantGroundPosition")
				if v70 then
					local v71 = v_u_7.findPlantAnchor(v69)
					local v72
					if v71 then
						local v73 = v71.Size.X
						local v74 = v71.Size.Z
						v72 = math.max(v73, v74) / 2
					else
						v72 = 0
					end
					if v72 > 0 then
						local v75 = v67.X - v70.X
						local v76 = v67.Z - v70.Z
						local v77 = v75 * v75 + v76 * v76
						local v78 = math.sqrt(v77)
						local v79 = p63 + v72
						if v78 < v79 and v78 > 0.001 then
							local v80 = v79 - v78
							local v81 = v75 / v78
							local v82 = v76 / v78
							local v83 = v67.X + v81 * v80
							local v84 = v67.Y
							local v85 = v67.Z + v82 * v80
							v67 = Vector3.new(v83, v84, v85)
							v68 = true
						elseif v78 <= 0.001 then
							local v86 = v67.X + 0.1
							local v87 = v67.Y
							local v88 = v67.Z + 0.1
							v67 = Vector3.new(v86, v87, v88)
							v68 = true
						end
					end
				end
			end
		end
		if not v68 then
			break
		end
	end
	return v67
end
local function v_u_97()
	-- upvalues: (copy) v_u_6, (copy) v_u_18, (ref) v_u_31, (ref) v_u_44
	local v90 = v_u_6.CurrentCamera
	if not v90 then
		return nil, false
	end
	local v91 = v_u_18:GetMouse()
	local v92 = RaycastParams.new()
	v92.FilterType = Enum.RaycastFilterType.Exclude
	v92.FilterDescendantsInstances = { v_u_18.Character, v_u_31 }
	local v93 = v90:ScreenPointToRay(v91.X, v91.Y)
	local v94 = v_u_6:Raycast(v93.Origin, v93.Direction * 200, v92)
	if not v94 then
		return nil, false
	end
	local v95 = false
	for _, v96 in v_u_44 do
		if v94.Instance == v96 then
			v95 = true
			break
		end
	end
	return v94.Position, v95
end
local function v_u_117(p98, p_u_99, p_u_100, p_u_101, p_u_102)
	-- upvalues: (copy) v_u_3
	local v_u_103 = {}
	for _, v104 in p98:GetDescendants() do
		if v104:IsA("BasePart") then
			local v105 = {
				["part"] = v104,
				["startCFrame"] = v104.CFrame
			}
			table.insert(v_u_103, v105)
		end
	end
	local v_u_106 = tick()
	local v_u_107 = nil
	v_u_107 = v_u_3.Heartbeat:Connect(function()
		-- upvalues: (copy) v_u_106, (copy) p_u_100, (copy) p_u_101, (copy) v_u_103, (copy) p_u_99, (ref) v_u_107, (copy) p_u_102
		local v108 = tick() - v_u_106
		local v109 = v108 / p_u_100
		local v110 = math.clamp(v109, 0, 1)
		local v111
		if p_u_101 then
			v111 = v110 * v110
		else
			local v112 = 1 - v110
			v111 = 1 - v112 * v112 * v112
		end
		for _, v113 in v_u_103 do
			if v113.part and v113.part.Parent then
				local v114 = v113.part
				local v115 = v113.startCFrame
				local v116 = p_u_99 * v111
				v114.CFrame = v115 + Vector3.new(0, v116, 0)
			end
		end
		if p_u_100 <= v108 then
			v_u_107:Disconnect()
			if p_u_102 then
				p_u_102()
			end
		end
	end)
end
local function v_u_120(p118)
	-- upvalues: (ref) v_u_23, (ref) v_u_24, (ref) v_u_42, (ref) v_u_43, (copy) v_u_10, (copy) v_u_11, (copy) v_u_12, (ref) v_u_36, (ref) v_u_37, (ref) v_u_38, (ref) v_u_39, (ref) v_u_49, (ref) v_u_29, (copy) v_u_5, (ref) v_u_31, (ref) v_u_51, (ref) v_u_30, (ref) v_u_33, (ref) v_u_34
	v_u_23 = false
	v_u_24 = false
	v_u_42 = false
	v_u_43 = false
	v_u_10.RotateRight.Image = v_u_11
	v_u_10.RotateLeft.Image = v_u_12
	if v_u_36 then
		v_u_36:Disconnect()
		v_u_36 = nil
	end
	if v_u_37 then
		v_u_37:Disconnect()
		v_u_37 = nil
	end
	if v_u_38 then
		v_u_38:Disconnect()
		v_u_38 = nil
	end
	if v_u_39 then
		v_u_39:Disconnect()
		v_u_39 = nil
	end
	for _, v119 in v_u_49 do
		v119:Disconnect()
	end
	v_u_49 = {}
	v_u_10.Close()
	if v_u_29 then
		v_u_5:RemoveTag(v_u_29, "TrowelHeld")
	end
	if v_u_31 then
		v_u_31:Destroy()
		v_u_31 = nil
	end
	if p118 and v_u_29 then
		v_u_29.Parent = v_u_51
	elseif v_u_29 then
		v_u_29:Destroy()
	end
	v_u_51 = nil
	v_u_29 = nil
	v_u_30 = nil
	v_u_33 = nil
	v_u_34 = nil
end
local function v_u_162(p121)
	-- upvalues: (ref) v_u_23, (ref) v_u_31, (ref) v_u_24, (ref) v_u_29, (copy) v_u_15, (copy) v_u_120, (copy) v_u_18, (ref) v_u_44, (ref) v_u_42, (ref) v_u_32, (ref) v_u_43, (copy) v_u_20, (ref) v_u_33, (copy) v_u_7, (copy) v_u_89, (ref) v_u_34, (copy) v_u_97
	if v_u_23 and (v_u_31 and not v_u_24) then
		if v_u_29 and v_u_29.Parent then
			local v122 = v_u_18.Character
			if v122 then
				local v123 = v122:FindFirstChild("HumanoidRootPart")
				if v123 then
					local v124 = (1 / 0)
					for _, v125 in v_u_44 do
						local v126 = (v123.Position - v125.Position).Magnitude
						if v126 < v124 then
							v124 = v126
						end
					end
					if v124 > 150 then
						v_u_15:FireServer()
						v_u_120(true)
						return
					end
				end
			end
			if v_u_42 then
				v_u_32 = v_u_32 + p121 * 180
			end
			if v_u_43 then
				v_u_32 = v_u_32 - p121 * 180
			end
			if v_u_20 then
				if v_u_33 then
					local v127 = v_u_31
					local v128 = v_u_7.findPlantAnchor(v127)
					local v129
					if v128 then
						local v130 = v128.Size.X
						local v131 = v128.Size.Z
						v129 = math.max(v130, v131) / 2
					else
						v129 = 0
					end
					local v132 = v_u_89(v_u_33, v129)
					local v133 = (v_u_34 or v_u_33.Y) + 4
					local v134 = v_u_7.positionPlantWithAnchor
					local v135 = v_u_31
					local v136 = v132.X
					local v137 = v132.Z
					v134(v135, Vector3.new(v136, v133, v137), v_u_32)
					return
				end
			else
				local v138, v139 = v_u_97()
				if v138 then
					if v139 then
						v_u_33 = v138
						v_u_34 = v138.Y
					end
					if not v139 then
						v138 = v_u_33
					end
					if v138 then
						local v140 = v_u_31
						local v141 = v_u_7.findPlantAnchor(v140)
						local v142
						if v141 then
							local v143 = v141.Size.X
							local v144 = v141.Size.Z
							v142 = math.max(v143, v144) / 2
						else
							v142 = 0
						end
						local v145 = v_u_89(v138, v142)
						local v146 = (v_u_34 or v138.Y) + 4
						local v147 = v_u_7.positionPlantWithAnchor
						local v148 = v_u_31
						local v149 = v145.X
						local v150 = v145.Z
						v147(v148, Vector3.new(v149, v146, v150), v_u_32)
						return
					end
				elseif v_u_33 then
					local v151 = v_u_31
					local v152 = v_u_7.findPlantAnchor(v151)
					local v153
					if v152 then
						local v154 = v152.Size.X
						local v155 = v152.Size.Z
						v153 = math.max(v154, v155) / 2
					else
						v153 = 0
					end
					local v156 = v_u_89(v_u_33, v153)
					local v157 = (v_u_34 or v_u_33.Y) + 4
					local v158 = v_u_7.positionPlantWithAnchor
					local v159 = v_u_31
					local v160 = v156.X
					local v161 = v156.Z
					v158(v159, Vector3.new(v160, v157, v161), v_u_32)
				end
			end
		else
			v_u_15:FireServer()
			v_u_120(false)
		end
	else
		return
	end
end
local function v_u_184()
	-- upvalues: (ref) v_u_23, (ref) v_u_31, (ref) v_u_33, (ref) v_u_27, (ref) v_u_24, (copy) v_u_20, (copy) v_u_97, (copy) v_u_7, (copy) v_u_89, (ref) v_u_36, (copy) v_u_117, (copy) v_u_14, (ref) v_u_30, (ref) v_u_32, (ref) v_u_34, (copy) v_u_3, (copy) v_u_162, (ref) v_u_26, (ref) v_u_41, (copy) v_u_18, (ref) v_u_40, (copy) v_u_17, (copy) v_u_19, (ref) v_u_28, (copy) v_u_120
	if not (v_u_23 and (v_u_31 and v_u_33)) then
		return
	end
	if not v_u_27() then
		return
	end
	if v_u_24 then
		return
	end
	if not v_u_20 then
		local _, v163 = v_u_97()
		if not v163 then
			return
		end
	end
	local v164 = v_u_31
	local v165 = v_u_7.findPlantAnchor(v164)
	local v166
	if v165 then
		local v167 = v165.Size.X
		local v168 = v165.Size.Z
		v166 = math.max(v167, v168) / 2
	else
		v166 = 0
	end
	local v169 = v_u_89(v_u_33, v166)
	v_u_24 = true
	if v_u_36 then
		v_u_36:Disconnect()
		v_u_36 = nil
	end
	local v_u_170 = false
	v_u_117(v_u_31, -4, 0.2, true, function()
		-- upvalues: (ref) v_u_170
		v_u_170 = true
	end)
	repeat
		task.wait()
	until v_u_170
	v_u_24 = false
	local v171, _ = v_u_14:InvokeServer({
		["Action"] = "Place",
		["PlantUuid"] = v_u_30,
		["Position"] = v169,
		["RotationY"] = v_u_32
	})
	if not v171 then
		if v_u_23 and (v_u_31 and v_u_33) then
			local v172 = (v_u_34 or v_u_33.Y) + 4
			local v173 = v_u_7.positionPlantWithAnchor
			local v174 = v_u_31
			local v175 = v169.X
			local v176 = v169.Z
			v173(v174, Vector3.new(v175, v172, v176), v_u_32)
			v_u_36 = v_u_3.Heartbeat:Connect(v_u_162)
		end
	end
	local v177 = v_u_26
	if v177 then
		v177 = v_u_26:FindFirstChild("Place")
	end
	if v177 then
		local v178 = Enum.AnimationPriority.Action
		local v179 = v_u_41[v177]
		if v179 then
			::l33::
			if v178 then
				v179.Priority = v178
			end
			v179.Looped = false
			v179:Play()
			goto l31
		end
		local v180 = v_u_18.Character
		local v181
		if v180 then
			local v182 = v180:FindFirstChildOfClass("Humanoid")
			if v182 then
				v181 = v182:FindFirstChildOfClass("Animator")
				if not v181 then
					v181 = Instance.new("Animator")
					v181.Parent = v182
				end
			else
				v181 = nil
			end
		else
			v181 = nil
		end
		if v181 then
			v179 = v181:LoadAnimation(v177)
			v_u_41[v177] = v179
			local v183 = v_u_40
			table.insert(v183, v179)
			goto l33
		end
	end
	::l31::
	v_u_17.PlaybackSpeed = 0.9 + v_u_19:NextNumber() * 0.3
	v_u_17:Play()
	v_u_28()
	v_u_120(false)
end
local function v_u_236()
	-- upvalues: (ref) v_u_27, (copy) v_u_18, (copy) v_u_56, (copy) v_u_14, (ref) v_u_26, (ref) v_u_41, (ref) v_u_40, (copy) v_u_16, (copy) v_u_19, (ref) v_u_29, (ref) v_u_30, (ref) v_u_32, (ref) v_u_31, (copy) v_u_5, (copy) v_u_6, (ref) v_u_51, (copy) v_u_2, (ref) v_u_23, (ref) v_u_24, (ref) v_u_50, (ref) v_u_45, (copy) v_u_10, (ref) v_u_49, (ref) v_u_42, (ref) v_u_43, (copy) v_u_184, (copy) v_u_20, (ref) v_u_33, (ref) v_u_34, (copy) v_u_97, (copy) v_u_7, (copy) v_u_89, (copy) v_u_3, (ref) v_u_37, (copy) v_u_4, (ref) v_u_38, (copy) v_u_11, (copy) v_u_12, (ref) v_u_39, (ref) v_u_44, (ref) v_u_36, (copy) v_u_162
	if not v_u_27() then
		return
	end
	local v185 = v_u_56((v_u_18:GetMouse()))
	if not v185 then
		return
	end
	local v186 = v185:GetAttribute("Uuid")
	if not v186 then
		return
	end
	local v187, _ = v_u_14:InvokeServer({
		["Action"] = "Pickup",
		["PlantUuid"] = v186
	})
	if not v187 then
		return
	end
	local v188 = v_u_26
	if v188 then
		v188 = v_u_26:FindFirstChild("Dig")
	end
	if v188 then
		local v189 = Enum.AnimationPriority.Action
		local v190 = v_u_41[v188]
		if not v190 then
			local v191 = v_u_18.Character
			local v192
			if v191 then
				local v193 = v191:FindFirstChildOfClass("Humanoid")
				if v193 then
					v192 = v193:FindFirstChildOfClass("Animator")
					if not v192 then
						v192 = Instance.new("Animator")
						v192.Parent = v193
					end
				else
					v192 = nil
				end
			else
				v192 = nil
			end
			if not v192 then
				goto l12
			end
			v190 = v192:LoadAnimation(v188)
			v_u_41[v188] = v190
			local v194 = v_u_40
			table.insert(v194, v190)
		end
		if v189 then
			v190.Priority = v189
		end
		v190.Looped = false
		v190:Play()
	end
	::l12::
	v_u_16.PlaybackSpeed = 0.9 + v_u_19:NextNumber() * 0.3
	v_u_16:Play()
	v_u_29 = v185
	v_u_30 = v186
	v_u_32 = v185:GetAttribute("AppliedRotationY") or 0
	v_u_31 = v_u_29:Clone()
	local v195 = {}
	for _, v196 in v_u_31:GetDescendants() do
		if v_u_5:HasTag(v196, "Fruit") then
			table.insert(v195, v196)
		end
	end
	for _, v197 in v195 do
		v197:Destroy()
	end
	for _, v198 in v_u_31:GetDescendants() do
		if v198:IsA("ProximityPrompt") then
			v198:Destroy()
		elseif v198:IsA("BasePart") then
			v198.Anchored = true
			v198.CanCollide = false
			v198.CanQuery = false
			v198.CanTouch = false
			if v198.Name ~= "PlantAnchor" and (v198.Name ~= "FruitAnchor" and v198.Name ~= "GrowthAnchor") then
				local v199 = v198.Transparency
				v198.Transparency = math.max(v199, 0.5)
			end
		end
	end
	v_u_31.Parent = v_u_6
	v_u_51 = v_u_29.Parent
	v_u_29.Parent = v_u_2
	v_u_5:AddTag(v_u_29, "TrowelHeld")
	v_u_23 = true
	v_u_24 = true
	for _, v200 in v_u_50 do
		v200:Disconnect()
	end
	v_u_50 = {}
	if v_u_45 then
		v_u_45:Destroy()
		v_u_45 = nil
	end
	v_u_10.Open()
	v_u_49 = {
		v_u_10.RotateRight.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_42
			v_u_42 = true
		end),
		v_u_10.RotateRight.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_42
			v_u_42 = false
		end),
		v_u_10.RotateLeft.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_43
			v_u_43 = true
		end),
		v_u_10.RotateLeft.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_43
			v_u_43 = false
		end),
		v_u_10.Confirm.Activated:Connect(v_u_184)
	}
	local v_u_201 = v_u_29:GetAttribute("PlantGroundPosition") or v_u_31:GetPivot().Position
	local v202
	if v_u_20 then
		v_u_33 = v_u_201
		v_u_34 = v_u_201.Y
		v202 = v_u_201
	else
		local v203, v204 = v_u_97()
		if v203 and v204 then
			v_u_33 = v203
			v_u_34 = v203.Y
			local v205 = v_u_31
			local v206 = v_u_7.findPlantAnchor(v205)
			local v207
			if v206 then
				local v208 = v206.Size.X
				local v209 = v206.Size.Z
				v207 = math.max(v208, v209) / 2
			else
				v207 = 0
			end
			v202 = v_u_89(v203, v207)
		else
			v_u_34 = v_u_201.Y
			v202 = v_u_201
		end
	end
	local v210 = v202.X
	local v211 = (v_u_34 or v_u_201.Y) + 4
	local v212 = v202.Z
	local v_u_213 = Vector3.new(v210, v211, v212)
	local v_u_214 = v_u_31
	local v_u_215 = v_u_32
	local function v_u_216()
		-- upvalues: (ref) v_u_24
		v_u_24 = false
	end
	local v_u_217 = tick()
	local v_u_218 = nil
	local v_u_219 = 0.25
	v_u_218 = v_u_3.Heartbeat:Connect(function()
		-- upvalues: (copy) v_u_217, (copy) v_u_219, (copy) v_u_201, (copy) v_u_213, (ref) v_u_7, (copy) v_u_214, (copy) v_u_215, (ref) v_u_218, (copy) v_u_216
		local v220 = tick() - v_u_217
		local v221 = v220 / v_u_219
		local v222 = math.clamp(v221, 0, 1)
		local v223 = v_u_201:Lerp(v_u_213, 1 - (1 - v222) * (1 - v222) * (1 - v222))
		v_u_7.positionPlantWithAnchor(v_u_214, v223, v_u_215)
		if v_u_219 <= v220 then
			v_u_218:Disconnect()
			if v_u_216 then
				v_u_216()
			end
		end
	end)
	v_u_37 = v_u_4.InputBegan:Connect(function(p224, p225)
		-- upvalues: (ref) v_u_42, (ref) v_u_10, (ref) v_u_43
		if not p225 then
			if p224.KeyCode == Enum.KeyCode.E or p224.KeyCode == Enum.KeyCode.DPadRight then
				v_u_42 = true
				v_u_10.RotateRight.Image = v_u_10.RotateRight.PressedImage
			end
			if p224.KeyCode == Enum.KeyCode.Q or p224.KeyCode == Enum.KeyCode.DPadLeft then
				v_u_43 = true
				v_u_10.RotateLeft.Image = v_u_10.RotateLeft.PressedImage
			end
		end
	end)
	v_u_38 = v_u_4.InputEnded:Connect(function(p226)
		-- upvalues: (ref) v_u_42, (ref) v_u_10, (ref) v_u_11, (ref) v_u_43, (ref) v_u_12
		if p226.KeyCode == Enum.KeyCode.E or p226.KeyCode == Enum.KeyCode.DPadRight then
			v_u_42 = false
			v_u_10.RotateRight.Image = v_u_11
		end
		if p226.KeyCode == Enum.KeyCode.Q or p226.KeyCode == Enum.KeyCode.DPadLeft then
			v_u_43 = false
			v_u_10.RotateLeft.Image = v_u_12
		end
	end)
	if v_u_20 then
		v_u_39 = v_u_4.InputBegan:Connect(function(p227, p228)
			-- upvalues: (ref) v_u_24, (ref) v_u_6, (ref) v_u_18, (ref) v_u_31, (ref) v_u_44, (ref) v_u_33, (ref) v_u_34
			if p228 then
				return
			end
			if p227.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			if v_u_24 then
				return
			end
			local v229 = v_u_6.CurrentCamera
			if not v229 then
				return
			end
			local v230 = p227.Position
			local v231 = v229:ScreenPointToRay(v230.X, v230.Y)
			local v232 = RaycastParams.new()
			v232.FilterType = Enum.RaycastFilterType.Exclude
			v232.FilterDescendantsInstances = { v_u_18.Character, v_u_31 }
			local v233 = v_u_6:Raycast(v231.Origin, v231.Direction * 200, v232)
			if not v233 then
				return
			end
			local v234 = false
			for _, v235 in v_u_44 do
				if v233.Instance == v235 then
					v234 = true
					break
				end
			end
			if v234 then
				v_u_33 = v233.Position
				v_u_34 = v233.Position.Y
			end
		end)
	end
	v_u_36 = v_u_3.Heartbeat:Connect(v_u_162)
end
local function v_u_237()
	-- upvalues: (ref) v_u_22, (ref) v_u_23, (copy) v_u_20, (copy) v_u_184, (copy) v_u_236
	if v_u_22 then
		if v_u_23 then
			if not v_u_20 then
				v_u_184()
			end
		else
			v_u_236()
		end
	else
		return
	end
end
function v_u_21.Activate(p238, p_u_239, p240, p241)
	-- upvalues: (ref) v_u_22, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (ref) v_u_28, (ref) v_u_41, (copy) v_u_18, (ref) v_u_40, (ref) v_u_44, (copy) v_u_6, (copy) v_u_5, (ref) v_u_50, (ref) v_u_35, (copy) v_u_237, (ref) v_u_46, (copy) v_u_3, (ref) v_u_23, (ref) v_u_45, (copy) v_u_56, (copy) v_u_61, (ref) v_u_47, (ref) v_u_48
	v_u_22 = true
	v_u_25 = p238
	v_u_26 = p_u_239
	v_u_27 = p240
	v_u_28 = p241
	local v242 = p_u_239:FindFirstChild("Equip")
	if v242 then
		local v243 = Enum.AnimationPriority.Action
		local v244 = v_u_41[v242]
		if not v244 then
			local v245 = v_u_18.Character
			local v246
			if v245 then
				local v247 = v245:FindFirstChildOfClass("Humanoid")
				if v247 then
					v246 = v247:FindFirstChildOfClass("Animator")
					if not v246 then
						v246 = Instance.new("Animator")
						v246.Parent = v247
					end
				else
					v246 = nil
				end
			else
				v246 = nil
			end
			if not v246 then
				goto l2
			end
			v244 = v246:LoadAnimation(v242)
			v_u_41[v242] = v244
			local v248 = v_u_40
			table.insert(v248, v244)
		end
		if v243 then
			v244.Priority = v243
		end
		v244.Looped = false
		v244:Play()
	end
	::l2::
	task.delay(0.2, function()
		-- upvalues: (ref) v_u_22, (copy) p_u_239, (ref) v_u_41, (ref) v_u_18, (ref) v_u_40
		if v_u_22 then
			local v249 = p_u_239:FindFirstChild("Idle")
			if v249 then
				local v250 = Enum.AnimationPriority.Idle
				local v251 = v_u_41[v249]
				if not v251 then
					local v252 = v_u_18.Character
					local v253
					if v252 then
						local v254 = v252:FindFirstChildOfClass("Humanoid")
						if v254 then
							v253 = v254:FindFirstChildOfClass("Animator")
							if not v253 then
								v253 = Instance.new("Animator")
								v253.Parent = v254
							end
						else
							v253 = nil
						end
					else
						v253 = nil
					end
					if not v253 then
						return
					end
					v251 = v253:LoadAnimation(v249)
					v_u_41[v249] = v251
					local v255 = v_u_40
					table.insert(v255, v251)
				end
				if v250 then
					v251.Priority = v250
				end
				v251.Looped = true
				v251:Play()
			end
		end
	end)
	v_u_44 = {}
	for _, v256 in v_u_6:WaitForChild("Plots"):GetChildren() do
		if v256:IsA("Model") and v256:GetAttribute("Owner") == v_u_18.UserId then
			local v257 = v256:FindFirstChild("PlantableArea")
			if v257 then
				for _, v258 in v257:GetChildren() do
					if v258:IsA("BasePart") then
						local v259 = v_u_44
						table.insert(v259, v258)
					end
				end
			end
		end
	end
	for _, v260 in v_u_5:GetTagged("Plant") do
		if v260:GetAttribute("OwnerUserId") == v_u_18.UserId then
			for _, v261 in v260:GetDescendants() do
				if v261:IsA("ProximityPrompt") and v261.Name == "HarvestPrompt" then
					v261.Enabled = false
				end
			end
		end
	end
	for _, v262 in v_u_5:GetTagged("Plant") do
		if v262:GetAttribute("OwnerUserId") == v_u_18.UserId then
			for _, v_u_263 in v262:GetChildren() do
				if v_u_263:IsA("Model") and not v_u_263:GetAttribute("FullyGrown") then
					local v_u_264 = nil
					v_u_264 = v_u_263:GetAttributeChangedSignal("FullyGrown"):Connect(function()
						-- upvalues: (ref) v_u_22, (ref) v_u_264, (copy) v_u_263
						if v_u_22 then
							if v_u_263:GetAttribute("FullyGrown") then
								for _, v265 in v_u_263:GetDescendants() do
									if v265:IsA("ProximityPrompt") and v265.Name == "HarvestPrompt" then
										v265.Enabled = false
									end
								end
								v_u_264:Disconnect()
							end
						else
							v_u_264:Disconnect()
						end
					end)
					local v266 = v_u_50
					local v267 = v_u_264
					table.insert(v266, v267)
				end
			end
			local v278 = v262.ChildAdded:Connect(function(p_u_268)
				-- upvalues: (ref) v_u_22, (ref) v_u_50
				if v_u_22 then
					if p_u_268:IsA("Model") then
						for _, v269 in p_u_268:GetDescendants() do
							if v269:IsA("ProximityPrompt") and v269.Name == "HarvestPrompt" then
								v269.Enabled = false
							end
						end
						local v_u_270 = nil
						v_u_270 = p_u_268.DescendantAdded:Connect(function(p271)
							-- upvalues: (ref) v_u_22, (ref) v_u_270
							if v_u_22 then
								if p271:IsA("ProximityPrompt") and p271.Name == "HarvestPrompt" then
									p271.Enabled = false
								end
							else
								v_u_270:Disconnect()
							end
						end)
						local v272 = v_u_50
						local v273 = v_u_270
						table.insert(v272, v273)
						if not p_u_268:GetAttribute("FullyGrown") then
							local v_u_274 = nil
							v_u_274 = p_u_268:GetAttributeChangedSignal("FullyGrown"):Connect(function()
								-- upvalues: (ref) v_u_22, (ref) v_u_274, (copy) p_u_268
								if v_u_22 then
									if p_u_268:GetAttribute("FullyGrown") then
										for _, v275 in p_u_268:GetDescendants() do
											if v275:IsA("ProximityPrompt") and v275.Name == "HarvestPrompt" then
												v275.Enabled = false
											end
										end
										v_u_274:Disconnect()
									end
								else
									v_u_274:Disconnect()
								end
							end)
							local v276 = v_u_50
							local v277 = v_u_274
							table.insert(v276, v277)
						end
					end
				else
					return
				end
			end)
			local v279 = v_u_50
			table.insert(v279, v278)
		end
	end
	v_u_35 = p_u_239.Activated:Connect(v_u_237)
	local v_u_280 = v_u_18:GetMouse()
	v_u_46 = v_u_3.Heartbeat:Connect(function()
		-- upvalues: (ref) v_u_22, (ref) v_u_23, (ref) v_u_45, (ref) v_u_56, (copy) v_u_280, (ref) v_u_61
		if v_u_22 and not v_u_23 then
			v_u_61((v_u_56(v_u_280)))
		elseif v_u_45 then
			v_u_45:Destroy()
			v_u_45 = nil
		end
	end)
	v_u_47 = v_u_5:GetInstanceAddedSignal("Plant"):Connect(function(p_u_281)
		-- upvalues: (ref) v_u_22, (ref) v_u_18, (ref) v_u_50
		if v_u_22 then
			if p_u_281:GetAttribute("OwnerUserId") == v_u_18.UserId then
				task.defer(function()
					-- upvalues: (ref) v_u_22, (copy) p_u_281, (ref) v_u_50
					if v_u_22 then
						for _, v282 in p_u_281:GetDescendants() do
							if v282:IsA("ProximityPrompt") and v282.Name == "HarvestPrompt" then
								v282.Enabled = false
							end
						end
						for _, v_u_283 in p_u_281:GetChildren() do
							if v_u_283:IsA("Model") and not v_u_283:GetAttribute("FullyGrown") then
								local v_u_284 = nil
								v_u_284 = v_u_283:GetAttributeChangedSignal("FullyGrown"):Connect(function()
									-- upvalues: (ref) v_u_22, (ref) v_u_284, (copy) v_u_283
									if v_u_22 then
										if v_u_283:GetAttribute("FullyGrown") then
											for _, v285 in v_u_283:GetDescendants() do
												if v285:IsA("ProximityPrompt") and v285.Name == "HarvestPrompt" then
													v285.Enabled = false
												end
											end
											v_u_284:Disconnect()
										end
									else
										v_u_284:Disconnect()
									end
								end)
								local v286 = v_u_50
								local v287 = v_u_284
								table.insert(v286, v287)
							end
						end
						p_u_281.ChildAdded:Connect(function(p_u_288)
							-- upvalues: (ref) v_u_22, (ref) v_u_50
							if v_u_22 then
								if p_u_288:IsA("Model") then
									for _, v289 in p_u_288:GetDescendants() do
										if v289:IsA("ProximityPrompt") and v289.Name == "HarvestPrompt" then
											v289.Enabled = false
										end
									end
									p_u_288.DescendantAdded:Connect(function(p290)
										-- upvalues: (ref) v_u_22
										if v_u_22 then
											if p290:IsA("ProximityPrompt") and p290.Name == "HarvestPrompt" then
												p290.Enabled = false
											end
										end
									end)
									if not p_u_288:GetAttribute("FullyGrown") then
										local v_u_291 = nil
										v_u_291 = p_u_288:GetAttributeChangedSignal("FullyGrown"):Connect(function()
											-- upvalues: (ref) v_u_22, (ref) v_u_291, (copy) p_u_288
											if v_u_22 then
												if p_u_288:GetAttribute("FullyGrown") then
													for _, v292 in p_u_288:GetDescendants() do
														if v292:IsA("ProximityPrompt") and v292.Name == "HarvestPrompt" then
															v292.Enabled = false
														end
													end
													v_u_291:Disconnect()
												end
											else
												v_u_291:Disconnect()
											end
										end)
										local v293 = v_u_50
										local v294 = v_u_291
										table.insert(v293, v294)
									end
								end
							else
								return
							end
						end)
					end
				end)
			end
		else
			return
		end
	end)
	v_u_48 = v_u_5:GetInstanceAddedSignal("HarvestPrompt"):Connect(function(p295)
		-- upvalues: (ref) v_u_22, (ref) v_u_18
		if v_u_22 then
			if p295:IsA("ProximityPrompt") then
				local v296 = p295.Parent
				local v297 = 0
				while v296 and (v296 ~= workspace and v297 < 10) do
					local v298 = v296:GetAttribute("OwnerUserId")
					if v298 then
						if v298 == v_u_18.UserId then
							p295.Enabled = false
						end
						return
					end
					v296 = v296.Parent
					v297 = v297 + 1
				end
			end
		else
			return
		end
	end)
end
function v_u_21.Deactivate()
	-- upvalues: (ref) v_u_23, (copy) v_u_15, (copy) v_u_120, (ref) v_u_22, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (ref) v_u_28, (ref) v_u_35, (ref) v_u_46, (ref) v_u_47, (ref) v_u_48, (ref) v_u_45, (ref) v_u_40, (ref) v_u_41, (ref) v_u_44, (copy) v_u_5, (copy) v_u_18
	if v_u_23 then
		v_u_15:FireServer()
		v_u_120(true)
	end
	v_u_22 = false
	v_u_25 = nil
	v_u_26 = nil
	v_u_27 = nil
	v_u_28 = nil
	if v_u_35 then
		v_u_35:Disconnect()
		v_u_35 = nil
	end
	if v_u_46 then
		v_u_46:Disconnect()
		v_u_46 = nil
	end
	if v_u_47 then
		v_u_47:Disconnect()
		v_u_47 = nil
	end
	if v_u_48 then
		v_u_48:Disconnect()
		v_u_48 = nil
	end
	if v_u_45 then
		v_u_45:Destroy()
		v_u_45 = nil
	end
	for _, v299 in v_u_40 do
		if v299 and v299.IsPlaying then
			v299:Stop()
		end
	end
	for _, v300 in v_u_40 do
		v300:Destroy()
	end
	v_u_40 = {}
	v_u_41 = {}
	v_u_44 = {}
	for _, v301 in v_u_5:GetTagged("Plant") do
		if v301:GetAttribute("OwnerUserId") == v_u_18.UserId then
			for _, v302 in v301:GetDescendants() do
				if v302:IsA("ProximityPrompt") and (v302.Name == "HarvestPrompt" and not v302.Parent:GetAttribute("Favorited")) then
					v302.Enabled = true
				end
			end
		end
	end
end
v_u_18.CharacterAdded:Connect(function()
	-- upvalues: (copy) v_u_21
	v_u_21.Deactivate()
end)
return v_u_21