--!nocheck

local GHZ_REMOTE = GHZ_REMOTE or getgenv().GHZ_REMOTE
local EventsTab = {}
local reg
local Tabs

local function LoadEvents()
	local Events = {}
	if getgenv().DEV_MODE then
		Events.Strange = GHZ_REMOTE("UI/Tabs/Events/Strange")
	else
		Events.Strange = require("./Events/Strange.luau")
	end
	return Events
end

function EventsTab.Initialize(registry)
	reg = registry
	local Interface = reg.Interface
	Tabs = reg.Tabs
	--local Options = reg.Options
	--local QuickSave = reg.Window.QuickSave

	Tabs.Events = Interface:AddTab({ Title = "Events", Icon = "calendar" })

	local Events = LoadEvents()
	Events.Strange.Initialize(reg, Tabs.Events)

	--return Events
end

return EventsTab
