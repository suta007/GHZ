local v_u_40 = {
	["findPlantAnchor"] = function(p1)
		if not p1 then
			return nil
		end
		local v2 = p1:FindFirstChild("PlantAnchor")
		if v2 and v2:IsA("BasePart") then
			return v2
		end
		for _, v3 in p1:GetDescendants() do
			if v3.Name == "PlantAnchor" and v3:IsA("BasePart") then
				return v3
			end
		end
		return nil
	end,
	["findFruitAnchor"] = function(p4)
		if not p4 then
			return nil
		end
		local v5 = p4:FindFirstChild("FruitAnchor")
		if v5 and v5:IsA("BasePart") then
			return v5
		end
		for _, v6 in p4:GetDescendants() do
			if v6.Name == "FruitAnchor" and v6:IsA("BasePart") then
				return v6
			end
		end
		return nil
	end,
	["findGrowthAnchors"] = function(p7)
		-- upvalues: (copy) v_u_40
		if not p7 then
			return {}
		end
		local v8 = {}
		for _, v9 in p7:GetDescendants() do
			if v9.Name == "GrowthAnchor" and v9:IsA("BasePart") then
				table.insert(v8, v9)
			end
		end
		if #v8 > 1 then
			local v_u_10 = p7:GetPivot().Position
			local v11 = v_u_40.findPlantAnchor(p7)
			if v11 then
				v_u_10 = v11.Position
			end
			table.sort(v8, function(p12, p13)
				-- upvalues: (ref) v_u_10
				return (p12.Position - v_u_10).Magnitude < (p13.Position - v_u_10).Magnitude
			end)
		end
		return v8
	end,
	["setupAnchorPart"] = function(p14)
		if p14 then
			p14.Transparency = 1
			p14.CanCollide = false
			p14.CanQuery = false
			p14.CanTouch = false
			p14.Massless = true
			p14.Anchored = true
			p14.Locked = true
		end
	end,
	["positionPlantWithAnchor"] = function(p15, p16, p17)
		-- upvalues: (copy) v_u_40
		local v18 = v_u_40.findPlantAnchor(p15)
		if not v18 then
			return false
		end
		local v19 = v18.CFrame
		local v20 = p15:GetPivot():ToObjectSpace(v19):Inverse()
		local v21 = p17 or 0
		p15:PivotTo(CFrame.new(p16) * CFrame.Angles(0, math.rad(v21), 0) * v20)
		p15:SetAttribute("UsedPlantAnchor", true)
		p15:SetAttribute("AppliedRotationY", v21)
		return true
	end,
	["positionFruitWithAnchor"] = function(p22, p23)
		-- upvalues: (copy) v_u_40
		local v24 = v_u_40.findFruitAnchor(p22)
		if not v24 then
			return false
		end
		local v25 = v24.CFrame
		p22:PivotTo(p23 * p22:GetPivot():ToObjectSpace(v25):Inverse())
		p22:SetAttribute("UsedFruitAnchor", true)
		return true
	end,
	["positionFruitToGrowthAnchor"] = function(p26, p27, p28)
		-- upvalues: (copy) v_u_40
		local v29 = v_u_40.findFruitAnchor(p26)
		if not v29 then
			return false
		end
		local v30 = p26:GetPivot():ToObjectSpace(v29.CFrame):Inverse()
		p26:PivotTo(p27.CFrame * v30)
		p26:SetAttribute("UsedFruitAnchor", true)
		if p28 then
			p26:SetAttribute("GrowthAnchorIndex", p28)
		end
		return true
	end,
	["initializeAnchorsOnModel"] = function(p31)
		-- upvalues: (copy) v_u_40
		if p31 then
			local v32 = v_u_40.findPlantAnchor(p31)
			if v32 then
				v_u_40.setupAnchorPart(v32)
			end
			local v33 = v_u_40.findFruitAnchor(p31)
			if v33 then
				v_u_40.setupAnchorPart(v33)
			end
			for _, v34 in v_u_40.findGrowthAnchors(p31) do
				v_u_40.setupAnchorPart(v34)
			end
			for _, v35 in p31:GetChildren() do
				if v35:IsA("Model") then
					local v36 = v_u_40.findFruitAnchor(v35)
					if v36 then
						v_u_40.setupAnchorPart(v36)
					end
				end
			end
		end
	end,
	["hasPlantAnchor"] = function(p37)
		-- upvalues: (copy) v_u_40
		return v_u_40.findPlantAnchor(p37) ~= nil
	end,
	["hasFruitAnchor"] = function(p38)
		-- upvalues: (copy) v_u_40
		return v_u_40.findFruitAnchor(p38) ~= nil
	end,
	["hasGrowthAnchors"] = function(p39)
		-- upvalues: (copy) v_u_40
		return #v_u_40.findGrowthAnchors(p39) > 0
	end
}
return v_u_40