--!nocheck
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/FluentData/Renewed/Fluent.luau", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()
CollapsibleAddon(Fluent)

local fVersion = "2569.03.09-10.54"

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
local MutationData = ReplicatedStorage.Plants.Definitions.MutationDataDefinitions

local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local CoreGui = game:GetService("CoreGui")

local noclipConnection = nil

local Terrain = workspace.Terrain
local Lighting = game:GetService("Lighting")
local SutaDistLimit = 14
local SutaYoffset = 4
local IsLoading = true
local Pos = {
	GearShop = CFrame.new(211.64, 205.47, 608.18),
	SeedShop = CFrame.new(176.70, 205.49, 672.00),
	Botanist = CFrame.new(214.00, 205.47, 621.05),
	Sell = CFrame.new(149.40, 205.51, 672.00),
	Quest = CFrame.new(111.52, 205.50, 635.02),
}

--Control Variable
local isBuyingSeed, isBuyingGear, isPlanting = false, false, false
local HarVestCropsList = {}
local actionQueue = {}
local isProcessing = false
local HarvestPause = false
local isHarvesting = false
local isQuestClaiming = false
local isRemovePlants = false
--End of Control Variable
local NewPlayer
local QuickSave, GetSelectedItems, TweenToTarget, ParseFruitUuid, SetNoClip, SafeTeleport
local CheckHarvestCrops, ScanCrops, HarvestCrops
local AutoBuySeed, AutoBuyGear, AutoSellCrops, AutoClaimQuest, AutoPlantsSeeds
local processQueue
local InitializePlotData, GetRandomPlantPosition, ResetControlVariable
local RemoteNotification, RemoteReplicaSet
local ApplyAntiLag, RestoreAntiLag, SetVisibility, HidePlant, HideFruit, UpdateVisibilityFromAnchor
local CreatESP, espPlants, espFruit, SetespPlant, SetespFruit
local PlantsESPFolderName = "PlantsESP"
local FruitESPFolderName = "FruitESP"
local ESPFruitConnection
local bGuiSession = {}

local HarvestConfig = {}
local RemoveConfig = {}
local RemovePlants, RemoveCrops

local isAntiLag = false

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

local SettingCache = {
	GlobalShadows = Lighting.GlobalShadows,
	FogEnd = Lighting.FogEnd,
	Brightness = Lighting.Brightness,
	EnvDiffuse = Lighting.EnvironmentDiffuseScale,
	EnvSpecular = Lighting.EnvironmentSpecularScale,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	-- Terrain
	WaterWaveSize = Terrain.WaterWaveSize,
	WaterWaveSpeed = Terrain.WaterWaveSpeed,
	WaterReflectance = Terrain.WaterReflectance,
	WaterTransparency = Terrain.WaterTransparency,
}
ApplyAntiLag = function()
	-- Lighting
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	Lighting.Brightness = 2
	Lighting.EnvironmentDiffuseScale = 0
	Lighting.EnvironmentSpecularScale = 0
	Lighting.OutdoorAmbient = Color3.new(0, 0, 0)

	-- Terrain Water
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 1

	-- Workspace optimize
	for i, v in ipairs(workspace:GetDescendants()) do
		if i % 200 == 0 then task.wait() end

		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("ParticleEmitter") then
			v.Enabled = false
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 1
		end
	end

	-- Rendering quality (safe)
	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)
end

RestoreAntiLag = function()
	-- คืนค่า Lighting
	Lighting.GlobalShadows = SettingCache.GlobalShadows
	Lighting.FogEnd = SettingCache.FogEnd
	Lighting.Brightness = SettingCache.Brightness
	Lighting.EnvironmentDiffuseScale = SettingCache.EnvDiffuse
	Lighting.EnvironmentSpecularScale = SettingCache.EnvSpecular
	Lighting.OutdoorAmbient = SettingCache.OutdoorAmbient

	-- คืนค่า Terrain
	Terrain.WaterWaveSize = SettingCache.WaterWaveSize
	Terrain.WaterWaveSpeed = SettingCache.WaterWaveSpeed
	Terrain.WaterReflectance = SettingCache.WaterReflectance
	Terrain.WaterTransparency = SettingCache.WaterTransparency

	-- คืนค่าวัตถุใน Workspace
	for i, v in ipairs(workspace:GetDescendants()) do
		if i % 200 == 0 then task.wait() end

		if v:IsA("BasePart") then
			v.Material = Enum.Material.Plastic
			v.Reflectance = 0
		elseif v:IsA("ParticleEmitter") then
			v.Enabled = true
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 0
		end
	end

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
	end)

	print("SutaHub: Graphics Restored!")
end

-- [[ Main Visibility Functions ]]

SetVisibility = function(obj, isHidden)
	-- Optimize 1: ตัด MeshPart ออก เพราะ IsA("BasePart") คลุมหมดแล้ว
	if obj:IsA("BasePart") or obj:IsA("Decal") or obj:IsA("Texture") then
		if isHidden then
			if not obj:GetAttribute("OriginalTrans") then obj:SetAttribute("OriginalTrans", obj.Transparency) end
			obj.Transparency = 1
		else
			local orig = obj:GetAttribute("OriginalTrans")
			if orig then obj.Transparency = orig end
		end
	elseif obj:IsA("ParticleEmitter") or obj:IsA("Sparkles") or obj:IsA("Fire") or obj:IsA("Trail") then
		if isHidden then
			if obj:GetAttribute("OriginalEnabled") == nil then obj:SetAttribute("OriginalEnabled", obj.Enabled) end
			obj.Enabled = false
		else
			local orig = obj:GetAttribute("OriginalEnabled")
			if orig ~= nil then obj.Enabled = orig end
		end
	end
end

-- [[ Helper: ฟังก์ชันจัดการแบบรวบยอด (ประหยัด CPU) ]]
UpdateVisibilityFromAnchor = function(anchorName, state, isPlantCheck)
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if not ClientPlants then return end

	-- Optimize 2: วิ่งหาเฉพาะ Anchor ไม่ต้องถาม Part ทุกชิ้น
	for _, obj in ipairs(ClientPlants:GetDescendants()) do
		if obj.Name == anchorName then
			local parent = obj.Parent
			if parent then
				-- ถ้าเช็กต้นไม้ ต้องแน่ใจว่าไม่มี FruitAnchor วางปนอยู่
				if isPlantCheck and parent:FindFirstChild("FruitAnchor") then
					continue -- ข้ามไปเลย
				end

				-- สั่งซ่อน/แสดง ให้กับทุกชิ้นที่อยู่ใน Parent เดียวกันรวดเดียว
				for _, sibling in ipairs(parent:GetChildren()) do
					SetVisibility(sibling, state)
				end
			end
		end
	end
end

-- ใช้งาน Helper ให้โค้ดสั้นและคลีนขึ้น
HidePlant = function(state)
	UpdateVisibilityFromAnchor("PlantAnchor", state, true)
end

HideFruit = function(state)
	UpdateVisibilityFromAnchor("FruitAnchor", state, false)
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

	local finalX = worldCFrame.Position.X
	local finalY = cframe.Position.Y
	local finalZ = worldCFrame.Position.Z

	-- 🌟 เปลี่ยนจาก Vector3.new เป็น CFrame.new ค่ะ
	return CFrame.new(finalX, finalY, finalZ)
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

--MySpawnPoint = MySpawn:GetPivot()

TweenToTarget = function(targetCFrame, speed)
	local character = game.Players.LocalPlayer.Character
	if not character then return false end
	local rootPart = character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return false end

	local currentDistance = (rootPart.Position - targetCFrame.Position).Magnitude
	if currentDistance <= SutaDistLimit then return true end

	local walkSpeed = speed or 50
	local height = SutaYoffset or 3
	local targetPos = targetCFrame.Position
	local spawnY = (MySpawnPoint and MySpawnPoint.Position.Y or 0)

	local groundPoint = Vector3.new(targetPos.X, spawnY, targetPos.Z)
	local distanceFromGround = (targetPos - groundPoint).Magnitude

	local finalY
	if distanceFromGround > SutaDistLimit then
		finalY = targetPos.Y + height
	else
		finalY = spawnY + height
	end

	finalY = math.max(finalY, spawnY + height)

	local finalCFrame = CFrame.new(Vector3.new(targetPos.X, finalY, targetPos.Z))

	rootPart.Anchored = false
	SetNoClip(true)

	local tweenTime = (rootPart.Position - finalCFrame.Position).Magnitude / walkSpeed
	local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
	local tween = TweenService:Create(rootPart, tweenInfo, { CFrame = finalCFrame })

	tween:Play()
	tween.Completed:Wait()

	rootPart.Anchored = true
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
	rootPart.Anchored = false
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
	SubTitle = "by EfHub v " .. fVersion,
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
	Auto = Window:AddTab({ Title = "Automatic", Icon = "bot" }),
	Misc = Window:AddTab({ Title = "Misc", Icon = "component" }),
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
local SeedDataTable = { "ALL" }
for PlantName, _ in pairs(require(PlantData)) do
	table.insert(PlantDataTable, PlantName)
	table.insert(SeedDataTable, PlantName .. " Seed")
end
local MutationDataTable = { "ALL" }
for MutationName, _ in pairs(require(MutationData)) do
	table.insert(MutationDataTable, MutationName)
end

local PlantDataBackTable = table.clone(PlantDataTable)
PlantDataBackTable[1] = "NONE"

local SeedDataBackTable = table.clone(SeedDataTable)
SeedDataBackTable[1] = "NONE"

local MutationDataBackTable = table.clone(MutationDataTable)
MutationDataBackTable[1] = "NONE"

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
			table.insert(actionQueue, {
				FuncName = AutoPlantsSeeds,
			})
		else
			isPlanting = false
		end
		if QuickSave then QuickSave() end
	end,
})
PlantsSection:AddButton({
	Title = "Clear Selected Seeds",
	Callback = function()
		Options.ddPlantsSeeds:SetValue({})
	end,
})
PlantsSection:AddDropdown("ddPlantsSeeds", {
	Title = "Select Seeds",
	Values = PlantDataTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

PlantsSection:AddDropdown("ddPlantsPos", {
	Title = "Select Plants Position",
	Values = { "Player", "Random" },
	Default = "Player",
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

local HarvestSection = Tabs.Main:AddCollapsibleSection("Harvest", false)
HarvestSection:AddToggle("tgHarvestEnable", {
	Title = "Auto Harvest",
	Default = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
		table.clear(HarVestCropsList)
		if not Value then isHarvesting = false end
	end,
})

HarvestSection:AddDivider()

HarvestSection:AddButton({
	Title = "Clear Selected Crops",
	Callback = function()
		Options.ddHarvestCrops:SetValue({ ALL = true })
	end,
})
HarvestSection:AddDropdown("ddHarvestCrops", {
	Title = "Select Crops",
	Values = PlantDataTable,
	Multi = true,
	Default = { "ALL" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
HarvestSection:AddButton({
	Title = "Clear Backlist Crops",
	Callback = function()
		Options.ddHarvestBlackCrops:SetValue({ NONE = true })
	end,
})
HarvestSection:AddDropdown("ddHarvestBlackCrops", {
	Title = "Blacklist Crops",
	Values = PlantDataBackTable,
	Multi = true,
	Default = { "NONE" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

HarvestSection:AddDivider()
HarvestSection:AddButton({
	Title = "Clear Selected Mutant",
	Callback = function()
		Options.ddHarvestMutants:SetValue({ ALL = true })
	end,
})

HarvestSection:AddDropdown("ddHarvestMutants", {
	Title = "Select Mutants",
	Values = MutationDataTable,
	Multi = true,
	Default = { "ALL" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

HarvestSection:AddButton({
	Title = "Clear Backlist Mutant",
	Callback = function()
		Options.ddHarvestBackMutants:SetValue({ NONE = true })
	end,
})

HarvestSection:AddDropdown("ddHarvestBackMutants", {
	Title = "Backlist Mutants",
	Values = MutationDataBackTable,
	Multi = true,
	Default = { "NONE" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

HarvestSection:AddDivider()
HarvestSection:AddDropdown("ddRipeness", {
	Title = "Ripeness Stage",
	Values = { "ALL", "Unripe", "Ripened", "Lush" },
	Default = { "ALL" },
	Multi = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

HarvestSection:AddInput("ipRipenessMulti", {
	Title = "Ripeness Multiplier",
	Default = 3,
	Numeric = false,
	Finished = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

HarvestSection:AddDropdown("ddBlackRipeness", {
	Title = "Backlist Ripeness Stage",
	Values = { "NONE", "Unripe", "Ripened", "Lush" },
	Default = { "NONE" },
	Multi = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

HarvestSection:AddDivider()
HarvestSection:AddDropdown("ddVariant", {
	Title = "Variant",
	Values = { "ALL", "Silver", "Gold" },
	Default = { "ALL" },
	Multi = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
HarvestSection:AddDropdown("ddBackVariant", {
	Title = "Backlist Variant",
	Values = { "NONE", "Silver", "Gold" },
	Default = { "NONE" },
	Multi = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
HarvestSection:AddDivider()
HarvestSection:AddDropdown("ddWeight", {
	Title = "Weight",
	Values = { "Below", "Above" },
	Default = "Below",
	Multi = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
HarvestSection:AddInput("ipWeight", {
	Title = "Weight",
	Default = 0,
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

local SellSection = Tabs.Main:AddCollapsibleSection("Sell", false)
SellSection:AddToggle("tgSellCropsEnable", {
	Title = "Sell",
	Default = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
		--if not Value then isProcessing = false end
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
		Options.ddBuySeeds:SetValue({})
	end,
})
BuySeedSection:AddDropdown("ddBuySeeds", {
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

local QuestSection = Tabs.Auto:AddCollapsibleSection("Quest", false)
QuestSection:AddToggle("tgQuestEnable", {
	Title = "Auto Claim Quest",
	Default = false,
	Callback = function(Value)
		if Value then RemoteEvents:WaitForChild("RequestQuests"):FireServer() end
		if QuickSave then QuickSave() end
	end,
})

local RemoveSection = Tabs.Auto:AddCollapsibleSection("Remove", false)
RemoveSection:AddToggle("tgRemovePlantsEnable", {
	Title = "Auto Remove Plants",
	Default = false,
	Callback = function(Value)
		if Value then table.insert(actionQueue, {
			FuncName = RemovePlants,
		}) end
		if QuickSave then QuickSave() end
	end,
})
RemoveSection:AddButton({
	Title = "Clear Selected Plants",
	Callback = function()
		Options.ddRemovePlants:SetValue({})
	end,
})
RemoveSection:AddDropdown("ddRemovePlants", {
	Title = "Select Remove Plants",
	Values = PlantDataTable,
	Default = {},
	Multi = true,
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
RemoveSection:AddDropdown("ddRemovePlantsScale", {
	Title = "Plants Scale Threshold",
	Values = { "ALL", "Below", "Above" },
	Default = "ALL",
	Multi = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
RemoveSection:AddInput("ipRemovePlantsScale", {
	Title = "Plants Scale",
	Default = 0,
	Numeric = true,
	Finished = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

local RemoveFruitSection = Tabs.Auto:AddCollapsibleSection("Remove Fruit", false)
RemoveFruitSection:AddToggle("tgRemoveFruitEnable", {
	Title = "Auto Remove Fruit",
	Default = false,
	Callback = function(Value)
		--[[ 		if Value then table.insert(actionQueue, {
			FuncName = AutoRemoveFruit,
		}) end ]]
		if QuickSave then QuickSave() end
	end,
})

RemoveFruitSection:AddDivider()

RemoveFruitSection:AddButton({
	Title = "Clear Selected Remove Crops",
	Callback = function()
		Options.ddRemoveCrops:SetValue({ ALL = true })
	end,
})
RemoveFruitSection:AddDropdown("ddRemoveCrops", {
	Title = "Select Remove Crops",
	Values = PlantDataTable,
	Multi = true,
	Default = { "ALL" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
RemoveFruitSection:AddButton({
	Title = "Clear Backlist Remove Crops",
	Callback = function()
		Options.ddRemoveBlackCrops:SetValue({ NONE = true })
	end,
})
RemoveFruitSection:AddDropdown("ddRemoveBlackCrops", {
	Title = "Blacklist Remove Crops",
	Values = PlantDataBackTable,
	Multi = true,
	Default = { "NONE" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

RemoveFruitSection:AddDivider()
RemoveFruitSection:AddButton({
	Title = "Clear Selected Mutant",
	Callback = function()
		Options.ddRemoveMutants:SetValue({ ALL = true })
	end,
})

RemoveFruitSection:AddDropdown("ddRemoveMutants", {
	Title = "Select Mutants",
	Values = MutationDataTable,
	Multi = true,
	Default = { "ALL" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

RemoveFruitSection:AddButton({
	Title = "Clear Backlist Mutant",
	Callback = function()
		Options.ddRemoveBackMutants:SetValue({ NONE = true })
	end,
})

RemoveFruitSection:AddDropdown("ddRemoveBackMutants", {
	Title = "Backlist Mutants",
	Values = MutationDataBackTable,
	Multi = true,
	Default = { "NONE" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

RemoveFruitSection:AddDivider()
RemoveFruitSection:AddDropdown("ddRemoveRipeness", {
	Title = "Ripeness Stage",
	Values = { "ALL", "Unripe", "Ripened", "Lush" },
	Default = { "ALL" },
	Multi = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

RemoveFruitSection:AddInput("ipRemoveRipenessMulti", {
	Title = "Ripeness Multiplier",
	Default = 3,
	Numeric = false,
	Finished = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

RemoveFruitSection:AddDropdown("ddRemoveBlackRipeness", {
	Title = "Backlist Ripeness Stage",
	Values = { "NONE", "Unripe", "Ripened", "Lush" },
	Default = { "NONE" },
	Multi = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

RemoveFruitSection:AddDivider()
RemoveFruitSection:AddDropdown("ddRemoveVariant", {
	Title = "Variant",
	Values = { "ALL", "Silver", "Gold" },
	Default = { "ALL" },
	Multi = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
RemoveFruitSection:AddDropdown("ddRemoveBackVariant", {
	Title = "Backlist Variant",
	Values = { "NONE", "Silver", "Gold" },
	Default = { "NONE" },
	Multi = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
RemoveFruitSection:AddDivider()
RemoveFruitSection:AddDropdown("ddRemoveWeight", {
	Title = "Weight",
	Values = { "Below", "Above" },
	Default = "Below",
	Multi = false,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
HarvestSection:AddInput("ipRemoveWeight", {
	Title = "Weight",
	Default = 0,
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

--end of remove
--รีเซ็ท ตัวแปรที่ใช้ควบคุม
local MiscSection = Tabs.Misc:AddCollapsibleSection("Misc", false)
MiscSection:AddButton({
	Title = "Reset Control Variable",
	Callback = function()
		if ResetControlVariable then ResetControlVariable() end
	end,
})
local AntiLagSection = Tabs.Misc:AddCollapsibleSection("Anti-Lag", false)

AntiLagSection:AddToggle("tgAntiLag", {
	Title = "Anti-Lag",
	Default = false,
	Callback = function(Value)
		pcall(function()
			if Value then
				ApplyAntiLag()
				isAntiLag = true
			else
				if isAntiLag then RestoreAntiLag() end
				isAntiLag = false
			end
		end)
		if QuickSave then QuickSave() end
	end,
})
AntiLagSection:AddToggle("tgHideFruit", {
	Title = "Hide Fruit",
	Default = false,
	Callback = function(Value)
		--pcall(function()
		HideFruit(Value)
		--end)
		if QuickSave then QuickSave() end
	end,
})

AntiLagSection:AddToggle("tgHidePlant", {
	Title = "Hide Plant",
	Default = false,
	Callback = function(Value)
		--pcall(function()
		HidePlant(Value)
		--end)
		if QuickSave then QuickSave() end
	end,
})

local NewPlayerSection = Tabs.Misc:AddCollapsibleSection("New Player", false)
NewPlayerSection:AddInput("ipNewDelay", {
	Title = "Delay timmes (Minute)",
	Default = 5,
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
NewPlayerSection:AddToggle("tgNewAutoSell", {
	Title = "Auto Sell",
	Default = false,
	Callback = function(Value)
		--if Value then
		--HarvestPause = true
		--table.clear(HarVestCropsList)
		--table.insert(actionQueue, {
		--	FuncName = AutoSellCrops,
		--})
		--end
		if QuickSave then QuickSave() end
	end,
})

local espSection = Tabs.Misc:AddCollapsibleSection("ESP", false)
espSection:AddToggle("tgPlantsESP", {
	Title = "ESP Plants",
	Default = false,
	Callback = function(Value)
		if espPlants then espPlants(Value) end
		if QuickSave then QuickSave() end
	end,
})
espSection:AddButton({
	Title = "Clear Selected Plants",
	Callback = function()
		Options.ddPlantsESP:SetValue({ NONE = true })
	end,
})
espSection:AddDropdown("ddPlantsESP", {
	Title = "Select Plants",
	Values = PlantDataBackTable,
	Multi = true,
	Default = { "NONE" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})
espSection:AddDivider()
espSection:AddToggle("tgFruitESP", {
	Title = "ESP Fruit",
	Default = false,
	Callback = function(Value)
		if espFruit then espFruit(Value) end
		if QuickSave then QuickSave() end
	end,
})
espSection:AddButton({
	Title = "Clear Selected Fruit",
	Callback = function()
		Options.ddFruitESP:SetValue({ NONE = true })
	end,
})
espSection:AddDropdown("ddFruitESP", {
	Title = "Select Fruit",
	Values = PlantDataBackTable,
	Multi = true,
	Default = { "NONE" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then QuickSave() end
	end,
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

--SaveManager:SetIgnoreIndexes({})
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

ResetControlVariable = function()
	isBuyingSeed = false
	isBuyingGear = false
	isPlanting = false
	isProcessing = false
	HarvestPause = false
	isHarvesting = false
	isQuestClaiming = false
	isRemovePlants = false

	table.clear(HarVestCropsList)
	table.clear(actionQueue)
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
--[[ 
CheckHarvestCrops = function(fruit)
	-- ดึงค่า Attributes ของผลไม้มาเก็บไว้ก่อน เพื่อลดการเรียกฟังก์ชันซ้ำซ้อน
	local fruitName = fruit:GetAttribute("PlantType") or (fruit.Parent and fruit.Parent:GetAttribute("PlantType")) or "Fruit"
	local fruitRipeness = fruit:GetAttribute("RipenessStage")
	local fruitVariant = fruit:GetAttribute("Variant")
	local CropsMutants = fruit:GetAttribute("Mutation")

	-- White list Variables
	local ddHarvestCropsList = GetSelectedItems(Options.ddHarvestCrops.Value)
	local ddHarvestMutantsList = GetSelectedItems(Options.ddHarvestMutants.Value)
	local ddRipenessList = GetSelectedItems(Options.ddRipeness.Value)
	local ipRipenessMulti = tonumber(Options.ipRipenessMulti.Value)
	local ddVariantList = GetSelectedItems(Options.ddVariant.Value)
	local ddWeight = Options.ddWeight.Value
	local ipWeight = tonumber(Options.ipWeight.Value)

	-- White list Checks
	if not table.find(ddHarvestCropsList, "ALL") and not table.find(ddHarvestCropsList, fruitName) then return false end
	if fruit:GetAttribute("Favorited") == true then return false end
	if not table.find(ddRipenessList, "ALL") and not table.find(ddRipenessList, fruitRipeness) then return false end
	if ipRipenessMulti ~= 0 and fruit:GetAttribute("RipenessMultiplier") < ipRipenessMulti then return false end
	if not table.find(ddVariantList, "ALL") and not table.find(ddVariantList, fruitVariant) then return false end

	if not table.find(ddHarvestMutantsList, "ALL") then
		if not CropsMutants or CropsMutants == "" then return false end
		local CropsMutantsTable = string.split(CropsMutants, ",")
		local isMutantMatch = false
		for _, mutation in ipairs(CropsMutantsTable) do
			if table.find(ddHarvestMutantsList, mutation) then isMutantMatch = true end
		end
		if not isMutantMatch then return false end
	end

	if ipWeight ~= 0 then
		local rawWeight = fruit:GetAttribute("FruitWeight")
		if not rawWeight then return false end
		local weight = tonumber(rawWeight)
		if ddWeight == "Below" and weight >= ipWeight then return false end
		if ddWeight == "Above" and weight <= ipWeight then return false end
	end

	-- Black list Variables
	local ddHarvestBlackCropsList = GetSelectedItems(Options.ddHarvestBlackCrops.Value)
	local ddBlackRipenessList = GetSelectedItems(Options.ddBlackRipeness.Value)
	local ddHarvestBackVariantList = GetSelectedItems(Options.ddBackVariant.Value)
	local ddHarvestBackMutantsList = GetSelectedItems(Options.ddHarvestBackMutants.Value)

	-- Black list Checks (แก้ไข Logic Bug แล้ว)
	if not table.find(ddHarvestBlackCropsList, "NONE") and table.find(ddHarvestBlackCropsList, fruitName) then return false end
	if not table.find(ddBlackRipenessList, "NONE") and table.find(ddBlackRipenessList, fruitRipeness) then return false end
	if not table.find(ddHarvestBackVariantList, "NONE") and table.find(ddHarvestBackVariantList, fruitVariant) then return false end -- แก้ไขเอา not ออก

	if not table.find(ddHarvestBackMutantsList, "NONE") then
		if CropsMutants and CropsMutants ~= "" then
			local CropsMutantsTable = string.split(CropsMutants, ",")
			local isBackMutantMatch = false
			for _, mutation in ipairs(CropsMutantsTable) do
				if table.find(ddHarvestBackMutantsList, mutation) then isBackMutantMatch = true end
			end
			if isBackMutantMatch then return false end
		end
	end

	return true
end ]]

-- สร้าง Wrapper function หรือดึงค่ามาก่อนจะโยนเข้า CheckHarvestCrops
HarvestConfig = {
	wl = {
		crops = GetSelectedItems(Options.ddHarvestCrops.Value),
		mutants = GetSelectedItems(Options.ddHarvestMutants.Value),
		ripeness = GetSelectedItems(Options.ddRipeness.Value),
		ripenessMulti = tonumber(Options.ipRipenessMulti.Value) or 0,
		variant = GetSelectedItems(Options.ddVariant.Value),
		weightCondition = Options.ddWeight.Value,
		weightValue = tonumber(Options.ipWeight.Value) or 0,
	},
	bl = {
		crops = GetSelectedItems(Options.ddHarvestBlackCrops.Value),
		ripeness = GetSelectedItems(Options.ddBlackRipeness.Value),
		variant = GetSelectedItems(Options.ddBackVariant.Value),
		mutants = GetSelectedItems(Options.ddHarvestBackMutants.Value),
	},
}

RemoveConfig = {
	wl = {
		crops = GetSelectedItems(Options.ddRemoveCrops.Value),
		mutants = GetSelectedItems(Options.ddRemoveMutants.Value),
		ripeness = GetSelectedItems(Options.ddRemoveRipeness.Value),
		ripenessMulti = tonumber(Options.ipRemoveRipenessMulti.Value) or 0,
		variant = GetSelectedItems(Options.ddRemoveVariant.Value),
		weightCondition = Options.ddRemoveWeight.Value,
		weightValue = tonumber(Options.ipRemoveWeight.Value) or 0,
	},
	bl = {
		crops = GetSelectedItems(Options.ddRemoveBlackCrops.Value),
		ripeness = GetSelectedItems(Options.ddRemoveBlackRipeness.Value),
		variant = GetSelectedItems(Options.ddRemoveBackVariant.Value),
		mutants = GetSelectedItems(Options.ddRemoveBackMutants.Value),
	},
}

CheckHarvestCrops = function(fruit, config)
	-- ดึงค่า Attributes ของผลไม้
	local fruitName = fruit:GetAttribute("PlantType") or (fruit.Parent and fruit.Parent:GetAttribute("PlantType")) or "Fruit"
	local fruitRipeness = fruit:GetAttribute("RipenessStage")
	local fruitVariant = fruit:GetAttribute("Variant")
	local CropsMutants = fruit:GetAttribute("Mutation")

	-- White list Checks
	if not table.find(config.wl.crops, "ALL") and not table.find(config.wl.crops, fruitName) then return false end
	if fruit:GetAttribute("Favorited") == true then return false end
	if not table.find(config.wl.ripeness, "ALL") and not table.find(config.wl.ripeness, fruitRipeness) then return false end
	if config.wl.ripenessMulti ~= 0 and fruit:GetAttribute("RipenessMultiplier") < config.wl.ripenessMulti then return false end
	if not table.find(config.wl.variant, "ALL") and not table.find(config.wl.variant, fruitVariant) then return false end

	if not table.find(config.wl.mutants, "ALL") then
		if not CropsMutants or CropsMutants == "" then return false end
		local CropsMutantsTable = string.split(CropsMutants, ",")
		local isMutantMatch = false
		for _, mutation in ipairs(CropsMutantsTable) do
			if table.find(config.wl.mutants, mutation) then isMutantMatch = true end
		end
		if not isMutantMatch then return false end
	end

	if config.wl.weightValue ~= 0 then
		local rawWeight = fruit:GetAttribute("FruitWeight")
		if not rawWeight then return false end
		local weight = tonumber(rawWeight)
		if config.wl.weightCondition == "Below" and weight >= config.wl.weightValue then return false end
		if config.wl.weightCondition == "Above" and weight <= config.wl.weightValue then return false end
	end

	-- Black list Checks
	if not table.find(config.bl.crops, "NONE") and table.find(config.bl.crops, fruitName) then return false end
	if not table.find(config.bl.ripeness, "NONE") and table.find(config.bl.ripeness, fruitRipeness) then return false end
	if not table.find(config.bl.variant, "NONE") and table.find(config.bl.variant, fruitVariant) then return false end

	if not table.find(config.bl.mutants, "NONE") then
		if CropsMutants and CropsMutants ~= "" then
			local CropsMutantsTable = string.split(CropsMutants, ",")
			local isBackMutantMatch = false
			for _, mutation in ipairs(CropsMutantsTable) do
				if table.find(config.bl.mutants, mutation) then isBackMutantMatch = true end
			end
			if isBackMutantMatch then return false end
		end
	end

	return true
end

ScanCrops = function()
	if not Options.tgHarvestEnable.Value then return end
	table.clear(HarVestCropsList)

	-- 1. ค้นหาผ่าน Tag ที่ปุ่มกด
	for _, prompt in pairs(CollectionService:GetTagged("HarvestPrompt")) do
		if prompt.Enabled then
			local fruit = prompt.Parent.Parent -- ย้อนกลับไปหา Model หลัก

			if CheckHarvestCrops(fruit, HarvestConfig) then table.insert(HarVestCropsList, fruit) end
		end
	end

	-- 2. เรียงลำดับตามชื่อผลไม้ (PlantType) เพื่อให้เก็บเป็นโซนๆ ไป
	if #HarVestCropsList > 1 then
		table.sort(HarVestCropsList, function(a, b)
			local nameA = a:GetAttribute("PlantType") or (a.Parent and a.Parent:GetAttribute("PlantType")) or "Fruit"
			local nameB = b:GetAttribute("PlantType") or (b.Parent and b.Parent:GetAttribute("PlantType")) or "Fruit"
			return nameA < nameB
		end)
	end
end

HarvestCrops = function()
	if HarvestPause or isProcessing or isHarvesting or not Options.tgHarvestEnable.Value then return end

	if #HarVestCropsList > 0 then
		isHarvesting = true
		local fruit = table.remove(HarVestCropsList, 1)

		local prompt = fruit:FindFirstChild("HarvestPrompt", true)
		if not fruit or not fruit.Parent or not prompt or not prompt.Enabled then
			isHarvesting = false
			return
		end

		local targetCFrame = CFrame.new(fruit:GetPivot().Position + Vector3.new(3, 0, 0))

		TweenToTarget(targetCFrame, 100)

		-- จำลองการกดปุ่ม E
		task.wait(0.1) -- พักนิดนึงให้ฟิสิกส์นิ่ง
		--if prompt.Enabled then fireproximityprompt(prompt) end
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
	HarvestPause = false
end

AutoBuySeed = function(Items)
	if not Options.tgBuySeedEnable.Value then return end
	--[[ 	if not MySpawnPoint then
		if not InitializePlotData() then return nil end
	end ]]

	if not Items then return end
	isBuyingSeed = true
	local SeedBuyList = GetSelectedItems(Options.ddBuySeeds.Value)
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
	task.wait(1)
	isBuyingSeed = false
	HarvestPause = false
	task.wait(0.2)
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
	task.wait(1)
	isBuyingGear = false
	HarvestPause = false
	task.wait(0.2)
end

AutoPlantsSeeds = function()
	if not Options.tgPlantsEnable.Value or isPlanting then return end

	pcall(function()
		Humanoid:UnequipTools()
	end)
	local ddPlantsPos = Options.ddPlantsPos.Value
	local PlantPos
	local Backpack = LocalPlayer.Backpack
	local SeedList = GetSelectedItems(Options.ddPlantsSeeds.Value)

	if Backpack then
		for _index, item in pairs(Backpack:GetChildren()) do
			if not Options.tgPlantsEnable.Value then break end
			if item:GetAttribute("Type") == "Seeds" and (table.find(SeedList, "ALL") or table.find(SeedList, item:GetAttribute("PlantType"))) then
				isPlanting = true
				pcall(function()
					Humanoid:EquipTool(item)
				end)
				local ItemCount = item:GetAttribute("ItemCount") or 0
				for i = 1, ItemCount do
					if not Options.tgPlantsEnable.Value then
						isPlanting = false
						break
					end
					if ddPlantsPos == "Player" then
						PlantPos = Character:GetPivot()
					elseif ddPlantsPos == "Random" then
						PlantPos = GetRandomPlantPosition()
						TweenToTarget(CFrame.new(PlantPos.X + 3, PlantPos.Y, PlantPos.Z), 100)
					end
					local args = {
						item:GetAttribute("PlantType"),
						--Vector3.new(PlantPos.X, PlantPos.Y, PlantPos.Z),
						PlantPos.Position,
					}
					PlantSeed:InvokeServer(unpack(args))
					task.wait(0.3)
				end
				pcall(function()
					Humanoid:UnequipTools()
				end)
			end
		end
		isPlanting = false
	end
end

AutoClaimQuest = function(QuestData)
	if not Options.tgQuestEnable.Value or isQuestClaiming or not QuestData then return end

	isQuestClaiming = true
	local Daily = QuestData.Daily.Active
	for index, qDaily in pairs(Daily) do
		if qDaily.CompletedAt and not qDaily.Claimed then game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ClaimQuest"):FireServer("Daily", index) end
	end

	local Weekly = QuestData.Weekly.Active
	for index, qWeekly in pairs(Weekly) do
		if qWeekly.CompletedAt and not qWeekly.Claimed then game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("ClaimQuest"):FireServer("Weekly", index) end
	end
	isQuestClaiming = false
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
	task.wait(0.5)
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
			table.clear(HarVestCropsList)
			table.insert(actionQueue, {
				FuncName = AutoSellCrops,
			})
		end
	end
end

CreatESP = function(espfolder, obj, uuid, txt1, txt2, arg)
	if not (espfolder and obj and uuid and txt1) then return end
	local priority = arg or 0
	if bGuiSession[uuid] then
		bGuiSession[uuid]:Destroy()
		bGuiSession[uuid] = nil
	end

	local bgui = Instance.new("BillboardGui")
	bgui.Name = "ESP_" .. uuid
	bgui.Adornee = obj
	bgui.Size = UDim2.new(0, 200, 0, 80)
	bgui.StudsOffset = Vector3.new(0, 3.5, 0)
	bgui.AlwaysOnTop = true
	bgui.LightInfluence = 0
	bgui.Parent = espfolder

	local textLabel = Instance.new("TextLabel")
	textLabel.Parent = bgui
	textLabel.Size = UDim2.new(1, 0, 0, 0)
	textLabel.AutomaticSize = Enum.AutomaticSize.XY
	textLabel.BackgroundTransparency = 1
	textLabel.TextWrapped = false
	if txt2 and txt2 ~= "" then
		textLabel.Text = string.format("%s\n%s", tostring(txt1), tostring(txt2))
	else
		textLabel.Text = tostring(txt1)
	end

	if priority == 3 then
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 10)
	elseif priority == 2 then
		textLabel.TextColor3 = Color3.fromRGB(200, 50, 10)
	elseif priority == 1 then
		textLabel.TextColor3 = Color3.fromRGB(10, 200, 10)
	else
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	end

	textLabel.TextStrokeTransparency = 0
	textLabel.TextSize = 16
	textLabel.Font = Enum.Font.FredokaOne

	textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	textLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	bGuiSession[uuid] = bgui
end

SetespPlant = function(obj)
	if not Options.tgPlantsESP.Value then return end
	local plant = (obj:IsA("Model") and obj) or obj:FindFirstAncestorOfClass("Model")
	if not plant then return end
	local plantName = plant:GetAttribute("PlantType")
	if not plantName then return end

	local TargetFolder = gethui and gethui() or CoreGui
	local ESPFolder = TargetFolder:FindFirstChild(PlantsESPFolderName)
	local espPlantsList = GetSelectedItems(Options.ddPlantsESP.Value)

	if table.find(espPlantsList, "NONE") then return end

	if table.find(espPlantsList, plantName) then
		local uuid = plant:GetAttribute("Uuid") or plant.Name
		local scale = plant:GetAttribute("HiddenNumber") or 0
		local Weight = plant:GetAttribute("PlantWeight") or 0
		local arg = 0
		if scale >= 2 then
			arg = 3
		elseif scale >= 1.5 then
			arg = 2
		elseif scale >= 1 then
			arg = 1
		end
		if Weight > 0 then
			CreatESP(ESPFolder, plant, uuid, "🌱 " .. plantName, string.format("Weight : %.2f kg", Weight), arg)
		else
			CreatESP(ESPFolder, plant, uuid, "🌱 " .. plantName, string.format("Scale : %.2f", scale), arg)
		end
	end
end

espPlants = function(State)
	local TargetFolder = gethui and gethui() or CoreGui
	local oldFolder = TargetFolder:FindFirstChild(PlantsESPFolderName)
	if oldFolder then oldFolder:Destroy() end

	if State ~= true then return end
	local espPlantsList = GetSelectedItems(Options.ddPlantsESP.Value)
	if table.find(espPlantsList, "NONE") then return end

	local ESPFolder = Instance.new("Folder")
	ESPFolder.Name = PlantsESPFolderName
	ESPFolder.Parent = TargetFolder

	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if ClientPlants then
		for _, plant in pairs(ClientPlants:GetChildren()) do
			SetespPlant(plant)
		end
	end
end

SetespFruit = function(obj)
	if not Options.tgFruitESP.Value then return end

	local fruit = (obj:IsA("Model") and obj) or obj:FindFirstAncestorOfClass("Model")
	if not fruit then return end

	local fruitName = fruit:GetAttribute("PlantType") or (fruit.Parent and fruit.Parent:GetAttribute("PlantType"))
	if not fruitName then return end

	local TargetFolder = gethui and gethui() or CoreGui
	local ESPFolder = TargetFolder:FindFirstChild(FruitESPFolderName)
	local espFruitList = GetSelectedItems(Options.ddFruitESP.Value)

	if table.find(espFruitList, "NONE") then return end

	if table.find(espFruitList, fruitName) then
		local uuid = fruit:GetAttribute("Uuid") or fruitName
		local Weight = 0
		for i = 1, 3 do
			Weight = fruit:GetAttribute("FruitWeight") or fruit:GetAttribute("PlantWeight") or 0

			if Weight > 0 then break end

			task.wait(1)
		end

		local scale = fruit:GetAttribute("HiddenNumber") or 0
		local arg = 0
		if scale >= 2 then
			arg = 3
		elseif scale >= 1.5 then
			arg = 2
		elseif scale >= 1 then
			arg = 1
		end
		if Weight > 0 then
			CreatESP(ESPFolder, fruit, uuid, "🍎" .. fruitName, string.format("Weight : %.2f kg", Weight), arg)
		else
			CreatESP(ESPFolder, fruit, uuid, "🍎" .. fruitName, string.format("Scale : %.2f", scale), arg)
		end
	end
end

espFruit = function(State)
	local TargetFolder = gethui and gethui() or CoreGui
	local oldFolder = TargetFolder:FindFirstChild(FruitESPFolderName)
	if oldFolder then oldFolder:Destroy() end
	if ESPFruitConnection then
		ESPFruitConnection:Disconnect()
		ESPFruitConnection = nil
	end
	if State ~= true then return end

	local espFruitList = GetSelectedItems(Options.ddFruitESP.Value)
	if table.find(espFruitList, "NONE") then return end

	local ESPFolder = Instance.new("Folder")
	ESPFolder.Name = FruitESPFolderName
	ESPFolder.Parent = TargetFolder

	for _, prompt in pairs(CollectionService:GetTagged("HarvestPrompt")) do
		--if prompt.Enabled then SetespFruit(prompt) end
		SetespFruit(prompt)
	end
	ESPFruitConnection = CollectionService:GetInstanceAddedSignal("HarvestPrompt"):Connect(SetespFruit)
end

RemovePlants = function()
	if not Options.tgRemovePlantsEnable.Value or isRemovePlants then return end
	local RemovePlantsList = GetSelectedItems(Options.ddRemovePlants.Value)

	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	local Backpack = LocalPlayer.Backpack
	local Shovel = Backpack:FindFirstChild("Shovel", true)
	local RemovePlant = RemoteEvents.RemovePlant
	if ClientPlants then
		isRemovePlants = true
		for _, plant in pairs(ClientPlants:GetChildren()) do
			local PlantType = plant:GetAttribute("PlantType")
			if PlantType then
				if table.find(RemovePlantsList, "ALL") or table.find(RemovePlantsList, PlantType) then
					pcall(function()
						Humanoid:UnequipTools()
					end)
					print(PlantType)
					task.wait()
					Humanoid:EquipTool(Shovel)
					task.wait()
					local Uuid = plant:GetAttribute("Uuid")

					local targetCFrame = CFrame.new(plant:GetPivot().Position + Vector3.new(3, 0, 4))
					TweenToTarget(targetCFrame, 100)
					RemovePlant:FireServer(Uuid)
					task.wait()
				end
			end
		end
		isRemovePlants = false
	end
end

RemoveCrops = function()
	if not Options.tgRemoveFruitEnable.Value then return end
	local RemoveCropsList = GetSelectedItems(Options.ddRemoveCrops.Value)
	if table.find(RemoveCropsList, "NONE") then return end
end

local lastTriggerMinute = -1
NewPlayer = function()
	local timeData = os.date("!*t")
	local currentMinute = timeData.min
	local ipNewDelay = tonumber(Options.ipNewDelay.Value)
	if currentMinute % ipNewDelay == 0 and currentMinute ~= lastTriggerMinute then
		lastTriggerMinute = currentMinute
		if Options.tgNewAutoSell.Value then
			HarvestPause = true
			table.clear(HarVestCropsList)
			table.insert(actionQueue, {
				FuncName = AutoSellCrops,
			})
		end
		if Options.tgPlantsEnable.Value then table.insert(actionQueue, {
			FuncName = AutoPlantsSeeds,
		}) end
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
			elseif RemoteName == "UpdateQuests" then
				table.insert(actionQueue, {
					FuncName = AutoClaimQuest,
					args = args[1],
				})
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

task.spawn(function()
	while true do
		pcall(NewPlayer)
		task.wait(10)
	end
end)

--Watch Dog
task.spawn(function()
	while true do
		task.wait(3600)
		if Options.tgPlantsESP and Options.tgPlantsESP.Value == true then Options.tgPlantsESP:SetValue(false) end
		if Options.tgFruitESP and Options.tgFruitESP.Value == true then Options.tgFruitESP:SetValue(false) end
		if ResetControlVariable then ResetControlVariable() end
	end
end)

-- [[ Tracker System: ดักจับต้นไม้ที่ปลูกใหม่ ]]

SetupTracker = function()
	local ClientPlants = workspace:FindFirstChild("ClientPlants")
	if not ClientPlants then return end

	ClientPlants.DescendantAdded:Connect(function(newPlant)
		task.wait(0.5)

		for _, obj in ipairs(newPlant:GetDescendants()) do
			if obj.Name == "PlantAnchor" then
				local parent = obj.Parent

				if Options.tgPlantsESP.Value then
					if parent:GetAttribute("HarvestablePlant") then
						SetespFruit(obj)
					else
						SetespPlant(obj)
					end
				end

				if parent:GetAttribute("HarvestablePlant") then
					if Options.tgHideFruit.Value then
						for _, sibling in ipairs(obj.Parent:GetChildren()) do
							SetVisibility(sibling, true)
						end
					end
				else
					if Options.tgHidePlant.Value then
						for _, sibling in ipairs(parent:GetChildren()) do
							SetVisibility(sibling, true)
						end
					end
				end
			elseif obj.Name == "FruitAnchor" then
				local parent = obj.Parent
				if Options.tgFruitESP.Value then SetespFruit(obj) end
				if Options.tgHideFruit.Value then
					for _, sibling in ipairs(parent:GetChildren()) do
						SetVisibility(sibling, true)
					end
				end
			end
		end
	end)
end

SetupTracker()
