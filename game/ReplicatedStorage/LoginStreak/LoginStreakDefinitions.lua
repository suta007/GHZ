local v_u_2 = {
	["Rewards"] = {
		{
			["Day"] = 1,
			["Type"] = "Seed",
			["Item"] = "Carrot Seed",
			["Amount"] = 7
		},
		{
			["Day"] = 2,
			["Type"] = "SeedPack",
			["Item"] = "Streak Seed Pack",
			["Amount"] = 1
		},
		{
			["Day"] = 3,
			["Type"] = "Gear",
			["Item"] = "Watering Can",
			["Amount"] = 10
		},
		{
			["Day"] = 4,
			["Type"] = "Seed",
			["Item"] = "Strawberry Seed",
			["Amount"] = 3
		},
		{
			["Day"] = 5,
			["Type"] = "Seed",
			["Item"] = "Beetroot Seed",
			["Amount"] = 5
		},
		{
			["Day"] = 6,
			["Type"] = "Seed",
			["Item"] = "Tomato Seed",
			["Amount"] = 2
		},
		{
			["Day"] = 7,
			["Type"] = "SeedPack",
			["Item"] = "Streak Seed Pack",
			["Amount"] = 5
		},
		{
			["Day"] = 8,
			["Type"] = "Seed",
			["Item"] = "Apple Seed",
			["Amount"] = 1
		},
		{
			["Day"] = 9,
			["Type"] = "SeedPack",
			["Item"] = "Streak Seed Pack",
			["Amount"] = 2
		},
		{
			["Day"] = 10,
			["Type"] = "Gear",
			["Item"] = "Basic Sprinkler",
			["Amount"] = 2
		},
		{
			["Day"] = 11,
			["Type"] = "Seed",
			["Item"] = "Wheat Seed",
			["Amount"] = 3
		},
		{
			["Day"] = 12,
			["Type"] = "Seed",
			["Item"] = "Banana Seed",
			["Amount"] = 1
		},
		{
			["Day"] = 13,
			["Type"] = "Seed",
			["Item"] = "Plum Seed",
			["Amount"] = 1
		},
		{
			["Day"] = 14,
			["Type"] = "SeedPack",
			["Item"] = "Streak Seed Pack",
			["Amount"] = 10
		},
		{
			["Day"] = 15,
			["Type"] = "Seed",
			["Item"] = "Potato Seed",
			["Amount"] = 1
		},
		{
			["Day"] = 16,
			["Type"] = "Gear",
			["Item"] = "Harvest Bell",
			["Amount"] = 10
		},
		{
			["Day"] = 17,
			["Type"] = "Seed",
			["Item"] = "Cabbage Seed",
			["Amount"] = 1
		},
		{
			["Day"] = 18,
			["Type"] = "SeedPack",
			["Item"] = "Streak Seed Pack",
			["Amount"] = 3
		},
		{
			["Day"] = 19,
			["Type"] = "Seed",
			["Item"] = "Bamboo Seed",
			["Amount"] = 1
		},
		{
			["Day"] = 20,
			["Type"] = "Seed",
			["Item"] = "Cherry Seed",
			["Amount"] = 1
		},
		{
			["Day"] = 21,
			["Type"] = "SeedPack",
			["Item"] = "Streak Seed Pack",
			["Amount"] = 15
		},
		{
			["Day"] = 22,
			["Type"] = "Gear",
			["Item"] = "Turbo Sprinkler",
			["Amount"] = 2
		},
		{
			["Day"] = 23,
			["Type"] = "SeedPack",
			["Item"] = "Dawn Seed Pack",
			["Amount"] = 3
		},
		{
			["Day"] = 24,
			["Type"] = "Gear",
			["Item"] = "Favorite Tool",
			["Amount"] = 10
		},
		{
			["Day"] = 25,
			["Type"] = "SeedPack",
			["Item"] = "Dawn Seed Pack",
			["Amount"] = 3
		},
		{
			["Day"] = 26,
			["Type"] = "Gear",
			["Item"] = "Super Sprinkler",
			["Amount"] = 1
		},
		{
			["Day"] = 27,
			["Type"] = "Seed",
			["Item"] = "Mango Seed",
			["Amount"] = 1
		},
		{
			["Day"] = 28,
			["Type"] = "SeedPack",
			["Item"] = "Streak Seed Pack",
			["Amount"] = 20
		}
	},
	["GetReward"] = function(p1)
		-- upvalues: (copy) v_u_2
		if typeof(p1) == "number" and (p1 >= 1 and p1 <= 28) then
			return v_u_2.Rewards[p1]
		else
			return nil
		end
	end
}
return v_u_2