local function v15(p1, p2)
	local v3 = p2:sub(2, 3)
	local v4 = tonumber(v3, 16)
	local v5 = p2:sub(4, 5)
	local v6 = tonumber(v5, 16)
	local v7 = p2:sub(6, 7)
	local v8 = tonumber(v7, 16)
	local v9 = v4 * 0.4
	local v10 = math.floor(v9)
	local v11 = v6 * 0.4
	local v12 = math.floor(v11)
	local v13 = v8 * 0.4
	local v14 = math.floor(v13)
	return ("<stroke color=\"%s\" thickness=\"1.3\"><font color=\"%s\"><b>%s</b></font></stroke>"):format(string.format("#%02x%02x%02x", v10, v12, v14), p2, p1)
end
local v16 = {}
local v17 = {
	["Name"] = "Fog",
	["Description"] = ("Your fruit can become %s!"):format(v15("FOGGY", "#C0C0C0")),
	["Chance"] = 5,
	["Cooldown"] = 2,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://114697015143439",
	["SoundId"] = "",
	["Mutations"] = {
		["Foggy"] = 1
	},
	["GrowthBoost"] = 1
}
v16.Fog = v17
v16.Normal = {
	["Name"] = "Normal",
	["Description"] = "",
	["Chance"] = 1,
	["Cooldown"] = -1,
	["Duration"] = -1,
	["Icon"] = "",
	["SoundId"] = "",
	["Mutations"] = {},
	["GrowthBoost"] = 1
}
local v18 = {
	["Name"] = "Rain",
	["Description"] = ("+25%% Grow Speed! %s and %s Fruit Chance!"):format(v15("SOAKED", "#4A90D9"), v15("FLOODED", "#2E5CB8")),
	["Chance"] = 3,
	["Cooldown"] = 3,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://103375809961019",
	["SoundId"] = "rbxassetid://123955742183386",
	["Mutations"] = {
		["Soaked"] = 3,
		["Flooded"] = 1
	},
	["GrowthBoost"] = 1.25
}
v16.Rain = v18
local v19 = {
	["Name"] = "Sandstorm",
	["Description"] = ("Take cover! Higher %s Fruit Chance and 20%% Grow Speed!"):format(v15("SANDY", "#F7D341")),
	["Chance"] = 1,
	["Cooldown"] = 3,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://84238748079462",
	["SoundId"] = "rbxassetid://107302113902831",
	["Mutations"] = {
		["Sandy"] = 1
	},
	["GrowthBoost"] = 1.2
}
v16.Sandstorm = v19
local v20 = {
	["Name"] = "Snow",
	["Description"] = ("It\'s freezing out here! Higher %s and %s Fruit Chance!"):format(v15("SNOWY", "#A5F2F3"), v15("CHILLED", "#B0E0E6")),
	["Chance"] = 2,
	["Cooldown"] = 3,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://75412091527456",
	["SoundId"] = "rbxassetid://93219686102046",
	["Mutations"] = {
		["Snowy"] = 2,
		["Chilled"] = 3
	},
	["GrowthBoost"] = 0.85
}
v16.Snow = v20
local v21 = {
	["Name"] = "Starfall",
	["Description"] = ("Watch out for falling debris! Higher %s Fruit Chance!"):format(v15("STARSTRUCK", "#9B59B6")),
	["Chance"] = 1,
	["Cooldown"] = 4,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://128057564038674",
	["SoundId"] = "rbxassetid://129920467159484",
	["Mutations"] = {
		["Starstruck"] = 1
	},
	["GrowthBoost"] = 1
}
v16.Starfall = v21
local v22 = {
	["Name"] = "Storm",
	["Description"] = ("+50%% Grow Speed! %s Fruit Chance!"):format(v15("SHOCKED", "#FFFF00")),
	["Chance"] = 2,
	["Cooldown"] = 3,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://97074261337256",
	["SoundId"] = "rbxassetid://102464891974761",
	["Mutations"] = {
		["Shocked"] = 1
	},
	["MutationChance"] = 0.0175,
	["GrowthBoost"] = 1.5
}
v16.Storm = v22
local v23 = {
	["Name"] = "Meteor Shower",
	["Description"] = ("The sky ignites! +20%% Grow Speed! Higher %s Fruit Chance!"):format(v15("METEORIC", "#8B0000")),
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://93668582061486",
	["SoundId"] = "",
	["Mutations"] = {
		["Meteoric"] = 1
	},
	["MutationChance"] = 0.0125,
	["GrowthBoost"] = 1.2
}
v16.MeteorShower = v23
local v24 = {
	["Name"] = "Tsunami",
	["Description"] = ("The ocean surges! Higher %s Fruit Chance!"):format(v15("TIDAL", "#D6EAEA")),
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://120264835400081",
	["SoundId"] = "",
	["Mutations"] = {
		["Tidal"] = 1
	},
	["MutationChance"] = 0.025,
	["GrowthBoost"] = 1
}
v16.Tsunami = v24
v16.SeedRain = {
	["Name"] = "Seed Rain",
	["Description"] = ("Seeds fall from the sky! Obtain %s seeds!"):format(v15("BONUS", "#FFE02E")),
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://107171640649932",
	["SoundId"] = "",
	["Mutations"] = {},
	["MutationChance"] = 0,
	["GrowthBoost"] = 1
}
v16.LuckyBlockRain = {
	["Name"] = "Lucky Block Rain",
	["Description"] = "Lucky Blocks fall from the sky! Collect them for free seeds and gears!",
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://129221032267806",
	["SoundId"] = "",
	["Mutations"] = {},
	["MutationChance"] = 0,
	["GrowthBoost"] = 1
}
v16.AdminWar = {
	["Name"] = "Admin War",
	["Description"] = "",
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = -1,
	["Icon"] = "",
	["SoundId"] = "",
	["Mutations"] = {},
	["MutationChance"] = 0,
	["GrowthBoost"] = 1,
	["ShowIcon"] = false
}
v16.AdminWarFinale = {
	["Name"] = "Admin War Finale",
	["Description"] = "",
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = -1,
	["Icon"] = "",
	["SoundId"] = "",
	["Mutations"] = {},
	["MutationChance"] = 0,
	["GrowthBoost"] = 1,
	["ShowIcon"] = false
}
local v25 = {
	["Name"] = "Beam Clash",
	["Description"] = "",
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 20,
	["Icon"] = "",
	["SoundId"] = "",
	["Mutations"] = {
		["Salad"] = 1,
		["Banned"] = 1
	},
	["MutationChance"] = 0.125,
	["GrowthBoost"] = 1,
	["ShowIcon"] = false
}
v16.BeamClash = v25
v16.MannyMishap = {
	["Name"] = "Manny\'s Mishap",
	["Description"] = "Manny\'s cart tipped over! Collect fruit for rewards!",
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://108921906581300",
	["SoundId"] = "",
	["Mutations"] = {},
	["MutationChance"] = 0,
	["GrowthBoost"] = 1
}
local v26 = {
	["Name"] = "DJ Kine",
	["Description"] = ("DJ Kine drops the beat! Higher %s Fruit Chance!"):format(v15("PARTY", "#FF1493")),
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 218,
	["Icon"] = "rbxassetid://118282099898634",
	["SoundId"] = "",
	["Mutations"] = {
		["Party"] = 1
	},
	["MutationChance"] = 0.025,
	["GrowthBoost"] = 1
}
v16.DJKine = v26
local v27 = {
	["Name"] = "Strange Weather",
	["Description"] = ("Something is off... Higher %s Fruit Chance!"):format(v15("STRANGE", "#7FFF00")),
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://135104007032941",
	["SoundId"] = "",
	["Mutations"] = {
		["Strange"] = 1
	},
	["MutationChance"] = 0.025,
	["GrowthBoost"] = 1
}
v16.StrangeWeather = v27
local v28 = {
	["Name"] = "Heavy Rain",
	["Description"] = ("An ancient terror stirs... Higher %s Fruit Chance!"):format(v15("ANCIENT", "#4B0082")),
	["Chance"] = -1,
	["Cooldown"] = 0,
	["Duration"] = 300,
	["Icon"] = "rbxassetid://138689184698877",
	["SoundId"] = "",
	["Mutations"] = {
		["Ancient"] = 1
	},
	["MutationChance"] = 0,
	["GrowthBoost"] = 1
}
v16.HeavyRain = v28
return v16