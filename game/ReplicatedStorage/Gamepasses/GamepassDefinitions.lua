local v1 = {
	["HarvestHand"] = {
		["GamepassId"] = 1738861883,
		["Name"] = "Harvest Hand",
		["DoubleHarvestChance"] = 0.1
	},
	["FertileSoil"] = {
		["GamepassId"] = 1736495264,
		["Name"] = "Fertile Soil",
		["GrowthSpeedMultiplier"] = 1.25
	},
	["GearMastery"] = {
		["GamepassId"] = 1737772173,
		["Name"] = "Gear Mastery",
		["SaveGearChance"] = 0.1
	},
	["BotanistsBlessing"] = {
		["GamepassId"] = 1736851227,
		["Name"] = "Botanist\'s Blessing",
		["BotanistPriceReduction"] = 0.8,
		["MutationChanceBonus"] = 0.1
	},
	["ById"] = {}
}
for v2, v3 in pairs(v1) do
	if typeof(v3) == "table" and v3.GamepassId then
		v1.ById[v3.GamepassId] = v2
	end
end
return v1