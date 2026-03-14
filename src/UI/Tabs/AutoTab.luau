--!nocheck
local AutoTab = {}

function AutoTab.Setup(tab, Options, SaveManager, Registry)
	-- Quest Section
	local QuestSection = tab:AddCollapsibleSection("Quest", false)
	QuestSection:AddToggle("tgQuestEnable", {
		Title = "Auto Claim Quest",
		Default = false,
		Callback = function(Value)
			if Value then 
				Registry.Network.Events.RequestQuests:FireServer() 
			end
			SaveManager:Save("Horizons")
		end,
	})

	-- Removal Section
	local RemoveSection = tab:AddCollapsibleSection("Remove Plants", false)
	RemoveSection:AddToggle("tgRemovePlantsEnable", {
		Title = "Auto Remove Plants",
		Default = false,
	})
end

return AutoTab
