local v1 = game:GetService("Players")
local v_u_2 = require(script.Ranks)
local v_u_3 = game.GameId == 125175568976972 and 250 or 253
local v_u_4 = {}
local v_u_5 = Instance.new("BindableEvent")
local function v_u_9(p_u_6)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	local v7, v8 = pcall(function()
		-- upvalues: (copy) p_u_6
		return p_u_6:GetRankInGroupAsync(460048752)
	end)
	v_u_4[p_u_6.UserId] = v7 and v8 and v8 or 0
	v_u_5:Fire(p_u_6.UserId)
end
local v_u_10 = {}
local function v12(p11)
	-- upvalues: (copy) v_u_9
	task.spawn(v_u_9, p11)
end
local function v14(p13)
	-- upvalues: (copy) v_u_4
	v_u_4[p13.UserId] = nil
end
local v_u_15 = {}
for _, v16 in v1:GetPlayers() do
	task.spawn(v_u_9, v16)
end
v1.PlayerAdded:Connect(v12)
v1.PlayerRemoving:Connect(v14)
function v_u_15.GetGroupRank(p_u_17, p18)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	if p18 or v_u_4[p_u_17.UserId] == nil then
		local v19, v20 = pcall(function()
			-- upvalues: (copy) p_u_17
			return p_u_17:GetRankInGroupAsync(460048752)
		end)
		v_u_4[p_u_17.UserId] = v19 and v20 and v20 or 0
		v_u_5:Fire(p_u_17.UserId)
	end
	return v_u_4[p_u_17.UserId]
end
function v_u_15.WaitForRankCache(p21)
	-- upvalues: (copy) v_u_4, (copy) v_u_5
	if v_u_4[p21.UserId] == nil then
		while v_u_4[p21.UserId] == nil do
			v_u_5.Event:Wait()
		end
	end
end
function v_u_15.GetRankData(p22)
	-- upvalues: (copy) v_u_2
	return v_u_2[p22]
end
function v_u_15.IsGroupAdmin(p23)
	-- upvalues: (copy) v_u_15, (copy) v_u_3
	return game.PlaceId == 125175568976972 and p23.UserId == 7187797145 and true or v_u_3 <= v_u_15.GetGroupRank(p23)
end
function v_u_15.IsAdminAbuseGuest(p24)
	-- upvalues: (copy) v_u_10
	return table.find(v_u_10, p24.UserId) ~= nil
end
function v_u_15.IsGroupMember(p25)
	-- upvalues: (copy) v_u_15
	return v_u_15.GetGroupRank(p25, true) > 0
end
return v_u_15