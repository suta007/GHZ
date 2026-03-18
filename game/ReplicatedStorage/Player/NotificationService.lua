game:GetService("ReplicatedStorage")
local v_u_1 = game:GetService("TweenService")
local v_u_2 = game:GetService("Players")
local v_u_3 = game:GetService("SoundService")
local v_u_4 = game:GetService("UserService")
local v5 = game:GetService("UserInputService")
local v_u_6 = v_u_2.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Notification"):WaitForChild("Frame")
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = 0
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = {}
local v_u_13 = false
local v_u_14 = {}
local v_u_15 = nil
local v_u_16 = {}
if v5.TouchEnabled then
	v_u_6.Size = UDim2.new(0.8, 0, 0.9, 0)
end
local function v_u_20(p17, p18)
	-- upvalues: (copy) v_u_20, (copy) v_u_1
	for _, v19 in pairs(p17:GetDescendants()) do
		if v19:IsA("Frame") then
			v_u_20(v19, p18)
		end
		if v19:IsA("UIStroke") then
			v_u_1:Create(v19, TweenInfo.new(0.5), {
				["Transparency"] = p18
			}):Play()
		end
		if v19:IsA("ImageLabel") then
			v_u_1:Create(v19, TweenInfo.new(0.5), {
				["ImageTransparency"] = p18
			}):Play()
		end
		if v19:IsA("GuiObject") and not v19:IsA("Frame") then
			if v19:IsA("TextLabel") then
				v_u_1:Create(v19, TweenInfo.new(0.5), {
					["TextTransparency"] = p18
				}):Play()
			else
				v_u_1:Create(v19, TweenInfo.new(0.5), {
					["Transparency"] = p18
				}):Play()
			end
		end
	end
end
local function v_u_25(p21, p22, p23)
	local v24 = 0
	for _, _ in utf8.graphemes(p22) do
		v24 = v24 + 1
		p21.MaxVisibleGraphemes = v24
		task.wait(p23)
	end
end
function v_u_7.showAdminInfo(_, _) end
local function v_u_32(p26, p27, p28)
	-- upvalues: (copy) v_u_8, (copy) v_u_16, (copy) v_u_1
	if not v_u_8[p26] or v_u_8[p26].instance ~= p27 then
		return
	end
	v_u_8[p26] = nil
	for v29, v30 in ipairs(v_u_16) do
		if v30 == p26 then
			table.remove(v_u_16, v29)
			break
		end
	end
	local v31 = v_u_1:Create(p27, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		["Size"] = UDim2.new(p28.X.Scale, p28.X.Offset, 0, 0)
	})
	v31:Play()
	v31.Completed:Wait()
	p27:Destroy()
end
local function v_u_34(p33)
	-- upvalues: (copy) v_u_7
	if p33.type == "notify" then
		v_u_7.Notify(p33.message, p33.duration, p33.color)
		return
	elseif p33.type == "notifySound" then
		v_u_7.NotifySound(p33.message, p33.duration, p33.color)
	elseif p33.type == "adminMessage" then
		v_u_7.AdminMessage(p33.adminId, p33.message, p33.duration, p33.color)
	end
end
function v_u_7.Notify(p_u_35, p36, p37)
	-- upvalues: (ref) v_u_13, (ref) v_u_15, (ref) v_u_14, (ref) v_u_10, (ref) v_u_11, (copy) v_u_8, (ref) v_u_9, (copy) v_u_32, (copy) v_u_16, (copy) v_u_6, (copy) v_u_25
	if v_u_13 then
		local v_u_38 = p36 or 3
		v_u_10 = nil
		v_u_11 = nil
		if v_u_8[p_u_35] then
			local v_u_39 = v_u_8[p_u_35]
			v_u_39.count = v_u_39.count + 1
			local v40 = " [X" .. v_u_39.count .. "]"
			v_u_39.instance.CONTENT.Text = p_u_35 .. v40
			v_u_39.instance.CONTENT.CONTENT_SHADOW.Text = p_u_35:gsub("color%s*=%s*\"#%x+\"", "color=\"#000000\""):gsub("color%s*=%s*\"rgb%b()\"", "color=\"#000000\""):gsub("color%s*=%s*\'#%x+\'", "color=\"#000000\""):gsub("color%s*=%s*\'rgb%b()\'", "color=\"#000000\"") .. v40
			v_u_39.instance.CONTENT.MaxVisibleGraphemes = -1
			v_u_39.instance.CONTENT.CONTENT_SHADOW.MaxVisibleGraphemes = -1
			v_u_9 = v_u_9 + 1
			v_u_39.instance.LayoutOrder = v_u_9
			if v_u_39.destroyTask then
				task.cancel(v_u_39.destroyTask)
				v_u_39.destroyTask = nil
			end
			v_u_39.destroyTask = task.delay(v_u_38, function()
				-- upvalues: (ref) v_u_32, (copy) p_u_35, (copy) v_u_39
				v_u_32(p_u_35, v_u_39.instance, v_u_39.fullSize)
			end)
		else
			while #v_u_16 >= 100 do
				local v41 = v_u_16[1]
				local v42 = v_u_8[v41]
				if v42 then
					if v42.destroyTask then
						task.cancel(v42.destroyTask)
						v42.destroyTask = nil
					end
					v_u_32(v41, v42.instance, v42.fullSize)
				else
					table.remove(v_u_16, 1)
				end
			end
			local v43 = v_u_6:WaitForChild("NotificationTemplate")
			local v_u_44 = v43:Clone()
			v_u_9 = v_u_9 + 1
			v_u_44.LayoutOrder = v_u_9
			v_u_44.Parent = v_u_6
			local v_u_45 = v_u_44:WaitForChild("CONTENT")
			local v_u_46 = v_u_45:WaitForChild("CONTENT_SHADOW")
			v_u_45.Text = p_u_35
			v_u_45.MaxVisibleGraphemes = 0
			v_u_46.Text = p_u_35:gsub("color%s*=%s*\"#%x+\"", "color=\"#000000\""):gsub("color%s*=%s*\"rgb%b()\"", "color=\"#000000\""):gsub("color%s*=%s*\'#%x+\'", "color=\"#000000\""):gsub("color%s*=%s*\'rgb%b()\'", "color=\"#000000\"")
			v_u_46.MaxVisibleGraphemes = 0
			local v_u_47 = UDim2.new(v43.Size.X.Scale, v43.Size.X.Offset, v43.Size.Y.Scale, v43.Size.Y.Offset)
			v_u_44.Visible = true
			v_u_8[p_u_35] = {
				["instance"] = v_u_44,
				["count"] = 1,
				["fullSize"] = v_u_47,
				["destroyTask"] = nil
			}
			local v48 = v_u_16
			table.insert(v48, p_u_35)
			local v_u_49 = coroutine.create(function()
				-- upvalues: (ref) v_u_25, (copy) v_u_45, (copy) p_u_35
				v_u_25(v_u_45, p_u_35, 0.01)
			end)
			local v50 = coroutine.create(function()
				-- upvalues: (ref) v_u_25, (copy) v_u_46, (copy) p_u_35
				v_u_25(v_u_46, p_u_35, 0.01)
			end)
			coroutine.resume(v_u_49)
			coroutine.resume(v50)
			task.spawn(function()
				-- upvalues: (copy) v_u_49, (ref) v_u_8, (copy) p_u_35, (copy) v_u_44, (ref) v_u_38, (ref) v_u_32, (copy) v_u_47
				repeat
					task.wait()
				until coroutine.status(v_u_49) == "dead"
				if v_u_8[p_u_35] and (v_u_8[p_u_35].instance == v_u_44 and not v_u_8[p_u_35].destroyTask) then
					v_u_8[p_u_35].destroyTask = task.delay(v_u_38, function()
						-- upvalues: (ref) v_u_32, (ref) p_u_35, (ref) v_u_44, (ref) v_u_47
						v_u_32(p_u_35, v_u_44, v_u_47)
					end)
				end
			end)
		end
	else
		local v51 = {
			["type"] = "notify",
			["message"] = p_u_35,
			["duration"] = p36,
			["color"] = p37
		}
		if not v_u_15 then
			v_u_15 = os.clock()
		end
		v51.timestamp = os.clock() - v_u_15
		local v52 = v_u_14
		table.insert(v52, v51)
		return
	end
end
function v_u_7.Dismiss(p53)
	-- upvalues: (ref) v_u_14, (copy) v_u_8, (copy) v_u_32
	for v54 = #v_u_14, 1, -1 do
		if v_u_14[v54].message == p53 then
			table.remove(v_u_14, v54)
		end
	end
	local v55 = v_u_8[p53]
	if v55 then
		if v55.destroyTask then
			task.cancel(v55.destroyTask)
			v55.destroyTask = nil
		end
		v_u_32(p53, v55.instance, v55.fullSize)
	end
end
function v_u_7.NotifySound(p56, p57, p58)
	-- upvalues: (ref) v_u_13, (ref) v_u_15, (ref) v_u_14, (copy) v_u_3, (copy) v_u_7
	if v_u_13 then
		local v59 = v_u_3:FindFirstChild("SFX") and v_u_3.SFX:FindFirstChild("UI")
		if v59 then
			v59 = v_u_3.SFX.UI:FindFirstChild("Notification")
		end
		if v59 then
			v59:Play()
		end
		v_u_7.Notify(p56, p57, p58)
	else
		local v60 = {
			["type"] = "notifySound",
			["message"] = p56,
			["duration"] = p57,
			["color"] = p58
		}
		if not v_u_15 then
			v_u_15 = os.clock()
		end
		v60.timestamp = os.clock() - v_u_15
		local v61 = v_u_14
		table.insert(v61, v60)
	end
end
function v_u_7.AdminMessage(p_u_62, p63, p_u_64, p65)
	-- upvalues: (ref) v_u_13, (ref) v_u_15, (ref) v_u_14, (copy) v_u_3, (copy) v_u_6, (ref) v_u_10, (ref) v_u_11, (ref) v_u_9, (copy) v_u_12, (copy) v_u_4, (copy) v_u_2, (copy) v_u_20, (copy) v_u_25, (copy) v_u_1
	if v_u_13 then
		local v66 = v_u_3:FindFirstChild("SFX") and v_u_3.SFX:FindFirstChild("UI")
		if v66 then
			v66 = v_u_3.SFX.UI:FindFirstChild("Notification")
		end
		if v66 then
			v66:Play()
		end
		if not p_u_64 then
			local v67 = select(2, p63:gsub("%S+", "")) * 0.4 + 2
			p_u_64 = math.clamp(v67, 4, 20)
		end
		local v68 = v_u_6:WaitForChild("UserInfo")
		local v69 = v_u_6:WaitForChild("AdminMessageTemplate")
		local v_u_70
		if (v_u_10 ~= p_u_62 or v_u_11 == nil) and true or not v_u_11.Parent then
			v_u_9 = v_u_9 + 1
			v_u_70 = v68:Clone()
			v_u_70.LayoutOrder = v_u_9
			v_u_70.Parent = v_u_6
			v_u_70.Visible = true
			v_u_10 = p_u_62
			v_u_11 = v_u_70
			v_u_12[v_u_70] = {}
			local v71 = v_u_70:WaitForChild("NameInfo")
			local v72, v73 = pcall(function()
				-- upvalues: (ref) v_u_4, (copy) p_u_62
				return v_u_4:GetUserInfosByUserIdsAsync({ p_u_62 })
			end)
			if v72 and (v73 and v73[1]) then
				local v74 = v73[1]
				local v75 = v71:WaitForChild("DisplayName")
				local v76 = v74.DisplayName
				local _ = v74.HasVerifiedBadge
				local v77 = ""
				v75.Text = v76 .. v77
				v71:WaitForChild("Username").Text = "@" .. v74.Username
			else
				warn("NotificationService: Failed to fetch user info for", p_u_62)
				local v78 = v_u_2:GetPlayerByUserId(p_u_62)
				if v78 then
					v71:WaitForChild("DisplayName").Text = v78.DisplayName
					v71:WaitForChild("Username").Text = "@" .. v78.Name
				else
					v71:WaitForChild("DisplayName").Text = "Admin"
					v71:WaitForChild("Username").Text = "#" .. tostring(p_u_62)
				end
			end
			task.spawn(function()
				-- upvalues: (ref) v_u_2, (copy) p_u_62, (ref) v_u_70
				local v79, v80 = pcall(function()
					-- upvalues: (ref) v_u_2, (ref) p_u_62
					return v_u_2:GetUserThumbnailAsync(p_u_62, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
				end)
				if v79 then
					if v_u_70 and v_u_70.Parent then
						v_u_70:WaitForChild("AvatarHeadshot").Image = v80
					end
				else
					warn("NotificationService: Failed to fetch thumbnail for", p_u_62)
				end
			end)
			v_u_20(v_u_70, 0)
		else
			v_u_70 = v_u_11
		end
		v_u_9 = v_u_9 + 1
		local v_u_81 = v69:Clone()
		v_u_81.LayoutOrder = v_u_9
		v_u_81.Parent = v_u_6
		local v_u_82 = v_u_81:WaitForChild("CONTENT")
		local v_u_83 = v_u_82:WaitForChild("CONTENT_SHADOW")
		local v_u_84 = " " .. p63
		v_u_82.Text = v_u_84
		v_u_82.MaxVisibleGraphemes = 0
		v_u_83.Text = v_u_84:gsub("color%s*=%s*\"#%x+\"", "color=\"#000000\""):gsub("color%s*=%s*\"rgb%b()\"", "color=\"#000000\""):gsub("color%s*=%s*\'#%x+\'", "color=\"#000000\""):gsub("color%s*=%s*\'rgb%b()\'", "color=\"#000000\"")
		v_u_83.MaxVisibleGraphemes = 0
		local v_u_85 = UDim2.new(v69.Size.X.Scale, v69.Size.X.Offset, v69.Size.Y.Scale, v69.Size.Y.Offset)
		v_u_81.Visible = true
		local v_u_86 = v_u_70
		local v87 = v_u_12[v_u_70]
		table.insert(v87, v_u_81)
		local v_u_88 = coroutine.create(function()
			-- upvalues: (ref) v_u_25, (copy) v_u_82, (ref) v_u_84
			v_u_25(v_u_82, v_u_84, 0.01)
		end)
		local v89 = coroutine.create(function()
			-- upvalues: (ref) v_u_25, (copy) v_u_83, (ref) v_u_84
			v_u_25(v_u_83, v_u_84, 0.01)
		end)
		coroutine.resume(v_u_88)
		coroutine.resume(v89)
		task.spawn(function()
			-- upvalues: (copy) v_u_88, (ref) p_u_64, (ref) v_u_20, (copy) v_u_81, (ref) v_u_1, (copy) v_u_85, (ref) v_u_12, (copy) v_u_86, (ref) v_u_11, (ref) v_u_10
			repeat
				task.wait()
			until coroutine.status(v_u_88) == "dead"
			task.delay(p_u_64, function()
				-- upvalues: (ref) v_u_20, (ref) v_u_81, (ref) v_u_1, (ref) v_u_85, (ref) v_u_12, (ref) v_u_86, (ref) v_u_11, (ref) v_u_10
				v_u_20(v_u_81, 1)
				task.wait(0.5)
				local v90 = v_u_1:Create(v_u_81, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					["Size"] = UDim2.new(v_u_85.X.Scale, v_u_85.X.Offset, 0, 0)
				})
				v90:Play()
				v90.Completed:Wait()
				v_u_81:Destroy()
				if v_u_12[v_u_86] then
					for v91, v92 in ipairs(v_u_12[v_u_86]) do
						if v92 == v_u_81 then
							table.remove(v_u_12[v_u_86], v91)
							break
						end
					end
					if #v_u_12[v_u_86] == 0 then
						v_u_20(v_u_86, 1)
						task.wait(0.5)
						v_u_86:Destroy()
						v_u_12[v_u_86] = nil
						if v_u_11 == v_u_86 then
							v_u_10 = nil
							v_u_11 = nil
						end
					end
				end
			end)
		end)
	else
		local v93 = {
			["type"] = "adminMessage",
			["adminId"] = p_u_62,
			["message"] = p63,
			["duration"] = p_u_64,
			["color"] = p65
		}
		if not v_u_15 then
			v_u_15 = os.clock()
		end
		v93.timestamp = os.clock() - v_u_15
		local v94 = v_u_14
		table.insert(v94, v93)
	end
end
function v_u_7.SetReady()
	-- upvalues: (ref) v_u_13, (ref) v_u_14, (copy) v_u_34, (ref) v_u_15
	if v_u_13 then
		return
	else
		v_u_13 = true
		if #v_u_14 ~= 0 then
			task.spawn(function()
				-- upvalues: (ref) v_u_14, (ref) v_u_34, (ref) v_u_15
				local v95 = v_u_14[1].timestamp
				for _, v96 in ipairs(v_u_14) do
					local v97 = v96.timestamp - v95
					if v97 > 0 then
						task.wait(v97)
					end
					v_u_34(v96)
					v95 = v96.timestamp
				end
				v_u_14 = {}
				v_u_15 = nil
			end)
		end
	end
end
return v_u_7