--!nocheck
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/FluentData/Renewed/Fluent.luau", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()
CollapsibleAddon(Fluent)

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

local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local noclipConnection = nil

local IsLoading = true

local QuickSave, TweenToTarget, ParseFruitUuid, SetNoClip, SafeTeleport
local AutoBuySeed, AutoPlantSeed, AutoHarvest, AutoSellFruit
local isBuying, isPlanting, isHarvesting, isSelling = false, false, false, false

local InitializePlotData, GetRandomPlantPosition

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
				print("เจอสวนของพี่เอฟแล้ว! บันทึกแปลงผักจำนวน:", #MyPlantableParts, "ชิ้น")
				return true
			end
		end
	end
	warn("ยังหาสวนไม่เจอค่ะ")
	return false
end

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
	--Main = Window:AddTab({ Title = "Main", Icon = "house" }),
	Buy = Window:AddTab({ Title = "Buy", Icon = "shopping-cart" }),
	Plot = Window:AddTab({ Title = "Plot", Icon = "tree-pine" }),
	Sell = Window:AddTab({ Title = "Sell", Icon = "dollar-sign" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}
local Options = Fluent.Options
Window:SelectTab(1)

local RS = game:GetService("ReplicatedStorage").Shop.ShopData

local function getShopData(path)
	local names = {}
	for _, item in pairs(require(RS[path]).ShopData) do
		table.insert(names, item.Name)
	end
	return names
end

SeedShopTable = getShopData("SeedShopData")
GearShopTable = getShopData("GearShopData")

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

local BuySeedSection = Tabs.Buy:AddCollapsibleSection("Buy Seed", false)
BuySeedSection:AddToggle("tgBuySeedEn", {
	Title = "Auto Buy Seed",
	Default = false,
	Callback = function(Value)
		if Value then
			if AutoBuySeed then AutoBuySeed() end
		end
		if QuickSave then QuickSave() end
	end,
})

BuySeedSection:AddToggle("tgBuyAllSeedEn", {
	Title = "Auto Buy All Seed",
	Default = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

BuySeedSection:AddDropdown("ddBuySeed", {
	Title = "Select Seed",
	Values = SeedShopTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

local PlantSection = Tabs.Plot:AddCollapsibleSection("Plant", false)
PlantSection:AddToggle("tgPlantEn", {
	Title = "Plant",
	Default = false,
	Callback = function(Value)
		if Value then
			if AutoPlantSeed() then AutoPlantSeed() end
		end
		if QuickSave then QuickSave() end
	end,
})
PlantSection:AddToggle("tgHarvestEn", {
	Title = "Auto Harvest",
	Default = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

local SellSection = Tabs.Sell:AddCollapsibleSection("Sell", false)
SellSection:AddToggle("tgSellFruitEn", {
	Title = "Sell",
	Default = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

AutoBuySeed = function()
	if not Options.tgBuySeedEn.Value then return end
	local args = {
		"SeedShop",
	}
	local SeedShop = GetShopData:InvokeServer(unpack(args))
	if not SeedShop then return end
	--local carrotAmount = SeedShop.Items["Carrot Seed"].Amount
	--if carrotAmount < 1 then
	--	return
	--end
	isBuying = true

	SafeTeleport(CFrame.new(176.70, 205.49, 672.00))
	task.wait(0.5)
	for Name, Seed in pairs(SeedShop.Items) do
		print(Name .. " : " .. tostring(Seed.Amount))
		for i = 1, tonumber(Seed.Amount) do
			--local Shillings = LocalPlayer.leaderstats.Shillings.Value
			--if Shillings >= 20 then
			PurchaseShopItem:InvokeServer("SeedShop", Name)
			task.wait(0.3)
			--else
			--	break
			--end
		end
	end

	--Current Pos: CFrame.new(164.29, 189.98, 348.02)
	--SafeTeleport(CFrame.new(164.29, 189.98, 348.02))
	SafeTeleport(MySpawnPoint)
	isBuying = false
end

AutoPlantSeed = function()
	if not Options.tgPlantEn.Value then return end
	pcall(function()
		Humanoid:UnequipTools()
	end)
	local Backpack = LocalPlayer.Backpack
	--Current Pos: CFrame.new(147.13, 190.09, 317.79)
	--local PlantPos = CFrame.new(147.13, 190.09, 317.79)
	local PlantPos
	if Backpack then
		for _, item in pairs(Backpack:GetChildren()) do
			--print(item:GetAttribute("BaseName") .. ":" .. tostring(item:GetAttribute("ItemCount")))
			--if item:GetAttribute("BaseName") == "Carrot Seed" then
			--PlantPos = GetRandomPlantPosition() * MySpawnPoint.CFrame
			if item:GetAttribute("Type") == "Seeds" then
				isPlanting = true

				pcall(function()
					Humanoid:EquipTool(item)
				end)

				local ItemCount = item:GetAttribute("ItemCount") or 0
				for i = 1, ItemCount do
					if not Options.tgPlantEn.Value then break end
					PlantPos = GetRandomPlantPosition()
					TweenToTarget(CFrame.new(PlantPos.X + 3, PlantPos.Y, PlantPos.Z), 100, 3)
					local args = {
						--"Carrot",
						item:GetAttribute("PlantType"),
						--vector.create(147.13, 190.09, 317.79),
						Vector3.new(PlantPos.X, PlantPos.Y, PlantPos.Z),
					}
					PlantSeed:InvokeServer(unpack(args))
					task.wait(0.3)
				end
				pcall(function()
					Humanoid:UnequipTools()
				end)
				isPlanting = false
			end
		end
	end
end

AutoHarvest = function()
	if not Options.tgHarvestEn.Value then return end

	local ClientPlants = workspace.ClientPlants
	local Crop = {}
	for _, plant in pairs(ClientPlants:GetChildren()) do
		if plant:GetAttribute("FullyGrown") and plant:GetAttribute("HarvestablePlant") then
			Crop = { plant }
		else
			Crop = plant:GetChildren()
		end
		isHarvesting = true
		for _, fruit in pairs(Crop) do
			if not Options.tgHarvestEn.Value then break end
			if fruit:GetAttribute("FullyGrown") then
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
				task.wait(0.2)
			end
		end
		isHarvesting = false
	end
end
AutoSellFruit = function()
	if not Options.tgSellFruitEn.Value then return end
	local Backpack = LocalPlayer.Backpack
	print("Sell Check")
	local gotosell = false
	for _, item in pairs(Backpack:GetChildren()) do
		if item and item:GetAttribute("IsHarvested") then
			print(item:GetAttribute("BaseName"))
			gotosell = true
			print("Found Fruit")
			break
		end
	end
	if not gotosell then return end
	isSelling = true
	SafeTeleport(CFrame.new(149.40, 205.51, 672.00))
	task.wait(0.5)
	local args = {
		"SellAll",
	}
	SellItems:InvokeServer(unpack(args))
	SafeTeleport(CFrame.new(164.29, 189.98, 348.02))
	task.wait(0.5)
	isSelling = false
end
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

AutoBuySeed()
local function isWorking()
	return isBuying or isPlanting or isHarvesting or isSelling
end

workspace:GetAttributeChangedSignal("SeedShop"):Connect(function()
	if Options.tgBuySeedEn.Value and not isSelling then
		AutoBuySeed()
		isPlanting = false
		isHarvesting = false
	end
end)

task.spawn(function()
	while true do
		if isWorking() then
			print("Working" .. tostring(isWorking()))
			task.wait(1)
			continue
		end
		if Options.tgPlantEn.Value then
			pcall(AutoPlantSeed) --task.wait(10)
			--print("Plant")
		end
		if Options.tgHarvestEn.Value then
			pcall(AutoHarvest) --task.wait(10)
			--print("Harvest")
		end
		if Options.tgSellFruitEn.Value then
			pcall(AutoSellFruit) --task.wait(10)
			--print("Sell")
		end
		if Options.tgBuySeedEn.Value then
			pcall(AutoBuySeed) --isPlanting = false
			--isHarvesting = false
		end
		task.wait(30)
	end
end)

--[[ Anti-AFK ]]
InitializePlotData()
LocalPlayer.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)
