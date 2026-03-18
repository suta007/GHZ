local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("TweenService")
local v_u_4 = game:GetService("Workspace")
local v_u_5 = require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDefinitions"))
local v_u_6 = require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDataDefinitions"))
local v_u_7 = require(v1:WaitForChild("Plants"):WaitForChild("AnchorService"))
local v_u_8 = require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("MutationDataDefinitions"))
local v9 = require(v1:WaitForChild("Plants"):WaitForChild("PlantMathUtil"))
local v10 = require(v1:WaitForChild("Plants"):WaitForChild("HarvestPromptUtil"))
local v_u_11 = v9.deserializeVector3
local v_u_12 = v9.calculateBaseSproutTime
local v_u_13 = v9.calculateBaseGrowthTime
local v_u_14 = v9.calculateBaseFruitSproutTime
local v_u_15 = v10.Create
local v_u_16 = v1:WaitForChild("MutationEffects")
local v_u_17 = v1:WaitForChild("VariantEffects")
local v_u_18 = {}
local v_u_19 = Random.new()
local function v_u_23(p20)
	for _, v21 in p20:GetDescendants() do
		if v21:IsA("BasePart") then
			v21:SetAttribute("OriginalTransparency", v21.Transparency)
			v21:SetAttribute("OriginalCanCollide", v21.CanCollide)
			v21:SetAttribute("OriginalCanQuery", v21.CanQuery)
			v21:SetAttribute("OriginalCanTouch", v21.CanTouch)
			v21.Transparency = 1
			v21.CanCollide = false
			v21.CanQuery = false
			v21.CanTouch = false
			for _, v22 in v21:GetDescendants() do
				if v22:IsA("Decal") or v22:IsA("Texture") then
					v22:SetAttribute("OriginalTransparency", v22.Transparency)
					v22.Transparency = 1
				elseif v22:IsA("SurfaceGui") or v22:IsA("BillboardGui") then
					v22:SetAttribute("WasEnabled", v22.Enabled)
					v22.Enabled = false
				end
			end
		end
	end
end
local function v_u_27(p24)
	for _, v25 in p24:GetDescendants() do
		if v25:IsA("Decal") or v25:IsA("Texture") then
			v25.Transparency = v25:GetAttribute("OriginalTransparency") or 0
			v25:SetAttribute("OriginalTransparency", nil)
		elseif v25:IsA("SurfaceGui") or v25:IsA("BillboardGui") then
			local v26 = v25:GetAttribute("WasEnabled")
			if v26 == nil then
				v25.Enabled = true
			else
				v25.Enabled = v26
				v25:SetAttribute("WasEnabled", nil)
			end
		end
	end
end
local function v_u_34(p28)
	-- upvalues: (copy) v_u_27
	for _, v29 in p28:GetDescendants() do
		if v29:IsA("BasePart") then
			local v30 = v29:GetAttribute("OriginalTransparency")
			if v30 == nil then
				::l5::
				if v29.Name ~= "PlantAnchor" and (v29.Name ~= "FruitAnchor" and (v29.Name ~= "GrowthAnchor" and (v29.Name ~= "MutationBoundingPart" and (v29.Name ~= "VariantBoundingPart" and (v29.Name ~= "Handle" and v29.Name ~= "Truss"))))) then
					v29.Transparency = 0
					local v31 = v29:GetAttribute("OriginalCanCollide")
					local v32 = v29:GetAttribute("OriginalCanQuery")
					local v33 = v29:GetAttribute("OriginalCanTouch")
					if v31 ~= nil then
						v29.CanCollide = v31
					end
					if v32 ~= nil then
						v29.CanQuery = v32
					end
					if v33 ~= nil then
						v29.CanTouch = v33
					end
					v_u_27(v29)
				end
			else
				v29:SetAttribute("OriginalTransparency", nil)
				if v30 < 1 then
					goto l5
				end
			end
		end
	end
end
local function v_u_37(p35)
	-- upvalues: (copy) v_u_27
	for _, v36 in p35 do
		v36.CanCollide = v36:GetAttribute("OriginalCanCollide") ~= false
		v36.CanQuery = v36:GetAttribute("OriginalCanQuery") ~= false
		v36.CanTouch = v36:GetAttribute("OriginalCanTouch") ~= false
		v36.Transparency = 0
		v_u_27(v36)
	end
end
local function v_u_44(p38)
	local v39 = {}
	for _, v40 in p38:GetDescendants() do
		if v40:IsA("BasePart") then
			local v41 = v40.Name
			local v42 = tonumber(v41)
			if v42 then
				if not v39[v42] then
					v39[v42] = {}
				end
				local v43 = v39[v42]
				table.insert(v43, v40)
			end
		end
	end
	return v39
end
local function v_u_55(p45, p46, p47, p48)
	-- upvalues: (copy) v_u_44, (copy) v_u_37
	if p46 < p47 then
		return
	else
		local v49 = v_u_44(p45)
		local v50 = 0
		for v51 in v49 do
			if v50 < v51 then
				v50 = v51
			end
		end
		if v50 ~= 0 and p48 > 0 then
			local v52 = (p46 - p47) / p48 * v50
			local v53 = math.floor(v52) + 1
			for v54 = 1, math.min(v50, v53) do
				if v49[v54] then
					v_u_37(v49[v54])
				end
			end
		end
	end
end
local function v_u_76(p56, p57, p58, p59)
	-- upvalues: (copy) v_u_7
	v_u_7.initializeAnchorsOnModel(p56)
	if not v_u_7.positionPlantWithAnchor(p56, p57, p58.Y, p58.X, p58.Z) then
		local v60
		if p59 then
			local v61 = p57.Y + p59.Size.Y / 2
			local v62 = CFrame.new(p57.X, v61, p57.Z)
			local v63 = CFrame.Angles
			local v64 = p58.X
			local v65 = math.rad(v64)
			local v66 = p58.Y
			local v67 = math.rad(v66)
			local v68 = p58.Z
			v60 = v62 * v63(v65, v67, (math.rad(v68)))
		else
			local v69 = CFrame.new(p57)
			local v70 = CFrame.Angles
			local v71 = p58.X
			local v72 = math.rad(v71)
			local v73 = p58.Y
			local v74 = math.rad(v73)
			local v75 = p58.Z
			v60 = v69 * v70(v72, v74, (math.rad(v75)))
		end
		p56:PivotTo(v60)
	end
end
local function v_u_86(p77, p78)
	local v79, v80 = p77:GetBoundingBox()
	local v_u_81 = Instance.new("Part")
	v_u_81.Name = p78
	v_u_81.Size = v80
	v_u_81.CFrame = v79
	v_u_81.Transparency = 1
	v_u_81.CanCollide = false
	v_u_81.CanQuery = false
	v_u_81.CanTouch = false
	v_u_81.Anchored = false
	v_u_81.Massless = true
	v_u_81.Parent = p77.Parent
	local v82 = p77.PrimaryPart
	if not v82 then
		for _, v83 in p77:GetChildren() do
			if v83:IsA("BasePart") and v83 ~= v_u_81 then
				v82 = v83
				break
			end
		end
	end
	if v82 then
		local v84 = Instance.new("WeldConstraint")
		v84.Part0 = v_u_81
		v84.Part1 = v82
		v84.Parent = v_u_81
	else
		v_u_81.Anchored = true
	end
	local v85 = Instance.new("ObjectValue")
	v85.Name = p78 .. "Ref"
	v85.Value = v_u_81
	v85.Parent = p77
	p77.Destroying:Once(function()
		-- upvalues: (copy) v_u_81
		if v_u_81 and v_u_81.Parent then
			v_u_81:Destroy()
		end
	end)
	return v_u_81
end
local function v_u_94(p87, p88, p89, p90)
	for _, v91 in {
		Enum.NormalId.Front,
		Enum.NormalId.Back,
		Enum.NormalId.Left,
		Enum.NormalId.Right,
		Enum.NormalId.Top,
		Enum.NormalId.Bottom
	} do
		local v92 = Instance.new("SurfaceGui")
		v92.Name = p90
		v92.Face = v91
		v92.AlwaysOnTop = true
		v92.LightInfluence = 0
		v92.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
		v92.PixelsPerStud = 50
		v92.Parent = p87
		local v93 = Instance.new("ImageLabel")
		v93.Size = UDim2.new(1, 0, 1, 0)
		v93.BackgroundTransparency = 1
		v93.ImageTransparency = p89
		v93.ImageColor3 = p88
		v93.Image = "rbxassetid://241837213"
		v93.Parent = v92
	end
end
local function v_u_106(p95, p96)
	-- upvalues: (copy) v_u_16, (copy) v_u_86, (copy) v_u_94
	local v97 = v_u_16:FindFirstChild(p96)
	if v97 then
		local v98 = p95:FindFirstChild("MutationBoundingPartRef")
		if v98 then
			v98 = v98.Value
		end
		if not (v98 and v98.Parent) then
			v98 = v_u_86(p95, "MutationBoundingPart")
		end
		local v99 = v97.Color
		local v100 = v97.Transparency
		for _, v101 in p95:GetDescendants() do
			if v101:IsA("BasePart") and (v101.Name ~= "MutationBoundingPart" and (v101.Name ~= "VariantBoundingPart" and (v101.Name ~= "PlantAnchor" and (v101.Name ~= "FruitAnchor" and v101.Name ~= "GrowthAnchor")))) then
				local v102 = 1 - v100
				if v102 > 0 then
					v101.Color = v101.Color:Lerp(v99, v102 * 0.5)
				end
				v_u_94(v101, v99, v100, "MutationOverlay")
			end
		end
		for _, v103 in v97:GetChildren() do
			if v103:IsA("ParticleEmitter") or v103:IsA("Attachment") then
				local v104 = v103:Clone()
				v104.Parent = v98
				if v104:IsA("ParticleEmitter") then
					v104.Enabled = true
				end
				for _, v105 in v104:GetDescendants() do
					if v105:IsA("ParticleEmitter") then
						v105.Enabled = true
					end
				end
			end
		end
	end
end
function v_u_18.RefreshMutationVisuals(p107)
	-- upvalues: (copy) v_u_8, (copy) v_u_106
	local v108 = p107:FindFirstChild("MutationBoundingPartRef")
	if v108 then
		v108 = v108.Value
	end
	if v108 and v108.Parent then
		for _, v109 in v108:GetChildren() do
			if v109:IsA("ParticleEmitter") or v109:IsA("Attachment") then
				v109:Destroy()
			end
		end
	end
	for _, v110 in p107:GetDescendants() do
		if v110:IsA("SurfaceGui") and v110.Name == "MutationOverlay" then
			v110:Destroy()
		end
	end
	local v111 = p107:GetAttribute("Mutation")
	if v111 and v111 ~= "" then
		local v112 = 0
		local v113 = nil
		for v114 in string.gmatch(v111, "([^,]+)") do
			local v115 = v114:match("^%s*(.-)%s*$")
			local v116 = v_u_8[v115]
			if v116 and (v116.priceMultiplier and v112 < v116.priceMultiplier) then
				v112 = v116.priceMultiplier
				v113 = v115
			end
		end
		if v113 then
			v_u_106(p107, v113)
		end
	end
end
function v_u_18.ApplyVariantVisuals(p117, p118)
	-- upvalues: (copy) v_u_17, (copy) v_u_94, (copy) v_u_86
	local v119 = v_u_17:FindFirstChild(p118)
	if v119 then
		local v120 = p117:FindFirstChild("VariantBoundingPartRef")
		local v121
		if v120 then
			v121 = v120.Value
		else
			v121 = v120
		end
		if v121 then
			v121:Destroy()
		end
		if v120 then
			v120:Destroy()
		end
		for _, v122 in p117:GetDescendants() do
			if v122:IsA("SurfaceGui") and v122.Name == "VariantOverlay" then
				v122:Destroy()
			end
		end
		local v123 = v119.Color
		local v124 = v119.Transparency
		local v125 = 1 - v124
		for _, v126 in p117:GetDescendants() do
			if v126:IsA("BasePart") and (v126.Name ~= "VariantBoundingPart" and (v126.Name ~= "PlantAnchor" and (v126.Name ~= "FruitAnchor" and v126.Name ~= "GrowthAnchor"))) then
				if v125 > 0 then
					v126.Color = v126.Color:Lerp(v123, v125)
					if v126:IsA("MeshPart") then
						v126.TextureID = ""
					end
				end
				v_u_94(v126, v123, v124, "VariantOverlay")
			end
		end
		local v127 = v_u_86(p117, "VariantBoundingPart")
		for _, v128 in v119:GetChildren() do
			if v128:IsA("ParticleEmitter") then
				v128:Clone().Parent = v127
			elseif v128:IsA("Attachment") then
				local v129 = v128:Clone()
				v129.Parent = v127
				for _, v130 in v129:GetChildren() do
					if v130:IsA("ParticleEmitter") then
						v130.Enabled = true
					end
				end
			end
		end
	end
end
local function v_u_142(p131, p132, _)
	-- upvalues: (copy) v_u_14
	local v133 = v_u_14(p131)
	local v134 = (p131.fruitBaseGrowthTime or 3) * (p132.HiddenNumber or 1)
	local v135 = v133 + v134
	local v136
	if p132.GrowthHealth == nil then
		if p132.FullyGrown then
			v136 = v135
		else
			local v137
			if p132.FruitSpawnTime then
				local v138 = workspace:GetServerTimeNow()
				local v139 = math.floor(v138) - p132.FruitSpawnTime
				v137 = math.min(v139, v135)
			else
				v137 = 0
			end
			v136 = math.min(v135, v137)
		end
	else
		v136 = p132.GrowthHealth
		if p132.GrowthSaveTime then
			local v140 = workspace:GetServerTimeNow()
			local v141 = v136 + (math.floor(v140) - p132.GrowthSaveTime)
			v136 = math.min(v135, v141)
		end
	end
	return v136, v135, v133, v134
end
local function v_u_172(p143, p144, p145, p146, p147)
	-- upvalues: (copy) v_u_142, (copy) v_u_2, (copy) v_u_7, (copy) v_u_34, (copy) v_u_15, (copy) v_u_18
	if not p145.fruitTemplate then
		return nil
	end
	p143.Transparency = 1
	p143.CanCollide = false
	local v148 = p146.FruitTemplateName
	local v151
	if p145.fruitTemplate then
		local v150 = p145.fruitTemplate:GetChildren()
		if #v150 == 0 then
			v151 = nil
		else
			if v148 then
				for _, v151 in v150 do
					if v151.Name == v148 then
						goto l5
					end
				end
			end
			v151 = v150[1]
		end
	else
		v151 = nil
	end
	::l5::
	if not v151 then
		return nil
	end
	local v152 = v151:Clone()
	local v153 = p146.HiddenNumber or 1
	local v154 = p145.FruitBaseWeight or 0.1
	local v155, v156
	if p147 >= 10 then
		v155 = v154 * v153
		v156 = v155 / v154
	else
		local v157 = p146.FruitSizeBoost or 0
		v155 = v154 * v153 * (1 + v157)
		if p146.IsGiant then
			v155 = v155 * (p145.giantScaleMultiplier or 2)
		end
		v156 = v155 / v154
	end
	local v158 = p147 >= 10
	local _, v159, v160, v161 = v_u_142(p145, p146, p147)
	v152:ScaleTo(v156)
	v_u_2:AddTag(v152, "Fruit")
	v152.Parent = p144
	v_u_7.initializeAnchorsOnModel(v152)
	if not v_u_7.positionFruitToGrowthAnchor(v152, p143, p146.GrowthAnchorIndex) then
		v152:PivotTo(p143.CFrame)
	end
	local v162 = "FruitSpawnTime"
	local v163 = p146.FruitSpawnTime
	if not v163 then
		local v164 = workspace:GetServerTimeNow()
		v163 = math.floor(v164)
	end
	v152:SetAttribute(v162, v163)
	v152:SetAttribute("HiddenNumber", p146.HiddenNumber or 1)
	v152:SetAttribute("FruitWeight", v155)
	v152:SetAttribute("FruitScale", v156)
	v152:SetAttribute("FruitSizeBoost", v158 and 0 or (p146.FruitSizeBoost or 0))
	v152:SetAttribute("GrowthAnchorIndex", p146.GrowthAnchorIndex or 1)
	v152:SetAttribute("FruitGrowthTime", v161)
	v152:SetAttribute("FruitSproutTime", v160)
	v152:SetAttribute("FruitTemplateName", v152.Name)
	v152:SetAttribute("Sprouting", false)
	v152:SetAttribute("FullyGrown", true)
	v152:SetAttribute("GrowthHealth", v159)
	v152:SetAttribute("GrowthMaxHealth", v159)
	v152:SetAttribute("RipenessBaseElapsed", p146.RipenessHealth or (p146.RipenessElapsed or 0))
	local v165 = "RipenessSessionStart"
	local v166 = p146.RipenessSaveTime
	if not v166 then
		local v167 = workspace:GetServerTimeNow()
		v166 = math.floor(v167)
	end
	v152:SetAttribute(v165, v166)
	if p146.IsGiant then
		v152:SetAttribute("IsGiant", true)
	end
	if p146.Favorited then
		v152:SetAttribute("Favorited", true)
	end
	local v168 = p144:GetAttribute("Uuid")
	if p146.Uuid then
		v152:SetAttribute("Uuid", p146.Uuid)
	elseif v168 then
		v152:SetAttribute("Uuid", v168 .. ":" .. (p146.GrowthAnchorIndex or 1))
	end
	v152:SetAttribute("SproutDuration", v160)
	v152:SetAttribute("GrowthDuration", v161)
	for _, v169 in v152:GetDescendants() do
		if v169:IsA("BasePart") and v169.Name == "FruitAnchor" then
			v169.Transparency = 1
			v169.CanCollide = false
			v169.CanQuery = false
			v169.CanTouch = false
		end
	end
	v_u_34(v152)
	v_u_15(v152, p145)
	if p146.Variant then
		local v170 = p146.Variant
		if typeof(v170) == "string" and p146.Variant ~= "None" then
			v152:SetAttribute("Variant", p146.Variant)
			v_u_18.ApplyVariantVisuals(v152, p146.Variant)
		end
	end
	if p146.Mutation then
		local v171 = p146.Mutation
		if typeof(v171) == "string" and p146.Mutation ~= "" then
			v152:SetAttribute("Mutation", p146.Mutation)
			v_u_18.RefreshMutationVisuals(v152)
		end
	end
	return v152
end
local function v_u_201(p173, p174, p175, p176, p177, p178, p179, p180, p181)
	-- upvalues: (copy) v_u_23, (copy) v_u_2, (copy) v_u_7, (copy) v_u_55
	if not p175.fruitTemplate then
		return nil
	end
	p173.Transparency = 1
	p173.CanCollide = false
	local v182 = p176.FruitTemplateName
	local v185
	if p175.fruitTemplate then
		local v184 = p175.fruitTemplate:GetChildren()
		if #v184 == 0 then
			v185 = nil
		else
			if v182 then
				for _, v185 in v184 do
					if v185.Name == v182 then
						goto l5
					end
				end
			end
			v185 = v184[1]
		end
	else
		v185 = nil
	end
	::l5::
	if not v185 then
		return nil
	end
	local v186 = v185:Clone()
	v_u_23(v186)
	local v187 = p176.HiddenNumber or 1
	local v188 = p175.FruitBaseWeight or 0.1
	local v189, v190
	if p181 >= 10 then
		v189 = v188 * v187
		v190 = v189 / v188
	else
		local v191 = p176.FruitSizeBoost or 0
		v189 = v188 * v187 * (1 + v191)
		if p176.IsGiant then
			v189 = v189 * (p175.giantScaleMultiplier or 2)
		end
		v190 = v189 / v188
	end
	local v192 = p181 >= 10
	local v193 = v186:FindFirstChild("Handle")
	if v193 then
		v193.Size = Vector3.new(0.01, 0.01, 0.01)
	end
	local v194 = v186:FindFirstChild("Handle")
	if v194 then
		v194.Size = Vector3.new(0.01, 0.01, 0.01)
	end
	v186:ScaleTo(v190)
	v_u_2:AddTag(v186, "Fruit")
	v186.Parent = p174
	v_u_7.initializeAnchorsOnModel(v186)
	if not v_u_7.positionFruitToGrowthAnchor(v186, p173, p176.GrowthAnchorIndex) then
		v186:PivotTo(p173.CFrame)
	end
	local v195 = p177 < p179
	local v196 = "FruitSpawnTime"
	local v197 = p176.FruitSpawnTime
	if not v197 then
		local v198 = workspace:GetServerTimeNow()
		v197 = math.floor(v198)
	end
	v186:SetAttribute(v196, v197)
	v186:SetAttribute("HiddenNumber", p176.HiddenNumber or 1)
	v186:SetAttribute("FruitWeight", v189)
	v186:SetAttribute("FruitScale", v190)
	v186:SetAttribute("FruitSizeBoost", v192 and 0 or (p176.FruitSizeBoost or 0))
	v186:SetAttribute("GrowthAnchorIndex", p176.GrowthAnchorIndex or 1)
	v186:SetAttribute("FruitGrowthTime", p180)
	v186:SetAttribute("FruitSproutTime", p179)
	v186:SetAttribute("FruitTemplateName", v186.Name)
	v186:SetAttribute("Sprouting", v195)
	v186:SetAttribute("GrowthHealth", p177)
	v186:SetAttribute("GrowthMaxHealth", p178)
	if p176.IsGiant then
		v186:SetAttribute("IsGiant", true)
	end
	if p176.Favorited then
		v186:SetAttribute("Favorited", true)
	end
	local v199 = p174:GetAttribute("Uuid")
	if p176.Uuid then
		v186:SetAttribute("Uuid", p176.Uuid)
	elseif v199 then
		v186:SetAttribute("Uuid", v199 .. ":" .. (p176.GrowthAnchorIndex or 1))
	end
	v186:SetAttribute("SproutDuration", p179)
	v186:SetAttribute("GrowthDuration", p180)
	if p176.Variant then
		local v200 = p176.Variant
		if typeof(v200) == "string" and p176.Variant ~= "None" then
			v186:SetAttribute("Variant", p176.Variant)
		end
	end
	if not v195 then
		v_u_55(v186, p177, p179, p180)
	end
	return v186
end
local function v_u_233(p202, p203, p204, p205)
	-- upvalues: (copy) v_u_7, (copy) v_u_142, (copy) v_u_172, (copy) v_u_201, (copy) v_u_6
	local v206 = v_u_7.findGrowthAnchors(p202)
	if #v206 ~= 0 then
		local v207 = {}
		if p204.Fruits then
			local v208 = p204.Fruits
			if typeof(v208) == "table" then
				for _, v209 in p204.Fruits do
					local v210 = v209.GrowthAnchorIndex
					if v210 and v206[v210] then
						local v211, v212, v213, v214 = v_u_142(p203, v209, p205)
						if v212 <= v211 then
							v_u_172(v206[v210], p202, p203, v209, p205)
						else
							v_u_201(v206[v210], p202, p203, v209, v211, v212, v213, v214, p205)
						end
						v207[v210] = true
					end
				end
			end
		end
		if p204.RegrowingFruits then
			local v215 = p204.RegrowingFruits
			if typeof(v215) == "table" then
				local v216 = workspace:GetServerTimeNow()
				local v217 = math.floor(v216)
				local v218 = v_u_6[p204.PlantId]
				for _, v219 in p204.RegrowingFruits do
					local v220 = typeof(v219) == "number" and v219 and v219 or v219.Index
					local v221
					if typeof(v219) == "table" then
						v221 = v219.RegrowStartTime or v217
					else
						v221 = v217
					end
					if v220 and (v206[v220] and not v207[v220]) then
						local v222 = v206[v220]
						v222.Transparency = 1
						v222.CanCollide = false
						local v223 = not v218 or v218.fruitSproutTime or (v218.sproutTime or 5)
						local v224 = v218 and (v218.fruitBaseGrowthTime or 10) or 10
						local v225 = v223 + v224
						local v226 = v217 - v221
						local v227 = Random.new((p204.Seed or 0) + v220 * 997 + v221)
						local v228 = p203.fruitGiantChance and v227:NextNumber() < p203.fruitGiantChance and true or false
						local v229 = v227:NextInteger(700, 1400) / 1000
						if v228 then
							v229 = v229 * (p203.giantScaleMultiplier or 2)
						end
						local v230 = nil
						if p203.fruitTemplate then
							local v231 = p203.fruitTemplate:GetChildren()
							if #v231 > 0 then
								v230 = v231[v227:NextInteger(1, #v231)].Name
							end
						end
						local v232 = {
							["GrowthAnchorIndex"] = v220,
							["HiddenNumber"] = v229,
							["FruitSizeBoost"] = 0,
							["IsGiant"] = v228,
							["FruitTemplateName"] = v230
						}
						if v225 <= v226 then
							v232.FullyGrown = true
							v_u_172(v222, p202, p203, v232, 10)
						else
							v_u_201(v222, p202, p203, v232, v226, v225, v223, v224, 10)
						end
						v207[v220] = true
					end
				end
			end
		end
	end
end
function v_u_18.RenderPlant(p234, p235, p236)
	-- upvalues: (copy) v_u_5, (copy) v_u_11, (copy) v_u_12, (copy) v_u_13, (copy) v_u_23, (copy) v_u_2, (copy) v_u_4, (copy) v_u_76, (copy) v_u_34, (copy) v_u_18, (copy) v_u_233, (copy) v_u_15, (copy) v_u_55
	local v237 = p234.PlantId
	local v238 = v_u_5[v237]
	if not v238 then
		warn("[PlantRenderer] No config for", v237)
		return nil
	end
	local v239 = p234.DataVersion
	local v240 = tonumber(v239) or 1
	local v241
	if v240 >= 6 then
		v241 = p235:PointToWorldSpace(v_u_11(p234.RelativePosition))
	else
		v241 = v_u_11(p234.Position or p234.RelativePosition)
	end
	local v242 = v_u_11(p234.Rotation)
	if v240 >= 6 then
		local v243 = p235.LookVector
		local v244 = -v243.X
		local v245 = -v243.Z
		local v246 = math.atan2(v244, v245)
		local v247 = v242.Y + math.deg(v246)
		v242 = Vector3.new(0, v247, 0)
	end
	local v248 = p234.PlantScale or 1
	local v249
	if p234.HiddenNumber then
		local v250 = p234.HiddenNumber
		local v251 = v238.PlantBaseWeight or 0.1
		local v252
		if v240 >= 10 then
			v252 = v251 * v250
		else
			v252 = v251 * v250 * (1 + (p234.LockedSizeBoost or 0))
			if p234.IsGiant then
				v252 = v252 * (v238.giantScaleMultiplier or 2)
			end
		end
		v249 = v252 / v251
	else
		v249 = v248
	end
	local v253 = p234.PlantTemplateName
	local v256
	if v238.template then
		local v255 = v238.template
		if typeof(v255) == "table" then
			if v253 then
				for _, v256 in v238.template do
					if v256.Name == v253 then
						goto l18
					end
				end
				goto l22
			end
			::l22::
			v256 = v238.template[1]
		else
			v256 = v238.template
		end
	else
		v256 = nil
	end
	::l18::
	if not v256 then
		warn("[PlantRenderer] No template for", v237, p234.PlantTemplateName)
		return nil
	end
	local v257 = v_u_12(v238, v248)
	local v258 = v_u_13(v238, v248)
	local v259 = p234.GrowthMaxHealth or v257 + v258
	local v260 = v257 + v258
	if v260 > 0 then
		local v261 = v259 - v260
		if math.abs(v261) > 0.01 then
			local v262 = v259 / v260
			v257 = v257 * v262
			v258 = v258 * v262
		end
	end
	local v263
	if p234.GrowthHealth == nil then
		if p234.FullyGrown then
			v263 = v259
		else
			local v264 = workspace:GetServerTimeNow()
			local v265 = math.floor(v264)
			local v266 = p234.PlantTime
			if not v266 then
				local v267 = workspace:GetServerTimeNow()
				v266 = math.floor(v267)
			end
			local v268 = v265 - v266
			v263 = math.min(v259, v268)
		end
	else
		v263 = p234.GrowthHealth
		if p234.GrowthSaveTime then
			local v269 = workspace:GetServerTimeNow()
			local v270 = v263 + (math.floor(v269) - p234.GrowthSaveTime)
			v263 = math.min(v259, v270)
		end
	end
	local v271 = p234.FullyGrown == true and true or v259 <= v263
	local v272 = v256:Clone()
	if not v271 then
		v_u_23(v272)
	end
	v272:SetAttribute("PlantType", v237)
	v272:SetAttribute("Uuid", p234.Uuid)
	v272:SetAttribute("Seed", p234.Seed)
	v272:SetAttribute("Scale", v249)
	v272:SetAttribute("OwnerUserId", p236)
	v272:SetAttribute("PlantGroundPosition", v241)
	local v273 = "PlantTime"
	local v274 = p234.PlantTime
	if not v274 then
		local v275 = workspace:GetServerTimeNow()
		v274 = math.floor(v275)
	end
	v272:SetAttribute(v273, v274)
	v272:SetAttribute("PlantScale", v249)
	v272:SetAttribute("PlantSeed", p234.Seed)
	v272:SetAttribute("LockedSizeBoost", p234.LockedSizeBoost or 0)
	v272:SetAttribute("PlantTemplateName", p234.PlantTemplateName)
	v272:SetAttribute("GrowthHealth", v263)
	v272:SetAttribute("GrowthMaxHealth", v259)
	v272:SetAttribute("SproutDuration", v257)
	v272:SetAttribute("GrowthDuration", v258)
	if p234.IsGiant then
		v272:SetAttribute("IsGiant", true)
	end
	if p234.HiddenNumber then
		v272:SetAttribute("HiddenNumber", p234.HiddenNumber)
	end
	if p234.Favorited then
		v272:SetAttribute("Favorited", true)
	end
	v_u_2:AddTag(v272, "Plant")
	v272:ScaleTo(v249)
	local v276 = nil
	for _, v277 in v272:GetChildren() do
		if v277:IsA("BasePart") and v277.Name == "1" then
			v276 = v277
			break
		end
	end
	local v278 = v276 or (v272.PrimaryPart or v272:FindFirstChildWhichIsA("BasePart", true))
	if v278 then
		v272.PrimaryPart = v278
	end
	local v279 = v_u_4:FindFirstChild("ClientPlants")
	if not (v279 and v279:IsA("Folder")) then
		v279 = Instance.new("Folder")
		v279.Name = "ClientPlants"
		v279.Parent = v_u_4
	end
	v272.Parent = v279
	v_u_76(v272, v241, v242, v278)
	if v271 then
		v272:SetAttribute("FullyGrown", true)
		v272:SetAttribute("Sprouting", false)
		v_u_34(v272)
		if p234.Variant then
			local v280 = p234.Variant
			if typeof(v280) == "string" and p234.Variant ~= "None" then
				v272:SetAttribute("Variant", p234.Variant)
				v_u_18.ApplyVariantVisuals(v272, p234.Variant)
			end
		end
		if p234.Mutation then
			local v281 = p234.Mutation
			if typeof(v281) == "string" and p234.Mutation ~= "" then
				v272:SetAttribute("Mutation", p234.Mutation)
				v_u_18.RefreshMutationVisuals(v272)
			end
		end
		if v238.fruitTemplate then
			v_u_233(v272, v238, p234, v240)
			return v272
		end
		if v238.isSingleHarvest then
			v272:SetAttribute("HarvestablePlant", true)
			if p234.HiddenNumber then
				local v282 = v238.PlantBaseWeight or 0.1
				local v283
				if v240 >= 10 then
					v283 = v282 * p234.HiddenNumber
				else
					v283 = v282 * p234.HiddenNumber * (1 + (p234.LockedSizeBoost or 0))
					if p234.IsGiant then
						v283 = v283 * (v238.giantScaleMultiplier or 2)
					end
				end
				v272:SetAttribute("PlantWeight", v283)
			end
			v272:SetAttribute("RipenessBaseElapsed", p234.RipenessHealth or (p234.PlantRipenessElapsed or 0))
			local v284 = "RipenessSessionStart"
			local v285 = p234.RipenessSaveTime
			if not v285 then
				local v286 = workspace:GetServerTimeNow()
				v285 = math.floor(v286)
			end
			v272:SetAttribute(v284, v285)
			v_u_15(v272, v238)
			return v272
		end
	else
		v272:SetAttribute("FullyGrown", false)
		v272:SetAttribute("Sprouting", v263 < v257)
		if p234.Variant then
			local v287 = p234.Variant
			if typeof(v287) == "string" and p234.Variant ~= "None" then
				v272:SetAttribute("Variant", p234.Variant)
			end
		end
		if p234.Mutation then
			local v288 = p234.Mutation
			if typeof(v288) == "string" and p234.Mutation ~= "" then
				v272:SetAttribute("Mutation", p234.Mutation)
			end
		end
		v_u_55(v272, v263, v257, v258)
	end
	return v272
end
function v_u_18.DestroyPlant(p289)
	-- upvalues: (copy) v_u_2
	if p289 then
		if not v_u_2:HasTag(p289, "TrowelHeld") then
			if p289.Parent then
				p289:Destroy()
			end
		end
	else
		return
	end
end
function v_u_18.CreateDirtEffect(p290)
	-- upvalues: (copy) v_u_19, (copy) v_u_4, (copy) v_u_3
	local v291 = 1.5 * (1 + v_u_19:NextNumber() * 0.2)
	local v292 = v291 * 0.8
	local v293 = Instance.new("Part")
	v293.Name = "PlantDirt"
	v293.Anchored = true
	v293.CanCollide = false
	v293.CanQuery = false
	v293.CanTouch = false
	v293.Material = Enum.Material.Ground
	v293.Color = Color3.fromRGB(101, 67, 33)
	v293.Size = Vector3.new(0.15, v292, v292)
	v293.CFrame = CFrame.new(p290 + Vector3.new(0, 0.08, 0)) * CFrame.Angles(0, 0, 1.5707963267948966)
	v293.Parent = v_u_4
	v_u_3:Create(v293, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
		["Size"] = Vector3.new(0.18, v291, v291)
	}):Play()
	return v293
end
function v_u_18.RenderFruitGrowing(p294, p295, p296, p297, p298, p299, p300, p301, p302)
	-- upvalues: (copy) v_u_201
	return v_u_201(p294, p295, p296, p297, p298, p299, p300, p301, p302)
end
return v_u_18