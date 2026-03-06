--!nocheck
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestQuests"):FireServer()

game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestQuests").OnClientEvent:Connect(function(QuestData)
ShowData(QuestData)
end)



-- 1. คำสั่งส่งคำร้องขอข้อมูลเควสไปยัง Server
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("RequestQuests"):FireServer()

-- 2. คำสั่งรอรับข้อมูลเควสที่ Server อัปเดตและส่งกลับมาให้ Client
game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("UpdateQuests").OnClientEvent:Connect(function(QuestData)
    print("ได้รับข้อมูลเควสเรียบร้อย:", QuestData)
    
    -- ตรงนี้พี่เอฟสามารถเขียนโค้ดเพื่อนำ QuestData ไปใช้งานต่อได้เลยค่ะ
    -- เช่น โยนค่าไปแสดงผลบน UI
end)



📋 Script initialized successfully.
  [Weekly] : (Table)
    [ResetCounts] : (Table)
      [1] : 0
      [3] : 0
      [2] : 1
      [5] : 0
      [4] : 0
    [WeekId] : 2930
    [Active] : (Table)
      [1] : (Table)
        [Type] : HarvestCrops
        [Description] : Harvest 50 Strawberries
        [Progress] : 50
        [AssignedAt] : 1772611143
        [CompletedAt] : 1772632285
        [Goal] : 50
        [TargetItem] : Strawberry
        [RewardType] : Shillings
        [RewardAmount] : 12000
        [SessionId] : 8de43081-4d07-4660-a126-09cbcaf7d7c7
        [Claimed] : true
      [3] : (Table)
        [Type] : HarvestCrops
        [Description] : Harvest 100 Corn
        [Progress] : 100
        [AssignedAt] : 1772611143
        [RewardType] : SeedPack
        [CompletedAt] : 1772633017
        [Claimed] : true
        [RewardItem] : Gardener Seed Pack
        [TargetItem] : Corn
        [RewardAmount] : 2
        [SessionId] : 9016e2d3-7a36-4d63-8984-dfc1f7cda08e
        [Goal] : 100
      [2] : (Table)
        [Type] : PlantSeeds
        [Description] : Plant 30 Onion Seeds
        [Progress] : 30
        [AssignedAt] : 1772725439
        [RewardType] : SeedPack
        [CompletedAt] : 1772725520
        [Claimed] : true
        [RewardItem] : Gardener Seed Pack
        [TargetItem] : Onion
        [RewardAmount] : 3
        [SessionId] : 75e37b55-b756-4e84-93f3-7c6e8fde1c79
        [Goal] : 30
      [5] : (Table)
        [Type] : HarvestCrops
        [Description] : Harvest 15 Apples
        [Progress] : 15
        [AssignedAt] : 1772611143
        [RewardType] : SeedPack
        [CompletedAt] : 1772631853
        [Claimed] : true
        [RewardItem] : Dawn Seed Pack
        [TargetItem] : Apple
        [RewardAmount] : 1
        [SessionId] : e6033d46-46df-492a-b9a3-2f508d427c9a
        [Goal] : 15
      [4] : (Table)
        [Type] : PlantSeeds
        [Description] : Plant 25 Strawberry Seeds
        [Progress] : 0
        [AssignedAt] : 1772611143
        [RewardType] : SeedPack
        [Goal] : 25
        [RewardItem] : Gardener Seed Pack
        [TargetItem] : Strawberry
        [RewardAmount] : 2
        [Claimed] : false
        [SessionId] : 0564d895-38fd-4a16-bbdd-c3fb72d75bff
  [Daily] : (Table)
    [DayId] : 20518
    [ResetCounts] : (Table)
      [1] : 0
      [3] : 0
      [2] : 0
      [5] : 0
      [4] : 0
    [Active] : (Table)
      [1] : (Table)
        [Type] : HarvestCrops
        [Description] : Harvest 4 Roses
        [Progress] : 4
        [AssignedAt] : 1772762664
        [RewardType] : SeedPack
        [CompletedAt] : 1772763424
        [Claimed] : false
        [RewardItem] : Dawn Seed Pack
        [TargetItem] : Rose
        [RewardAmount] : 1
        [SessionId] : 852f32a9-4a4d-479d-a1d3-c03c5cd3f898
        [Goal] : 4
      [3] : (Table)
        [Type] : PlantSeeds
        [Description] : Plant 8 Corn Seeds
        [Progress] : 0
        [AssignedAt] : 1772762664
        [RewardType] : Shillings
        [Goal] : 8
        [TargetItem] : Corn
        [RewardAmount] : 1500
        [Claimed] : false
        [SessionId] : 2bfc7bab-44a8-40f5-9fee-30a757d36e60
      [2] : (Table)
        [Type] : HarvestCrops
        [Description] : Harvest 10 Mushrooms
        [Progress] : 10
        [AssignedAt] : 1772762664
        [CompletedAt] : 1772763381
        [Goal] : 10
        [TargetItem] : Mushroom
        [RewardType] : Shillings
        [RewardAmount] : 3000
        [SessionId] : 61a41681-cb82-4ca9-b5de-813fa6d9aa11
        [Claimed] : false
      [5] : (Table)
        [Type] : HarvestCrops
        [Description] : Harvest 4 Apples
        [Progress] : 4
        [AssignedAt] : 1772762664
        [RewardType] : SeedPack
        [CompletedAt] : 1772763341
        [Claimed] : false
        [RewardItem] : Dawn Seed Pack
        [TargetItem] : Apple
        [RewardAmount] : 1
        [SessionId] : ad94d8bb-b233-4836-8f66-ff9a6202b38c
        [Goal] : 4
      [4] : (Table)
        [Type] : PlantSeeds
        [Description] : Plant 1 Apple Seed
        [Progress] : 0
        [AssignedAt] : 1772762664
        [RewardType] : SeedPack
        [Goal] : 1
        [RewardItem] : Dawn Seed Pack
        [TargetItem] : Apple
        [RewardAmount] : 1
        [Claimed] : false
        [SessionId] : 4903c675-31ea-4b91-93cf-15c279287469


        local Weekly = QuestData.Weekly.Active
        local Daily = QuestData.Daily.Active