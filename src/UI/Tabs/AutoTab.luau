local AutoTab = {}
local reg
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local TaskRemovePlants, TaskRemoveFruit

function AutoTab.Initialize(registry)
	reg = registry
	local Interface = reg.Interface
	local Tabs = reg.Tabs
	local Options = reg.Options
	local QuickSave = reg.Window.QuickSave
	local sData = reg.sData
	local Auto = reg.Auto
	local fVar = reg.fVar

	Tabs.Auto = Interface:AddTab({ Title = "Automatic", Icon = "bot" })

	-- [[ Quest Section ]]
	local QuestSection = Tabs.Auto:AddCollapsibleSection("Quest", false)
	QuestSection:AddToggle("tgQuestEnable", {
		Title = "Auto Claim Quest",
		Default = false,
		Callback = function(Value)
			if Value then RemoteEvents:WaitForChild("RequestQuests"):FireServer() end
			QuickSave()
		end,
	})

	-- [[ Remove Plants Section ]]
	local RemoveSection = Tabs.Auto:AddCollapsibleSection("Remove Plants", false)
	RemoveSection:AddToggle("tgRemovePlantsEnable", {
		Title = "Auto Remove Plants",
		Default = false,
		Callback = function(Value)
			if Value then
				TaskRemovePlants = task.spawn(function()
					while true do
						if not fVar.isRemovingPlants then Auto.RemovePlants() end
						task.wait(0.5)
					end
				end)
			else
				if TaskRemovePlants then
					task.cancel(TaskRemovePlants)
					TaskRemovePlants = nil
				end
				fVar.isRemovePlants = false
			end
			QuickSave()
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
		Values = sData.PlantDataTable,
		Default = {},
		Multi = true,
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	RemoveSection:AddDropdown("ddRemovePlantsScale", {
		Title = "Plants Scale Threshold",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
	RemoveSection:AddInput("ipRemovePlantsScale", {
		Title = "Plants Scale",
		Default = 0,
		Numeric = true,
		Finished = false,
		Callback = function(Value)
			QuickSave()
		end,
	})

	-- [[ Remove Fruit Section ]]
	local RemoveFruitSection = Tabs.Auto:AddCollapsibleSection("Remove Fruit", false)
	RemoveFruitSection:AddToggle("tgRemoveFruitEnable", {
		Title = "Auto Remove Fruit",
		Default = false,
		Callback = function(Value)
			if Value then
				TaskRemoveFruit = task.spawn(function()
					while true do
						if not fVar.isRemovePlants then Auto.RemoveCrops() end
						task.wait(0.5)
					end
				end)
			else
				if TaskRemoveFruit then
					task.cancel(TaskRemoveFruit)
					TaskRemoveFruit = nil
				end
				fVar.isRemoveCrops = false
			end
			QuickSave()
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
		Values = sData.PlantDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
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
		Values = sData.PlantDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
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
		Values = sData.MutationDataTable,
		Multi = true,
		Default = { "ALL" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
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
		Values = sData.MutationDataBlackTable,
		Multi = true,
		Default = { "NONE" },
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddDropdown("ddRemoveRipeness", {
		Title = "Ripeness Stage",
		Values = { "ALL", "Unripe", "Ripened", "Lush" },
		Default = { "ALL" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	RemoveFruitSection:AddInput("ipRemoveRipenessMulti", {
		Title = "Ripeness Multiplier",
		Default = 0,
		Numeric = false,
		Finished = false,
		Callback = function(Value)
			QuickSave()
		end,
	})

	RemoveFruitSection:AddDropdown("ddRemoveBlackRipeness", {
		Title = "Backlist Ripeness Stage",
		Values = { "NONE", "Unripe", "Ripened", "Lush" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddDropdown("ddRemoveVariant", {
		Title = "Variant",
		Values = { "ALL", "Silver", "Gold" },
		Default = { "ALL" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	RemoveFruitSection:AddDropdown("ddRemoveBlackVariant", {
		Title = "Backlist Variant",
		Values = { "NONE", "Silver", "Gold" },
		Default = { "NONE" },
		Multi = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddDropdown("ddRemoveWeight", {
		Title = "Weight",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
	RemoveFruitSection:AddInput("ipRemoveWeight", {
		Title = "Weight",
		Default = 0,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	RemoveFruitSection:AddDivider()
	RemoveFruitSection:AddDropdown("ddRemoveScale", {
		Title = "Scale",
		Values = { "Below", "Above" },
		Default = "Below",
		Multi = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
	RemoveFruitSection:AddInput("ipRemoveScale", {
		Title = "Scale",
		Default = 0,
		Numeric = true,
		Finished = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
	local OpenPackSection = Tabs.Auto:AddCollapsibleSection("Open Pack", false)
	OpenPackSection:AddToggle("tgOpenPackAnimation", {
		Title = "Disable Animation",
		Default = false,
		Callback = function(Value)
			if Value then
				pcall(function()
					Auto.disablePackAnimations()
				end)
			else
				pcall(function()
					Auto.enablePackAnimations()
				end)
			end
			--QuickSave()
		end,
	})

	Options.tgOpenPackAnimation:SetValue(false)
	-- toggle enable
	OpenPackSection:AddToggle("tgOpenPackEnable", {
		Title = "Auto Open Pack",
		Default = false,
		Callback = function(Value)
			if Value then
				fVar.LockDownControlVar()
				Auto.OpenPack()
				fVar.ResetControlVar()
			else
				fVar.ResetControlVar()
			end
			QuickSave()
		end,
	})
	-- dropdown select seed pack
	OpenPackSection:AddDropdown("ddOpenPackSelect", {
		Title = "Select Seed Pack",
		Values = sData.SeedPackTable,
		Default = { "ALL" },
		Multi = true,
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
end

return AutoTab
