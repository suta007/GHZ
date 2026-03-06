local PlantDataTable = { "ALL" }
local SeedDataTable = { "ALL" }
for PlantName, _ in pairs(require(PlantData)) do
	table.insert(PlantDataTable, PlantName)
	table.insert(SeedDataTable, PlantName .. " Seed")
end
