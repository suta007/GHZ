local v1 = {}
local v2 = {
	["Generic"] = {
		{
			["Type"] = "HarvestAny",
			["Item"] = nil,
			["Goal"] = 15,
			["Desc"] = "Harvest %s plants",
			["RewardType"] = "Gear",
			["RewardItem"] = "Watering Can",
			["RewardAmount"] = 5
		},
		{
			["Type"] = "HarvestAny",
			["Item"] = nil,
			["Goal"] = 30,
			["Desc"] = "Harvest %s plants",
			["RewardType"] = "Gear",
			["RewardItem"] = "Basic Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestAny",
			["Item"] = nil,
			["Goal"] = 50,
			["Desc"] = "Harvest %s plants",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "SellPlants",
			["Item"] = nil,
			["Goal"] = 10,
			["Desc"] = "Sell %s plants",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "SellPlants",
			["Item"] = nil,
			["Goal"] = 25,
			["Desc"] = "Sell %s plants",
			["RewardType"] = "Gear",
			["RewardItem"] = "Basic Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "SellPlants",
			["Item"] = nil,
			["Goal"] = 40,
			["Desc"] = "Sell %s plants",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		}
	},
	["Planting"] = {
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Carrot",
			["Goal"] = 20,
			["Desc"] = "Plant %s Carrot Seeds",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Corn",
			["Goal"] = 10,
			["Desc"] = "Plant %s Corn Seeds",
			["RewardType"] = "Gear",
			["RewardItem"] = "Basic Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Onion",
			["Goal"] = 6,
			["Desc"] = "Plant %s Onion Seeds",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Strawberry",
			["Goal"] = 3,
			["Desc"] = "Plant %s Strawberry Seeds",
			["RewardType"] = "Gear",
			["RewardItem"] = "Harvest Bell",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Mushroom",
			["Goal"] = 3,
			["Desc"] = "Plant %s Mushroom Seeds",
			["RewardType"] = "Gear",
			["RewardItem"] = "Favorite Tool",
			["RewardAmount"] = 1
		}
	},
	["Harvesting"] = {
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Carrot",
			["Goal"] = 20,
			["Desc"] = "Harvest %s Carrots",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Corn",
			["Goal"] = 15,
			["Desc"] = "Harvest %s Corn",
			["RewardType"] = "Gear",
			["RewardItem"] = "Basic Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Onion",
			["Goal"] = 8,
			["Desc"] = "Harvest %s Onions",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Strawberry",
			["Goal"] = 10,
			["Desc"] = "Harvest %s Strawberries",
			["RewardType"] = "Gear",
			["RewardItem"] = "Harvest Bell",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Mushroom",
			["Goal"] = 8,
			["Desc"] = "Harvest %s Mushrooms",
			["RewardType"] = "Gear",
			["RewardItem"] = "Watering Can",
			["RewardAmount"] = 3
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Tomato",
			["Goal"] = 4,
			["Desc"] = "Harvest %s Tomatoes",
			["RewardType"] = "Gear",
			["RewardItem"] = "Turbo Sprinkler",
			["RewardAmount"] = 1
		}
	},
	["Economy"] = {
		{
			["Type"] = "GainShillings",
			["Item"] = nil,
			["Goal"] = 5000,
			["Desc"] = "Earn %s Shillings",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "GainShillings",
			["Item"] = nil,
			["Goal"] = 10000,
			["Desc"] = "Earn %s Shillings",
			["RewardType"] = "Gear",
			["RewardItem"] = "Harvest Bell",
			["RewardAmount"] = 1
		}
	}
}
v1.Daily = v2
local v3 = {
	["Generic"] = {
		{
			["Type"] = "HarvestAny",
			["Item"] = nil,
			["Goal"] = 100,
			["Desc"] = "Harvest %s plants",
			["RewardType"] = "Gear",
			["RewardItem"] = "Basic Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestAny",
			["Item"] = nil,
			["Goal"] = 200,
			["Desc"] = "Harvest %s plants",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestAny",
			["Item"] = nil,
			["Goal"] = 350,
			["Desc"] = "Harvest %s plants",
			["RewardType"] = "Gear",
			["RewardItem"] = "Turbo Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "SellPlants",
			["Item"] = nil,
			["Goal"] = 60,
			["Desc"] = "Sell %s plants",
			["RewardType"] = "Gear",
			["RewardItem"] = "Trowel",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "SellPlants",
			["Item"] = nil,
			["Goal"] = 120,
			["Desc"] = "Sell %s plants",
			["RewardType"] = "Gear",
			["RewardItem"] = "Harvest Bell",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "SellPlants",
			["Item"] = nil,
			["Goal"] = 200,
			["Desc"] = "Sell %s plants",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		}
	},
	["Planting"] = {
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Carrot",
			["Goal"] = 100,
			["Desc"] = "Plant %s Carrot Seeds",
			["RewardType"] = "Gear",
			["RewardItem"] = "Basic Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Corn",
			["Goal"] = 50,
			["Desc"] = "Plant %s Corn Seeds",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 2
		},
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Onion",
			["Goal"] = 25,
			["Desc"] = "Plant %s Onion Seeds",
			["RewardType"] = "Gear",
			["RewardItem"] = "Harvest Bell",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Strawberry",
			["Goal"] = 12,
			["Desc"] = "Plant %s Strawberry Seeds",
			["RewardType"] = "Gear",
			["RewardItem"] = "Turbo Sprinkler",
			["RewardAmount"] = 2
		},
		{
			["Type"] = "PlantSeeds",
			["Item"] = "Mushroom",
			["Goal"] = 10,
			["Desc"] = "Plant %s Mushroom Seeds",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 2
		}
	},
	["Harvesting"] = {
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Carrot",
			["Goal"] = 80,
			["Desc"] = "Harvest %s Carrots",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 2
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Corn",
			["Goal"] = 60,
			["Desc"] = "Harvest %s Corn",
			["RewardType"] = "Gear",
			["RewardItem"] = "Harvest Bell",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Strawberry",
			["Goal"] = 40,
			["Desc"] = "Harvest %s Strawberries",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Mushroom",
			["Goal"] = 35,
			["Desc"] = "Harvest %s Mushrooms",
			["RewardType"] = "Gear",
			["RewardItem"] = "Turbo Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Tomato",
			["Goal"] = 20,
			["Desc"] = "Harvest %s Tomatoes",
			["RewardType"] = "Gear",
			["RewardItem"] = "Favorite Tool",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "HarvestCrops",
			["Item"] = "Apple",
			["Goal"] = 12,
			["Desc"] = "Harvest %s Apples",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		}
	},
	["Economy"] = {
		{
			["Type"] = "GainShillings",
			["Item"] = nil,
			["Goal"] = 50000,
			["Desc"] = "Earn %s Shillings",
			["RewardType"] = "Gear",
			["RewardItem"] = "Turbo Sprinkler",
			["RewardAmount"] = 1
		},
		{
			["Type"] = "GainShillings",
			["Item"] = nil,
			["Goal"] = 150000,
			["Desc"] = "Earn %s Shillings",
			["RewardType"] = "SeedPack",
			["RewardItem"] = "Royal Seed Pack",
			["RewardAmount"] = 1
		}
	}
}
v1.Weekly = v3
local v4 = {
	["Daily"] = {},
	["Weekly"] = {}
}
for v5, v6 in pairs(v1) do
	for _, v7 in pairs(v6) do
		for _, v8 in ipairs(v7) do
			local v9 = v4[v5]
			table.insert(v9, v8)
		end
	end
end
return v4