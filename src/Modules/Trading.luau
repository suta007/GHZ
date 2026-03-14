--!nocheck
local Trading = {}
local Registry = nil
local State = nil
local Utils = nil
local Network = nil
local Constants = nil

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Options = {}

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
	if not Options.ddBuySeed or not Options.tgBuySeedEnable.Value then return end
	local targets = Options.ddBuySeed.Value
	if #targets == 0 then return end

	Utils.SafeTeleport(Constants.Pos.SeedShop)
	task.wait(0.5)

	for _, item in ipairs(itemList) do
		if targets[item.Name] then
			Network.Functions.PurchaseShopItem:InvokeServer("SeedShop", item.Uuid, 1)
			task.wait(0.1)
		end
	end
end

function Trading.AutoBuyGear(itemList)
	if not Options.ddBuyGear or not Options.tgBuyGearEnable.Value then return end
	local targets = Options.ddBuyGear.Value
	if #targets == 0 then return end

	Utils.SafeTeleport(Constants.Pos.GearShop)
	task.wait(0.5)

	for _, item in ipairs(itemList) do
		if targets[item.Name] then
			Network.Functions.PurchaseShopItem:InvokeServer("GearShop", item.Uuid, 1)
			task.wait(0.1)
		end
	end
end

function Trading.AutoSell(items)
	if not Options.tgSellEnable.Value or not items or #items == 0 then return end
	
	Utils.SafeTeleport(Constants.Pos.Sell)
	task.wait(0.5)
	
	Network.Functions.SellItems:InvokeServer(items)
	task.wait(1)
end

return Trading
