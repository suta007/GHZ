--!nocheck
local MainTab = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlantData = ReplicatedStorage.Plants.Definitions.PlantDataDefinitions
local MutationData = ReplicatedStorage.Plants.Definitions.MutationDataDefinitions

function MainTab.Setup(tab, Options, SaveManager, Registry)
	local UIData = Registry.UIData
	local State = Registry.State
	local Utils = Registry.Utils
	local Planting = Registry.Planting

	-- 1. Plants Section
	local PlantsSection = tab:AddCollapsibleSection("Plants", false)
	PlantsSection:AddToggle("tgPlantsEnable", {
		Title = "Auto Plants",
		Default = false,
		Callback = function(Value)
			if not Value then
				State.isPlanting = false
			end
			SaveManager:Save("Horizons")
		end,
	})
	PlantsSection:AddButton({
		Title = "Clear Selected Seeds",
		Callback = function()
			Options.ddPlantsSeeds:SetValue({})
		end,
	})
	PlantsSection:AddDropdown("ddPlantsSeeds", {
		Title = "Select Seeds",
		Values = UIData.PlantDataTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	PlantsSection:AddDropdown("ddPlantsPos", {
		Title = "Select Plants Position",
		Values = { "Player", "Random" },
		Default = "Player",
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	-- 2. Harvest Section
	local HarvestSection = tab:AddCollapsibleSection("Harvest", false)
	HarvestSection:AddToggle("tgHarvestEnable", {
		Title = "Auto Harvest",
		Default = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
			table.clear(State.HarVestCropsList)
			if not Value then State.isHarvesting = false end
		end,
	})

	HarvestSection:AddDivider()

	HarvestSection:AddButton({
		Title = "Clear Selected Crops",
		Callback = function()
			Options.ddHarvestCrops:SetValue({ ALL = true })
		end,
	})
	HarvestSection:AddDropdown("ddHarvestCrops", {
		Title = "Select Crops",
		Values = UIData.PlantDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	HarvestSection:AddButton({
		Title = "Clear Backlist Crops",
		Callback = function()
			Options.ddHarvestBlackCrops:SetValue({ NONE = true })
		end,
	})
	HarvestSection:AddDropdown("ddHarvestBlackCrops", {
		Title = "Blacklist Crops",
		Values = UIData.PlantDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	HarvestSection:AddDivider()
	HarvestSection:AddButton({
		Title = "Clear Selected Mutant",
		Callback = function()
			Options.ddHarvestMutants:SetValue({ ALL = true })
		end,
	})

	HarvestSection:AddDropdown("ddHarvestMutants", {
		Title = "Select Mutants",
		Values = UIData.MutationDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	HarvestSection:AddButton({
		Title = "Clear Backlist Mutant",
		Callback = function()
			Options.ddHarvestBlackMutants:SetValue({ NONE = true })
		end,
	})

	HarvestSection:AddDropdown("ddHarvestBlackMutants", {
		Title = "Backlist Mutants",
		Values = UIData.MutationDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	HarvestSection:AddDivider()
	HarvestSection:AddDropdown("ddRipeness", {
		Title = "Ripeness Stage",
		Values = { "ALL", "Unripe", "Ripened", "Lush" },
		Default = { "Lush" },
		Multi = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	HarvestSection:AddInput("ipRipenessMulti", {
		Title = "Ripeness Multiplier",
		Default = 3,
		Numeric = false,
		Finished = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	HarvestSection:AddDropdown("ddBlackRipeness", {
		Title = "Backlist Ripeness Stage",
		Values = { "NONE", "Unripe", "Ripened", "Lush" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	HarvestSection:AddDivider()
	HarvestSection:AddDropdown("ddVariant", {
		Title = "Variant",
		Values = { "ALL", "Silver", "Gold" },
		Default = { "ALL" },
		Multi = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	HarvestSection:AddDropdown("ddBlackVariant", {
		Title = "Backlist Variant",
		Values = { "NONE", "Silver", "Gold" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	HarvestSection:AddDivider()
	HarvestSection:AddDropdown("ddWeight", {
		Title = "Weight",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	HarvestSection:AddInput("ipWeight", {
		Title = "Weight",
		Default = 0,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	-- 3. Sell Section
	local SellSection = tab:AddCollapsibleSection("Sell", false)
	SellSection:AddToggle("tgSellCropsEnable", {
		Title = "Sell",
		Default = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
end

return MainTab
