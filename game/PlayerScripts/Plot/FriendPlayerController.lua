local v_u_1 = game:GetService("Players")
local v_u_2 = game:GetService("StarterGui")
local v_u_3 = v_u_1.LocalPlayer
local v4 = workspace:WaitForChild("Plots")
local function v_u_21(p_u_5)
	-- upvalues: (copy) v_u_3, (copy) v_u_1, (copy) v_u_2
	local v6 = p_u_5:WaitForChild("PlayerSign")
	if v6 then
		local v7 = v6:WaitForChild("Main")
		if v7 then
			local v_u_8 = v7:WaitForChild("FriendPlayer")
			if v_u_8 then
				print("[FriendPlayer] Setup complete for", p_u_5.Name)
				local function v13()
					-- upvalues: (copy) p_u_5, (ref) v_u_3, (copy) v_u_8
					local v9 = p_u_5
					local v_u_10 = tonumber(v9:GetAttribute("Owner"))
					if v_u_10 and v_u_10 ~= v_u_3.UserId then
						task.spawn(function()
							-- upvalues: (ref) v_u_3, (copy) v_u_10, (ref) v_u_8
							local v11, v12 = pcall(function()
								-- upvalues: (ref) v_u_3, (ref) v_u_10
								return v_u_3:IsFriendsWithAsync(v_u_10)
							end)
							v_u_8.Enabled = not (v11 and v12)
						end)
					else
						v_u_8.Enabled = false
					end
				end
				v13()
				p_u_5:GetAttributeChangedSignal("Owner"):Connect(v13)
				v_u_8.Triggered:Connect(function()
					-- upvalues: (copy) p_u_5, (ref) v_u_3, (ref) v_u_1, (copy) v_u_8, (ref) v_u_2
					print("[FriendPlayer] Triggered on", p_u_5.Name)
					local v14 = p_u_5
					local v_u_15 = tonumber(v14:GetAttribute("Owner"))
					if v_u_15 then
						if v_u_15 == v_u_3.UserId then
							return
						else
							local v_u_16 = v_u_1:GetPlayerByUserId(v_u_15)
							if v_u_16 then
								local v17, v18 = pcall(function()
									-- upvalues: (ref) v_u_3, (copy) v_u_15
									return v_u_3:IsFriendsWithAsync(v_u_15)
								end)
								if v17 and v18 then
									print("[FriendPlayer] Already friends with", v_u_15)
									v_u_8.Enabled = false
								else
									local v19, v20 = pcall(function()
										-- upvalues: (ref) v_u_2, (copy) v_u_16
										v_u_2:SetCore("PromptSendFriendRequest", v_u_16)
									end)
									if not v19 then
										warn("[FriendPlayer] SetCore failed:", v20)
									end
								end
							else
								print("[FriendPlayer] Owner not in game:", v_u_15)
								return
							end
						end
					else
						return
					end
				end)
			else
				print("[FriendPlayer] No FriendPlayer prompt in", v7:GetFullName())
			end
		else
			print("[FriendPlayer] No Main in", v6:GetFullName())
			return
		end
	else
		print("[FriendPlayer] No PlayerSign in", p_u_5.Name)
		return
	end
end
for _, v22 in v4:GetChildren() do
	if v22:IsA("Model") then
		task.spawn(v_u_21, v22)
	end
end
v4.ChildAdded:Connect(function(p23)
	-- upvalues: (copy) v_u_21
	if p23:IsA("Model") then
		task.spawn(v_u_21, p23)
	end
end)