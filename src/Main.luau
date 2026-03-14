local Main = {}

local function LoadModules()
	local Registry = {}
	-- 1. Core
	Registry.Constants = GHZ_REMOTE("Core/Constants")
	-- 3. UI Modules
	Registry.Window = GHZ_REMOTE("UI/Window")

	return Registry
end

function Main.Initailize()
	local Registry = LoadModules()
	Registry.Window.Initialize(Registry)
end
return Main
