local v_u_8 = {
	["FindGroundAnchor"] = function(p1)
		for _, v2 in p1:GetChildren() do
			if v2.Name == "GroundAnchor" and v2:IsA("BasePart") then
				return v2
			end
		end
		for _, v3 in p1:GetDescendants() do
			if v3.Name == "GroundAnchor" and v3:IsA("BasePart") then
				return v3
			end
		end
		return nil
	end,
	["PositionWithAnchor"] = function(p4, p5)
		-- upvalues: (copy) v_u_8
		local v6 = v_u_8.FindGroundAnchor(p4)
		if not v6 then
			p4:PivotTo(CFrame.new(p5))
			return false
		end
		local v7 = p4:GetPivot():ToObjectSpace(v6.CFrame)
		p4:PivotTo(CFrame.new(p5) * v7:Inverse())
		v6.Transparency = 1
		v6.CanCollide = false
		return true
	end
}
return v_u_8