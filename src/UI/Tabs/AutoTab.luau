--!nocheck
local AutoTab = {}

function AutoTab.Setup(tab, Options, SaveManager, Registry)
	local UIData = Registry.UIData
	local Network = Registry.Network

	-- 1. Quest Section
	local QuestSection = tab:AddCollapsibleSection("Quest", false)
	QuestSection:AddToggle("tgQuestEnable", {
		Title = "Auto Claim Quest",
		Default = false,
		Callback = function(Value)
			if Value then
				Network.Events.RequestQuests:FireServer()
			end
			SaveManager:Save("Horizons")
		end,
	})

	-- 2. Remove Plants Section
	local RemoveSection = tab:AddCollapsibleSection("Remove Plants", false)
	RemoveSection:AddToggle("tgRemovePlantsEnable", {
		Title = "Auto Remove Plants",
		Default = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	RemoveSection:AddButton({
		Title = "Clear Selected Plants",
		Callback = function()
			Options.ddRemovePlants:SetValue({})
		end,
	})
	RemoveSection:AddDropdown("ddRemovePlants", {
		Title = "Select Remove Plants",
		Values = UIData.PlantDataTable,
		Default = {},
		Multi = true,
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	RemoveSection:AddDropdown("ddRemovePlantsScale", {
		Title = "Plants Scale Threshold",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	RemoveSection:AddInput("ipRemovePlantsScale", {
		Title = "Plants Scale",
		Default = 0,
		Numeric = true,
		Finished = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	-- 3. Remove Fruit Section
	local RemoveFruitSection = tab:AddCollapsibleSection("Remove Fruit", false)
	RemoveFruitSection:AddToggle("tgRemoveFruitEnable", {
		Title = "Auto Remove Fruit",
		Default = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	RemoveFruitSection:AddDivider()

	RemoveFruitSection:AddButton({
		Title = "Clear Selected Remove Crops",
		Callback = function()
			Options.ddRemoveCrops:SetValue({ ALL = true })
		end,
	})
	RemoveFruitSection:AddDropdown("ddRemoveCrops", {
		Title = "Select Remove Crops",
		Values = UIData.PlantDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	RemoveFruitSection:AddButton({
		Title = "Clear Backlist Remove Crops",
		Callback = function()
			Options.ddRemoveBlackCrops:SetValue({ NONE = true })
		end,
	})
	RemoveFruitSection:AddDropdown("ddRemoveBlackCrops", {
		Title = "Blacklist Remove Crops",
		Values = UIData.PlantDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddButton({
		Title = "Clear Selected Mutant",
		Callback = function()
			Options.ddRemoveMutants:SetValue({ ALL = true })
		end,
	})

	RemoveFruitSection:AddDropdown("ddRemoveMutants", {
		Title = "Select Mutants",
		Values = UIData.MutationDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	RemoveFruitSection:AddButton({
		Title = "Clear Backlist Mutant",
		Callback = function()
			Options.ddRemoveBlackMutants:SetValue({ NONE = true })
		end,
	})

	RemoveFruitSection:AddDropdown("ddRemoveBlackMutants", {
		Title = "Backlist Mutants",
		Values = UIData.MutationDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddDropdown("ddRemoveRipeness", {
		Title = "Ripeness Stage",
		Values = { "ALL", "Unripe", "Ripened", "Lush" },
		Default = { "ALL" },
		Multi = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	RemoveFruitSection:AddInput("ipRemoveRipenessMulti", {
		Title = "Ripeness Multiplier",
		Default = 0,
		Numeric = false,
		Finished = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	RemoveFruitSection:AddDropdown("ddRemoveBlackRipeness", {
		Title = "Backlist Ripeness Stage",
		Values = { "NONE", "Unripe", "Ripened", "Lush" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddDropdown("ddRemoveVariant", {
		Title = "Variant",
		Values = { "ALL", "Silver", "Gold" },
		Default = { "ALL" },
		Multi = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	RemoveFruitSection:AddDropdown("ddRemoveBlackVariant", {
		Title = "Backlist Variant",
		Values = { "NONE", "Silver", "Gold" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddDropdown("ddRemoveWeight", {
		Title = "Weight",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	RemoveFruitSection:AddInput("ipRemoveWeight", {
		Title = "Weight",
		Default = 0,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddDropdown("ddRemoveScale", {
		Title = "Scale",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
	RemoveFruitSection:AddInput("ipRemoveScale", {
		Title = "Scale",
		Default = 0,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
end

return AutoTab
