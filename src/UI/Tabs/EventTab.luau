--!nocheck
local EventTab = {}

local _State = require(script.Parent.Parent.Parent.Core.State)
local _MannyMishap = require(script.Parent.Parent.Parent.Modules.Events.MannyMishap)

function EventTab.Setup(tab, Options, SaveManager)
	-- Manny Mishap Section
	local MannySection = tab:AddCollapsibleSection("Manny Mishap", false)
	MannySection:AddToggle("tgMannyMishapEnable", {
		Title = "Auto Manny Mishap Collect",
		Default = false,
		Callback = function(Value)
			SaveManager:Save("Horizons")
		end,
	})

	-- Here is where other events can be added easily
	-- Example: 
	-- local SummerEventSection = tab:AddCollapsibleSection("Summer Event", false)
	-- ...
end

return EventTab
