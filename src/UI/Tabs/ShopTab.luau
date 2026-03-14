--!nocheck
local ShopTab = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShopData = ReplicatedStorage.Shop.ShopData

function ShopTab.Setup(tab, Options, SaveManager, Registry)
	local UIData = Registry.UIData
	local State = Registry.State
	local Network = Registry.Network
	local Trading = Registry.Trading

	local function tempBuySeed()
		local success, SeedShop = pcall(function() return Network.Functions.GetShopData:InvokeServer("SeedShop") end)
		if not success or not SeedShop then return end
		table.insert(State.actionQueue, {
			FuncName = Trading.AutoBuySeed,
			args = SeedShop.Items,
		})
	end

	-- 1. Seed Shop Section
	local BuySeedSection = tab:AddCollapsibleSection("Buy Seed", false)
	BuySeedSection:AddToggle("tgBuySeedEnable", {
		Title = "Auto Buy Seed",
		Default = false,
		Callback = function(Value)
			if Value then
				tempBuySeed()
			end
			SaveManager:Save("Horizons")
		end,
	})
	BuySeedSection:AddButton({
		Title = "Clear Selected Seeds",
		Callback = function()
			Options.ddBuySeeds:SetValue({})
		end,
	})
	BuySeedSection:AddDropdown("ddBuySeeds", {
		Title = "Select Seeds",
		Values = UIData.SeedShopTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	local function tempBuyGear()
		local success, GearShop = pcall(function() return Network.Functions.GetShopData:InvokeServer("GearShop") end)
		if not success or not GearShop then return end
		table.insert(State.actionQueue, {
			FuncName = Trading.AutoBuyGear,
			args = GearShop.Items,
		})
	end

	-- 2. Gear Shop Section
	local BuyGearSection = tab:AddCollapsibleSection("Buy Gear", false)
	BuyGearSection:AddToggle("tgBuyGearEnable", {
		Title = "Auto Buy Gear",
		Default = false,
		Callback = function(Value)
			if Value then
				tempBuyGear()
			end
			SaveManager:Save("Horizons")
		end,
	})

	BuyGearSection:AddButton({
		Title = "Clear Selected Gears",
		Callback = function()
			Options.ddBuyGear:SetValue({})
		end,
	})
	BuyGearSection:AddDropdown("ddBuyGear", {
		Title = "Select Gears",
		Values = UIData.GearShopTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
end

return ShopTab
