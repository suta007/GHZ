--!nocheck
local Services = {}

Services.Players = game:GetService("Players")
Services.LocalPlayer = Services.Players.LocalPlayer
Services.ReplicatedStorage = game:GetService("ReplicatedStorage")
Services.VirtualUser = game:GetService("VirtualUser")
Services.TweenService = game:GetService("TweenService")
Services.RunService = game:GetService("RunService")
Services.CollectionService = game:GetService("CollectionService")
Services.CoreGui = game:GetService("CoreGui")
Services.Lighting = game:GetService("Lighting")
Services.Terrain = workspace.Terrain

Services.RemoteEvents = Services.ReplicatedStorage:WaitForChild("RemoteEvents")
Services.GetShopData = Services.RemoteEvents:WaitForChild("GetShopData")
Services.PurchaseShopItem = Services.RemoteEvents:WaitForChild("PurchaseShopItem")
Services.PlantSeed = Services.RemoteEvents:WaitForChild("PlantSeed")
Services.HarvestFruit = Services.RemoteEvents:WaitForChild("HarvestFruit")
Services.SellItems = Services.RemoteEvents:WaitForChild("SellItems")
Services.ClaimQuest = Services.RemoteEvents:FindFirstChild("ClaimQuest")
Services.RemovePlant = Services.RemoteEvents:FindFirstChild("RemovePlant")

Services.ShopData = Services.ReplicatedStorage.Shop.ShopData
Services.PlantData = Services.ReplicatedStorage.Plants.Definitions.PlantDataDefinitions
Services.MutationData = Services.ReplicatedStorage.Plants.Definitions.MutationDataDefinitions

return Services
