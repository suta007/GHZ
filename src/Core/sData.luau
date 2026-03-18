local sData = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShopData = ReplicatedStorage:WaitForChild("Shop"):WaitForChild("ShopData")
local PlantData = ReplicatedStorage:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDataDefinitions")
local MutationData = ReplicatedStorage:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("MutationDataDefinitions")
local SeedPackDefinitions = ReplicatedStorage:WaitForChild("RNGPacks"):WaitForChild("SeedPackDefinitions")

local function getShopData(path)
	local names = { "ALL" }
	local success, data = pcall(require, ShopData[path])
	if success then
		for _, item in pairs(data.ShopData) do
			table.insert(names, item.Name)
		end
	end
	return names
end
sData.SeedShopTable = getShopData("SeedShopData")
sData.GearShopTable = getShopData("GearShopData")
sData.PlantDataTable = { "ALL" }
sData.SeedDataTable = { "ALL" }
sData.MutationDataTable = { "ALL" }
sData.PlantDataBlackTable = {}
sData.MutationDataBlackTable = {}

local pData = require(PlantData)
for PlantName, _ in pairs(pData) do
	table.insert(sData.PlantDataTable, PlantName)
	table.insert(sData.SeedDataTable, PlantName .. " Seed")
end

local mData = require(MutationData)
for MutationName, _ in pairs(mData) do
	table.insert(sData.MutationDataTable, MutationName)
end

sData.PlantDataBlackTable = table.clone(sData.PlantDataTable)
sData.PlantDataBlackTable[1] = "NONE"

sData.MutationDataBlackTable = table.clone(sData.MutationDataTable)
sData.MutationDataBlackTable[1] = "NONE"

sData.SeedPackTable = { "ALL" }
local seedPackData = require(SeedPackDefinitions)
for SeedPackName, _ in pairs(seedPackData) do
	table.insert(sData.SeedPackTable, SeedPackName)
end

return sData
