--!nocheck
local ShopTab = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShopData = ReplicatedStorage.Shop.ShopData

function ShopTab.Setup(tab, Options, SaveManager, Registry)
	local Network = Registry.Network
	local Trading = Registry.Trading

	-- Seed Shop Section
	local SeedSection = tab:AddCollapsibleSection("Seed Shop", false)
	SeedSection:AddToggle("tgBuySeedEnable", { 
		Title = "Auto Buy Seeds", 
		Default = false,
		Callback = function(Value)
			if Value then
				local SeedShop = Network.Functions.GetShopData:InvokeServer("SeedShop")
				if SeedShop then table.insert(Registry.State.actionQueue, { FuncName = Trading.AutoBuySeed, args = SeedShop.Items }) end
			end
			SaveManager:Save("Horizons")
		end,
	})

	-- Gear Shop Section
	local GearSection = tab:AddCollapsibleSection("Gear Shop", false)
	GearSection:AddToggle("tgBuyGearEnable", {
		Title = "Auto Buy Gear",
		Default = false,
		Callback = function(Value)
			if Value then
				local GearShop = Network.Functions.GetShopData:InvokeServer("GearShop")
				if GearShop then table.insert(Registry.State.actionQueue, { FuncName = Trading.AutoBuyGear, args = GearShop.Items }) end
			end
			SaveManager:Save("Horizons")
		end,
	})
end

return ShopTab
