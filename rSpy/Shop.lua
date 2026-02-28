--!nocheck
--เงิน
game:GetService("Players").LocalPlayer.leaderstats.Shillings (.Value)


workspace.MapPhysical.Shops["Seed Shop"]   176.5, 206.611084, 678.71167, 1, 0, 0, 0, 1, 0, 0, 0, 1
Current Pos: CFrame.new(176.70, 205.49, 672.00)

workspace.MapPhysical.Shops["Gear Shop"] 
Current Pos: CFrame.new(212.47, 205.50, 606.06)

workspace.MapPhysical.Shops["Sell Stand"]
Current Pos: CFrame.new(149.40, 205.51, 672.00)

WorldPovot


local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
Character:PivotTo(CFrame.new(217.811676, 206.661087, 608.700012))

--SeedShop
local args = {
	"SeedShop",
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("GetShopData"):InvokeServer(unpack(args))
--[[
📋 Script initialized successfully.
  [Items] : (Table)
    [Carrot Seed] : (Table)
      [MaxAmount] : 13
      [Amount] : 13
    [Corn Seed] : (Table)
      [MaxAmount] : 2
      [Amount] : 2
  [Seed] : 5907494

  
  [Items] : (Table)
	[Carrot Seed] : (Table)
	  [MaxAmount] : 14
	  [Amount] : 13
	[Strawberry Seed] : (Table)
	  [MaxAmount] : 2
	  [Amount] : 2
	[Cabbage Seed] : (Table)
	  [MaxAmount] : 3
	  [Amount] : 3
	[Corn Seed] : (Table)
	  [MaxAmount] : 1
	  [Amount] : 1
	[Banana Seed] : (Table)
	  [MaxAmount] : 2
	  [Amount] : 2
	[Apple Seed] : (Table)
	  [MaxAmount] : 2
	  [Amount] : 2
	[Tomato Seed] : (Table)
	  [MaxAmount] : 1
	  [Amount] : 1
  [Seed] : 5907500
]]

local args = {
	"SeedShop",
	"Carrot Seed",
}
game:GetService("ReplicatedStorage")
	:WaitForChild("RemoteEvents")
	:WaitForChild("PurchaseShopItem")
	:InvokeServer(unpack(args))

--Sell

local args = {
	"SellSingle",
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SellItems"):InvokeServer(unpack(args))

local args = {
	"SellAll",
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("SellItems"):InvokeServer(unpack(args))


--Gear Shop
local args = {
	"GearShop"
}
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("GetShopData"):InvokeServer(unpack(args))


--Quests
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestQuests"):FireServer()
