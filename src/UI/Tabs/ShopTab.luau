--!nocheck
local ShopTab = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShopData = ReplicatedStorage.Shop.ShopData
local Network = require(script.Parent.Parent.Parent.Core.Network)
local Trading = require(script.Parent.Parent.Parent.Modules.Trading)

local function getShopData(path)
	local names = { "ALL" }
	local success, data = pcall(function() return require(ShopData[path]) end)
	if success and data and data.ShopData then
		for _, item in pairs(data.ShopData) do
			table.insert(names, item.Name)
		end
	end
	return names
end

function ShopTab.Setup(tab, Options, SaveManager)
	local SeedShopTable = getShopData("SeedShopData")
	local GearShopTable = getShopData("GearShopData")

	-- Buy Seeds
	local BuySeedSection = tab:AddCollapsibleSection("Buy Seed", false)
	BuySeedSection:AddToggle("tgBuySeedEnable", {
		Title = "Auto Buy Seed",
		Default = false,
		Callback = function(Value)
			if Value then
				local SeedShop = Network.Functions.GetShopData:InvokeServer("SeedShop")
				if SeedShop then table.insert(require(script.Parent.Parent.Parent.Core.State).actionQueue, { FuncName = Trading.AutoBuySeed, args = SeedShop.Items }) end
			end
			SaveManager:Save("Horizons")
		end,
	})
	
	BuySeedSection:AddDropdown("ddBuySeeds", {
		Title = "Select Seeds",
		Values = SeedShopTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})

	-- Buy Gears
	local BuyGearSection = tab:AddCollapsibleSection("Buy Gear", false)
	BuyGearSection:AddToggle("tgBuyGearEnable", {
		Title = "Auto Buy Gear",
		Default = false,
		Callback = function(Value)
			if Value then
				local GearShop = Network.Functions.GetShopData:InvokeServer("GearShop")
				if GearShop then table.insert(require(script.Parent.Parent.Parent.Core.State).actionQueue, { FuncName = Trading.AutoBuyGear, args = GearShop.Items }) end
			end
			SaveManager:Save("Horizons")
		end,
	})

	BuyGearSection:AddDropdown("ddBuyGear", {
		Title = "Select Gears",
		Values = GearShopTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})
end

return ShopTab
