local MainTab = {}

local Interface
local Tabs
local Options
local QuickSave
local sData
local fVar
local Main
--local actionQueue
local TaskPlantsSeeds, TaskHarvestCrops
function MainTab.Initialize(reg)
	Interface = reg.Interface
	Tabs = reg.Tabs
	Options = reg.Options
	QuickSave = reg.Window.QuickSave
	sData = reg.sData
	fVar = reg.fVar
	Main = reg.Main
	--actionQueue = reg.fVar.actionQueue
	Tabs.Main = Interface:AddTab({ Title = "Main", Icon = "rbxassetid://10723345661" })
	local PlantsSection = Tabs.Main:AddCollapsibleSection("Plants", false)
	PlantsSection:AddToggle("tgPlantsEnable", {
		Title = "Auto Plants",
		Default = false,
		Callback = function(Value)
			if Value then
				TaskPlantsSeeds = task.spawn(function()
					while task.wait(30) do
						Main.AutoPlantsSeeds()
					end
				end)
			else
				task.cancel(TaskPlantsSeeds)
			end
			QuickSave()
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
		Values = sData.PlantDataTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	PlantsSection:AddDropdown("ddPlantsPos", {
		Title = "Select Plants Position",
		Values = { "Player", "Random", "Here" },
		Default = "Player",
		Callback = function(Value)
			QuickSave()
		end,
	})

	-- ==============================
	-- Harvest Section
	-- ==============================
	local HarvestSection = Tabs.Main:AddCollapsibleSection("Harvest", false)
	HarvestSection:AddToggle("tgHarvestEnable", {
		Title = "Auto Harvest",
		Default = false,
		Callback = function(Value)
			if Value then
				TaskHarvestCrops = task.spawn(function()
					while task.wait(0.1) do
						if #reg.HarVestCropsList > 0 then
							if not fVar.isHarvesting then Main.HarvestCrops() end
						else
							Main.ScanCrops()
						end
					end
				end)
			else
				task.cancel(TaskHarvestCrops)
			end
			QuickSave()
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
		Values = sData.PlantDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
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
		Values = sData.PlantDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
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
		Values = sData.MutationDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
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
		Values = sData.MutationDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	HarvestSection:AddDivider()
	HarvestSection:AddDropdown("ddRipeness", {
		Title = "Ripeness Stage",
		Values = { "ALL", "Unripe", "Ripened", "Lush" },
		Default = { "Lush" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	HarvestSection:AddInput("ipRipenessMulti", {
		Title = "Ripeness Multiplier",
		Default = 3,
		Numeric = false,
		Finished = false,
		Callback = function(Value)
			QuickSave()
		end,
	})

	HarvestSection:AddDropdown("ddBlackRipeness", {
		Title = "Backlist Ripeness Stage",
		Values = { "NONE", "Unripe", "Ripened", "Lush" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	HarvestSection:AddDivider()
	HarvestSection:AddDropdown("ddVariant", {
		Title = "Variant",
		Values = { "ALL", "Silver", "Gold" },
		Default = { "ALL" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	HarvestSection:AddDropdown("ddBlackVariant", {
		Title = "Backlist Variant",
		Values = { "NONE", "Silver", "Gold" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	HarvestSection:AddDivider()
	HarvestSection:AddDropdown("ddWeight", {
		Title = "Weight",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
	HarvestSection:AddInput("ipWeight", {
		Title = "Weight",
		Default = 0,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	-- ==============================
	-- Sell Section
	-- ==============================
	local SellSection = Tabs.Main:AddCollapsibleSection("Sell", false)
	SellSection:AddToggle("tgSellCropsEnable", {
		Title = "Sell",
		Default = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
end
return MainTab
