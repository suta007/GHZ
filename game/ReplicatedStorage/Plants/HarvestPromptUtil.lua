local v_u_1 = game:GetService("CollectionService")
local v2 = {}
local function v_u_11(p3)
	local v4, v5 = p3:GetBoundingBox()
	local v6 = Instance.new("Part")
	v6.Name = "HarvestBoundingPart"
	v6.Size = Vector3.new(0.05, 0.05, 0.05)
	local v7 = v5.Y / 2
	v6.CFrame = v4 + Vector3.new(0, v7, 0)
	v6.Transparency = 1
	v6.CanCollide = false
	v6.CanQuery = false
	v6.CanTouch = false
	v6.Anchored = false
	v6.Massless = true
	v6.Parent = p3
	local v8 = p3.PrimaryPart
	if not v8 then
		for _, v9 in p3:GetChildren() do
			if v9:IsA("BasePart") and v9 ~= v6 then
				v8 = v9
				break
			end
		end
	end
	if not v8 then
		v6.Anchored = true
		return v6
	end
	local v10 = Instance.new("WeldConstraint")
	v10.Part0 = v6
	v10.Part1 = v8
	v10.Parent = v6
	return v6
end
function v2.Create(p12, p13)
	-- upvalues: (copy) v_u_11, (copy) v_u_1
	if not p12:FindFirstChild("HarvestPrompt", true) then
		local v14 = Instance.new("ProximityPrompt")
		v14.Name = "HarvestPrompt"
		v14.ActionText = p13 and (p13.promptActionText or "Harvest") or "Harvest"
		v14.ObjectText = p12:GetAttribute("PlantType") or (p12.Parent and (p12.Parent:GetAttribute("PlantType") or "Fruit") or "Fruit")
		v14.KeyboardKeyCode = p13 and p13.promptKey or Enum.KeyCode.E
		v14.HoldDuration = 0
		v14.RequiresLineOfSight = false
		v14.Exclusivity = Enum.ProximityPromptExclusivity.OnePerButton
		v14.GamepadKeyCode = Enum.KeyCode.ButtonX
		v14.Style = Enum.ProximityPromptStyle.Custom
		local v15 = p13 and (p13.promptDistance or 15) or 15
		local v16
		if p12:IsA("Model") then
			local _, v17 = p12:GetBoundingBox()
			local v18 = v15 + v17.Magnitude / 2
			v14.MaxActivationDistance = math.min(v18, 35)
			if p13 and p13.isSingleHarvest then
				v16 = p12:FindFirstChild("PlantAnchor")
				if not (v16 and v16:IsA("BasePart")) then
					v16 = v_u_11(p12)
				end
			else
				v16 = p12:FindFirstChild("FruitAnchor")
				if not (v16 and v16:IsA("BasePart")) then
					v16 = p12:FindFirstChild("PlantAnchor")
					if not (v16 and v16:IsA("BasePart")) then
						v16 = v_u_11(p12)
					end
				end
			end
		else
			v14.MaxActivationDistance = v15
			v16 = p12
		end
		v14.Parent = v16
		v_u_1:AddTag(v14, "HarvestPrompt")
		if not p12:IsA("Model") then
			p12 = p12.Parent
		end
		if p12 and p12:GetAttribute("Favorited") then
			v14.Enabled = false
		end
	end
end
return v2