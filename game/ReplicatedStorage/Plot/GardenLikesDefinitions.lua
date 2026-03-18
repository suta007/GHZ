local v1 = game.ReplicatedStorage:WaitForChild("VariantEffects")
local v_u_5 = {
	["Tiers"] = {
		{
			["name"] = "Bronze",
			["threshold"] = 10,
			["color"] = "#CD7F32",
			["variantEffect"] = v1:WaitForChild("Bronze")
		},
		{
			["name"] = "Silver",
			["threshold"] = 100,
			["color"] = "#C0C0C0",
			["variantEffect"] = v1:WaitForChild("Silver")
		},
		{
			["name"] = "Gold",
			["threshold"] = 1000,
			["color"] = "#FFD700",
			["variantEffect"] = v1:WaitForChild("Gold")
		}
	},
	["GetTier"] = function(p2)
		-- upvalues: (copy) v_u_5
		local v3 = nil
		for _, v4 in v_u_5.Tiers do
			if v4.threshold <= p2 then
				v3 = v4
			end
		end
		return v3
	end
}
return v_u_5