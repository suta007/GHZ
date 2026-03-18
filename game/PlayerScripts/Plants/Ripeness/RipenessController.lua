local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("CollectionService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Plants.Definitions.RipenessDataDefinitions)
local v_u_5 = require(v1:WaitForChild("Player"):WaitForChild("NotificationService"))
local v6 = v1:WaitForChild("RemoteEvents"):WaitForChild("GrowthUpdate")
local v_u_7 = v3.LocalPlayer
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = {}
local v_u_12 = {}
local v_u_13 = {
	["Lush"] = "A crop has reached <font color=\"%s\">Lush</font>! Peak value!"
}
local v_u_14 = {}
local function v_u_33(p_u_15, p16, p17)
	-- upvalues: (copy) v_u_13, (copy) v_u_14, (copy) v_u_5
	if v_u_13[p_u_15] then
		if not v_u_14[p_u_15] then
			v_u_14[p_u_15] = {
				["color"] = p_u_15 == "Ripe" and p16.ripeColor or p16.lushColor,
				["count"] = 0,
				["targets"] = {}
			}
			task.delay(1, function()
				-- upvalues: (ref) v_u_14, (copy) p_u_15, (ref) v_u_13, (ref) v_u_5
				local v18 = v_u_14[p_u_15]
				if v18 then
					v_u_14[p_u_15] = nil
					local v19 = v18.color
					local v20 = v19.R * 255 + 0.5
					local v21 = math.floor(v20)
					local v22 = v19.G * 255 + 0.5
					local v23 = math.floor(v22)
					local v24 = v19.B * 255 + 0.5
					local v25 = math.floor(v24)
					local v26 = string.format("#%02X%02X%02X", v21, v23, v25)
					local v27 = v_u_13[p_u_15]
					if v27 then
						v_u_5.Notify(string.format(v27, v26), 3)
					end
					for _, v28 in v18.targets do
						if v28.Parent then
							local v29 = v18.color
							local v_u_30 = Instance.new("Highlight")
							v_u_30.FillColor = v29
							v_u_30.OutlineColor = v29
							v_u_30.FillTransparency = 0.5
							v_u_30.Parent = v28
							task.delay(3, function()
								-- upvalues: (copy) v_u_30
								if v_u_30 then
									v_u_30:Destroy()
								end
							end)
						end
					end
				end
			end)
		end
		local v31 = v_u_14[p_u_15]
		v31.count = v31.count + 1
		local v32 = v_u_14[p_u_15].targets
		table.insert(v32, p17)
	end
end
local function v_u_73(p34, p35)
	-- upvalues: (copy) v_u_7, (copy) v_u_33, (copy) v_u_11, (copy) v_u_9, (copy) v_u_10
	if p34.Parent then
		if p34:GetAttribute("FullyGrown") then
			if not p34:GetAttribute("RipenessSessionStart") then
				local v36 = workspace:GetServerTimeNow()
				p34:SetAttribute("RipenessSessionStart", (math.floor(v36)))
			end
			local v37 = p34:GetAttribute("RipenessStage")
			local v38 = p34:GetAttribute("RipenessBaseElapsed") or 0
			local v39 = p34:GetAttribute("RipenessSessionStart")
			if v39 then
				local v40 = workspace:GetServerTimeNow()
				v38 = v38 + (math.floor(v40) - v39)
			end
			local v41 = p35.unripeTime
			local v42 = p35.lushTime
			local v43 = p35.unripeMultiplier
			local v44 = p35.ripeMultiplier
			local v45 = p35.lushMultiplier
			local v46 = p35.sigmoidSteepness
			local v47, v48
			if v38 < v41 then
				local v49 = v38 / v41
				local v50 = -v46 * (v49 - 0.5)
				local v51 = 1 / (math.exp(v50) + 1)
				v47 = v43 + (v44 - v43) * v51
				v48 = "Unripe"
			else
				local v52 = (v38 - v41) / v42
				local v53 = math.min(v52, 1)
				v47 = v44 + (v45 - v44) * v53
				if v45 <= v47 then
					v48 = "Lush"
				else
					v48 = "Ripe"
				end
			end
			p34:SetAttribute("RipenessMultiplier", v47)
			p34:SetAttribute("RipenessStage", v48)
			p34:SetAttribute("RipenessElapsed", v38)
			if v37 and (v37 ~= v48 and (v48 == "Ripe" or v48 == "Lush")) then
				local v54
				if p34:GetAttribute("OwnerUserId") or not (p34.Parent and p34.Parent:IsA("Model")) then
					v54 = p34
				else
					v54 = p34.Parent
				end
				if v54:GetAttribute("OwnerUserId") == v_u_7.UserId then
					v_u_33(v48, p35, p34)
				end
			end
			if v48 ~= "Unripe" then
				local v55 = p35.unripeTime
				local v56 = p35.lushTime
				local v57
				if v38 < v55 then
					local v58 = v38 / v55
					local v59 = p35.unripeColor
					local v60 = p35.ripeColor
					v57 = Color3.new(v59.R + (v60.R - v59.R) * v58, v59.G + (v60.G - v59.G) * v58, v59.B + (v60.B - v59.B) * v58)
				else
					local v61 = (v38 - v55) / v56
					local v62 = math.min(v61, 1)
					local v63 = p35.ripeColor
					local v64 = p35.lushColor
					v57 = Color3.new(v63.R + (v64.R - v63.R) * v62, v63.G + (v64.G - v63.G) * v62, v63.B + (v64.B - v63.B) * v62)
				end
				local v65 = p35.colorIntensity
				local v66 = v_u_11[p34]
				if v66 then
					local v67 = v66.R - v57.R
					local v68
					if math.abs(v67) < 0.00392156862745098 then
						local v69 = v66.G - v57.G
						if math.abs(v69) < 0.00392156862745098 then
							local v70 = v66.B - v57.B
							v68 = math.abs(v70) < 0.00392156862745098
						else
							v68 = false
						end
					else
						v68 = false
					end
					if v68 then
						return
					end
				end
				v_u_11[p34] = v57
				for _, v71 in p34:GetDescendants() do
					if v71:IsA("BasePart") and (v71.Name ~= "MutationBoundingPart" and v71.Name ~= "VariantBoundingPart") then
						if not v_u_9[v71] then
							v_u_9[v71] = v71.Color
						end
						if p34 then
							if not v_u_10[p34] then
								v_u_10[p34] = {}
							end
							v_u_10[p34][v71] = true
						end
						local v72 = v_u_9[v71]
						v71.Color = Color3.new(v72.R + (v57.R - v72.R) * v65, v72.G + (v57.G - v72.G) * v65, v72.B + (v57.B - v72.B) * v65)
					end
				end
			end
		end
	else
		return
	end
end
local function v_u_78(p74, p75)
	-- upvalues: (copy) v_u_8, (copy) v_u_12, (copy) v_u_73
	if not p74:GetAttribute("RipenessSessionStart") then
		local v76 = workspace:GetServerTimeNow()
		p74:SetAttribute("RipenessSessionStart", (math.floor(v76)))
	end
	if not p74:GetAttribute("RipenessBaseElapsed") then
		p74:SetAttribute("RipenessBaseElapsed", 0)
	end
	v_u_8[p74] = p75
	local v77 = p74:GetAttribute("Uuid")
	if v77 then
		v_u_12["ripeness:" .. v77] = p74
	end
	v_u_73(p74, p75)
end
local function v84(p_u_79)
	-- upvalues: (copy) v_u_4, (copy) v_u_78
	if p_u_79:IsA("Model") then
		local v80 = p_u_79:GetAttribute("PlantType")
		if not v80 then
			local v81 = p_u_79.Parent
			if v81 and v81:IsA("Model") then
				v80 = v81:GetAttribute("PlantType")
			else
				v80 = nil
			end
		end
		local v_u_82 = v_u_4.getConfigForPlant(v80 or "")
		if v_u_82.enabled then
			if p_u_79:GetAttribute("FullyGrown") then
				task.defer(function()
					-- upvalues: (copy) p_u_79, (ref) v_u_78, (copy) v_u_82
					if p_u_79.Parent then
						v_u_78(p_u_79, v_u_82)
					end
				end)
			else
				local v_u_83 = nil
				v_u_83 = p_u_79:GetAttributeChangedSignal("FullyGrown"):Connect(function()
					-- upvalues: (copy) p_u_79, (ref) v_u_83, (ref) v_u_78, (copy) v_u_82
					if p_u_79:GetAttribute("FullyGrown") then
						if v_u_83 then
							v_u_83:Disconnect()
						end
						v_u_78(p_u_79, v_u_82)
					end
				end)
			end
		else
			return
		end
	else
		return
	end
end
v2:GetInstanceAddedSignal("Fruit"):Connect(v84)
v2:GetInstanceRemovedSignal("Fruit"):Connect(function(p85)
	-- upvalues: (copy) v_u_12, (copy) v_u_8, (copy) v_u_10, (copy) v_u_9, (copy) v_u_11
	local v86 = p85:GetAttribute("Uuid")
	if v86 then
		v_u_12["ripeness:" .. v86] = nil
	end
	v_u_8[p85] = nil
	local v87 = v_u_10[p85]
	if v87 then
		for v88 in v87 do
			v_u_9[v88] = nil
		end
		v_u_10[p85] = nil
	end
	v_u_11[p85] = nil
end)
for _, v89 in ipairs(v2:GetTagged("Fruit")) do
	task.spawn(v84, v89)
end
local function v96(p_u_90)
	-- upvalues: (copy) v_u_8, (copy) v_u_4, (copy) v_u_78
	if p_u_90:IsA("Model") then
		local function v_u_94()
			-- upvalues: (copy) p_u_90, (ref) v_u_8, (ref) v_u_4, (ref) v_u_78
			if p_u_90:GetAttribute("HarvestablePlant") then
				if v_u_8[p_u_90] then
					return
				else
					local v91 = p_u_90:GetAttribute("PlantType")
					local v_u_92 = v_u_4.getConfigForPlant(v91 or "")
					if v_u_92.enabled then
						if p_u_90:GetAttribute("FullyGrown") then
							task.defer(function()
								-- upvalues: (ref) p_u_90, (ref) v_u_78, (copy) v_u_92
								if p_u_90.Parent then
									v_u_78(p_u_90, v_u_92)
								end
							end)
						else
							local v_u_93 = nil
							v_u_93 = p_u_90:GetAttributeChangedSignal("FullyGrown"):Connect(function()
								-- upvalues: (ref) p_u_90, (ref) v_u_93, (ref) v_u_78, (copy) v_u_92
								if p_u_90:GetAttribute("FullyGrown") then
									if v_u_93 then
										v_u_93:Disconnect()
									end
									v_u_78(p_u_90, v_u_92)
								end
							end)
						end
					else
						return
					end
				end
			else
				return
			end
		end
		v_u_94()
		if not p_u_90:GetAttribute("HarvestablePlant") then
			local v_u_95 = nil
			v_u_95 = p_u_90:GetAttributeChangedSignal("HarvestablePlant"):Connect(function()
				-- upvalues: (copy) p_u_90, (ref) v_u_95, (copy) v_u_94
				if p_u_90:GetAttribute("HarvestablePlant") then
					if v_u_95 then
						v_u_95:Disconnect()
					end
					v_u_94()
				end
			end)
		end
	end
end
v2:GetInstanceAddedSignal("Plant"):Connect(v96)
v2:GetInstanceRemovedSignal("Plant"):Connect(function(p97)
	-- upvalues: (copy) v_u_12, (copy) v_u_8, (copy) v_u_10, (copy) v_u_9, (copy) v_u_11
	local v98 = p97:GetAttribute("Uuid")
	if v98 then
		v_u_12["ripeness:" .. v98] = nil
	end
	v_u_8[p97] = nil
	local v99 = v_u_10[p97]
	if v99 then
		for v100 in v99 do
			v_u_9[v100] = nil
		end
		v_u_10[p97] = nil
	end
	v_u_11[p97] = nil
end)
for _, v101 in ipairs(v2:GetTagged("Plant")) do
	task.spawn(v96, v101)
end
task.spawn(function()
	-- upvalues: (copy) v_u_8, (copy) v_u_73, (copy) v_u_10, (copy) v_u_9, (copy) v_u_11
	while true do
		task.wait(1)
		for v102, v103 in pairs(v_u_8) do
			if v102.Parent then
				v_u_73(v102, v103)
			else
				v_u_8[v102] = nil
				local v104 = v_u_10[v102]
				if v104 then
					for v105 in v104 do
						v_u_9[v105] = nil
					end
					v_u_10[v102] = nil
				end
				v_u_11[v102] = nil
			end
		end
	end
end)
v6.OnClientEvent:Connect(function(_, p106)
	-- upvalues: (copy) v_u_12
	if typeof(p106) == "table" then
		for _, v107 in p106 do
			local v108 = v_u_12[v107.Uuid]
			if v108 and v108.Parent then
				v108:SetAttribute("RipenessBaseElapsed", v107.Health)
				local v109 = workspace:GetServerTimeNow()
				v108:SetAttribute("RipenessSessionStart", (math.floor(v109)))
			end
		end
	end
end)
print("[RipenessController] Initialized")