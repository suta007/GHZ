--!nocheck
local EventTab = {}

function EventTab.Setup(tab, Options, SaveManager, Registry)
	local MannyMishap = Registry.MannyMishap

	-- Manny Mishap Section
	local MannySection = tab:AddCollapsibleSection("Manny Mishap", false)
	MannySection:AddToggle("tgMannyMishapEnable", {
		Title = "Auto Manny Mishap Collect",
		Default = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})
end

return EventTab
