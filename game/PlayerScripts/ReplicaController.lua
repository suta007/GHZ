local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.ReplicaClient)
game.Players.LocalPlayer:WaitForChild("PlayerGui")
local v_u_3 = require(v1:WaitForChild("Economy"):WaitForChild("CurrencyController"))
local v_u_4 = require(v1:WaitForChild("Shop"):WaitForChild("SeedShopController"))
local v_u_5 = require(v1:WaitForChild("Shop"):WaitForChild("GearShopController"))
local v_u_6 = require(v1:WaitForChild("Tutorial"):WaitForChild("TutorialController"))
local v_u_7 = game:GetService("SoundService"):WaitForChild("SFX"):WaitForChild("UI")
local v_u_8 = require(v1:WaitForChild("Player"):WaitForChild("NotificationService"))
local v_u_9 = require(v1:WaitForChild("UI"):WaitForChild("FloraBookController"))
local v_u_10 = require(v1:WaitForChild("LoginStreak"):WaitForChild("LoginStreakController"))
v2.OnNew("PlayerData_" .. game.Players.LocalPlayer.UserId, function(p_u_11)
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5, (copy) v_u_9, (copy) v_u_6, (copy) v_u_10, (copy) v_u_7, (copy) v_u_8
	v_u_3:UpdateValue(p_u_11.Data.Money)
	v_u_4.RestockItems(p_u_11.Data.SeedShop)
	v_u_5.RestockItems(p_u_11.Data.GearShop)
	v_u_9:UpdateStatValues(p_u_11)
	local v12 = v_u_6.new()
	if p_u_11.Data.TutorialCompleted then
		v12.Completed = true
	end
	v12:Run()
	print("Replica loaded")
	task.spawn(v_u_10.Init)
	p_u_11:OnChange(function(_, p13, p14, _)
		-- upvalues: (ref) v_u_4, (copy) p_u_11, (ref) v_u_7, (ref) v_u_8, (ref) v_u_5, (ref) v_u_10, (ref) v_u_9, (ref) v_u_6
		if p13[1] == "SeedShop" and p13[2] ~= "AdminRestock" then
			v_u_4.RestockItems(p_u_11.Data.SeedShop)
			if not v_u_4.IsPurchasing then
				v_u_7:WaitForChild("Restock"):Play()
				if p_u_11.Data.SeedShop.AdminRestock then
					v_u_8.Notify("The Seed Shop has been restocked by an Admin!")
				else
					v_u_8.Notify("The Seed Shop has been restocked!")
				end
			end
		elseif p13[1] == "GearShop" and p13[2] ~= "AdminRestock" then
			v_u_5.RestockItems(p_u_11.Data.GearShop)
			if not v_u_5.IsPurchasing then
				v_u_7:WaitForChild("Restock"):Play()
				if p_u_11.Data.GearShop.AdminRestock then
					v_u_8.Notify("The Gear Shop has been restocked by an Admin!")
				else
					v_u_8.Notify("The Gear Shop has been restocked!")
				end
			end
		end
		if p13[1] == "LoginStreak" then
			v_u_10.OnStreakDataChanged(p_u_11.Data.LoginStreak)
		end
		if p13[1] == "FloraBook" then
			v_u_9:UpdateStatValues(p_u_11)
		end
		if p13[1] == "FloraBook" and (p13[2] == "Plants" and (p13[4] == "TotalHarvested" and p14 == 1)) then
			v_u_9:UpdateStatValues(p_u_11)
			local v15 = p13[3]
			local v16 = v_u_6.GetInstance()
			local v17 = v16 and not v16.Completed
			if v17 then
				v17 = v15 == "Carrot"
			end
			if not v17 then
				v_u_8.NotifySound("You discovered " .. tostring(v15) .. "! Open the Flora Book to see it!")
			end
		end
	end)
	p_u_11:OnSet({ "Money" }, function()
		-- upvalues: (ref) v_u_3, (copy) p_u_11, (ref) v_u_9
		v_u_3:UpdateValue(p_u_11.Data.Money)
		v_u_9:UpdateStatValues(p_u_11)
	end)
end)
v2.RequestData()