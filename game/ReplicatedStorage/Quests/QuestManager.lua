local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1.Economy.Formatter.NumberFormatter)
local v_u_28 = {
	["GetRefreshPrice"] = function(p3, p4)
		return (p4 == "Weekly" and 350000 or 50000) * ((p3 or 0) + 1)
	end,
	["UpdateEntry"] = function(p5, p6, p7, p8)
		-- upvalues: (copy) v_u_2, (copy) v_u_28
		if p6 then
			p5.Visible = true
			p5.QuestName.Text = p6.Description
			p5.QuestReward.RichText = true
			local v9 = p6.RewardType == "Shillings" and v_u_2:FormatFull(p6.RewardAmount)
			if not v9 then
				local v10 = p6.RewardAmount
				v9 = tostring(v10)
			end
			p5.QuestReward.Text = "Reward: <font color=\"#62d45e\">" .. v9 .. "x " .. (p6.RewardItem or "Shillings") .. "</font>"
			if p6.Claimed then
				p5.QuestStatus.Text = "Claimed!"
				p5.Claim.Visible = false
				if p5:FindFirstChild("Refresh") then
					p5.Refresh.Visible = true
				end
			elseif p6.Progress >= p6.Goal then
				p5.QuestStatus.Text = "Ready!"
				p5.Claim.Visible = true
				p5.Claim.Text = "Claim!"
				if p5:FindFirstChild("Refresh") then
					p5.Refresh.Visible = false
				end
			else
				p5.QuestStatus.Text = v_u_2:FormatNumberShort(p6.Progress) .. "/" .. v_u_2:FormatNumberShort(p6.Goal)
				p5.Claim.Visible = false
				if p5:FindFirstChild("Refresh") then
					p5.Refresh.Visible = false
				end
			end
			local v11 = p5:FindFirstChild("RefreshShadow")
			if v11 then
				local v12 = v11:FindFirstChild("PurchaseButton")
				local v13 = v12 and v12:FindFirstChild("PriceLabel")
				if v13 then
					v13.Text = v_u_2:FormatFull((v_u_28.GetRefreshPrice(p7, p8))) .. " Shillings"
				end
			end
		else
			p5.Visible = false
		end
	end,
	["FormatDailyTimer"] = function(p14)
		local v15 = p14 / 86400
		local v16 = (math.floor(v15) + 1) * 86400 - p14
		local v17 = string.format
		local v18 = v16 / 3600
		local v19 = math.floor(v18)
		local v20 = v16 % 3600 / 60
		return v17("%02d:%02d:%02d", v19, math.floor(v20), v16 % 60)
	end,
	["FormatWeeklyTimer"] = function(p21)
		local v22 = (p21 - 345600) / 604800
		local v23 = (math.floor(v22) + 1) * 604800 + 345600 - p21
		local v24 = string.format
		local v25 = v23 / 86400
		local v26 = math.floor(v25)
		local v27 = v23 % 86400 / 3600
		return v24("%dd %dh", v26, (math.floor(v27)))
	end
}
return v_u_28