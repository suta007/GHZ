--!nocheck
local Trading = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local State = require(script.Parent.Parent.Core.State)
local Utils = require(script.Parent.Parent.Core.Utils)
local Network = require(script.Parent.Parent.Core.Network)
local Constants = require(script.Parent.Parent.Core.Constants)

local Options = {}

function Trading.SetOptions(opts)
	Options = opts
end

local function GetSelectedItems(DropdownValue)
	local Items = {}
	if type(DropdownValue) == "table" then
		for Value, State in pairs(DropdownValue) do
			if State then table.insert(Items, Value) end
		end
	end
	return Items
end

function Trading.AutoSellCrops()
	if not (Options.tgSellCropsEnable.Value or Options.tgNewAutoSell.Value) then return end
	Utils.SafeTeleport(Constants.Pos.Sell)
	task.wait(0.3)
	Network.Functions.SellItems:InvokeServer("SellAll")
	task.wait(1)
	Utils.SafeTeleport(State.MySpawnPoint)
	task.wait(0.3)
	State.HarvestPause = false
end

function Trading.AutoBuyItem(ShopType, Items, DropdownValue)
	if not Items then return end
	if ShopType == "SeedShop" then
		State.isBuyingSeed = true
	else
		State.isBuyingGear = true
	end

	local BuyList = GetSelectedItems(DropdownValue)
	Utils.SafeTeleport(Constants.Pos[ShopType])
	task.wait(0.5)

	for Name, itemData in pairs(Items) do
		if table.find(BuyList, "ALL") or table.find(BuyList, Name) then
			for i = 1, tonumber(itemData.Amount) do
				Network.Functions.PurchaseShopItem:InvokeServer(ShopType, Name)
				task.wait(0.2)
			end
		end
	end

	Utils.SafeTeleport(State.MySpawnPoint)
	task.wait(1)
	
	if ShopType == "SeedShop" then
		State.isBuyingSeed = false
	else
		State.isBuyingGear = false
	end
	
	State.HarvestPause = false
	task.wait(0.2)
end

function Trading.AutoBuySeed(Items)
	if not Options.tgBuySeedEnable.Value then return end
	Trading.AutoBuyItem("SeedShop", Items, Options.ddBuySeeds.Value)
end

function Trading.AutoBuyGear(Items)
	if not Options.tgBuyGearEnable.Value then return end
	Trading.AutoBuyItem("GearShop", Items, Options.ddBuyGear.Value)
end

return Trading
