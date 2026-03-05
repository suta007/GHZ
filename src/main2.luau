--!nocheck
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/FluentData/Renewed/Fluent.luau", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()
CollapsibleAddon(Fluent)

local EncodingService = game:GetService("EncodingService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local GetShopData = RemoteEvents:WaitForChild("GetShopData")
local PurchaseShopItem = RemoteEvents:WaitForChild("PurchaseShopItem")
local PlantSeed = RemoteEvents:WaitForChild("PlantSeed")
local HarvestFruit = RemoteEvents:WaitForChild("HarvestFruit")
local SellItems = RemoteEvents:WaitForChild("SellItems")

local ShopData = ReplicatedStorage.Shop.ShopData
local PlantData = ReplicatedStorage.Plants.Definitions.PlantDataDefinitions

local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local noclipConnection = nil

local IsLoading = true
local Pos = {
	GearShop = CFrame.new(211.64, 205.47, 608.18),
	SeedShop = CFrame.new(176.70, 205.49, 672.00),
	Botanist = CFrame.new(214.00, 205.47, 621.05),
	Sell = CFrame.new(149.40, 205.51, 672.00),
	Quest = CFrame.new(111.52, 205.50, 635.02),
}
local isBuyingSeed, isBuyingGear, isPlanting, isSelling = false, false, false, false
local HarVestCropsList = {}
local actionQueue = {}
local isProcessing = false
local HarvestPause = false
local isHarvesting = false

local QuickSave, GetSelectedItems, TweenToTarget, ParseFruitUuid, SetNoClip, SafeTeleport
local CheckHarvestCrops, ScanCrops, getCleanFruitName, HarvestCrops
local AutoBuySeed, AutoBuyGear, AutoPlantSeed, AutoHarvest, AutoSellCrops
local processQueue

local InitializePlotData, GetRandomPlantPosition

local RemoteNotification, RemoteReplicaSet

local RNG = Random.new()
local MyPlantableParts = {}
local MyPlot, MySpawn, MySpawnPoint

local function ShowData(tbl, indent)
	local lclIndent = indent or 0
	local spacing = string.rep("  ", lclIndent)
	if type(tbl) == "table" then
		for k, v in pairs(tbl) do
			if type(v) == "table" then
				print(spacing .. "[" .. tostring(k) .. "] : (Table)")
				ShowData(v, lclIndent + 1)
			else
				print(spacing .. "[" .. tostring(k) .. "] : " .. tostring(v))
			end
		end
	else
		print(spacing .. tostring(tbl))
	end
end

InitializePlotData = function()
	local PlotsFolder = workspace:FindFirstChild("Plots")
	if not PlotsFolder then return false end
	for _, plot in ipairs(PlotsFolder:GetChildren()) do
		local ownerVal = plot:FindFirstChild("Owner")
		if ownerVal and ownerVal.Value == LocalPlayer.Name then
			local plantableArea = plot:FindFirstChild("PlantableArea")
			MyPlot = plot
			MySpawn = MyPlot.Spawn
			MySpawnPoint = MySpawn:GetPivot()
			if plantableArea then
				table.clear(MyPlantableParts)
				for _, part in ipairs(plantableArea:GetChildren()) do
					if part:IsA("BasePart") then table.insert(MyPlantableParts, part) end
				end
				return true
			end
		end
	end
	return false
end

InitializePlotData()

GetRandomPlantPosition = function()
	if #MyPlantableParts == 0 then
		if not InitializePlotData() then return nil end
	end
	local targetPart = MyPlantableParts[math.random(1, #MyPlantableParts)]
	local size = targetPart.Size
	local cframe = targetPart.CFrame

	local randomY = RNG:NextNumber(-size.Y / 2, size.Y / 2)
	local randomZ = RNG:NextNumber(-size.Z / 2, size.Z / 2)

	local floatDistance = 5

	local localOffset = CFrame.new(floatDistance, randomY, randomZ)
	local worldCFrame = cframe * localOffset

	-- 🌟 เปลี่ยนจาก CFrame.new เป็น Vector3.new
	local finalX = worldCFrame.Position.X
	local finalY = cframe.Position.Y
	local finalZ = worldCFrame.Position.Z

	return Vector3.new(finalX, finalY, finalZ)
end

SetNoClip = function(state)
	if state then
		if not noclipConnection then
			noclipConnection = RunService.Stepped:Connect(function()
				local char = LocalPlayer.Character
				if char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
					end
				end
			end)
		end
	else
		if noclipConnection then
			noclipConnection:Disconnect()
			noclipConnection = nil
		end
	end
end

TweenToTarget = function(targetCFrame, speed, yOffset)
	local character = LocalPlayer.Character
	if not character then return false end

	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return false end

	local currentDistance = (rootPart.Position - targetCFrame.Position).Magnitude

	if currentDistance <= 5 then return true end

	local walkSpeed = speed or 50
	local height = yOffset or 3

	local finalPosition = targetCFrame.Position + Vector3.new(0, height, 0)
	local finalCFrame = CFrame.new(finalPosition)

	local flyDistance = (rootPart.Position - finalCFrame.Position).Magnitude
	local tweenTime = flyDistance / walkSpeed

	local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

	local goal = { CFrame = finalCFrame }

	local tween = TweenService:Create(rootPart, tweenInfo, goal)

	SetNoClip(true)

	tween:Play()
	tween.Completed:Wait()

	SetNoClip(false)

	return true
end

SafeTeleport = function(targetCFrame)
	local character = LocalPlayer.Character
	if not character then return end

	local humanoid = character:FindFirstChild("Humanoid")
	local rootPart = character:FindFirstChild("HumanoidRootPart")

	-- 1. เคลียร์สถานะท่านั่งและการเดิน
	if humanoid then
		if humanoid.Sit then
			humanoid.Sit = false
			humanoid.Jump = true
			task.wait(0.05)
		end

		humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
	end

	if rootPart then
		rootPart.AssemblyLinearVelocity = Vector3.zero
		rootPart.AssemblyAngularVelocity = Vector3.zero
	end

	character:PivotTo(targetCFrame)

	task.wait(0.1)
end

ParseFruitUuid = function(rawUuid)
	local baseUuid = string.split(rawUuid, ":")[1]

	local numberSuffixStr = string.match(rawUuid, ":(%d+)$")

	local finalNumber = nil
	if numberSuffixStr then finalNumber = tonumber(numberSuffixStr) end

	return baseUuid, finalNumber
end

local Window = Fluent:CreateWindow({
	Title = "Garden Horizons",
	SubTitle = "by EfHub",
	TabWidth = 100,
	Size = UDim2.fromOffset(1400, 800),
	Resize = true,
	MinSize = Vector2.new(580, 460),
	Acrylic = true,
	Theme = "Darker",
	MinimizeKey = Enum.KeyCode.RightControl,
})

local Tabs = {
	Main = Window:AddTab({ Title = "Main", Icon = "house" }),
	Shop = Window:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
	Plot = Window:AddTab({ Title = "Plot", Icon = "tree-pine" }),
	Sell = Window:AddTab({ Title = "Sell", Icon = "dollar-sign" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}
local Options = Fluent.Options
Window:SelectTab(1)

local function getShopData(path)
	local names = { "ALL" }
	for _, item in pairs(require(ShopData[path]).ShopData) do
		table.insert(names, item.Name)
	end
	return names
end

local SeedShopTable = getShopData("SeedShopData")
local GearShopTable = getShopData("GearShopData")

local PlantDataTable = { "ALL" }
for PlantName, _ in pairs(require(PlantData)) do
	table.insert(PlantDataTable, PlantName)
end

------------------------------------------------------
-- ระบบปุ่มลอย (Floating Button) สำหรับ Android
------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ToggleGui.Name = "EfHub_Toggle"
ToggleGui.Parent = game:GetService("CoreGui")
ToggleGui.ResetOnSpawn = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 100)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "EfHub"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
	pcall(function()
		if Window.GUI then
			Window.GUI.Enabled = not Window.GUI.Enabled
		elseif Window.Instance then
			Window.Instance.Enabled = not Window.Instance.Enabled
		elseif Window.Root then
			Window.Root.Visible = not Window.Root.Visible
		end
	end)
end)
local PlantsSection = Tabs.Main:AddCollapsibleSection("Plants", false)
PlantsSection:AddToggle("tgPlantsEnable", {
	Title = "Auto Plants",
	Default = false,
	Callback = function(Value)
		if Value then
			--if AutoPlantSeed() then AutoPlantSeed() end
		end
		if QuickSave then QuickSave() end
	end,
})

local HarvestSection = Tabs.Main:AddCollapsibleSection("Harvest", false)
HarvestSection:AddToggle("tgHarvestEnable", {
	Title = "Auto Harvest",
	Default = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
HarvestSection:AddDivider()

HarvestSection:AddButton({
	Title = "Clear Selected Crops",
	Callback = function()
		Options.ddHarvestCrops:SetValue({})
	end,
})
HarvestSection:AddDropdown("ddHarvestCrops", {
	Title = "Select Crops",
	Values = PlantDataTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

HarvestSection:AddDivider()
HarvestSection:AddButton({
	Title = "Clear Selected Mutant",
	Callback = function()
		Options.ddHarvestMutants:SetValue({})
	end,
})

HarvestSection:AddDropdown("ddHarvestMutants", {
	Title = "Select Mutants",
	Values = {}, --PlantDataTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

local function tempBuySeed()
	local SeedShop = GetShopData:InvokeServer("SeedShop")
	if not SeedShop then return end
	table.insert(actionQueue, {
		FuncName = AutoBuySeed,
		args = SeedShop.Items,
	})
end

local BuySeedSection = Tabs.Shop:AddCollapsibleSection("Buy Seed", false)
BuySeedSection:AddToggle("tgBuySeedEnable", {
	Title = "Auto Buy Seed",
	Default = false,
	Callback = function(Value)
		if Value then
			if tempBuySeed then tempBuySeed() end
		end
		if QuickSave then QuickSave() end
	end,
})
BuySeedSection:AddButton({
	Title = "Clear Selected Seeds",
	Callback = function()
		Options.ddBuySeed:SetValue({})
	end,
})
BuySeedSection:AddDropdown("ddBuySeed", {
	Title = "Select Seeds",
	Values = SeedShopTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

local function tempBuyGear()
	local GearShop = GetShopData:InvokeServer("GearShop")
	if not GearShop then return end
	table.insert(actionQueue, {
		FuncName = AutoBuyGear,
		args = GearShop.Items,
	})
end

local BuyGearSection = Tabs.Shop:AddCollapsibleSection("Buy Gear", false)
BuyGearSection:AddToggle("tgBuyGearEnable", {
	Title = "Auto Buy Gear",
	Default = false,
	Callback = function(Value)
		if Value then
			if tempBuyGear then tempBuyGear() end
		end
		if QuickSave then QuickSave() end
	end,
})

BuyGearSection:AddButton({
	Title = "Clear Selected Gears",
	Callback = function()
		Options.ddBuyGear:SetValue({})
	end,
})
BuyGearSection:AddDropdown("ddBuyGear", {
	Title = "Select Gears",
	Values = GearShopTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

local SellSection = Tabs.Sell:AddCollapsibleSection("Sell", false)
SellSection:AddToggle("tgSellCropsEnable", {
	Title = "Sell",
	Default = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("EfHub")
SaveManager:SetFolder("EfHub/HRZ")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

QuickSave = function()
	if not IsLoading then SaveManager:Save("Horizons") end
end

GetSelectedItems = function(DropdownValue)
	local Items = {}
	if type(DropdownValue) == "table" then
		for Value, State in pairs(DropdownValue) do
			if State then table.insert(Items, Value) end
		end
	end
	return Items
end

task.spawn(function()
	while not SaveManager.Options.SaveManager_ConfigList do
		task.wait()
	end
	SaveManager.Options.SaveManager_ConfigList:SetValue("EfHub")
	SaveManager:Load("Horizons")
	task.wait(1)
	IsLoading = false
	Fluent:Notify({
		Title = "EfHub",
		Content = "Settings loaded automatically",
		Duration = 3,
	})
end)

--[[ Anti-AFK ]]

LocalPlayer.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

--[[ Function ]]

getCleanFruitName = function(rawName)
	local cleanName = string.gsub(rawName, "%d+$", "")
	return cleanName
end

CheckHarvestCrops = function(fruit)
	local ddHarvestCropsList = GetSelectedItems(Options.ddHarvestCrops.Value)
	local fruitName
	if fruit.Parent.name == "ClientPlants" then
		fruitName = getCleanFruitName(fruit.Name)
	elseif fruit.Parent then
		fruitName = getCleanFruitName(fruit.Parent.Name)
	else
		return false -- กันเหนียวไว้กรณีที่ fruit ไม่มี Parent แล้ว
	end
	if not table.find(ddHarvestCropsList, "ALL") and not table.find(ddHarvestCropsList, fruitName) then return false end

	return true
end

ScanCrops = function()
	if not Options.tgHarvestEnable.Value then return end
	table.clear(HarVestCropsList)
	local ClientPlants = workspace.ClientPlants
	local Crops = {}
	for _, plant in pairs(ClientPlants:GetChildren()) do
		if plant:GetAttribute("FullyGrown") and plant:GetAttribute("HarvestablePlant") then
			Crops = { plant }
		else
			Crops = plant:GetChildren()
		end
		for _, fruit in pairs(Crops) do
			if not Options.tgHarvestEnable.Value then break end
			if fruit:GetAttribute("FullyGrown") then
				if CheckHarvestCrops(fruit) then table.insert(HarVestCropsList, fruit) end
			end
		end
	end
	return
end

HarvestCrops = function()
	if isProcessing or isHarvesting or HarvestPause or not Options.tgHarvestEnable.Value then return end

	if #HarVestCropsList > 0 then
		isHarvesting = true
		local fruit = table.remove(HarVestCropsList, 1)

		TweenToTarget(fruit:GetPivot() * CFrame.new(3, 0, 0), 50, 1)
		local gUuid, gindex = ParseFruitUuid(fruit:GetAttribute("Uuid"))
		local args = {}
		if gindex then
			args = {
				{
					{
						GrowthAnchorIndex = gindex,
						Uuid = gUuid,
					},
				},
			}
		else
			args = {
				{
					{
						Uuid = gUuid,
					},
				},
			}
		end
		HarvestFruit:FireServer(unpack(args))
		task.wait(0.1)
	end
	isHarvesting = false
end

AutoSellCrops = function()
	if not Options.tgSellCropsEnable.Value then return end
	SafeTeleport(Pos.Sell)
	task.wait(0.3)
	local args = {
		"SellAll",
	}
	SellItems:InvokeServer(unpack(args))
	task.wait(1)
	SafeTeleport(MySpawnPoint)
	task.wait(0.3)
end

AutoBuySeed = function(Items)
	if not Options.tgBuySeedEnable.Value then return end
	--[[ 	if not MySpawnPoint then
		if not InitializePlotData() then return nil end
	end ]]

	if not Items then return end
	isBuyingSeed = true
	local SeedBuyList = GetSelectedItems(Options.ddBuySeed.Value)
	SafeTeleport(Pos.SeedShop)
	task.wait(0.5)
	for Name, Seed in pairs(Items) do
		if table.find(SeedBuyList, "ALL") or table.find(SeedBuyList, Name) then
			for i = 1, tonumber(Seed.Amount) do
				PurchaseShopItem:InvokeServer("SeedShop", Name)
				task.wait(0.2)
			end
		end
	end
	SafeTeleport(MySpawnPoint)
	task.wait(0.3)
	isBuyingSeed = false
	--retrn
end

AutoBuyGear = function(Items)
	if not Options.tgBuyGearEnable.Value then return end

	if not Items then return end
	isBuyingGear = true
	local SeedGearList = GetSelectedItems(Options.ddBuyGear.Value)
	SafeTeleport(Pos.GearShop)
	task.wait(0.5)
	for Name, Seed in pairs(Items) do
		if table.find(SeedGearList, "ALL") or table.find(SeedGearList, Name) then
			for i = 1, tonumber(Seed.Amount) do
				PurchaseShopItem:InvokeServer("GearShop", Name)
				task.wait(0.2)
			end
		end
	end
	SafeTeleport(MySpawnPoint)
	task.wait(0.3)
	isBuyingGear = false
	--retrn
end

processQueue = function()
	if isProcessing then return end
	isProcessing = true
	HarvestPause = true
	task.wait(0.2)

	while #actionQueue > 0 do
		local taskData = table.remove(actionQueue, 1)
		local success, _ = pcall(function()
			if taskData.args then
				taskData.FuncName(taskData.args)
			else
				taskData.FuncName()
			end
		end)

		if not success then
			table.insert(actionQueue, taskData)
			task.wait(2)
		end
	end
	isProcessing = false
	HarvestPause = false
end

RemoteReplicaSet = function(args)
	if type(args[2]) ~= "table" then return end
	local fType = args[2][1]
	local fData = args[3]
	if fType == "SeedShop" and not isBuyingSeed then
		table.insert(actionQueue, {
			FuncName = AutoBuySeed,
			args = fData.Items,
		})
	elseif fType == "GearShop" and not isBuyingGear then
		table.insert(actionQueue, {
			FuncName = AutoBuyGear,
			args = fData.Items,
		})
	elseif fType == "Money" then
	end
end

RemoteNotification = function(args)
	if args[1] and type(args[1]) == "string" then
		if string.find(args[1], "inventory is full!") then
			HarvestPause = true
			table.insert(actionQueue, {
				FuncName = AutoSellCrops,
			})
		end
	end
end

--[[ Hook ]]
local function hookIncoming(remote)
	if remote:IsA("RemoteEvent") then
		remote.OnClientEvent:Connect(function(...)
			local RemoteName = remote.Name
			local args = { ... }
			if RemoteName == "ReplicaSet" then
				RemoteReplicaSet(args)
			elseif RemoteName == "Notification" then
				RemoteNotification(args)
			end
		end)
	end
end

for _, obj in ipairs(game:GetDescendants()) do
	hookIncoming(obj)
end

game.DescendantAdded:Connect(function(obj)
	hookIncoming(obj)
end)

task.spawn(function()
	while true do
		task.wait(0.2)
		if not Options.tgHarvestEnable.Value then continue end
		if #HarVestCropsList == 0 then ScanCrops() end
	end
end)

task.spawn(function()
	while true do
		task.wait(0.2)
		if not Options.tgHarvestEnable.Value or HarvestPause or isProcessing or isHarvesting then continue end
		HarvestCrops()
	end
end)

task.spawn(function()
	while true do
		if #actionQueue > 0 and not isProcessing then processQueue() end
		task.wait(0.5)
	end
end)
