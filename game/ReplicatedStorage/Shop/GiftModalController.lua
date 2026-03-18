local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GiftModal")
local v4 = {}
local v_u_5 = v_u_3:WaitForChild("Background"):WaitForChild("ScrollingFrame")
local v6 = v_u_3:WaitForChild("Background"):WaitForChild("Close")
local v_u_7 = v_u_3:WaitForChild("Background"):WaitForChild("SearchBar"):WaitForChild("TextBox")
local v_u_8 = v_u_5:WaitForChild("NoPlayers")
local v_u_9 = require(v1:WaitForChild("UI"):WaitForChild("UIManager"))
v6.MouseButton1Click:Connect(function()
	-- upvalues: (copy) v_u_3
	v_u_3.Enabled = false
end)
v_u_7:GetPropertyChangedSignal("Text"):Connect(function()
	-- upvalues: (copy) v_u_7, (copy) v_u_5, (copy) v_u_8
	local v10 = string.lower(v_u_7.Text)
	local v11 = 0
	for _, v12 in v_u_5:GetChildren() do
		if v12:IsA("ImageLabel") then
			if v10 == "" then
				v12.Visible = true
				v11 = v11 + 1
			else
				local v13 = string.lower(v12.Name)
				local v14 = string.lower(v12.DisplayName)
				if string.find(v13, v10) or string.find(v14, v10) then
					v12.Visible = true
					v11 = v11 + 1
				else
					v12.Visible = false
				end
			end
		end
	end
	v_u_8.Visible = v11 == 0
end)
local function v_u_20(p_u_15)
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (copy) v_u_8, (copy) v_u_7
	for _, v16 in v_u_5:GetChildren() do
		if v16:IsA("ImageLabel") then
			v16:Destroy()
		end
	end
	local v17 = 0
	for _, v_u_18 in v_u_2:GetPlayers() do
		if v_u_18 ~= v_u_2.LocalPlayer then
			v17 = v17 + 1
			local v19 = script.PlayerTemplate:Clone()
			v19.Name = v_u_18.Name
			v19.DisplayName.Text = v_u_18.DisplayName
			v19.Username.Text = "@" .. v_u_18.Name
			v19.ImageLabel.Image = v_u_2:GetUserThumbnailAsync(v_u_18.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
			v19.Parent = v_u_5
			v19.Gift.MouseButton1Click:Connect(function()
				-- upvalues: (copy) v_u_18, (copy) p_u_15
				script:SetAttribute("SelectedPlayer", v_u_18.UserId)
				p_u_15(v_u_18)
			end)
		end
	end
	v_u_8.Visible = v17 == 0
	v_u_7.Text = ""
end
v_u_20()
function v4.GetPlayer(_, p21)
	-- upvalues: (copy) v_u_9, (copy) v_u_3, (copy) v_u_20
	v_u_9:CloseAllExclusive("GiftModal")
	v_u_3.Enabled = true
	v_u_20(p21)
end
function v4.Close(_)
	-- upvalues: (copy) v_u_3
	v_u_3.Enabled = false
end
return v4