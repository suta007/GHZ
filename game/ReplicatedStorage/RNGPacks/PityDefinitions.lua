local v1 = require(script.Parent.SeedPackDefinitions)
local v2 = {
	["Regular"] = 125,
	["Premium"] = 150
}
local v3 = {}
for v4, v5 in pairs(v1) do
	local v6 = v2[v5.Tier] or v2.Regular
	local v7 = {}
	for _, v8 in ipairs(v5.LootPool) do
		local v9 = {
			["Type"] = v8.Type,
			["RewardId"] = v8.RewardId
		}
		local v10 = v6 / v8.Chance
		v9.Pity = math.ceil(v10)
		table.insert(v7, v9)
	end
	v3[v4] = v7
end
return v3