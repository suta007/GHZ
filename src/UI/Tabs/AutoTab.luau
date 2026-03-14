--!nocheck
local AutoTab = {}

local State = require(script.Parent.Parent.Parent.Core.State)
local Quest = require(script.Parent.Parent.Parent.Modules.Quest)

function AutoTab.Setup(tab, Options, SaveManager)
	-- Quest Section
	local QuestSection = tab:AddCollapsibleSection("Quest", false)
	QuestSection:AddToggle("tgQuestEnable", {
		Title = "Auto Claim Quest",
		Default = false,
		Callback = function(Value)
			if Value then 
				require(script.Parent.Parent.Parent.Core.Network).Events.RequestQuests:FireServer() 
			end
			SaveManager:Save("Horizons")
		end,
	})

	-- Removal Section
	local RemoveSection = tab:AddCollapsibleSection("Remove Plants", false)
	RemoveSection:AddToggle("tgRemovePlantsEnable", {
		Title = "Auto Remove Plants",
		Default = false,
		Callback = function() SaveManager:Save("Horizons") end,
	})
	
	RemoveSection:AddDropdown("ddRemovePlants", {
		Title = "Select Remove Plants",
		Values = { "ALL", "NONE" }, -- Simplified for now, should be populated like MainTab
		Default = {},
		Multi = true,
		Searchable = true,
		Callback = function() SaveManager:Save("Horizons") end,
	})

	local RemoveFruitSection = tab:AddCollapsibleSection("Remove Fruit", false)
	RemoveFruitSection:AddToggle("tgRemoveFruitEnable", {
		Title = "Auto Remove Fruit",
		Default = false,
		Callback = function() SaveManager:Save("Horizons") end,
	})
end

return AutoTab
