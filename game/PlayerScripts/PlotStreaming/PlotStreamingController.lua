local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("RunService")
local v_u_4 = game:GetService("CollectionService")
local v5 = require(v2:WaitForChild("PlotStreaming"):WaitForChild("Definitions"):WaitForChild("StreamingConfig"))
local v_u_6 = require(script.Parent:WaitForChild("PlantRenderer"))
local v_u_7 = require(script.Parent:WaitForChild("GrowthController"))
local v_u_8 = require(v2:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDefinitions"))
local v_u_9 = require(v2:WaitForChild("Plants"):WaitForChild("AnchorService"))
local v_u_10 = require(v2:WaitForChild("Gears"):WaitForChild("Definitions"):WaitForChild("SprinklerDefinitions"))
local v_u_11 = require(v2:WaitForChild("Gears"):WaitForChild("SprinklerAnchorUtil"))
local v12 = require(v2:WaitForChild("PlotStreaming"):WaitForChild("PlotStreamingSignals"))
local v_u_13 = require(v2:WaitForChild("Plants"):WaitForChild("HarvestPromptUtil"))
local v_u_14 = v2:WaitForChild("Gears"):WaitForChild("Models"):WaitForChild("Sprinklers")
local v15 = v2:WaitForChild("RemoteEvents")
local v_u_16 = v15:WaitForChild("RequestCellData")
local v17 = v15:WaitForChild("CellDataUpdate")
local v_u_18 = v1.LocalPlayer
local v_u_19 = v5.CELL_SIZE
local v_u_20 = v5.STREAMING_PADDING
local v_u_21 = v5.DELOAD_DELAY
local v_u_22 = v5.POSITION_CHECK_INTERVAL
local v_u_23 = v5.POSITION_THRESHOLD
local v_u_24 = v5.LOAD_WAVE_STAGGER
local v_u_25 = v5.DELOAD_WAVE_STAGGER
local v_u_26 = workspace:WaitForChild("Plots")
local v_u_27 = {}
local v_u_28 = {}
local v_u_29 = {}
local v_u_30 = {}
local v_u_31 = {}
local v_u_32 = {}
local v_u_33 = {}
local v_u_34 = {}
local v_u_35 = {}
local v_u_36 = Vector3.new(0, 0, 0)
local v_u_37 = {}
local v_u_38 = {}
local function v_u_73(p39)
	-- upvalues: (copy) v_u_20, (copy) v_u_19
	local v40 = p39:FindFirstChild("PlantableArea")
	if not v40 then
		return nil
	end
	local v41 = (1 / 0)
	local v42 = (1 / 0)
	local v43 = (1 / 0)
	local v44 = (-1 / 0)
	local v45 = (-1 / 0)
	local v46 = (-1 / 0)
	for _, v47 in v40:GetChildren() do
		if v47:IsA("BasePart") then
			local v48 = v47.CFrame
			local v49 = v47.Size / 2
			for _, v50 in { -1, 1 } do
				for _, v51 in { -1, 1 } do
					for _, v52 in { -1, 1 } do
						local v53 = v49.X * v50
						local v54 = v49.Y * v51
						local v55 = v49.Z * v52
						local v56 = v48:PointToWorldSpace((Vector3.new(v53, v54, v55)))
						local v57 = v56.X
						v41 = math.min(v41, v57)
						local v58 = v56.Y
						v42 = math.min(v42, v58)
						local v59 = v56.Z
						v43 = math.min(v43, v59)
						local v60 = v56.X
						v44 = math.max(v44, v60)
						local v61 = v56.Y
						v45 = math.max(v45, v61)
						local v62 = v56.Z
						v46 = math.max(v46, v62)
					end
				end
			end
		end
	end
	if v41 == (1 / 0) then
		return nil
	end
	local v63 = v41 - v_u_20
	local v64 = v43 - v_u_20
	local v65 = v44 + v_u_20
	local v66 = v46 + v_u_20
	local v67 = (v65 - v63) / v_u_19
	local v68 = math.ceil(v67)
	local v69 = math.max(1, v68)
	local v70 = (v66 - v64) / v_u_19
	local v71 = math.ceil(v70)
	local v72 = math.max(1, v71)
	return {
		["BoundsMin"] = Vector3.new(v63, v42, v64),
		["BoundsMax"] = Vector3.new(v65, v45, v66),
		["GridOriginX"] = v63,
		["GridOriginZ"] = v64,
		["Cols"] = v69,
		["Rows"] = v72
	}
end
local function v_u_85(p74, p75)
	local v76, v77 = p75:match("^(%d+)_(%d+)$")
	local v78 = tonumber(v76)
	local v79 = tonumber(v77)
	if not (v78 and v79) then
		return {}
	end
	local v80 = {}
	for _, v81 in {
		{ -1, 0 },
		{ 1, 0 },
		{ 0, -1 },
		{ 0, 1 }
	} do
		local v82 = v78 + v81[1]
		local v83 = v79 + v81[2]
		if v82 >= 1 and (v82 <= p74.Rows and (v83 >= 1 and v83 <= p74.Cols)) then
			local v84 = v82 .. "_" .. v83
			table.insert(v80, v84)
		end
	end
	return v80
end
local function v_u_93(p86, p87)
	-- upvalues: (copy) v_u_85
	local v88 = {}
	local v89 = { p87 }
	table.insert(v88, v89)
	local v90 = {
		[p87] = true
	}
	while true do
		v89 = {}
		for _, v91 in v89 do
			for _, v92 in v_u_85(p86, v91) do
				if not v90[v92] then
					v90[v92] = true
					table.insert(v89, v92)
				end
			end
		end
		if #v89 == 0 then
			return v88
		end
		table.insert(v88, v89)
	end
end
local function v_u_98(p94)
	local v95 = p94:FindFirstChild("PlantableArea")
	if not v95 then
		return 0
	end
	local v96 = 0
	for _, v97 in v95:GetChildren() do
		if v97:IsA("BasePart") then
			v96 = v96 + 1
		end
	end
	return v96
end
local function v_u_112(p99)
	-- upvalues: (copy) v_u_33, (copy) v_u_34, (copy) v_u_31, (copy) v_u_7, (copy) v_u_37, (copy) v_u_38, (copy) v_u_6, (copy) v_u_32, (copy) v_u_28
	local v100 = v_u_33
	if v100[p99] then
		task.cancel(v100[p99])
		v100[p99] = nil
	end
	local v101 = v_u_34
	if v101[p99] then
		task.cancel(v101[p99])
		v101[p99] = nil
	end
	local v102 = tostring(p99) .. ":"
	local v103 = #v102
	for v104, v105 in pairs(v_u_31) do
		if string.sub(v104, 1, v103) == v102 then
			for _, v106 in v105 do
				v_u_7.Unregister(v106)
				for _, v107 in v106:GetChildren() do
					if v107:IsA("Model") and v107:GetAttribute("GrowthAnchorIndex") then
						v_u_7.Unregister(v107)
					end
				end
				local v108 = v106:GetAttribute("Uuid")
				if v108 then
					v_u_37[v108] = nil
				end
				v_u_38[v106] = nil
				v_u_6.DestroyPlant(v106)
			end
			v_u_31[v104] = nil
		end
	end
	for v109, v110 in pairs(v_u_32) do
		if string.sub(v109, 1, v103) == v102 then
			for _, v111 in v110 do
				if v111 and v111.Parent then
					v111:Destroy()
				end
			end
			v_u_32[v109] = nil
		end
	end
	v_u_28[p99] = nil
end
local function v_u_134(p113, p114, p115)
	-- upvalues: (copy) v_u_10, (copy) v_u_14, (copy) v_u_11, (copy) v_u_4
	local v116 = v_u_10[p113.SprinklerType]
	if not v116 then
		return nil
	end
	local v117 = v_u_14:FindFirstChild(v116.Model)
	if not v117 then
		return nil
	end
	local v118 = v117:Clone()
	local v119 = p113.RelativePosition
	local v120
	if v119 then
		v120 = v119.X
	else
		v120 = v119
	end
	local v121 = tonumber(v120) or 0
	local v122
	if v119 then
		v122 = v119.Y
	else
		v122 = v119
	end
	local v123 = tonumber(v122) or 0
	if v119 then
		v119 = v119.Z
	end
	local v124 = tonumber(v119) or 0
	local v125 = p114:PointToWorldSpace((Vector3.new(v121, v123, v124)))
	v_u_11.PositionWithAnchor(v118, v125)
	v118:SetAttribute("Uuid", p113.Uuid)
	v118:SetAttribute("SprinklerType", p113.SprinklerType)
	v118:SetAttribute("OwnerUserId", p115)
	v118:SetAttribute("Duration", p113.Duration or p113.GrowthMaxHealth)
	v118:SetAttribute("GrowthHealth", p113.GrowthHealth or 0)
	v118:SetAttribute("GrowthMaxHealth", p113.GrowthMaxHealth or p113.Duration)
	local v126 = "GrowthSaveTime"
	local v127 = p113.GrowthSaveTime
	if not v127 then
		local v128 = workspace:GetServerTimeNow()
		v127 = math.floor(v128)
	end
	v118:SetAttribute(v126, v127)
	local v129 = v118:FindFirstChild("GroundAnchor")
	if v129 then
		for _, v130 in v129:GetChildren() do
			if v130:IsA("Attachment") and v130.Name == "PreviewOutline" then
				for _, v131 in v130:GetDescendants() do
					if v131:IsA("ParticleEmitter") then
						v131.Enabled = false
					end
				end
			end
		end
	end
	for _, v132 in v118:GetDescendants() do
		if v132:IsA("BasePart") then
			v132.Anchored = true
			v132.CanCollide = false
			v132.CastShadow = false
		end
	end
	v_u_4:AddTag(v118, "Sprinkler")
	local v133 = workspace:FindFirstChild("ClientSprinklers")
	if not v133 then
		v133 = Instance.new("Folder")
		v133.Name = "ClientSprinklers"
		v133.Parent = workspace
	end
	v118.Parent = v133
	return v118
end
local function v_u_144(p135, p136, p137, p138)
	-- upvalues: (copy) v_u_32, (copy) v_u_134
	local v139 = p135 .. ":" .. p136
	if not v_u_32[v139] then
		v_u_32[v139] = {}
		for _, v140 in p137 do
			local v141, v142 = pcall(v_u_134, v140, p138, p135)
			if v141 and v142 then
				local v143 = v_u_32[v139]
				table.insert(v143, v142)
			elseif not v141 then
				warn("[PlotStreamingController] Failed to render sprinkler:", v142)
			end
		end
	end
end
local function v_u_155(p145, p146, p147)
	-- upvalues: (copy) v_u_31, (copy) v_u_7, (copy) v_u_37, (copy) v_u_38, (copy) v_u_6, (copy) v_u_3, (copy) v_u_32
	local v148 = p145 .. ":" .. p146
	local v149 = v_u_31[v148]
	if v149 then
		for _, v150 in v149 do
			v_u_7.Unregister(v150)
			for _, v151 in v150:GetChildren() do
				if v151:IsA("Model") and v151:GetAttribute("GrowthAnchorIndex") then
					v_u_7.Unregister(v151)
				end
			end
			local v152 = v150:GetAttribute("Uuid")
			if v152 then
				v_u_37[v152] = nil
			end
			v_u_38[v150] = nil
			v_u_6.DestroyPlant(v150)
			if os.clock() > p147.Value then
				v_u_3.Heartbeat:Wait()
				p147.Value = os.clock() + 0.004
			end
		end
		v_u_31[v148] = nil
	end
	local v153 = v_u_32[v148]
	if v153 then
		for _, v154 in v153 do
			if v154 and v154.Parent then
				v154:Destroy()
			end
		end
		v_u_32[v148] = nil
	end
end
local function v_u_172(p156, p157, p158, p159)
	-- upvalues: (copy) v_u_31, (copy) v_u_7, (copy) v_u_37, (copy) v_u_38, (copy) v_u_6, (copy) v_u_3
	local v160 = p156 .. ":" .. p157
	local v161 = v_u_31[v160]
	if v161 then
		for _, v162 in v161 do
			v_u_7.Unregister(v162)
			for _, v163 in v162:GetChildren() do
				if v163:IsA("Model") and v163:GetAttribute("GrowthAnchorIndex") then
					v_u_7.Unregister(v163)
				end
			end
			local v164 = v162:GetAttribute("Uuid")
			if v164 then
				v_u_37[v164] = nil
			end
			v_u_38[v162] = nil
			v_u_6.DestroyPlant(v162)
		end
	end
	v_u_31[v160] = {}
	local v165 = os.clock() + 0.004
	for _, v166 in p158 do
		local v167, v168 = pcall(v_u_6.RenderPlant, v166, p159, p156)
		if v167 and v168 then
			local v169 = v_u_31[v160]
			table.insert(v169, v168)
			local v170 = v168:GetAttribute("Uuid")
			if v170 then
				v_u_37[v170] = v168
			end
			v_u_38[v168] = v160
			if not v168:GetAttribute("FullyGrown") then
				v_u_7.Register(v168, {
					["EntryType"] = "Plant",
					["PlantId"] = v166.PlantId,
					["OwnerId"] = p156
				})
			end
			if v168:GetAttribute("FullyGrown") then
				for _, v171 in v168:GetChildren() do
					if v171:IsA("Model") and (v171:GetAttribute("GrowthAnchorIndex") and not v171:GetAttribute("FullyGrown")) then
						v_u_7.Register(v171, {
							["EntryType"] = "Fruit",
							["PlantId"] = v166.PlantId,
							["ParentPlant"] = v168,
							["GrowthAnchorIndex"] = v171:GetAttribute("GrowthAnchorIndex"),
							["OwnerId"] = p156,
							["SproutDuration"] = v171:GetAttribute("FruitSproutTime"),
							["GrowthDuration"] = v171:GetAttribute("FruitGrowthTime"),
							["Health"] = v171:GetAttribute("GrowthHealth")
						})
					end
				end
			end
		elseif not v167 then
			warn("[PlotStreamingController] Failed to render plant:", v168)
		end
		if v165 < os.clock() then
			v_u_3.Heartbeat:Wait()
			v165 = os.clock() + 0.004
		end
	end
end
local function v_u_181(p173)
	-- upvalues: (copy) v_u_37, (copy) v_u_7, (copy) v_u_38, (copy) v_u_31, (copy) v_u_6
	local v174 = v_u_37[p173]
	if not (v174 and v174.Parent) then
		v_u_37[p173] = nil
		v174 = nil
	end
	if not v174 then
		return
	end
	v_u_7.Unregister(v174)
	for _, v175 in v174:GetChildren() do
		if v175:IsA("Model") and v175:GetAttribute("GrowthAnchorIndex") then
			v_u_7.Unregister(v175)
		end
	end
	local v176 = v_u_38[v174]
	if v176 then
		local v177 = v_u_31[v176]
		if v177 then
			for v178, v179 in v177 do
				if v179 == v174 then
					table.remove(v177, v178)
					break
				end
			end
		end
	end
	local v180 = v174:GetAttribute("Uuid")
	if v180 then
		v_u_37[v180] = nil
	end
	v_u_38[v174] = nil
	v_u_6.DestroyPlant(v174)
end
local function v_u_186(p182, p183)
	-- upvalues: (copy) v_u_37, (copy) v_u_7
	local v184 = v_u_37[p182]
	if not (v184 and v184.Parent) then
		v_u_37[p182] = nil
		v184 = nil
	end
	if v184 then
		for _, v185 in v184:GetChildren() do
			if v185:IsA("Model") and v185:GetAttribute("GrowthAnchorIndex") == p183 then
				v_u_7.Unregister(v185)
				v185:Destroy()
				return
			end
		end
	end
end
v17.OnClientEvent:Connect(function(p187)
	-- upvalues: (copy) v_u_181, (copy) v_u_186, (copy) v_u_27, (ref) v_u_30, (copy) v_u_28, (copy) v_u_6, (copy) v_u_7, (copy) v_u_19, (copy) v_u_31, (copy) v_u_37, (copy) v_u_38, (copy) v_u_8, (copy) v_u_9, (copy) v_u_13, (copy) v_u_18, (copy) v_u_134, (copy) v_u_32
	if typeof(p187) ~= "table" then
		return
	end
	local v188 = p187.Action
	if v188 == "HarvestPlant" then
		v_u_181(p187.PlantUuid)
		return
	end
	if v188 == "HarvestFruit" then
		v_u_186(p187.PlantUuid, p187.GrowthAnchorIndex)
		return
	end
	if v188 == "NewPlant" then
		local v189 = p187.OwnerId
		local v190 = p187.PlantData
		if not (v189 and v190) then
			return
		end
		local v191 = v_u_27[v189]
		if not v191 then
			return
		end
		if not v_u_30[v189] then
			return
		end
		local v192 = v_u_28[v189]
		if not v192 then
			return
		end
		if v190.FullyGrown then
			v190.GrowthHealth = nil
			v190.GrowthSaveTime = nil
		end
		local v193, v194 = pcall(v_u_6.RenderPlant, v190, v192, v189)
		if not (v193 and v194) then
			return
		end
		if not v194:GetAttribute("FullyGrown") then
			v_u_7.Register(v194, {
				["EntryType"] = "Plant",
				["PlantId"] = v190.PlantId,
				["OwnerId"] = v189
			})
		end
		local v195 = v190.DataVersion
		local v196
		if (tonumber(v195) or 1) >= 6 then
			local v197 = v190.RelativePosition
			local v198
			if v197 then
				v198 = v197.X
			else
				v198 = v197
			end
			local v199 = tonumber(v198) or 0
			local v200
			if v197 then
				v200 = v197.Y
			else
				v200 = v197
			end
			local v201 = tonumber(v200) or 0
			if v197 then
				v197 = v197.Z
			end
			local v202 = tonumber(v197) or 0
			v196 = v192:PointToWorldSpace((Vector3.new(v199, v201, v202)))
		else
			v196 = nil
		end
		if not v196 then
			local v203 = v194:GetAttribute("Uuid")
			if v203 then
				v_u_37[v203] = v194
			end
			v_u_38[v194] = ""
			return
		end
		local v204 = (v196.X - v191.GridOriginX) / v_u_19
		local v205 = math.floor(v204) + 1
		local v206 = v191.Cols
		local v207 = math.clamp(v205, 1, v206)
		local v208 = (v196.Z - v191.GridOriginZ) / v_u_19
		local v209 = math.floor(v208) + 1
		local v210 = v191.Rows
		local v211 = math.clamp(v209, 1, v210) .. "_" .. v207
		if v211 then
			local v212 = v189 .. ":" .. v211
			if not v_u_31[v212] then
				v_u_31[v212] = {}
			end
			local v213 = v_u_31[v212]
			table.insert(v213, v194)
			local v214 = v194:GetAttribute("Uuid")
			if v214 then
				v_u_37[v214] = v194
			end
			v_u_38[v194] = v212
			return
		end
	else
		if v188 ~= "MutationApplied" then
			if v188 ~= "PlantGrowthComplete" then
				if v188 ~= "FruitGrowthComplete" then
					if v188 == "FruitRegrow" then
						local v215 = p187.OwnerId
						local v216 = p187.PlantUuid
						local v217 = p187.FruitData
						if not (v215 and (v216 and v217)) then
							return
						end
						if not v_u_30[v215] then
							return
						end
						local v218 = v_u_37[v216]
						if not (v218 and v218.Parent) then
							v_u_37[v216] = nil
							v218 = nil
						end
						if not v218 then
							return
						end
						local v219 = v218:GetAttribute("PlantType")
						local v220 = v_u_8[v219]
						if not (v220 and v220.fruitTemplate) then
							return
						end
						local v221 = v_u_9.findGrowthAnchors(v218)
						local v222 = v217.GrowthAnchorIndex
						if not (v222 and v221[v222]) then
							return
						end
						local v223 = v217.FruitSproutTime or (v220.fruitSproutTime or 0.5)
						local v224 = v217.FruitGrowthTime or (v220.fruitBaseGrowthTime or 3)
						if v217.IsGiant then
							v224 = v224 * (v220.giantScaleMultiplier or 2)
						end
						local v225 = v223 + v224
						local v226, v227 = pcall(v_u_6.RenderFruitGrowing, v221[v222], v218, v220, v217, 0, v225, v223, v224, 10)
						if v226 and v227 then
							v_u_7.Register(v227, {
								["EntryType"] = "Fruit",
								["PlantId"] = v219,
								["ParentPlant"] = v218,
								["GrowthAnchorIndex"] = v222,
								["OwnerId"] = v215,
								["SproutDuration"] = v223,
								["GrowthDuration"] = v224,
								["Health"] = 0
							})
							return
						end
					elseif v188 == "FavoriteToggle" then
						local v228 = p187.PlantUuid
						local v229 = v_u_37[v228]
						if not (v229 and v229.Parent) then
							v_u_37[v228] = nil
							v229 = nil
						end
						if not v229 then
							return
						end
						local v230 = nil
						if p187.GrowthAnchorIndex then
							for _, v231 in v229:GetChildren() do
								if v231:IsA("Model") and v231:GetAttribute("GrowthAnchorIndex") == p187.GrowthAnchorIndex then
									v230 = v231
									break
								end
							end
						else
							v230 = v229
						end
						if not v230 then
							return
						end
						v230:SetAttribute("Favorited", p187.Favorited or nil)
						local v232 = not p187.Favorited and v230:FindFirstChild("HarvestPrompt", true)
						if v232 then
							local v233 = v_u_18.Character
							if v233 then
								v233 = v233:FindFirstChildOfClass("Tool")
							end
							if not v233 then
								v232.Enabled = true
								v232.UIOffset = Vector2.new(0, 0)
								return
							end
						end
					elseif v188 == "NewSprinkler" then
						local v234 = p187.OwnerId
						local v235 = p187.SprinklerData
						if not (v234 and v235) then
							return
						end
						local v236 = v_u_27[v234]
						if not v236 then
							return
						end
						if not v_u_30[v234] then
							return
						end
						local v237 = v_u_28[v234]
						if not v237 then
							return
						end
						local v238, v239 = pcall(v_u_134, v235, v237, v234)
						if not (v238 and v239) then
							return
						end
						local v240 = v235.RelativePosition
						local v241
						if v240 then
							v241 = v240.X
						else
							v241 = v240
						end
						local v242 = tonumber(v241) or 0
						local v243
						if v240 then
							v243 = v240.Y
						else
							v243 = v240
						end
						local v244 = tonumber(v243) or 0
						if v240 then
							v240 = v240.Z
						end
						local v245 = tonumber(v240) or 0
						local v246 = v237:PointToWorldSpace((Vector3.new(v242, v244, v245)))
						local v247 = (v246.X - v236.GridOriginX) / v_u_19
						local v248 = math.floor(v247) + 1
						local v249 = v236.Cols
						local v250 = math.clamp(v248, 1, v249)
						local v251 = (v246.Z - v236.GridOriginZ) / v_u_19
						local v252 = math.floor(v251) + 1
						local v253 = v236.Rows
						local v254 = math.clamp(v252, 1, v253) .. "_" .. v250
						if v254 then
							local v255 = v234 .. ":" .. v254
							if not v_u_32[v255] then
								v_u_32[v255] = {}
							end
							local v256 = v_u_32[v255]
							table.insert(v256, v239)
							return
						end
					elseif v188 == "MovePlant" then
						local v257 = p187.OwnerId
						local v258 = p187.OldUuid
						local v259 = p187.PlantData
						if not (v257 and (v258 and v259)) then
							return
						end
						v_u_181(v258)
						local v260 = v_u_27[v257]
						if not v260 then
							return
						end
						if not v_u_30[v257] then
							return
						end
						local v261 = v_u_28[v257]
						if not v261 then
							return
						end
						if v259.FullyGrown then
							v259.GrowthHealth = nil
							v259.GrowthSaveTime = nil
						end
						local v262, v263 = pcall(v_u_6.RenderPlant, v259, v261, v257)
						if not (v262 and v263) then
							return
						end
						if not v263:GetAttribute("FullyGrown") then
							v_u_7.Register(v263, {
								["EntryType"] = "Plant",
								["PlantId"] = v259.PlantId,
								["OwnerId"] = v257
							})
						end
						if v263:GetAttribute("FullyGrown") then
							for _, v264 in v263:GetChildren() do
								if v264:IsA("Model") and (v264:GetAttribute("GrowthAnchorIndex") and not v264:GetAttribute("FullyGrown")) then
									v_u_7.Register(v264, {
										["EntryType"] = "Fruit",
										["PlantId"] = v259.PlantId,
										["ParentPlant"] = v263,
										["GrowthAnchorIndex"] = v264:GetAttribute("GrowthAnchorIndex"),
										["OwnerId"] = v257,
										["SproutDuration"] = v264:GetAttribute("FruitSproutTime"),
										["GrowthDuration"] = v264:GetAttribute("FruitGrowthTime"),
										["Health"] = v264:GetAttribute("GrowthHealth")
									})
								end
							end
						end
						local v265 = v259.DataVersion
						local v266
						if (tonumber(v265) or 1) >= 6 then
							local v267 = v259.RelativePosition
							local v268
							if v267 then
								v268 = v267.X
							else
								v268 = v267
							end
							local v269 = tonumber(v268) or 0
							local v270
							if v267 then
								v270 = v267.Y
							else
								v270 = v267
							end
							local v271 = tonumber(v270) or 0
							if v267 then
								v267 = v267.Z
							end
							local v272 = tonumber(v267) or 0
							v266 = v261:PointToWorldSpace((Vector3.new(v269, v271, v272)))
						else
							v266 = nil
						end
						if not v266 then
							local v273 = v263:GetAttribute("Uuid")
							if v273 then
								v_u_37[v273] = v263
							end
							v_u_38[v263] = ""
							return
						end
						local v274 = (v266.X - v260.GridOriginX) / v_u_19
						local v275 = math.floor(v274) + 1
						local v276 = v260.Cols
						local v277 = math.clamp(v275, 1, v276)
						local v278 = (v266.Z - v260.GridOriginZ) / v_u_19
						local v279 = math.floor(v278) + 1
						local v280 = v260.Rows
						local v281 = math.clamp(v279, 1, v280) .. "_" .. v277
						if v281 then
							local v282 = v257 .. ":" .. v281
							if not v_u_31[v282] then
								v_u_31[v282] = {}
							end
							local v283 = v_u_31[v282]
							table.insert(v283, v263)
							local v284 = v263:GetAttribute("Uuid")
							if v284 then
								v_u_37[v284] = v263
							end
							v_u_38[v263] = v282
							return
						end
					else
						if v188 == "RemoveSprinkler" then
							local v285 = p187.OwnerId
							local v286 = p187.SprinklerUuid
							if v285 and v286 then
								if workspace:FindFirstChild("ClientSprinklers") then
									for _, v287 in pairs(v_u_32) do
										for v288, v289 in v287 do
											if v289:GetAttribute("Uuid") == v286 then
												v289:Destroy()
												table.remove(v287, v288)
												return
											end
										end
									end
								end
							else
								return
							end
						end
						if v188 == "RevertPlant" then
							v_u_181(p187.PlantUuid)
						end
					end
					goto l36
				end
				local v290 = p187.PlantUuid
				local v291 = v_u_37[v290]
				if not (v291 and v291.Parent) then
					v_u_37[v290] = nil
					v291 = nil
				end
				if not v291 then
					return
				end
				for _, v292 in v291:GetChildren() do
					if v292:IsA("Model") and v292:GetAttribute("GrowthAnchorIndex") == p187.GrowthAnchorIndex then
						if v_u_7.IsGrowing(v292) then
							v_u_7.Unregister(v292)
						end
						v292:SetAttribute("FullyGrown", true)
						v292:SetAttribute("Sprouting", false)
						v292:SetAttribute("GrowthHealth", v292:GetAttribute("GrowthMaxHealth"))
						v292:SetAttribute("GrowthProgress", 1)
						v292:SetAttribute("RipenessBaseElapsed", 0)
						local v293 = workspace:GetServerTimeNow()
						v292:SetAttribute("RipenessSessionStart", (math.floor(v293)))
						for _, v294 in v292:GetDescendants() do
							if v294:IsA("BasePart") and (v294.Name ~= "FruitAnchor" and (v294.Name ~= "MutationBoundingPart" and (v294.Name ~= "VariantBoundingPart" and v294.Name ~= "Handle"))) then
								v294.Transparency = 0
								local v295 = v294:GetAttribute("OriginalCanCollide")
								local v296 = v294:GetAttribute("OriginalCanQuery")
								local v297 = v294:GetAttribute("OriginalCanTouch")
								if v295 ~= nil then
									v294.CanCollide = v295
								end
								if v296 ~= nil then
									v294.CanQuery = v296
								end
								if v297 ~= nil then
									v294.CanTouch = v297
								end
								for _, v298 in v294:GetDescendants() do
									if v298:IsA("Decal") or v298:IsA("Texture") then
										v298.Transparency = v298:GetAttribute("OriginalTransparency") or 0
										v298:SetAttribute("OriginalTransparency", nil)
									elseif v298:IsA("SurfaceGui") or v298:IsA("BillboardGui") then
										local v299 = v298:GetAttribute("WasEnabled")
										if v299 == nil then
											v298.Enabled = true
										else
											v298.Enabled = v299
											v298:SetAttribute("WasEnabled", nil)
										end
									end
								end
							end
						end
						local v300 = v292:GetAttribute("Variant")
						if v300 and typeof(v300) == "string" then
							v_u_6.ApplyVariantVisuals(v292, v300)
						end
						if not v292:FindFirstChild("HarvestPrompt", true) then
							local v301 = v_u_8[v291:GetAttribute("PlantType")]
							v_u_13.Create(v292, v301)
						end
						local v302 = p187.HiddenNumber
						if v302 then
							local v303 = v292:GetAttribute("HiddenNumber")
							if v303 and v303 > 0 then
								local v304 = v302 / v303
								local v305 = v304 - 1
								if math.abs(v305) > 0.01 then
									v292:ScaleTo(v292:GetScale() * v304)
								end
							end
							v292:SetAttribute("HiddenNumber", v302)
							return
						end
						goto l36
					end
				end
				return
			end
			local v306 = p187.PlantUuid
			local v307 = v_u_37[v306]
			if not (v307 and v307.Parent) then
				v_u_37[v306] = nil
				v307 = nil
			end
			if not v307 then
				return
			end
			if v_u_7.IsGrowing(v307) then
				v_u_7.Unregister(v307)
			end
			v307:SetAttribute("FullyGrown", true)
			v307:SetAttribute("Sprouting", false)
			v307:SetAttribute("GrowthHealth", v307:GetAttribute("GrowthMaxHealth"))
			v307:SetAttribute("GrowthProgress", 1)
			for _, v308 in v307:GetDescendants() do
				if v308:IsA("BasePart") then
					local v309 = v308:GetAttribute("OriginalTransparency")
					if v309 == nil then
						::l76::
						if v308.Name ~= "PlantAnchor" and (v308.Name ~= "FruitAnchor" and (v308.Name ~= "GrowthAnchor" and (v308.Name ~= "MutationBoundingPart" and (v308.Name ~= "VariantBoundingPart" and (v308.Name ~= "Handle" and v308.Name ~= "Truss"))))) then
							v308.Transparency = 0
							local v310 = v308:GetAttribute("OriginalCanCollide")
							local v311 = v308:GetAttribute("OriginalCanQuery")
							local v312 = v308:GetAttribute("OriginalCanTouch")
							if v310 ~= nil then
								v308.CanCollide = v310
							end
							if v311 ~= nil then
								v308.CanQuery = v311
							end
							if v312 ~= nil then
								v308.CanTouch = v312
							end
							for _, v313 in v308:GetDescendants() do
								if v313:IsA("Decal") or v313:IsA("Texture") then
									v313.Transparency = v313:GetAttribute("OriginalTransparency") or 0
									v313:SetAttribute("OriginalTransparency", nil)
								elseif v313:IsA("SurfaceGui") or v313:IsA("BillboardGui") then
									local v314 = v313:GetAttribute("WasEnabled")
									if v314 == nil then
										v313.Enabled = true
									else
										v313.Enabled = v314
										v313:SetAttribute("WasEnabled", nil)
									end
								end
							end
						end
					else
						v308:SetAttribute("OriginalTransparency", nil)
						if v309 < 1 then
							goto l76
						end
					end
				end
			end
			local v315 = v307:GetAttribute("Variant")
			if v315 and (typeof(v315) == "string" and v315 ~= "None") then
				v_u_6.ApplyVariantVisuals(v307, v315)
			end
			local v316 = v307:GetAttribute("Mutation")
			if v316 and (typeof(v316) == "string" and v316 ~= "") then
				v_u_6.RefreshMutationVisuals(v307)
			end
			local v317 = v307:GetAttribute("PlantType")
			local v318 = v_u_8[v317]
			if not v318 then
				return
			end
			if v318.fruitTemplate then
				local v319 = p187.PlantData
				if v319 and v319.Fruits then
					local v320 = v_u_9.findGrowthAnchors(v307)
					for _, v321 in v319.Fruits do
						local v322 = v321.GrowthAnchorIndex
						if v322 and v320[v322] then
							local v323 = v321.FruitSproutTime or (v318.fruitSproutTime or 0.5)
							local v324 = v321.FruitGrowthTime or (v318.fruitBaseGrowthTime or 3)
							if v321.IsGiant then
								v324 = v324 * (v318.giantScaleMultiplier or 2)
							end
							local v325 = v323 + v324
							local v326 = v321.GrowthHealth or 0
							if v321.GrowthSaveTime then
								local v327 = workspace:GetServerTimeNow()
								local v328 = v326 + (math.floor(v327) - v321.GrowthSaveTime)
								v326 = math.min(v325, v328)
							end
							if v325 <= v326 then
								local v329, v330 = pcall(v_u_6.RenderFruitGrowing, v320[v322], v307, v318, v321, v325, v325, v323, v324, 10)
								if v329 and v330 then
									v_u_7.Register(v330, {
										["EntryType"] = "Fruit",
										["PlantId"] = v317,
										["Config"] = v318,
										["ParentPlant"] = v307,
										["GrowthAnchorIndex"] = v322,
										["OwnerId"] = p187.OwnerId,
										["SproutDuration"] = v323,
										["GrowthDuration"] = v324,
										["Health"] = v325
									})
								end
							else
								local v331, v332 = pcall(v_u_6.RenderFruitGrowing, v320[v322], v307, v318, v321, v326, v325, v323, v324, 10)
								if v331 and v332 then
									v_u_7.Register(v332, {
										["EntryType"] = "Fruit",
										["PlantId"] = v317,
										["Config"] = v318,
										["ParentPlant"] = v307,
										["GrowthAnchorIndex"] = v322,
										["OwnerId"] = p187.OwnerId,
										["SproutDuration"] = v323,
										["GrowthDuration"] = v324,
										["Health"] = v326
									})
								end
							end
						end
					end
					return
				end
			elseif v318.isSingleHarvest then
				v307:SetAttribute("HarvestablePlant", true)
				v307:SetAttribute("RipenessBaseElapsed", 0)
				local v333 = workspace:GetServerTimeNow()
				v307:SetAttribute("RipenessSessionStart", (math.floor(v333)))
				local v334 = p187.PlantData
				if v334 and v334.HiddenNumber then
					local v335 = v318.PlantBaseWeight or 0.1
					v307:SetAttribute("HiddenNumber", v334.HiddenNumber)
					v307:SetAttribute("PlantScale", v334.HiddenNumber)
					v307:SetAttribute("PlantWeight", v335 * v334.HiddenNumber)
					v307:ScaleTo(v334.HiddenNumber)
				end
				v_u_13.Create(v307, v318)
				return
			end
			goto l36
		end
		local v336 = p187.PlantUuid
		local v337 = p187.GrowthAnchorIndex
		local v338 = p187.Mutation
		if v337 then
			local v339 = v_u_37[v336]
			if not (v339 and v339.Parent) then
				v_u_37[v336] = nil
				v339 = nil
			end
			if v339 then
				for _, v340 in v339:GetChildren() do
					if v340:IsA("Model") and v340:GetAttribute("GrowthAnchorIndex") == v337 then
						v340:SetAttribute("Mutation", v338)
						v_u_6.RefreshMutationVisuals(v340)
						return
					end
				end
				return
			end
		else
			local v341 = v_u_37[v336]
			if not (v341 and v341.Parent) then
				v_u_37[v336] = nil
				v341 = nil
			end
			if v341 then
				v341:SetAttribute("Mutation", v338)
				v_u_6.RefreshMutationVisuals(v341)
				return
			end
		end
	end
	::l36::
end)
v12.OnLocalHarvestPlant(v_u_181)
v12.OnLocalHarvestFruit(v_u_186)
local function v_u_398()
	-- upvalues: (copy) v_u_18, (ref) v_u_36, (copy) v_u_23, (copy) v_u_26, (copy) v_u_98, (copy) v_u_27, (copy) v_u_29, (copy) v_u_112, (ref) v_u_30, (copy) v_u_73, (copy) v_u_19, (copy) v_u_33, (copy) v_u_34, (copy) v_u_93, (copy) v_u_16, (copy) v_u_28, (copy) v_u_172, (copy) v_u_144, (copy) v_u_24, (copy) v_u_3, (copy) v_u_35, (copy) v_u_21, (copy) v_u_155, (copy) v_u_25
	local v342 = v_u_18.Character
	local v343 = v342 and v342:FindFirstChild("HumanoidRootPart")
	if v343 then
		v343 = v343.Position
	end
	if not v343 then
		return
	end
	if (v343 - v_u_36).Magnitude < v_u_23 then
		return
	end
	v_u_36 = v343
	local v344 = {}
	for _, v345 in v_u_26:GetChildren() do
		if v345:IsA("Model") then
			local v346 = v345:GetAttribute("Owner")
			if v346 then
				local v347 = v_u_98(v345)
				if not v_u_27[v346] then
					::l14::
					local v348 = v347 ~= 0 and v_u_73(v345)
					if v348 then
						v_u_27[v346] = v348
						v_u_29[v346] = v347
					end
					goto l17
				end
				if v347 ~= v_u_29[v346] then
					v_u_112(v346)
					v_u_30[v346] = nil
					v_u_27[v346] = nil
					v_u_29[v346] = nil
					goto l14
				end
				::l17::
				local v349 = v_u_27[v346]
				if v349 then
					local v350
					if v343.X >= v349.BoundsMin.X and (v343.X <= v349.BoundsMax.X and v343.Z >= v349.BoundsMin.Z) then
						v350 = v343.Z <= v349.BoundsMax.Z
					else
						v350 = false
					end
					if v350 then
						local v351 = (v343.X - v349.GridOriginX) / v_u_19
						local v352 = math.floor(v351) + 1
						local v353 = v349.Cols
						local v354 = math.clamp(v352, 1, v353)
						local v355 = (v343.Z - v349.GridOriginZ) / v_u_19
						local v356 = math.floor(v355) + 1
						local v357 = v349.Rows
						local v358 = math.clamp(v356, 1, v357) .. "_" .. v354
						if v358 then
							v344[v346] = v358
						end
					end
				end
			end
		end
	end
	for v_u_359, v_u_360 in v344 do
		if not v_u_30[v_u_359] then
			local v_u_361 = v_u_27[v_u_359]
			if v_u_361 then
				local v362 = v_u_33
				if v362[v_u_359] then
					task.cancel(v362[v_u_359])
					v362[v_u_359] = nil
				end
				local v363 = v_u_34
				if v363[v_u_359] then
					task.cancel(v363[v_u_359])
					v363[v_u_359] = nil
				end
				v_u_33[v_u_359] = task.spawn(function()
					-- upvalues: (ref) v_u_93, (copy) v_u_361, (copy) v_u_360, (ref) v_u_16, (copy) v_u_359, (ref) v_u_33, (ref) v_u_28, (ref) v_u_172, (ref) v_u_144, (ref) v_u_24, (ref) v_u_3
					local v364 = v_u_93(v_u_361, v_u_360)
					local v365 = 1
					while true do
						if v365 > #v364 then
							v_u_33[v_u_359] = nil
							return
						end
						local v366 = v365 + 2 - 1
						local v367 = #v364
						local v368 = math.min(v366, v367)
						local v369 = {}
						for v370 = v365, v368 do
							for _, v371 in v364[v370] do
								table.insert(v369, v371)
							end
						end
						local v372 = nil
						local v373 = nil
						local v374 = nil
						for _ = 1, 10 do
							local v375, v376, v377, v378 = pcall(v_u_16.InvokeServer, v_u_16, v_u_359, v369)
							if v375 and v376 then
								v372 = v378
								v374 = v377
								v373 = v376
								break
							end
							task.wait(1)
						end
						if not v373 then
							warn("[PlotStreamingController] Failed to load cell data for", v_u_359, "after retries")
							v_u_33[v_u_359] = nil
							return
						end
						if v374 and not v_u_28[v_u_359] then
							v_u_28[v_u_359] = v374
						end
						local v379 = v374 or v_u_28[v_u_359]
						for v380 = v365, v368 do
							for _, v381 in v364[v380] do
								local v382 = v373[v381]
								if v382 and #v382 > 0 then
									v_u_172(v_u_359, v381, v382, v379)
								end
								if v372 then
									local v383 = v372[v381]
									if v383 and #v383 > 0 then
										v_u_144(v_u_359, v381, v383, v379)
									end
								end
							end
							if v380 < #v364 then
								task.wait(v_u_24)
							end
						end
						v365 = v368 + 1
						if v365 <= #v364 then
							v_u_3.Heartbeat:Wait()
						end
					end
				end)
			end
		end
	end
	for v_u_384, v_u_385 in v_u_30 do
		if not v344[v_u_384] then
			local v_u_386 = v_u_27[v_u_384]
			if v_u_386 then
				local v387 = v_u_33
				if v387[v_u_384] then
					task.cancel(v387[v_u_384])
					v387[v_u_384] = nil
				end
				v_u_35[v_u_384] = (v_u_35[v_u_384] or 0) + 1
				local v_u_388 = v_u_35[v_u_384]
				task.delay(v_u_21, function()
					-- upvalues: (ref) v_u_35, (copy) v_u_384, (copy) v_u_388, (ref) v_u_30, (copy) v_u_385, (copy) v_u_386, (ref) v_u_33, (ref) v_u_34, (ref) v_u_93, (ref) v_u_155, (ref) v_u_25, (ref) v_u_28
					if v_u_35[v_u_384] == v_u_388 then
						if not v_u_30[v_u_384] then
							local v_u_389 = v_u_384
							local v_u_390 = v_u_385
							local v_u_391 = v_u_386
							local v392 = v_u_33
							if v392[v_u_389] then
								task.cancel(v392[v_u_389])
								v392[v_u_389] = nil
							end
							local v393 = v_u_34
							if v393[v_u_389] then
								task.cancel(v393[v_u_389])
								v393[v_u_389] = nil
							end
							v_u_34[v_u_389] = task.spawn(function()
								-- upvalues: (ref) v_u_93, (copy) v_u_391, (copy) v_u_390, (ref) v_u_155, (copy) v_u_389, (ref) v_u_25, (ref) v_u_28, (ref) v_u_34
								local v394 = v_u_93(v_u_391, v_u_390)
								local v395 = {
									["Value"] = os.clock() + 0.004
								}
								for v396 = #v394, 1, -1 do
									for _, v397 in v394[v396] do
										v_u_155(v_u_389, v397, v395)
									end
									if v396 > 1 then
										v395.Value = os.clock() + 0.004
										task.wait(v_u_25)
									end
								end
								v_u_28[v_u_389] = nil
								v_u_34[v_u_389] = nil
							end)
						end
					else
						return
					end
				end)
			end
		end
	end
	v_u_30 = v344
end
v12.OnPreloadPlot(function(p399)
	-- upvalues: (copy) v_u_98, (copy) v_u_27, (copy) v_u_29, (copy) v_u_112, (ref) v_u_30, (copy) v_u_73, (copy) v_u_19, (copy) v_u_33, (copy) v_u_34, (copy) v_u_93, (copy) v_u_16, (copy) v_u_28, (copy) v_u_172, (copy) v_u_144, (copy) v_u_24, (copy) v_u_3
	if not (p399 and p399:IsA("Model")) then
		return
	end
	local v_u_400 = p399:GetAttribute("Owner")
	if not v_u_400 then
		return
	end
	local v401 = v_u_98(p399)
	if v_u_27[v_u_400] then
		if v401 == v_u_29[v_u_400] then
			::l10::
			local v_u_402 = v_u_27[v_u_400]
			if v_u_402 then
				if v_u_30[v_u_400] then
					return
				else
					local v403 = p399:FindFirstChild("Spawn")
					if v403 then
						v403 = v403:FindFirstChild("Spawn")
					end
					if v403 then
						local v404 = v403.Position
						local v405 = (v404.X - v_u_402.GridOriginX) / v_u_19
						local v406 = math.floor(v405) + 1
						local v407 = v_u_402.Cols
						local v408 = math.clamp(v406, 1, v407)
						local v409 = (v404.Z - v_u_402.GridOriginZ) / v_u_19
						local v410 = math.floor(v409) + 1
						local v411 = v_u_402.Rows
						local v_u_412 = math.clamp(v410, 1, v411) .. "_" .. v408
						if v_u_412 then
							local v413 = v_u_33
							if v413[v_u_400] then
								task.cancel(v413[v_u_400])
								v413[v_u_400] = nil
							end
							local v414 = v_u_34
							if v414[v_u_400] then
								task.cancel(v414[v_u_400])
								v414[v_u_400] = nil
							end
							v_u_33[v_u_400] = task.spawn(function()
								-- upvalues: (ref) v_u_93, (copy) v_u_402, (copy) v_u_412, (ref) v_u_16, (copy) v_u_400, (ref) v_u_33, (ref) v_u_28, (ref) v_u_172, (ref) v_u_144, (ref) v_u_24, (ref) v_u_3
								local v415 = v_u_93(v_u_402, v_u_412)
								local v416 = 1
								while true do
									if v416 > #v415 then
										v_u_33[v_u_400] = nil
										return
									end
									local v417 = v416 + 2 - 1
									local v418 = #v415
									local v419 = math.min(v417, v418)
									local v420 = {}
									for v421 = v416, v419 do
										for _, v422 in v415[v421] do
											table.insert(v420, v422)
										end
									end
									local v423 = nil
									local v424 = nil
									local v425 = nil
									for _ = 1, 10 do
										local v426, v427, v428, v429 = pcall(v_u_16.InvokeServer, v_u_16, v_u_400, v420)
										if v426 and v427 then
											v423 = v429
											v425 = v428
											v424 = v427
											break
										end
										task.wait(1)
									end
									if not v424 then
										warn("[PlotStreamingController] Failed to load cell data for", v_u_400, "after retries")
										v_u_33[v_u_400] = nil
										return
									end
									if v425 and not v_u_28[v_u_400] then
										v_u_28[v_u_400] = v425
									end
									local v430 = v425 or v_u_28[v_u_400]
									for v431 = v416, v419 do
										for _, v432 in v415[v431] do
											local v433 = v424[v432]
											if v433 and #v433 > 0 then
												v_u_172(v_u_400, v432, v433, v430)
											end
											if v423 then
												local v434 = v423[v432]
												if v434 and #v434 > 0 then
													v_u_144(v_u_400, v432, v434, v430)
												end
											end
										end
										if v431 < #v415 then
											task.wait(v_u_24)
										end
									end
									v416 = v419 + 1
									if v416 <= #v415 then
										v_u_3.Heartbeat:Wait()
									end
								end
							end)
							v_u_30[v_u_400] = v_u_412
						end
					else
						return
					end
				end
			else
				return
			end
		end
		v_u_112(v_u_400)
		v_u_30[v_u_400] = nil
		v_u_27[v_u_400] = nil
		v_u_29[v_u_400] = nil
	end
	local v435 = v401 ~= 0 and v_u_73(p399)
	if v435 then
		v_u_27[v_u_400] = v435
		v_u_29[v_u_400] = v401
	end
	goto l10
end)
for _, v_u_436 in v_u_26:GetChildren() do
	if v_u_436:IsA("Model") then
		v_u_436:GetAttributeChangedSignal("Owner"):Connect(function()
			-- upvalues: (copy) v_u_436, (copy) v_u_27, (copy) v_u_29, (copy) v_u_28
			local v437 = v_u_436:GetAttribute("Owner")
			if v437 then
				v_u_27[v437] = nil
				v_u_29[v437] = nil
				v_u_28[v437] = nil
			end
		end)
	end
end
v_u_26.ChildAdded:Connect(function(p_u_438)
	-- upvalues: (copy) v_u_27, (copy) v_u_29, (copy) v_u_28
	if p_u_438:IsA("Model") then
		p_u_438:GetAttributeChangedSignal("Owner"):Connect(function()
			-- upvalues: (copy) p_u_438, (ref) v_u_27, (ref) v_u_29, (ref) v_u_28
			local v439 = p_u_438:GetAttribute("Owner")
			if v439 then
				v_u_27[v439] = nil
				v_u_29[v439] = nil
				v_u_28[v439] = nil
			end
		end)
	end
end)
task.spawn(function()
	-- upvalues: (copy) v_u_22, (copy) v_u_398
	while true do
		task.wait(v_u_22)
		v_u_398()
	end
end)
print("[PlotStreamingController] Initialized")