---@diagnostic disable-next-line: undefined-global
local GHZ_REMOTE = GHZ_REMOTE or getgenv().GHZ_REMOTE
local Main = {}

local function LoadModules()
	local Registry = {}
	-- 1. Core
	--Registry.Constants = GHZ_REMOTE("Core/Constants")
	-- 3. UI Modules
	Registry.Window = GHZ_REMOTE("UI/Window")
	Registry.MainTab = GHZ_REMOTE("UI/Tabs/MainTab")

	return Registry
end

function Main.Initialize()
	local Registry = LoadModules()
	Registry.Window.Initialize(Registry)
	Registry.MainTab.Initialize(Registry)

	Registry.Window.Finalize()

	return Registry
end
return Main
