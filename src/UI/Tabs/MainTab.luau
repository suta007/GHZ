--!nocheck
local MainTab = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlantData = ReplicatedStorage.Plants.Definitions.PlantDataDefinitions
local MutationData = ReplicatedStorage.Plants.Definitions.MutationDataDefinitions

function MainTab.Setup(tab, Options, SaveManager, Registry)
	local State = Registry.State
	local Harvest = Registry.Harvest
	local Planting = Registry.Planting
	local Trading = Registry.Trading

	-- Plants Section
	local PlantSection = tab:AddCollapsibleSection("Seed Inventory", true)
	PlantSection:AddButton({
		Title = "Refresh Seeds",
		Callback = function()
			-- Logic to list seeds from player inventory
		end,
	})

	-- Harvest Section
	local HarvestSection = tab:AddCollapsibleSection("Harvest Options", true)
	HarvestSection:AddToggle("tgHarvestEnable", { Title = "Auto Harvest", Default = false })
	
	HarvestSection:AddDropdown("ddHarvestList", {
		Title = "Select Plants to Harvest",
		Values = { "All", "Wheat", "Tomato" }, -- Should be dynamic
		Multi = true,
		Default = {},
	})

	-- Sell Section
	local SellSection = tab:AddCollapsibleSection("Sell Goods", true)
	SellSection:AddToggle("tgSellEnable", { Title = "Auto Sell", Default = false })
end

return MainTab
