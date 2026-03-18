local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Plants.Definitions.PlantDataDefinitions)
local v_u_9 = {
	["DefaultConfig"] = {
		["enabled"] = true,
		["unripeMultiplier"] = 1,
		["ripeMultiplier"] = 2,
		["lushMultiplier"] = 3,
		["sigmoidSteepness"] = 6,
		["unripeColor"] = Color3.fromRGB(120, 180, 80),
		["ripeColor"] = Color3.fromRGB(255, 200, 50),
		["lushColor"] = Color3.fromRGB(200, 80, 35),
		["colorIntensity"] = 0.3
	},
	["getConfigForPlant"] = function(p3)
		-- upvalues: (copy) v_u_9, (copy) v_u_2
		local v4 = {}
		for v5, v6 in pairs(v_u_9.DefaultConfig) do
			v4[v5] = v6
		end
		local v7 = v_u_2[p3]
		if not v7 then
			v4.unripeTime = 120
			v4.lushTime = 480
			return v4
		end
		local v8 = v7.fruitBaseGrowthTime or (v7.growthTime or 100)
		v4.unripeTime = v8 * 1.2
		v4.lushTime = v8 * 7.2
		return v4
	end
}
return v_u_9