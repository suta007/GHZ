local v_u_1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = v_u_1.LocalPlayer
local v4 = workspace:WaitForChild("Plots")
local v5 = v2:WaitForChild("RemoteEvents")
local v_u_6 = v5:WaitForChild("LikeGarden")
local v7 = v5:WaitForChild("GardenLiked")
local v_u_8 = {}
local function v_u_19(p_u_9)
	-- upvalues: (copy) v_u_3, (copy) v_u_8, (copy) v_u_6
	local v10 = p_u_9:WaitForChild("PlayerSign")
	if v10 then
		local v11 = v10:WaitForChild("Main")
		if v11 then
			local v_u_12 = v11:WaitForChild("LikeGarden")
			if v_u_12 then
				local function v15()
					-- upvalues: (copy) p_u_9, (ref) v_u_3, (copy) v_u_12, (ref) v_u_8
					local v13 = p_u_9
					local v14 = tonumber(v13:GetAttribute("Owner"))
					if v14 and v14 ~= v_u_3.UserId then
						if v_u_8[v14] then
							v_u_12.Enabled = false
						else
							v_u_12.Enabled = true
						end
					else
						v_u_12.Enabled = false
						return
					end
				end
				local v16 = tonumber(p_u_9:GetAttribute("Owner"))
				if v16 and v16 ~= v_u_3.UserId then
					if v_u_8[v16] then
						v_u_12.Enabled = false
					else
						v_u_12.Enabled = true
					end
				else
					v_u_12.Enabled = false
				end
				p_u_9:GetAttributeChangedSignal("Owner"):Connect(v15)
				v_u_12.Triggered:Connect(function()
					-- upvalues: (copy) p_u_9, (ref) v_u_3, (ref) v_u_8, (copy) v_u_12, (ref) v_u_6
					local v17 = p_u_9
					local v18 = tonumber(v17:GetAttribute("Owner"))
					if v18 then
						if v18 == v_u_3.UserId then
							return
						elseif not v_u_8[v18] then
							v_u_8[v18] = true
							v_u_12.Enabled = false
							v_u_6:FireServer(v18)
						end
					else
						return
					end
				end)
			end
		else
			return
		end
	else
		return
	end
end
for _, v20 in v4:GetChildren() do
	if v20:IsA("Model") then
		task.spawn(v_u_19, v20)
	end
end
v4.ChildAdded:Connect(function(p21)
	-- upvalues: (copy) v_u_19
	if p21:IsA("Model") then
		task.spawn(v_u_19, p21)
	end
end)
local v_u_22 = require(v2:WaitForChild("Player"):WaitForChild("NotificationService"))
local v_u_23 = {}
local v_u_24 = nil
local function v_u_26()
	-- upvalues: (ref) v_u_24, (copy) v_u_23, (copy) v_u_22
	v_u_24 = nil
	if #v_u_23 ~= 0 then
		local v25
		if #v_u_23 == 1 then
			v25 = v_u_23[1] .. " liked your garden!"
		elseif #v_u_23 == 2 then
			v25 = v_u_23[1] .. " and " .. v_u_23[2] .. " liked your garden!"
		else
			v25 = v_u_23[1] .. " and " .. #v_u_23 - 1 .. " others liked your garden!"
		end
		v_u_22.NotifySound(v25)
		table.clear(v_u_23)
	end
end
v7.OnClientEvent:Connect(function(p27, p28)
	-- upvalues: (copy) v_u_1, (copy) v_u_23, (ref) v_u_24, (copy) v_u_26, (copy) v_u_22
	if p28 == "received" then
		local v29 = v_u_1:GetPlayerByUserId(p27)
		local v30 = v29 and v29.DisplayName or "Someone"
		local v31 = v_u_23
		table.insert(v31, v30)
		if v_u_24 then
			task.cancel(v_u_24)
		end
		v_u_24 = task.delay(3, v_u_26)
	elseif p28 == "sent" then
		local v32 = v_u_1:GetPlayerByUserId(p27)
		local v33 = v32 and v32.DisplayName or "this garden"
		v_u_22.NotifySound("You liked " .. v33 .. "\'s garden!")
	end
end)