local v1 = game:GetService("ReplicatedStorage")
game:GetService("Players")
local v_u_2 = require(v1:WaitForChild("Player"):WaitForChild("NotificationService"))
local v_u_3 = require(v1:WaitForChild("Plants"):WaitForChild("Definitions"):WaitForChild("MutationDataDefinitions"))
local function v_u_7(p4)
	local v5 = workspace:FindFirstChild("ClientPlants")
	if not v5 then
		return nil
	end
	for _, v6 in v5:GetChildren() do
		if v6:IsA("Model") and v6:GetAttribute("Uuid") == p4 then
			return v6
		end
	end
	return nil
end
v1:WaitForChild("RemoteEvents"):WaitForChild("MutationNotification").OnClientEvent:Connect(function(p8, p9, p10, p11)
	-- upvalues: (copy) v_u_3, (copy) v_u_2, (copy) v_u_7
	local v12 = v_u_3[p8]
	local v13 = v12 and v12.color or "#FFFFFF"
	local v14 = string.format("Your %s became mutated with <font color=\"%s\">%s</font>!", p11 or "crop", v13, p8)
	v_u_2.Notify(v14, 3)
	local v15 = nil
	if p9 and typeof(p9) == "string" then
		local v16 = v_u_7(p9)
		if v16 then
			if p10 and typeof(p10) == "number" then
				for _, v17 in v16:GetChildren() do
					if v17:IsA("Model") and v17:GetAttribute("GrowthAnchorIndex") == p10 then
						v15 = v17
						break
					end
				end
			else
				v15 = v16
			end
		end
	end
	if v15 then
		local v_u_18 = Instance.new("Highlight")
		v_u_18.FillColor = Color3.fromHex(v13)
		v_u_18.OutlineColor = Color3.fromHex(v13)
		v_u_18.FillTransparency = 0.5
		v_u_18.Parent = v15
		task.delay(3, function()
			-- upvalues: (copy) v_u_18
			if v_u_18 then
				v_u_18:Destroy()
			end
		end)
	end
end)