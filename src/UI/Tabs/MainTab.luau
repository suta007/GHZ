local MainTab = {}

local Interface
local Tabs
local Options
local QuickSave
local sData
local fVar
local Main
local actionQueue
local TaskPlantsSeeds, TaskHarvestCrops
function MainTab.Initialize(reg)
	Interface = reg.Interface
	Tabs = reg.Tabs
	Options = reg.Options
	QuickSave = reg.Window.QuickSave
	sData = reg.sData
	fVar = reg.fVar
	Main = reg.Main
	actionQueue = reg.fVar.actionQueue
	Tabs.Main = Interface:AddTab({ Title = "Main", Icon = "dices" })
	local PlantsSection = Tabs.Main:AddCollapsibleSection("Plants", false)
	PlantsSection:AddToggle("tgPlantsEnable", {
		Title = "Auto Plants",
		Default = false,
		Callback = function(Value)
			if Value then
				TaskPlantsSeeds = task.spawn(function()
					while true do
						if not fVar.isPlanting then Main.AutoPlantsSeeds() end
						task.wait(30)
					end
				end)
			else
				if TaskPlantsSeeds then
					task.cancel(TaskPlantsSeeds)
					TaskPlantsSeeds = nil
				end
				fVar.isPlanting = false
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
					while task.wait(0.3) do
						if not fVar.isHarvesting and not fVar.HarvestPause then
							if #reg.HarVestCropsList > 0 then
								Main.HarvestCrops()
							else
								Main.ScanCrops2()
							end
						elseif fVar.HarvestPause then
							if #reg.HarVestCropsList > 0 then table.clear(reg.HarVestCropsList) end
						end
					end
				end)
			else
				if TaskHarvestCrops then
					task.cancel(TaskHarvestCrops)
					TaskHarvestCrops = nil
					table.clear(reg.HarVestCropsList)
				end
				fVar.isHarvesting = false
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
			--[[ 			if Value then
				local data = { FuncName = Main.AutoSellCrops, Args = {} }
				table.insert(actionQueue, data)
			end ]]
			QuickSave()
		end,
	})
	--Sell All Toggle
	SellSection:AddToggle("tgSellAllCropsEnable", {
		Title = "Sell All Crops",
		Default = false,
		Callback = function(Value)
			QuickSave()
		end,
	})

	SellSection:AddDivider()

	SellSection:AddButton({
		Title = "Clear Sell Crops",
		Callback = function()
			Options.ddSellCrops:SetValue({ ALL = true })
		end,
	})
	SellSection:AddDropdown("ddSellCrops", {
		Title = "Select Crops to Sell",
		Values = sData.PlantDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	SellSection:AddButton({
		Title = "Clear Blacklist Crops",
		Callback = function()
			Options.ddSellBlackCrops:SetValue({ NONE = true })
		end,
	})
	SellSection:AddDropdown("ddSellBlackCrops", {
		Title = "Blacklist Crops",
		Values = sData.PlantDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	SellSection:AddDivider()
	SellSection:AddDropdown("ddSellRipeness", {
		Title = "Ripeness Stage",
		Values = { "ALL", "Unripe", "Ripened", "Lush" },
		Default = { "ALL" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	SellSection:AddDropdown("ddSellBlackRipeness", {
		Title = "Blacklist Ripeness Stage",
		Values = { "NONE", "Unripe", "Ripened", "Lush" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	SellSection:AddDivider()
	SellSection:AddButton({
		Title = "Clear Selected Mutant",
		Callback = function()
			Options.ddSellMutants:SetValue({ ALL = true })
		end,
	})
	SellSection:AddDropdown("ddSellMutants", {
		Title = "Select Mutants",
		Values = sData.MutationDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	SellSection:AddButton({
		Title = "Clear Blacklist Mutant",
		Callback = function()
			Options.ddSellBlackMutants:SetValue({ NONE = true })
		end,
	})
	SellSection:AddDropdown("ddSellBlackMutants", {
		Title = "Blacklist Mutants",
		Values = sData.MutationDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	SellSection:AddDivider()
	SellSection:AddDropdown("ddSellWeight", {
		Title = "Weight Filter",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
	SellSection:AddInput("ipSellWeight", {
		Title = "Weight Value",
		Default = 0,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	SellSection:AddDivider()
	SellSection:AddDropdown("ddSellValue", {
		Title = "Value (Price) Filter",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
	SellSection:AddInput("ipSellValue", {
		Title = "Price Value",
		Default = 0,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	SellSection:AddSpacer(10)
end
return MainTab
