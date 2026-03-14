--!nocheck
local Window = {}
local Registry = nil

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()
CollapsibleAddon(Fluent)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ShopData = ReplicatedStorage:WaitForChild("Shop"):WaitForChild("ShopData")
local PlantData = ReplicatedStorage:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("PlantDataDefinitions")
local MutationData = ReplicatedStorage:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("MutationDataDefinitions")

local function getShopData(path)
	local names = { "ALL" }
	local success, data = pcall(require, ShopData[path])
	if success then
		for _, item in pairs(data.ShopData) do
			table.insert(names, item.Name)
		end
	end
	return names
end

function Window.Initialize(reg)
	Registry = reg
	--local Constants = reg.Constants

	local interface = Fluent:CreateWindow({
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
		Main = interface:AddTab({ Title = "Main", Icon = "house" }),
		Shop = interface:AddTab({ Title = "Shop", Icon = "shopping-cart" }),
		Auto = interface:AddTab({ Title = "Automatic", Icon = "bot" }),
		Event = interface:AddTab({ Title = "Event", Icon = "calendar" }),
		Misc = interface:AddTab({ Title = "Misc", Icon = "component" }),
		Settings = interface:AddTab({ Title = "Settings", Icon = "settings" }),
	}

	-- Data for Dropdowns
	local UIData = {
		SeedShopTable = getShopData("SeedShopData"),
		GearShopTable = getShopData("GearShopData"),
		PlantDataTable = { "ALL" },
		SeedDataTable = { "ALL" },
		MutationDataTable = { "ALL" },
		PlantDataBlackTable = {},
		MutationDataBlackTable = {},
	}

	local pData = require(PlantData)
	for PlantName, _ in pairs(pData) do
		table.insert(UIData.PlantDataTable, PlantName)
		table.insert(UIData.SeedDataTable, PlantName .. " Seed")
	end

	local mData = require(MutationData)
	for MutationName, _ in pairs(mData) do
		table.insert(UIData.MutationDataTable, MutationName)
	end

	UIData.PlantDataBlackTable = table.clone(UIData.PlantDataTable)
	UIData.PlantDataBlackTable[1] = "NONE"

	UIData.MutationDataBlackTable = table.clone(UIData.MutationDataTable)
	UIData.MutationDataBlackTable[1] = "NONE"

	Registry.UIData = UIData

	SaveManager:SetLibrary(Fluent)
	InterfaceManager:SetLibrary(Fluent)
	--SaveManager:IgnoreThemeSettings()
	--SaveManager:SetIgnoreIndexes({})
	SaveManager:SetFolder("EfHub/GHZs")
	InterfaceManager:SetFolder("EfHub")

	------------------------------------------------------
	-- ระบบปุ่มลอย (Floating Button) สำหรับ Android
	------------------------------------------------------
	local success, result = pcall(function()
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
				interface.Instance.Enabled = not interface.Instance.Enabled
			end)
		end)
	end)

	return interface, Tabs, Fluent, SaveManager, InterfaceManager
end

return Window
