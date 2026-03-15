local ShopTab = {}
local reg

function ShopTab.Initialize(Registry)
	reg = Registry
	local Options = reg.Options
	local Interface = reg.Interface
	local Tabs = reg.Tabs
	local QuickSave = reg.QuickSave
	local sData = reg.sData

	Tabs.Shop = Interface:AddTab({ Title = "Shop", Icon = "shopping-cart" })
	local BuySeedSection = Tabs.Shop:AddCollapsibleSection("Buy Seed", false)
	BuySeedSection:AddToggle("tgBuySeedEnable", {
		Title = "Auto Buy Seed",
		Default = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
	BuySeedSection:AddButton({
		Title = "Clear Selected Seeds",
		Callback = function()
			Options.ddBuySeeds:SetValue({ ALL = true })
		end,
	})
	BuySeedSection:AddDropdown("ddBuySeeds", {
		Title = "Select Seed",
		Values = sData.SeedShopTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})

	local BuyGearSection = Tabs.Shop:AddCollapsibleSection("Buy Gear", false)
	BuyGearSection:AddToggle("tgBuyGearEnable", {
		Title = "Auto Buy Gear",
		Default = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
	BuyGearSection:AddButton({
		Title = "Clear Selected Gear",
		Callback = function()
			Options.ddBuyGear:SetValue({ ALL = true })
		end,
	})
	BuyGearSection:AddDropdown("ddBuyGear", {
		Title = "Select Gear",
		Values = sData.GearShopTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			QuickSave()
		end,
	})
end

return ShopTab
