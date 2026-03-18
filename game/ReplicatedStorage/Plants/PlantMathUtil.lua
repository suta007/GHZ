local v_u_16 = {
	["AVG_SCALE"] = 1.05,
	["calculateBaseSproutTime"] = function(p1, p2)
		-- upvalues: (copy) v_u_16
		local v3 = p1.sproutTime or 2
		local v4 = p2 / v_u_16.AVG_SCALE
		return v3 * math.max(0.5, v4)
	end,
	["calculateBaseGrowthTime"] = function(p5, p6)
		return p5.growthTime * p6
	end,
	["calculateBaseFruitSproutTime"] = function(p7)
		return p7.fruitSproutTime or 0.5
	end,
	["deserializeVector3"] = function(p8)
		if typeof(p8) ~= "table" then
			return Vector3.new(0, 0, 0)
		end
		local v9 = p8.X
		local v10 = tonumber(v9) or 0
		local v11 = p8.Y
		local v12 = tonumber(v11) or 0
		local v13 = p8.Z
		local v14 = tonumber(v13) or 0
		return Vector3.new(v10, v12, v14)
	end,
	["serializeVector3"] = function(p15)
		return {
			["X"] = p15.X,
			["Y"] = p15.Y,
			["Z"] = p15.Z
		}
	end
}
return v_u_16