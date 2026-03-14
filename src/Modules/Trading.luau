--!nocheck
local Trading = {}
local Registry = nil
local State = nil
local Utils = nil
local Network = nil
local Constants = nil

local Players = game:GetService("Players")
local _LocalPlayer = Players.LocalPlayer

local Options = nil

function Trading.Initialize(reg)
	Registry = reg
	State = reg.State
	Utils = reg.Utils
	Network = reg.Network
	Constants = reg.Constants
end

function Trading.SetOptions(opts)
	Options = opts
end

function Trading.AutoBuySeed(itemList)
	if State.HarvestPause or State.isProcessing or State.isBuyingSeed or not Options.tgBuySeedEnable.Value then return end

	local targets = Utils.GetSelectedItems(Options.ddBuySeeds.Value)
	if #targets == 0 then return end

	State.isBuyingSeed = true
	Utils.SafeTeleport(Constants.Pos.SeedShop)
	task.wait(0.5)

	for _, item in ipairs(itemList) do
		if table.find(targets, item.Name) then
			Network.Functions.PurchaseShopItem:InvokeServer("SeedShop", item.Uuid, 1)
			task.wait(0.1)
		end
	end
	State.isBuyingSeed = false
end

function Trading.AutoBuyGear(itemList)
	if State.HarvestPause or State.isProcessing or State.isBuyingGear or not Options.tgBuyGearEnable.Value then return end

	local targets = Utils.GetSelectedItems(Options.ddBuyGear.Value)
	if #targets == 0 then return end

	State.isBuyingGear = true
	Utils.SafeTeleport(Constants.Pos.GearShop)
	task.wait(0.5)

	for _, item in ipairs(itemList) do
		if table.find(targets, item.Name) then
			Network.Functions.PurchaseShopItem:InvokeServer("GearShop", item.Uuid, 1)
			task.wait(0.1)
		end
	end
	State.isBuyingGear = false
end

function Trading.AutoSell(items)
	if State.HarvestPause or State.isProcessing or not Options.tgSellCropsEnable.Value then return end
	
	Utils.SafeTeleport(Constants.Pos.Sell)
	task.wait(0.3)
	
	Network.Functions.SellItems:InvokeServer("SellAll")
	task.wait(1)
	Utils.SafeTeleport(State.MySpawnPoint)
	task.wait(0.3)
	State.HarvestPause = false
end

return Trading
