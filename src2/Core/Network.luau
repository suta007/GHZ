--!nocheck
local Network = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")

Network.Events = {
	ClaimQuest = RemoteEvents:WaitForChild("ClaimQuest"),
	HarvestFruit = RemoteEvents:WaitForChild("HarvestFruit"),
	PlantSeed = RemoteEvents:WaitForChild("PlantSeed"),
	RemovePlant = RemoteEvents:WaitForChild("RemovePlant"),
	RequestQuests = RemoteEvents:WaitForChild("RequestQuests"),
}

Network.Functions = {
	GetShopData = RemoteEvents:WaitForChild("GetShopData"),
	PurchaseShopItem = RemoteEvents:WaitForChild("PurchaseShopItem"),
	SellItems = RemoteEvents:WaitForChild("SellItems"),
}

return Network
