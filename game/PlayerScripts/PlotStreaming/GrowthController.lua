local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("TweenService")
local v3 = game:GetService("RunService")
game:GetService("CollectionService")
local v_u_4 = require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDefinitions"))
require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDataDefinitions"))
require(v1:WaitForChild("Plants"):WaitForChild("AnchorService"))
local v_u_5 = require(script.Parent:WaitForChild("PlantRenderer"))
local v_u_6 = require(v1:WaitForChild("Plants"):WaitForChild("HarvestPromptUtil"))
local v7 = v1:WaitForChild("RemoteEvents"):WaitForChild("GrowthUpdate")
local v8 = {}
local v_u_9 = TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local v_u_10 = {}
local function v_u_17(p11)
	local v12 = {}
	for _, v13 in p11:GetDescendants() do
		if v13:IsA("BasePart") then
			local v14 = v13.Name
			local v15 = tonumber(v14)
			if v15 then
				if not v12[v15] then
					v12[v15] = {}
				end
				local v16 = v12[v15]
				table.insert(v16, v13)
			end
		end
	end
	return v12
end
local function v_u_21(p18)
	for _, v19 in p18:GetDescendants() do
		if v19:IsA("Decal") or v19:IsA("Texture") then
			v19.Transparency = v19:GetAttribute("OriginalTransparency") or 0
			v19:SetAttribute("OriginalTransparency", nil)
		elseif v19:IsA("SurfaceGui") or v19:IsA("BillboardGui") then
			local v20 = v19:GetAttribute("WasEnabled")
			if v20 == nil then
				v19.Enabled = true
			else
				v19.Enabled = v20
				v19:SetAttribute("WasEnabled", nil)
			end
		end
	end
end
local function v_u_25(p22)
	-- upvalues: (copy) v_u_21, (copy) v_u_2, (copy) v_u_9
	for _, v23 in p22 do
		v23.CanCollide = v23:GetAttribute("OriginalCanCollide") ~= false
		v23.CanQuery = v23:GetAttribute("OriginalCanQuery") ~= false
		v23.CanTouch = v23:GetAttribute("OriginalCanTouch") ~= false
		local v24 = v23.Size
		v23.Size = v24 * 0.01
		v23.Transparency = 0
		v_u_21(v23)
		v_u_2:Create(v23, v_u_9, {
			["Size"] = v24
		}):Play()
	end
end
local function v_u_33(p26, p27)
	-- upvalues: (copy) v_u_21
	local v28 = {}
	for _, v29 in p27 do
		for _, v30 in v29 do
			v28[v30] = true
		end
	end
	for _, v31 in p26:GetDescendants() do
		if v31:IsA("BasePart") and not v28[v31] then
			local v32 = v31:GetAttribute("OriginalTransparency")
			if v32 == nil then
				::l12::
				if v31.Name ~= "PlantAnchor" and (v31.Name ~= "FruitAnchor" and (v31.Name ~= "GrowthAnchor" and (v31.Name ~= "MutationBoundingPart" and (v31.Name ~= "VariantBoundingPart" and (v31.Name ~= "Handle" and v31.Name ~= "Truss"))))) then
					v31.Transparency = 0
					v31.CanCollide = v31:GetAttribute("OriginalCanCollide") ~= false
					v31.CanQuery = v31:GetAttribute("OriginalCanQuery") ~= false
					v31.CanTouch = v31:GetAttribute("OriginalCanTouch") ~= false
					v_u_21(v31)
				end
			else
				v31:SetAttribute("OriginalTransparency", nil)
				if v32 < 1 then
					goto l12
				end
			end
		end
	end
end
local function v_u_36(p_u_34)
	-- upvalues: (copy) v_u_2
	if p_u_34 and p_u_34.Parent then
		local v35 = v_u_2:Create(p_u_34, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["Transparency"] = 1
		})
		v35:Play()
		v35.Completed:Connect(function()
			-- upvalues: (copy) p_u_34
			p_u_34:Destroy()
		end)
	end
end
local function v_u_43(p37)
	-- upvalues: (copy) v_u_33, (copy) v_u_36, (copy) v_u_5, (copy) v_u_6
	local v38 = p37.Instance
	if v38.Parent then
		v38:SetAttribute("FullyGrown", true)
		v38:SetAttribute("Sprouting", false)
		v38:SetAttribute("GrowthHealth", p37.MaxHealth)
		v38:SetAttribute("GrowthProgress", 1)
		v_u_33(v38, p37.NumberedParts)
		if p37.DirtEffect then
			v_u_36(p37.DirtEffect)
			p37.DirtEffect = nil
		end
		local v39 = v38:GetAttribute("Variant")
		if v39 and (typeof(v39) == "string" and v39 ~= "None") then
			v_u_5.ApplyVariantVisuals(v38, v39)
		end
		local v40 = v38:GetAttribute("Mutation")
		if v40 and (typeof(v40) == "string" and v40 ~= "") then
			v_u_5.RefreshMutationVisuals(v38)
		end
		local v41 = p37.Config
		if v41.isSingleHarvest and not v41.fruitTemplate then
			v38:SetAttribute("HarvestablePlant", true)
			v38:SetAttribute("RipenessBaseElapsed", 0)
			local v42 = workspace:GetServerTimeNow()
			v38:SetAttribute("RipenessSessionStart", (math.floor(v42)))
			v_u_6.Create(v38, v41)
		end
	end
end
local function v_u_49(p44)
	-- upvalues: (copy) v_u_33, (copy) v_u_6, (copy) v_u_5
	local v45 = p44.Instance
	if v45.Parent then
		v45:SetAttribute("FullyGrown", true)
		v45:SetAttribute("Sprouting", false)
		v45:SetAttribute("GrowthHealth", p44.MaxHealth)
		v45:SetAttribute("GrowthProgress", 1)
		v45:SetAttribute("RipenessBaseElapsed", 0)
		local v46 = workspace:GetServerTimeNow()
		v45:SetAttribute("RipenessSessionStart", (math.floor(v46)))
		v_u_33(v45, p44.NumberedParts)
		for _, v47 in v45:GetDescendants() do
			if v47:IsA("BasePart") and v47.Name == "FruitAnchor" then
				v47.Transparency = 1
				v47.CanCollide = false
				v47.CanQuery = false
				v47.CanTouch = false
			end
		end
		v_u_6.Create(v45, p44.Config)
		local v48 = v45:GetAttribute("Variant")
		if v48 then
			v_u_5.ApplyVariantVisuals(v45, v48)
		end
	end
end
local function v_u_63(p50, p51)
	-- upvalues: (copy) v_u_36, (copy) v_u_25
	local v52 = p50.Instance
	local v53 = p51 * p50.SpeedMultiplier
	local v54 = p50.MaxHealth
	local v55 = p50.Health + v53
	p50.Health = math.min(v54, v55)
	v52:SetAttribute("GrowthHealth", p50.Health)
	if p50.IsSprouting and p50.Health >= p50.SproutDuration then
		p50.IsSprouting = false
		v52:SetAttribute("Sprouting", false)
		v52:SetAttribute("GrowthProgress", 0)
		if p50.DirtEffect then
			v_u_36(p50.DirtEffect)
			p50.DirtEffect = nil
		end
	end
	if not p50.IsSprouting and p50.MaxLevel > 0 then
		local v56
		if p50.MaxLevel == 0 or p50.IsSprouting then
			v56 = 0
		else
			local v57 = p50.Health - p50.SproutDuration
			if v57 <= 0 then
				v56 = 0
			elseif p50.GrowthDuration <= 0 then
				v56 = p50.MaxLevel
			else
				local v58 = v57 / p50.GrowthDuration
				local v59 = p50.MaxLevel
				local v60 = v58 * p50.MaxLevel
				local v61 = math.floor(v60) + 1
				v56 = math.min(v59, v61)
			end
		end
		if p50.LastRevealedLevel < v56 then
			for v62 = p50.LastRevealedLevel + 1, v56 do
				if p50.NumberedParts[v62] then
					v_u_25(p50.NumberedParts[v62])
				end
			end
			p50.LastRevealedLevel = v56
			v52:SetAttribute("GrowthProgress", v56 / p50.MaxLevel)
		end
	end
	return p50.Health >= p50.MaxHealth
end
function v8.Register(p64, p65)
	-- upvalues: (copy) v_u_10, (copy) v_u_17, (copy) v_u_4, (copy) v_u_49, (copy) v_u_43, (copy) v_u_5
	local v66 = p64:GetAttribute("Uuid")
	if v66 then
		local v67 = v_u_10[v66]
		if v67 then
			if v67.Instance and v67.Instance.Parent then
				return
			end
			v_u_10[v66] = nil
		end
		local v68 = v_u_17(p64)
		local v69 = 0
		for v70 in v68 do
			if v69 < v70 then
				v69 = v70
			end
		end
		local v71 = p65.SproutDuration or (p64:GetAttribute("SproutDuration") or 0)
		local v72 = p65.GrowthDuration or (p64:GetAttribute("GrowthDuration") or 0)
		local v73 = v71 + v72
		local v74 = p65.Health or (p64:GetAttribute("GrowthHealth") or 0)
		local v75 = v74 < v71
		local v76
		if v75 or (v69 <= 0 or v72 <= 0) then
			v76 = 0
		else
			local v77 = (v74 - v71) / v72 * v69
			local v78 = math.floor(v77) + 1
			v76 = math.min(v69, v78)
		end
		for v79, v80 in v68 do
			if v76 < v79 then
				for _, v81 in v80 do
					if v81:GetAttribute("OriginalCanQuery") == nil then
						v81:SetAttribute("OriginalCanQuery", v81.CanQuery)
					end
					if v81:GetAttribute("OriginalCanTouch") == nil then
						v81:SetAttribute("OriginalCanTouch", v81.CanTouch)
					end
					v81.CanQuery = false
					v81.CanTouch = false
				end
			end
		end
		local v82 = p64:GetAttribute("GrowthSpeed") or 1
		local v83 = {
			["Instance"] = p64,
			["Uuid"] = v66,
			["EntryType"] = p65.EntryType or "Plant",
			["PlantId"] = p65.PlantId or (p64:GetAttribute("PlantType") or ""),
			["Config"] = p65.Config or v_u_4[p64:GetAttribute("PlantType")],
			["Health"] = v74,
			["MaxHealth"] = v73,
			["SproutDuration"] = v71,
			["GrowthDuration"] = v72,
			["SpeedMultiplier"] = v82,
			["NumberedParts"] = v68,
			["MaxLevel"] = v69,
			["LastRevealedLevel"] = v76,
			["IsSprouting"] = v75,
			["DirtEffect"] = p65.DirtEffect,
			["ParentPlant"] = p65.ParentPlant,
			["GrowthAnchorIndex"] = p65.GrowthAnchorIndex,
			["OwnerId"] = p65.OwnerId
		}
		if v73 <= v74 then
			if v83.EntryType == "Fruit" then
				v_u_49(v83)
			else
				v_u_43(v83)
			end
		else
			v_u_10[v66] = v83
			local v84 = v83.EntryType == "Fruit" and p64:GetAttribute("Variant")
			if v84 then
				v_u_5.ApplyVariantVisuals(p64, v84)
			end
			p64:SetAttribute("GrowthSpeed", v82)
			return
		end
	else
		return
	end
end
function v8.Unregister(p85)
	-- upvalues: (copy) v_u_10
	local v86 = p85:GetAttribute("Uuid")
	if v86 then
		v_u_10[v86] = nil
	end
end
function v8.IsGrowing(p87)
	-- upvalues: (copy) v_u_10
	local v88 = p87:GetAttribute("Uuid")
	local v89
	if v88 == nil then
		v89 = false
	else
		v89 = v_u_10[v88] ~= nil
	end
	return v89
end
v3.Heartbeat:Connect(function(p90)
	-- upvalues: (copy) v_u_10, (copy) v_u_63, (copy) v_u_49, (copy) v_u_43
	local v91 = {}
	for v92, v93 in v_u_10 do
		if v93.Instance.Parent then
			if v_u_63(v93, p90) then
				table.insert(v91, v93)
			end
		else
			v_u_10[v92] = nil
		end
	end
	for _, v94 in v91 do
		v_u_10[v94.Uuid] = nil
		if v94.EntryType == "Fruit" then
			v_u_49(v94)
		else
			v_u_43(v94)
		end
	end
end)
v7.OnClientEvent:Connect(function(_, p95)
	-- upvalues: (copy) v_u_10
	if typeof(p95) == "table" then
		for _, v96 in p95 do
			local v97 = v_u_10[v96.Uuid]
			if v97 then
				if v96.MaxHealth then
					v97.MaxHealth = v96.MaxHealth
				end
				local v98 = v96.Health
				local v99 = v97.MaxHealth
				v97.Health = math.min(v98, v99)
				v97.SpeedMultiplier = v96.SpeedMultiplier or v97.SpeedMultiplier
				if v97.Instance and v97.Instance.Parent then
					v97.Instance:SetAttribute("GrowthSpeed", v97.SpeedMultiplier)
				end
			end
		end
	end
end)
print("[GrowthController] Initialized")
return v8