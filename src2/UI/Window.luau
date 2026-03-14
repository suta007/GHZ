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

	return interface, Tabs, Fluent, SaveManager, InterfaceManager
end

return Window
