local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v3 = require(v2:WaitForChild("Gears"):WaitForChild("Definitions"):WaitForChild("GearDefinitions"))
local v_u_4 = v3.Gears
local v_u_5 = v3.DefaultCooldown
local v_u_6 = require(script.Parent:WaitForChild("HarvestBellController"))
local v_u_7 = require(script.Parent:WaitForChild("Sprinklers"):WaitForChild("SprinklerController"))
local v_u_8 = require(script.Parent:WaitForChild("WateringCanController"))
local v_u_9 = require(script.Parent:WaitForChild("FavoriteToolController"))
local v_u_10 = require(script.Parent:WaitForChild("TrowelController"))
local v_u_11 = require(script.Parent:WaitForChild("ReverterController"))
local v12 = v1.LocalPlayer
local v_u_13 = 0
local v_u_14 = nil
local v_u_15 = nil
local function v_u_19(p16)
	-- upvalues: (copy) v_u_4
	local v17 = p16:GetAttribute("GearName")
	if v17 and v_u_4[v17] then
		return v17
	end
	for v18, _ in pairs(v_u_4) do
		if p16.Name == v18 or p16.Name:match(v18) then
			return v18
		end
	end
	return nil
end
local function v_u_21()
	-- upvalues: (copy) v_u_4, (ref) v_u_15, (copy) v_u_5, (ref) v_u_13
	local v20 = v_u_4[v_u_15]
	return (v20 and v20.Cooldown or v_u_5) <= tick() - v_u_13
end
local function v_u_22()
	-- upvalues: (ref) v_u_13
	v_u_13 = tick()
end
local function v_u_27(p23)
	-- upvalues: (copy) v_u_19, (copy) v_u_4, (ref) v_u_14, (ref) v_u_15, (copy) v_u_6, (copy) v_u_21, (copy) v_u_22, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11
	local v24 = v_u_19(p23)
	if v24 then
		local v25 = v_u_4[v24]
		if v25 then
			v_u_14 = p23
			v_u_15 = v24
			local v26 = v25.GearType
			if v26 == "HarvestBell" then
				v_u_6.Activate(v24, p23, v_u_21, v_u_22)
				return
			elseif v26 == "Sprinkler" then
				v_u_7.Activate(v24, p23, v_u_21, v_u_22)
				return
			elseif v26 == "WateringCan" then
				v_u_8.Activate(v24, p23, v_u_21, v_u_22)
				return
			elseif v26 == "FavoriteTool" then
				v_u_9.Activate(v24, p23, v_u_21, v_u_22)
				return
			elseif v26 == "Trowel" then
				v_u_10.Activate(v24, p23, v_u_21, v_u_22)
			elseif v26 == "Reverter" then
				v_u_11.Activate(v24, p23, v_u_21, v_u_22)
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_31(p28)
	-- upvalues: (ref) v_u_14, (copy) v_u_4, (ref) v_u_15, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8, (copy) v_u_9, (copy) v_u_10, (copy) v_u_11
	if p28 == v_u_14 then
		local v29 = v_u_4[v_u_15]
		if v29 then
			local v30 = v29.GearType
			if v30 == "HarvestBell" then
				v_u_6.Deactivate()
			elseif v30 == "Sprinkler" then
				v_u_7.Deactivate()
			elseif v30 == "WateringCan" then
				v_u_8.Deactivate()
			elseif v30 == "FavoriteTool" then
				v_u_9.Deactivate()
			elseif v30 == "Trowel" then
				v_u_10.Deactivate()
			elseif v30 == "Reverter" then
				v_u_11.Deactivate()
			end
			v_u_14 = nil
			v_u_15 = nil
		else
			v_u_14 = nil
			v_u_15 = nil
		end
	else
		return
	end
end
local function v36(p32)
	-- upvalues: (copy) v_u_27, (copy) v_u_31
	p32.ChildAdded:Connect(function(p33)
		-- upvalues: (ref) v_u_27
		if p33:IsA("Tool") then
			v_u_27(p33)
		end
	end)
	p32.ChildRemoved:Connect(function(p34)
		-- upvalues: (ref) v_u_31
		if p34:IsA("Tool") then
			v_u_31(p34)
		end
	end)
	for _, v35 in p32:GetChildren() do
		if v35:IsA("Tool") then
			v_u_27(v35)
		end
	end
end
if v12.Character then
	v36(v12.Character)
end
v12.CharacterAdded:Connect(v36)
v_u_7.Init()