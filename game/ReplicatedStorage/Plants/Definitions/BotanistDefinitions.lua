local v1 = {
	["MutationRollChance"] = 0.2,
	["CostPercentage"] = 0.325,
	["PREMIUM_PACK_INTERVAL"] = 40
}
local v2 = {
	["Foggy"] = {
		["TargetWeight"] = 2,
		["RewardCount"] = 1,
		["AcceptedMutations"] = { "Foggy", "Mossy" }
	},
	["Soaked"] = {
		["TargetWeight"] = 2,
		["RewardCount"] = 1,
		["AcceptedMutations"] = { "Soaked", "Flooded", "Muddy" }
	},
	["Chilled"] = {
		["TargetWeight"] = 1.5,
		["RewardCount"] = 1,
		["AcceptedMutations"] = { "Snowy", "Frostbit", "Chilled" }
	},
	["Sandy"] = {
		["TargetWeight"] = 1.5,
		["RewardCount"] = 1,
		["AcceptedMutations"] = { "Sandy", "Muddy" }
	},
	["Shocked"] = {
		["TargetWeight"] = 0.8,
		["RewardCount"] = 2
	},
	["Starstruck"] = {
		["TargetWeight"] = 0.8,
		["RewardCount"] = 3
	}
}
v1.MutationQuests = v2
v1.LegacyQuestMap = {
	["Flooded"] = "Soaked",
	["Snowy"] = "Chilled"
}
return v1