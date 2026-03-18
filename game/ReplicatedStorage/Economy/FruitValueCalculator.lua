local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Plants.Definitions.PlantDefinitions)
local v_u_3 = require(v1.Plants.Definitions.MutationDataDefinitions)
local v_u_4 = require(v1.Plants.Definitions.VariantDataDefinitions)
return {
	["GetValue"] = function(p5)
		-- upvalues: (copy) v_u_2, (copy) v_u_3, (copy) v_u_4
		local v6 = p5:GetAttribute("FruitValue")
		if v6 and (typeof(v6) == "number" and v6 > 0) then
			return v6
		end
		local v7 = p5:GetAttribute("HarvestedFrom")
		if not v7 or typeof(v7) ~= "string" then
			return 0
		end
		local v8 = v_u_2[v7]
		if not v8 then
			return 0
		end
		local v9 = v8.FruitBaseValue or (v8.PlantBaseValue or 0)
		if v9 <= 0 then
			return 0
		end
		local v10 = p5:GetAttribute("HiddenNumber") or 1
		local v11 = typeof(v10) ~= "number" and 1 or v10
		local v12 = 1
		local v13 = p5:GetAttribute("Mutation")
		if v13 and (typeof(v13) == "string" and v13 ~= "") then
			local v14 = 0
			local v15 = 0
			for v16 in string.gmatch(v13, "([^,]+)") do
				local v17 = v_u_3[v16:match("^%s*(.-)%s*$")]
				if v17 and v17.priceMultiplier then
					v14 = v14 + 1
					v15 = v15 + v17.priceMultiplier
				end
			end
			if v14 > 0 then
				v12 = v15 + 1 - v14
			end
		end
		local v18 = 1
		local v19 = p5:GetAttribute("Variant")
		if v19 and typeof(v19) == "string" then
			local v20 = v_u_4[v19]
			if v20 and v20.priceMultiplier then
				v18 = v20.priceMultiplier
			end
		end
		local v21 = p5:GetAttribute("RipenessMultiplier") or 1
		local v22 = typeof(v21) ~= "number" and 1 or v21
		local v23 = v9 * v11 * v11 * v12 * v18 * v22
		return math.floor(v23)
	end
}