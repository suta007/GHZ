local Strange = {}
local reg
local EventsTab

function Strange.Initialize(registry, tab)
	reg = registry
	EventsTab = tab
	local Options = reg.Options
	local QuickSave = reg.Window.QuickSave

	local StrangeSection = EventsTab:AddCollapsibleSection("Strange", false)
	StrangeSection:AddToggle("tgStrangeEnable", {
		Title = "Strange",
		Default = false,
		Callback = function(Value)
			QuickSave()
		end,
	})
end

return Strange
