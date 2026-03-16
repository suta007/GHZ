local GHZ_REMOTE = GHZ_REMOTE or getgenv().GHZ_REMOTE
local EventsTab = {}
local reg
local Tabs

local function LoadEvents()
	local Events = {}
	Events.Strange = GHZ_REMOTE("UI/Tabs/Events/Strange")
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
end

return EventsTab
