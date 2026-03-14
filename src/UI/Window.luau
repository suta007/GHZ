--!nocheck
local Window = {}
local Registry = nil

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local CollapsibleAddon = loadstring(game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()
CollapsibleAddon(Fluent)

function Window.Initialize(reg)
	Registry = reg
	local Constants = reg.Constants

	local interface = Fluent:CreateWindow({
		Title = "Garden Horizons",
		SubTitle = "v" .. Constants.Version,
		TabWidth = 160,
		Size = UDim2.fromOffset(580, 460),
		Acrylic = true,
		Theme = "Dark",
		MinimizeKey = Enum.KeyCode.RightControl,
	})

	local Tabs = {
		Main = interface:AddTab({ Title = "Dashboard", Icon = "home" }),
		Shop = interface:AddTab({ Title = "Trading", Icon = "shopping-cart" }),
		Event = interface:AddTab({ Title = "Event", Icon = "calendar" }),
		Auto = interface:AddTab({ Title = "Auto", Icon = "zap" }),
		Misc = interface:AddTab({ Title = "Misc", Icon = "settings" }),
		Settings = interface:AddTab({ Title = "Settings", Icon = "cog" }),
	}

	SaveManager:SetLibrary(Fluent)
	InterfaceManager:SetLibrary(Fluent)
	SaveManager:IgnoreThemeSettings()
	SaveManager:SetIgnoreIndexes({})
	SaveManager:SetFolder("Horizons")

	return interface, Tabs, Fluent, SaveManager, InterfaceManager
end

return Window
