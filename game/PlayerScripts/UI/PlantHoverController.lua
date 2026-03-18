local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v3 = game:GetService("ProximityPromptService")
local v_u_4 = game:GetService("UserInputService")
local v5 = game:GetService("ReplicatedStorage")
local v_u_6 = v1.LocalPlayer
local v_u_7 = workspace.CurrentCamera
local v8 = v_u_6:WaitForChild("PlayerGui")
local v_u_9 = require(v5:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("MutationDataDefinitions"))
local v_u_10 = require(v5:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("VariantDataDefinitions"))
local v_u_11 = require(v5:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("RarityDefinitions"))
local v_u_12 = require(v5:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDataDefinitions"))
local v13 = v8:WaitForChild("PlantTooltip")
local v_u_14 = v13:WaitForChild("TooltipFrame")
local v_u_15 = v_u_14:WaitForChild("PlantName")
local v_u_16 = v_u_14:WaitForChild("GrowthPercent")
local v_u_17 = v_u_14:WaitForChild("GrowthVariant")
local v_u_18 = v_u_14:Clone()
v_u_18.Name = "HoverFrame"
v_u_18.Parent = v13
v_u_18.Visible = false
local v_u_19 = v_u_18:WaitForChild("PlantName")
local v_u_20 = v_u_18:WaitForChild("GrowthPercent")
local v_u_21 = v_u_18:WaitForChild("GrowthVariant")
v13.AutoLocalize = false
v13.ResetOnSpawn = false
v13.DisplayOrder = -1
v_u_14.Visible = false
v_u_15.RichText = true
v_u_15.TextXAlignment = Enum.TextXAlignment.Center
v_u_16.RichText = true
v_u_16.TextXAlignment = Enum.TextXAlignment.Center
v_u_17.RichText = true
v_u_17.TextXAlignment = Enum.TextXAlignment.Center
v_u_19.RichText = true
v_u_19.TextXAlignment = Enum.TextXAlignment.Center
v_u_20.RichText = true
v_u_20.TextXAlignment = Enum.TextXAlignment.Center
v_u_21.RichText = true
v_u_21.TextXAlignment = Enum.TextXAlignment.Center
local v_u_22 = {
	["Unripe"] = "#78B450",
	["Ripened"] = "#FFC832",
	["Lush"] = "#C85023"
}
local v_u_23 = nil
local v_u_24 = nil
local v_u_25 = nil
local v_u_26 = nil
local v_u_27 = false
local v_u_28 = RaycastParams.new()
v_u_28.FilterType = Enum.RaycastFilterType.Exclude
local function v_u_32(p29)
	if not p29 then
		return nil, nil
	end
	local v30 = nil
	local v31 = nil
	while true do
		if not p29 or p29 == workspace then
			p29 = v31
			break
		end
		if not v30 and (p29:GetAttribute("Variant") or (p29:GetAttribute("Mutation") or (p29:GetAttribute("RipenessStage") or p29:GetAttribute("FullyGrown")))) then
			v30 = p29
		end
		if p29:GetAttribute("PlantType") then
			if not v30 then
				return p29, p29
			end
			break
		end
		p29 = p29.Parent
	end
	return p29, v30
end
local function v_u_49(p33, p34, p35)
	-- upvalues: (copy) v_u_12, (copy) v_u_11
	local v36 = p33 or "Unknown"
	local v37 = p34:GetAttribute("Rarity")
	if not v37 or v37 == "" then
		v37 = p35:GetAttribute("Rarity")
	end
	if (not v37 or v37 == "") and (p33 and (v_u_12[p33] and v_u_12[p33].Rarity)) then
		v37 = v_u_12[p33].Rarity
	end
	local v38
	if v37 then
		local v39 = v_u_11[v37]
		if v39 then
			if v39.Color then
				return string.format("<font color=\'%s\'>%s</font>", v39.Color, v36)
			end
			if v39.gradient then
				local v40 = v39.gradient
				if type(v40) == "table" and #v39.gradient > 0 then
					v38 = ""
					local v41 = #v36
					local v42 = #v39.gradient
					if v41 > 0 and v42 > 0 then
						for v43 = 1, v41 do
							local v44 = v36:sub(v43, v43)
							local v45 = (v43 - 1) / v41 * v42
							local v46 = math.floor(v45) + 1
							local v47 = math.clamp(v46, 1, v42)
							local v48 = v39.gradient[v47]
							if v48 then
								v38 = v38 .. string.format("<font color=\'%s\'>%s</font>", v48, v44)
							else
								v38 = v38 .. v44
							end
						end
					else
						v38 = v36
					end
				else
					v38 = v36
				end
			else
				v38 = v36
			end
		else
			v38 = v36
		end
	else
		v38 = v36
	end
	return v38
end
local function v_u_74(p50, p51)
	-- upvalues: (copy) v_u_22, (copy) v_u_10, (copy) v_u_9
	local v52 = ""
	local v53 = p50:GetAttribute("RipenessStage")
	if not v53 or v53 == "" then
		v53 = p51:GetAttribute("RipenessStage")
	end
	if v53 and v53 ~= "" then
		local v54 = v53 == "Ripe" and "Ripened" or v53
		local v55 = v_u_22[v54] or "#FFFFFF"
		local v56 = p50:GetAttribute("RipenessMultiplier") or p51:GetAttribute("RipenessMultiplier")
		if v56 then
			local v57 = v56 * 10
			local v58 = math.floor(v57) / 10
			v52 = string.format("<font color=\'%s\'>%s (%.1fx)</font>", v55, v54, v58)
		else
			v52 = string.format("<font color=\'%s\'>%s</font>", v55, v54)
		end
	end
	local v59 = p50:GetAttribute("Variant")
	if v59 and v59 ~= "" then
		local v60 = v_u_10[v59]
		if v60 then
			if v60.priceMultiplier and v60.color then
				v59 = string.format("<font color=\'%s\'>%s (%.1fx)</font>", v60.color, v59, v60.priceMultiplier)
			elseif v60.color then
				v59 = string.format("<font color=\'%s\'>%s</font>", v60.color, v59)
			elseif v60.priceMultiplier then
				v59 = string.format("%s (%.1fx)", v59, v60.priceMultiplier)
			end
		end
		if v52 ~= "" then
			v59 = v52 .. " <font color=\'#FFFFFF\'>+</font> " .. v59 or v59
		end
	else
		v59 = v52
	end
	local v61 = p50:GetAttribute("Mutation")
	local v62
	if v61 and v61 ~= "" then
		local v63 = {}
		for v64 in string.gmatch(v61, "([^,]+)") do
			local v65 = v64:match("^%s*(.-)%s*$")
			local v66 = v_u_9[v65]
			if v66 then
				if v66.priceMultiplier and v66.color then
					local v67 = string.format
					local v68 = v66.color
					local v69 = v66.priceMultiplier
					table.insert(v63, v67("<font color=\'%s\'>%s (%.1fx)</font>", v68, v65, v69))
				elseif v66.color then
					local v70 = string.format
					local v71 = v66.color
					table.insert(v63, v70("<font color=\'%s\'>%s</font>", v71, v65))
				elseif v66.priceMultiplier then
					local v72 = string.format
					local v73 = v66.priceMultiplier
					table.insert(v63, v72("%s (%.1fx)", v65, v73))
				else
					table.insert(v63, v65)
				end
			else
				table.insert(v63, v65)
			end
		end
		v62 = table.concat(v63, " <font color=\'#FFFFFF\'>+</font> ")
		if v59 ~= "" then
			v62 = v59 .. " <font color=\'#FFFFFF\'>+</font> " .. v62 or v62
		end
	else
		v62 = v59
	end
	return v62
end
local function v_u_81(p75, p76, p77, p78, p79)
	-- upvalues: (copy) v_u_49, (copy) v_u_74
	if p78 and p79 then
		p75.Text = v_u_49(p78:GetAttribute("PlantType"), p79, p78)
		p75.Visible = true
		p76.Visible = false
		local v80 = v_u_74(p79, p78)
		if v80 == "" then
			p77.Visible = false
		else
			p77.Text = v80
			p77.Visible = true
		end
	else
		return
	end
end
local function v_u_120()
	-- upvalues: (copy) v_u_6, (copy) v_u_18, (ref) v_u_7, (copy) v_u_4, (copy) v_u_28, (copy) v_u_32, (ref) v_u_23, (copy) v_u_81, (copy) v_u_19, (copy) v_u_20, (copy) v_u_21, (copy) v_u_49, (copy) v_u_10
	if v_u_6.Character then
		if workspace.CurrentCamera then
			v_u_7 = workspace.CurrentCamera
		end
		local v82 = v_u_4:GetMouseLocation()
		local v83 = v_u_7:ViewportPointToRay(v82.X, v82.Y)
		v_u_28.FilterDescendantsInstances = { v_u_6.Character }
		local v84 = workspace:Raycast(v83.Origin, v83.Direction * 100, v_u_28)
		local v85, v86
		if v84 and v84.Instance then
			v85, v86 = v_u_32(v84.Instance)
		else
			v86 = nil
			v85 = nil
		end
		if v86 and (v_u_23 and (v86 == v_u_23 or v86:IsDescendantOf(v_u_23))) then
			v_u_18.Visible = false
			return
		elseif v85 and v86 then
			if v86:GetAttribute("IsHarvested") then
				v_u_18.Visible = false
				return
			else
				local v87 = v86 ~= v85
				local v88 = v86:GetAttribute("FullyGrown")
				local v89 = v85:GetAttribute("FullyGrown")
				if v87 and not v88 then
					v_u_18.Visible = false
				else
					local v90 = v85:GetAttribute("PlantType")
					if v87 and v88 or not v87 and v89 then
						v_u_81(v_u_19, v_u_20, v_u_21, v85, v86)
					else
						v_u_19.Text = v_u_49(v90, v86, v85)
						v_u_19.Visible = true
						local v91 = ""
						local v92 = false
						if v86:GetAttribute("Sprouting") or v85:GetAttribute("Sprouting") then
							v92 = true
							v91 = "0%"
						else
							local v93 = v86:GetAttribute("GrowthHealth") or v85:GetAttribute("GrowthHealth")
							local v94 = v86:GetAttribute("GrowthMaxHealth") or v85:GetAttribute("GrowthMaxHealth")
							if v93 and (v94 and v94 > 0) then
								local v95 = v93 / v94
								local v96 = math.clamp(v95, 0, 1) * 100
								local v97 = math.floor(v96)
								local v98 = v86:GetAttribute("GrowthSpeed") or v85:GetAttribute("GrowthSpeed")
								local v99
								if v98 and v98 > 0 then
									local v100 = v94 - v93
									local v101 = math.ceil(v100)
									local v102 = math.max(0, v101)
									local v103 = v98 > 1
									local v104 = v102 / 3600
									local v105 = math.floor(v104)
									local v106 = v102 % 3600 / 60
									local v107 = math.floor(v106)
									local v108 = v102 % 60
									local v109 = v103 and "*" or ""
									if v105 > 0 then
										v99 = string.format(" (%d:%02d:%02d)%s", v105, v107, v108, v109)
									elseif v107 > 0 then
										v99 = string.format(" (%d:%02d)%s", v107, v108, v109)
									else
										v99 = string.format(" (%d)%s", v108, v109)
									end
								else
									v99 = ""
								end
								v91 = string.format("%d%%%s", math.min(v97, 99), v99)
								v92 = true
							end
						end
						local v110 = v86:GetAttribute("Variant") or v85:GetAttribute("Variant")
						if v110 and v110 ~= "" then
							local v111 = v_u_10[v110]
							if v111 then
								if v111.priceMultiplier and v111.color then
									v110 = string.format("<font color=\'%s\'>%s (%.1fx)</font>", v111.color, v110, v111.priceMultiplier)
								elseif v111.color then
									v110 = string.format("<font color=\'%s\'>%s</font>", v111.color, v110)
								end
							end
						else
							v110 = ""
						end
						if v92 then
							v_u_20.Text = v91
							v_u_20.Visible = true
							if v110 == "" then
								v_u_21.Visible = false
							else
								v_u_21.Text = v110
								v_u_21.Visible = true
							end
						else
							v_u_20.Visible = false
							if v110 == "" then
								v_u_21.Visible = false
							else
								v_u_21.Text = v110
								v_u_21.Visible = true
							end
						end
					end
					local v112 = v_u_7.ViewportSize
					local v113 = v_u_18.AbsoluteSize
					local v114 = v82.X + 15
					local v115 = v82.Y + 15
					if v114 + v113.X > v112.X then
						v114 = v82.X - v113.X - 15
					end
					if v115 + v113.Y > v112.Y then
						v115 = v82.Y - v113.Y - 15
					end
					local v116 = v112.X - v113.X
					local v117 = math.clamp(v114, 0, v116)
					local v118 = v112.Y - v113.Y
					local v119 = math.clamp(v115, 0, v118)
					v_u_18.Position = UDim2.fromOffset(v117, v119)
					v_u_18.Visible = true
				end
			end
		else
			v_u_18.Visible = false
			return
		end
	else
		v_u_18.Visible = false
		return
	end
end
local function v_u_127()
	-- upvalues: (ref) v_u_27, (ref) v_u_24, (ref) v_u_23, (copy) v_u_14, (copy) v_u_81, (copy) v_u_15, (copy) v_u_16, (copy) v_u_17, (ref) v_u_25, (ref) v_u_26, (ref) v_u_7, (copy) v_u_4
	if v_u_27 and (v_u_24 and v_u_23) then
		v_u_81(v_u_15, v_u_16, v_u_17, v_u_25, v_u_26)
		local v121 = v_u_24.Parent
		if v121 and (v121:IsA("BasePart") and v_u_7) then
			local v122, v123 = v_u_7:WorldToViewportPoint(v121.Position)
			if v123 then
				local v124 = v_u_4.GamepadEnabled and 65 or 0
				local v125 = v122.X - v_u_14.AbsoluteSize.X / 2
				local v126 = v122.Y + v124
				v_u_14.Position = UDim2.fromOffset(v125, v126)
				v_u_14.Visible = true
			else
				v_u_14.Visible = false
			end
		else
			v_u_14.Visible = false
			return
		end
	else
		v_u_14.Visible = false
		return
	end
end
v2.RenderStepped:Connect(function()
	-- upvalues: (copy) v_u_120, (copy) v_u_127
	v_u_120()
	v_u_127()
end)
v3.PromptShown:Connect(function(p128, _)
	-- upvalues: (copy) v_u_32, (ref) v_u_23, (ref) v_u_24, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27
	if p128:GetAttribute("DontShow") or p128.Style == Enum.ProximityPromptStyle.Default then
		return
	else
		local v129 = p128:FindFirstAncestorWhichIsA("Model")
		if v129 then
			local v130, v131 = v_u_32(v129)
			if v130 then
				v_u_23 = v129
				v_u_24 = p128
				v_u_25 = v130
				v_u_26 = v131
				v_u_27 = true
			end
		else
			return
		end
	end
end)
v3.PromptHidden:Connect(function(p132)
	-- upvalues: (ref) v_u_24, (ref) v_u_23, (ref) v_u_25, (ref) v_u_26, (ref) v_u_27, (copy) v_u_14
	if p132 == v_u_24 then
		v_u_24 = nil
		v_u_23 = nil
		v_u_25 = nil
		v_u_26 = nil
		v_u_27 = false
		v_u_14.Visible = false
	end
end)