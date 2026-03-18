local Shop = {}
local reg
local fVar

local RemoteEvents = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents")
local PurchaseShopItem = RemoteEvents:WaitForChild("PurchaseShopItem") :: RemoteFunction

function Shop.Initialize(Registry)
	reg = Registry
	fVar = reg.fVar
end

function Shop.AutoBuyItem(ShopType, Items, DropdownValue)
	local GetSelectedItems = reg.Utils.GetSelectedItems
	local SafeTeleport = reg.Utils.SafeTeleport

	local Pos = fVar.Pos
	local MySpawnPoint = reg.MySpawnPoint
	if not Items then return end
	fVar.HarvestPause = true
	if ShopType == "SeedShop" then
		fVar.isBuyingSeed = true
	else
		fVar.isBuyingGear = true
	end

	local BuyList = GetSelectedItems(DropdownValue)
	SafeTeleport(Pos[ShopType])
	task.wait(0.5)

	for Name, itemData in pairs(Items) do
		if table.find(BuyList, "ALL") or table.find(BuyList, Name) then
			for i = 1, tonumber(itemData.Amount) or 0 do
				PurchaseShopItem:InvokeServer(ShopType, Name)
				task.wait(0.2)
			end
		end
	end

	SafeTeleport(MySpawnPoint)
	task.wait(1)
	if ShopType == "SeedShop" then
		fVar.isBuyingSeed = false
	else
		fVar.isBuyingGear = false
	end
	fVar.HarvestPause = false
	task.wait(0.2)
end

function Shop.AutoBuySeed(Items)
	local Options = reg.Options
	if not Options.tgBuySeedEnable.Value then return end
	Shop.AutoBuyItem("SeedShop", Items, Options.ddBuySeeds.Value)
end

function Shop.AutoBuyGear(Items)
	local Options = reg.Options
	if not Options.tgBuyGearEnable.Value then return end
	Shop.AutoBuyItem("GearShop", Items, Options.ddBuyGear.Value)
end
return Shop
