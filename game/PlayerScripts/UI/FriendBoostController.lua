local v1 = game:GetService("Players")
local v_u_2 = game:GetService("SocialService")
local v_u_3 = v1.LocalPlayer
local v_u_4 = v_u_3:WaitForChild("PlayerGui")
local function v_u_10()
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	local v5 = v_u_4:FindFirstChild("FriendBoost")
	if v5 then
		local v6 = v5:FindFirstChild("Frame")
		if v6 then
			local v7 = v6:FindFirstChild("Text")
			local v8 = v6:FindFirstChild("InviteWrapper")
			if v7 and v8 then
				local v9 = v_u_3:GetAttribute("FriendBoostCount") or 0
				if v9 > 0 then
					v7.Text = "Friend Boost: +" .. v9 * 5 .. "%"
					v7.Visible = true
					v8.Visible = true
				else
					v7.Visible = false
					v8.Visible = false
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_11()
	-- upvalues: (copy) v_u_4, (copy) v_u_2, (copy) v_u_3
	v_u_4:WaitForChild("FriendBoost"):WaitForChild("Frame"):WaitForChild("InviteWrapper"):WaitForChild("Invite").MouseButton1Click:Connect(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_3
		pcall(function()
			-- upvalues: (ref) v_u_2, (ref) v_u_3
			v_u_2:PromptGameInvite(v_u_3)
		end)
	end)
end
v_u_3:GetAttributeChangedSignal("FriendBoostCount"):Connect(v_u_10)
task.defer(function()
	-- upvalues: (copy) v_u_11, (copy) v_u_10
	v_u_11()
	v_u_10()
end)