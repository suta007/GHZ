local v_u_1 = game:GetService("TextChatService")
local v_u_2 = game:GetService("Players")
local v3 = game:GetService("ReplicatedStorage")
local v4 = v3.RemoteEvents.SystemChat
local v_u_5 = require(v3:WaitForChild("Util"):WaitForChild("GroupUtils"))
local v_u_6 = require(v3:WaitForChild("Util"):WaitForChild("SpecialPlayers"))
local v_u_7 = require(script.ChatNameColor)
local v_u_8 = v_u_1.ChatWindowConfiguration
v4.OnClientEvent:Connect(function(p9)
	-- upvalues: (copy) v_u_1
	v_u_1:WaitForChild("TextChannels"):WaitForChild("RBXGeneral"):DisplaySystemMessage(p9)
end)
local function v_u_21(p10, p11)
	-- upvalues: (copy) v_u_2, (copy) v_u_7
	local v12 = v_u_2.LocalPlayer
	if not v12 then
		return p11.DisplayName .. ":"
	end
	if p10.TextSource.UserId == v12.UserId then
		local v13 = p10.TextChannel
		local v14 = v12.UserId
		local v15, v16 = string.match(v13.Name, "^RBXWhisper:(%d+)_(%d+)$")
		local v17
		if v15 and v16 then
			v17 = v_u_2:GetPlayerByUserId(tonumber(v15) == v14 and tonumber(v16) or tonumber(v15))
		else
			v17 = nil
		end
		if v17 then
			local v18 = v_u_7(v17):ToHex()
			local v19 = v_u_7(v12):ToHex()
			return string.format("[To: <font color=\'#%s\'>%s</font>] <font color=\'#%s\'>%s</font>:", v18, v17.DisplayName, v19, v12.DisplayName)
		end
	end
	local v20 = v_u_7(p11):ToHex()
	return string.format("[From: <font color=\'#%s\'>%s</font>]:", v20, p11.DisplayName)
end
function v_u_1.OnChatWindowAdded(p22)
	-- upvalues: (copy) v_u_8, (copy) v_u_2, (copy) v_u_21, (copy) v_u_6, (copy) v_u_5, (copy) v_u_7
	local v23 = v_u_8:DeriveNewMessageProperties()
	if not p22.TextSource then
		return v23
	end
	local v24 = v_u_2:GetPlayerByUserId(p22.TextSource.UserId)
	if not v24 then
		return v23
	end
	local v25 = p22.TextChannel
	local v26
	if v25 then
		v26 = string.match(v25.Name, "^RBXWhisper") ~= nil
	else
		v26 = false
	end
	if v26 then
		v23.PrefixText = v_u_21(p22, v24)
		v23.Text = p22.Text
		return v23
	end
	local v27 = v_u_6[p22.TextSource.UserId]
	local v28 = v_u_5.GetGroupRank(v24)
	local v29 = v_u_5.GetRankData(v28)
	if v27 then
		local v30 = v27.Gradient
		v23.PrefixTextProperties = v_u_8:DeriveNewMessageProperties()
		local v31 = Instance.new("UIGradient")
		v31.Color = v30
		v31.Parent = v23.PrefixTextProperties
		local v32 = v27.Name
		local v33 = v24.DisplayName
		v23.PrefixText = string.format("[%s] %s:", v32, v33)
		v23.Text = p22.Text
		return v23
	end
	if not v29 then
		local v34 = v_u_7(v24):ToHex()
		v23.PrefixText = string.format("<font color=\'#%s\'>%s</font>:", v34, v24.DisplayName)
		v23.Text = p22.Text
		return v23
	end
	local v35 = v29.Gradient
	v23.PrefixTextProperties = v_u_8:DeriveNewMessageProperties()
	local v36 = Instance.new("UIGradient")
	v36.Color = v35
	v36.Parent = v23.PrefixTextProperties
	local v37 = v29.Name
	local v38 = v24.DisplayName
	v23.PrefixText = string.format("[%s] %s:", v37, v38)
	v23.Text = p22.Text
	return v23
end