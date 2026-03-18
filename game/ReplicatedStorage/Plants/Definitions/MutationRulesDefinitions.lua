local v1 = {
	["Priority"] = {
		["Water"] = { "Flooded", "Soaked" },
		["Cold"] = { "Snowy", "Chilled" }
	}
}
local v2 = {
	["Frostbit"] = {
		["requires"] = { "Soaked", "Snowy" },
		["removes"] = { "Soaked", "Snowy" },
		["blocks"] = { "Snowy" }
	},
	["Muddy"] = {
		["requires"] = { "Flooded", "Sandy" },
		["removes"] = { "Flooded", "Sandy" },
		["blocks"] = { "Sandy" }
	},
	["Mossy"] = {
		["requires"] = { "Foggy", "Chilled" },
		["removes"] = { "Foggy", "Chilled" },
		["blocks"] = {}
	}
}
v1.Combinations = v2
return v1