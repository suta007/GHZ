local v_u_5 = {
	["MAX_POINTS"] = 500,
	["RESTART_COST"] = 100000000,
	["Rewards"] = {
		{
			["Points"] = 5,
			["Type"] = "Seed",
			["Item"] = "Strawberry Seed",
			["Amount"] = 3
		},
		{
			["Points"] = 10,
			["Type"] = "Seed",
			["Item"] = "Beetroot Seed",
			["Amount"] = 3
		},
		{
			["Points"] = 20,
			["Type"] = "Seed",
			["Item"] = "Tomato Seed",
			["Amount"] = 3
		},
		{
			["Points"] = 30,
			["Type"] = "Gear",
			["Item"] = "Basic Sprinkler",
			["Amount"] = 2
		},
		{
			["Points"] = 50,
			["Type"] = "SeedPack",
			["Item"] = "IGMA Seed Pack",
			["Amount"] = 1
		},
		{
			["Points"] = 75,
			["Type"] = "Seed",
			["Item"] = "Apple Seed",
			["Amount"] = 2
		},
		{
			["Points"] = 100,
			["Type"] = "Seed",
			["Item"] = "Rose Seed",
			["Amount"] = 2
		},
		{
			["Points"] = 125,
			["Type"] = "Gear",
			["Item"] = "Turbo Sprinkler",
			["Amount"] = 2
		},
		{
			["Points"] = 150,
			["Type"] = "SeedPack",
			["Item"] = "IGMA Seed Pack",
			["Amount"] = 3
		},
		{
			["Points"] = 175,
			["Type"] = "Seed",
			["Item"] = "Wheat Seed",
			["Amount"] = 3
		},
		{
			["Points"] = 200,
			["Type"] = "Seed",
			["Item"] = "Banana Seed",
			["Amount"] = 2
		},
		{
			["Points"] = 230,
			["Type"] = "SeedPack",
			["Item"] = "Royal Seed Pack",
			["Amount"] = 1
		},
		{
			["Points"] = 260,
			["Type"] = "Gear",
			["Item"] = "Favorite Tool",
			["Amount"] = 4
		},
		{
			["Points"] = 300,
			["Type"] = "Seed",
			["Item"] = "Plum Seed",
			["Amount"] = 2
		},
		{
			["Points"] = 330,
			["Type"] = "SeedPack",
			["Item"] = "Royal Seed Pack",
			["Amount"] = 3
		},
		{
			["Points"] = 360,
			["Type"] = "Gear",
			["Item"] = "Super Sprinkler",
			["Amount"] = 1
		},
		{
			["Points"] = 400,
			["Type"] = "Seed",
			["Item"] = "Potato Seed",
			["Amount"] = 2
		},
		{
			["Points"] = 430,
			["Type"] = "Gear",
			["Item"] = "Trowel",
			["Amount"] = 1
		},
		{
			["Points"] = 470,
			["Type"] = "SeedPack",
			["Item"] = "IGMA Seed Pack",
			["Amount"] = 5
		},
		{
			["Points"] = 500,
			["Type"] = "Seed",
			["Item"] = "Lilystalk Seed",
			["Amount"] = 1
		}
	},
	["GetRewardByIndex"] = function(p1)
		-- upvalues: (copy) v_u_5
		if typeof(p1) == "number" and (p1 >= 1 and #v_u_5.Rewards >= p1) then
			return v_u_5.Rewards[p1]
		else
			return nil
		end
	end,
	["GetRewardByPoints"] = function(p2)
		-- upvalues: (copy) v_u_5
		for v3, v4 in v_u_5.Rewards do
			if v4.Points == p2 then
				return v4, v3
			end
		end
		return nil
	end
}
return v_u_5