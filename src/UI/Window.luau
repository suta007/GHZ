--!nocheck
local Window = {}

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/FluentData/Renewed/Fluent.luau", true))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()
CollapsibleAddon(Fluent)

local Constants = require(script.Parent.Parent.Core.Constants)

function Window.Initialize()
	local interface = Fluent:CreateWindow({
		Title = "Garden Horizons",
		SubTitle = "by EfHub v " .. Constants.Version,
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

	SaveManager:SetLibrary(Fluent)
	InterfaceManager:SetLibrary(Fluent)
	InterfaceManager:SetFolder("EfHub")
	SaveManager:SetFolder("EfHub/HRZ")

	return interface, Tabs, Fluent, SaveManager, InterfaceManager
end

return Window
