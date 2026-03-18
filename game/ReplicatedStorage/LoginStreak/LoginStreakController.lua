local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = require(v1.LoginStreak.LoginStreakDefinitions)
local v_u_4 = require(v1.Plants.Definitions.PlantDataDefinitions)
local v_u_5 = require(v1.Gears.Definitions.GearDefinitions)
local v_u_6 = require(v1.RNGPacks.SeedPackDefinitions)
local v_u_7 = require(v1.Player.NotificationService)
local v8 = v1.RemoteEvents
local v_u_9 = v8.ClaimLoginStreak
local v10 = v8.LoginStreakStatus
local v11 = v8.LoginStreakClaimed
local v_u_12 = {
	["SmallItem"] = "rbxassetid://93639142092939",
	["SmallItemUnavailable"] = "rbxassetid://74020568998466",
	["LargeItem"] = "rbxassetid://71247750411874",
	["LargeItemUnavailable"] = "rbxassetid://111919321536803"
}
local v13 = {}
local v_u_14 = 0
local v_u_15 = nil
local v_u_16 = false
local v_u_17 = false
local v_u_18 = nil
local v_u_19 = nil
local v_u_20 = false
local function v_u_28(p21)
	-- upvalues: (copy) v_u_4, (copy) v_u_5, (copy) v_u_6
	if not p21 then
		return nil
	end
	if p21.Type == "Seed" then
		local v22 = v_u_4[p21.Item:gsub(" Seed$", "")]
		if v22 then
			local v23 = v22.SeedAssetId
			if v23 then
				if v23 == "" or v23 == "rbxassetid://" then
					v23 = false
				else
					v23 = v23 ~= "rbxassetid://0"
				end
			end
			if v23 then
				return v22.SeedAssetId
			end
		end
	elseif p21.Type == "Gear" then
		local v24 = v_u_5.Gears[p21.Item]
		if v24 then
			local v25 = v24.IconAssetId
			if v25 then
				if v25 == "" or v25 == "rbxassetid://" then
					v25 = false
				else
					v25 = v25 ~= "rbxassetid://0"
				end
			end
			if v25 then
				return v24.IconAssetId
			end
		end
	else
		local v26 = p21.Type == "SeedPack" and v_u_6[p21.Item]
		if v26 then
			local v27 = v26.Image
			if v27 then
				if v27 == "" or v27 == "rbxassetid://" then
					v27 = false
				else
					v27 = v27 ~= "rbxassetid://0"
				end
			end
			if v27 then
				return v26.Image
			end
		end
	end
	return nil
end
local function v_u_32(p29)
	local v30 = p29:FindFirstChild("RewardFrame")
	if not v30 then
		return nil
	end
	local v31 = Instance.new("ImageLabel")
	v31.Name = "RewardIcon"
	v31.BackgroundTransparency = 1
	v31.Size = UDim2.fromScale(1, 1)
	v31.Position = UDim2.fromScale(0, 0)
	v31.AnchorPoint = Vector2.new(0, 0)
	v31.ScaleType = Enum.ScaleType.Fit
	v31.Visible = false
	v31.Parent = v30
	return v31
end
local function v_u_37(p33)
	if p33.Type == "SeedPack" or (p33.Type == "Seed" or p33.Type == "Gear") then
		return "x" .. p33.Amount
	else
		local v34 = p33.Amount
		if v34 >= 1000000 then
			local v35 = v34 / 1000000
			if v35 == math.floor(v35) then
				return math.floor(v35) .. "M"
			else
				return string.format("%.1fM", v35)
			end
		else
			if v34 < 1000 then
				return tostring(v34)
			end
			local v36 = v34 / 1000
			return math.floor(v36) .. "K"
		end
	end
end
local function v_u_69()
	-- upvalues: (ref) v_u_17, (ref) v_u_15, (ref) v_u_14, (ref) v_u_18, (copy) v_u_3, (copy) v_u_37, (ref) v_u_16, (copy) v_u_12, (copy) v_u_28, (ref) v_u_19
	if v_u_17 then
		local v38
		if v_u_15 then
			v38 = v_u_15
			v_u_15 = nil
		else
			v38 = v_u_14 == 0 and 1 or (v_u_14 >= 28 and 29 or v_u_14 + 1)
		end
		local v39
		if v_u_14 >= 28 then
			v39 = 4
		else
			local v40 = v38 / 7
			local v41 = math.ceil(v40)
			v39 = math.clamp(v41, 1, 4)
		end
		local v42 = (v39 - 1) * 7 + 1
		for v43 = 1, 6 do
			local v44 = v42 + v43 - 1
			local v45 = v_u_18:FindFirstChild("Day" .. v43)
			if v45 then
				local v46 = v45:FindFirstChild("DayText")
				if v46 then
					v46.Text = "Day " .. v44
				end
				local v47 = v_u_3.GetReward(v44)
				local v48 = v45:FindFirstChild("Quantity")
				if v48 and v47 then
					v48.Text = v_u_37(v47)
				end
				local v49 = v44 <= v_u_14
				local v50 = v44 == v38 and v_u_16
				if v50 then
					v50 = v_u_14 < 28
				end
				local v51 = v49 or v50
				if v51 then
					v45.Image = v_u_12.SmallItem
				else
					v45.Image = v_u_12.SmallItemUnavailable
				end
				if v48 then
					v48.Visible = v51
				end
				local v52 = v45:FindFirstChild("QuantityUnavailable")
				if v52 and v47 then
					v52.Text = v_u_37(v47)
					v52.Visible = not v51
				end
				local v53 = v45:FindFirstChild("RewardFrame")
				if v53 then
					v53 = v53:FindFirstChild("RewardIcon")
				end
				if v53 then
					local v54 = v_u_28(v47)
					if v54 then
						v53.Image = v54
						v53.Visible = true
						if v47.Type == "SeedPack" then
							v53.AnchorPoint = Vector2.new(0.5, 1)
							v53.Position = UDim2.fromScale(0.5, 1)
						else
							v53.AnchorPoint = Vector2.new(0, 0)
							v53.Position = UDim2.fromScale(0, 0)
						end
					else
						v53.Visible = false
					end
				end
				if v53 then
					v53.ImageTransparency = v51 and 0 or 0.5
				end
				local v55 = v45:FindFirstChild("Claimed")
				if v55 then
					v55.Visible = v49
				end
				local v56 = v45:FindFirstChild("Claim")
				if v56 then
					v56.Visible = v50
				end
			end
		end
		local v57 = v42 + 6
		local v58 = v_u_19:FindFirstChild("DayText")
		if v58 then
			v58.Text = "Day " .. v57
		end
		local v59 = v_u_3.GetReward(v57)
		local v60 = v_u_19:FindFirstChild("Quantity")
		if v60 and v59 then
			v60.Text = v_u_37(v59)
		end
		local v61 = v57 <= v_u_14
		local v62 = v57 == v38 and v_u_16
		if v62 then
			v62 = v_u_14 < 28
		end
		local v63 = v61 or v62
		if v63 then
			v_u_19.Image = v_u_12.LargeItem
		else
			v_u_19.Image = v_u_12.LargeItemUnavailable
		end
		if v60 then
			v60.Visible = v63
		end
		local v64 = v_u_19:FindFirstChild("QuantityUnavailable")
		if v64 and v59 then
			v64.Text = v_u_37(v59)
			v64.Visible = not v63
		end
		local v65 = v_u_19:FindFirstChild("RewardFrame")
		if v65 then
			v65 = v65:FindFirstChild("RewardIcon")
		end
		if v65 then
			local v66 = v_u_28(v59)
			if v66 then
				v65.Image = v66
				v65.Visible = true
				if v59.Type == "SeedPack" then
					v65.AnchorPoint = Vector2.new(0.5, 1)
					v65.Position = UDim2.fromScale(0.5, 1)
				else
					v65.AnchorPoint = Vector2.new(0, 0)
					v65.Position = UDim2.fromScale(0, 0)
				end
			else
				v65.Visible = false
			end
		end
		if v65 then
			v65.ImageTransparency = v63 and 0 or 0.5
		end
		local v67 = v_u_19:FindFirstChild("Claimed")
		if v67 then
			v67.Visible = v61
		end
		local v68 = v_u_19:FindFirstChild("Claim")
		if v68 then
			v68.Visible = v62
		end
	end
end
local function v_u_70()
	-- upvalues: (copy) v_u_9
	v_u_9:FireServer()
end
function v13.Init()
	-- upvalues: (ref) v_u_17, (copy) v_u_2, (ref) v_u_18, (ref) v_u_19, (copy) v_u_32, (copy) v_u_70, (copy) v_u_69
	if not v_u_17 then
		local v_u_71 = v_u_2.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("LoginStreak")
		local v72 = v_u_71:WaitForChild("Background")
		local v73 = v72:WaitForChild("Content")
		v_u_18 = v73:WaitForChild("Frame")
		v_u_19 = v73:WaitForChild("Milestone")
		for v74 = 1, 6 do
			local v75 = v_u_18:FindFirstChild("Day" .. v74)
			if v75 then
				v_u_32(v75)
				local v76 = v75:FindFirstChild("Claim")
				if v76 then
					v76.Activated:Connect(v_u_70)
				end
			end
		end
		v_u_32(v_u_19)
		local v77 = v_u_19:FindFirstChild("Claim")
		if v77 then
			v77.Activated:Connect(v_u_70)
		end
		v72:WaitForChild("CloseButton").Activated:Connect(function()
			-- upvalues: (copy) v_u_71
			v_u_71.Enabled = false
		end)
		for v78 = 1, 6 do
			local v79 = v_u_18:FindFirstChild("Day" .. v78)
			if v79 then
				local v80 = v79:FindFirstChild("Claim")
				local v81 = v79:FindFirstChild("Claimed")
				if v80 then
					v80.Visible = false
				end
				if v81 then
					v81.Visible = false
				end
			end
		end
		local v82 = v_u_19:FindFirstChild("Claim")
		local v83 = v_u_19:FindFirstChild("Claimed")
		if v82 then
			v82.Visible = false
		end
		if v83 then
			v83.Visible = false
		end
		v_u_17 = true
		v_u_69()
	end
end
function v13.OnStreakDataChanged(p84)
	-- upvalues: (ref) v_u_14, (ref) v_u_20, (copy) v_u_69
	v_u_14 = p84.CurrentDay
	if v_u_20 then
		v_u_20 = false
	else
		v_u_69()
	end
end
v10.OnClientEvent:Connect(function(p85)
	-- upvalues: (ref) v_u_14, (ref) v_u_15, (ref) v_u_16, (copy) v_u_69
	v_u_14 = p85.currentDay
	if p85.displayDay then
		v_u_15 = p85.displayDay
	end
	v_u_16 = p85.isEligible
	v_u_69()
end)
v11.OnClientEvent:Connect(function(p86)
	-- upvalues: (ref) v_u_14, (ref) v_u_16, (ref) v_u_20, (copy) v_u_69, (copy) v_u_7
	v_u_14 = p86.day
	v_u_16 = false
	v_u_20 = true
	v_u_69()
	local v87 = p86.rewardItem or "Reward"
	local v88 = p86.rewardAmount or 1
	v_u_7.NotifySound("Day " .. p86.day .. " Reward: " .. v87 .. " x" .. v88, 5)
end)
return v13