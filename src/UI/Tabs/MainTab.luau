--!nocheck
local MainTab = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlantData = ReplicatedStorage.Plants.Definitions.PlantDataDefinitions
local MutationData = ReplicatedStorage.Plants.Definitions.MutationDataDefinitions

local State = require(script.Parent.Parent.Parent.Core.State)
local Harvest = require(script.Parent.Parent.Parent.Modules.Harvest)
local Planting = require(script.Parent.Parent.Parent.Modules.Planting)
local Trading = require(script.Parent.Parent.Parent.Modules.Trading)

function MainTab.Setup(tab, Options, SaveManager)
	-- Data Tables
	local PlantDataTable = { "ALL" }
	for PlantName, _ in pairs(require(PlantData)) do
		table.insert(PlantDataTable, PlantName)
	end
	
	local MutationDataTable = { "ALL" }
	for MutationName, _ in pairs(require(MutationData)) do
		table.insert(MutationDataTable, MutationName)
	end

	local PlantDataBlackTable = table.clone(PlantDataTable)
	PlantDataBlackTable[1] = "NONE"
	
	local MutationDataBlackTable = table.clone(MutationDataTable)
	MutationDataBlackTable[1] = "NONE"

	-- Plants Section
	local PlantsSection = tab:AddCollapsibleSection("Plants", false)
	PlantsSection:AddToggle("tgPlantsEnable", {
		Title = "Auto Plants",
		Default = false,
		Callback = function(Value)
			if Value then
				table.insert(State.actionQueue, { FuncName = Planting.Run })
			else
				State.isPlanting = false
			end
			SaveManager:Save("Horizons")
		end,
	})
	
	PlantsSection:AddDropdown("ddPlantsSeeds", {
		Title = "Select Seeds",
		Values = PlantDataTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})

	PlantsSection:AddDropdown("ddPlantsPos", {
		Title = "Select Plants Position",
		Values = { "Player", "Random" },
		Default = "Player",
		Callback = function() SaveManager:Save("Horizons") end,
	})

	-- Harvest Section
	local HarvestSection = tab:AddCollapsibleSection("Harvest", false)
	HarvestSection:AddToggle("tgHarvestEnable", {
		Title = "Auto Harvest",
		Default = false,
		Callback = function(Value)
			table.clear(State.HarVestCropsList)
			if not Value then State.isHarvesting = false end
			SaveManager:Save("Horizons")
		end,
	})

	HarvestSection:AddDropdown("ddHarvestCrops", {
		Title = "Select Crops",
		Values = PlantDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})

	HarvestSection:AddDropdown("ddHarvestBlackCrops", {
		Title = "Blacklist Crops",
		Values = PlantDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})

	HarvestSection:AddDropdown("ddHarvestMutants", {
		Title = "Select Mutants",
		Values = MutationDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})

	HarvestSection:AddDropdown("ddRipeness", {
		Title = "Ripeness Stage",
		Values = { "ALL", "Unripe", "Ripened", "Lush" },
		Default = { "Lush" },
		Multi = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})

	HarvestSection:AddInput("ipRipenessMulti", {
		Title = "Ripeness Multiplier",
		Default = 3,
		Numeric = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})

	-- Sell Section
	local SellSection = tab:AddCollapsibleSection("Sell", false)
	SellSection:AddToggle("tgSellCropsEnable", {
		Title = "Sell",
		Default = false,
		Callback = function() SaveManager:Save("Horizons") end,
	})
end

return MainTab
