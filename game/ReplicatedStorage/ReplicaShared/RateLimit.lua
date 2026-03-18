local v1 = game:GetService("Players")
local v_u_2 = {}
local v_u_3 = {}
local v_u_4 = {}
v_u_4.__index = v_u_4
function v_u_4.New(p5, p6)
	-- upvalues: (copy) v_u_4, (copy) v_u_3
	if p5 <= 0 then
		error("[RateLimit]: Invalid rate")
	end
	local v7 = {
		["sources"] = {},
		["rate_period"] = 1 / p5,
		["is_full_wait"] = p6 == true
	}
	local v8 = v_u_4
	setmetatable(v7, v8)
	v_u_3[v7] = true
	return v7
end
function v_u_4.CheckRate(p9, p10)
	-- upvalues: (copy) v_u_2
	local v11 = p9.sources
	local v12 = os.clock()
	local v13 = p10 == nil and "nil" or p10
	local v14 = v11[v13]
	if v14 == nil then
		if typeof(v13) == "Instance" and (v13:IsA("Player") and v_u_2[v13] == nil) then
			return false
		end
		v11[v13] = v12 + p9.rate_period
		return true
	end
	if p9.is_full_wait == true then
		if v14 > v12 then
			return false
		end
		v11[v13] = v12 + p9.rate_period
		return true
	end
	local v15 = v14 + p9.rate_period
	local v16 = math.max(v12, v15)
	if v16 - v12 >= 1 then
		return false
	end
	v11[v13] = v16
	return true
end
function v_u_4.CleanSource(p17, p18)
	p17.sources[p18] = nil
end
function v_u_4.Cleanup(p19)
	p19.sources = {}
end
function v_u_4.Destroy(p20)
	-- upvalues: (copy) v_u_3
	v_u_3[p20] = nil
end
for _, v21 in ipairs(v1:GetPlayers()) do
	v_u_2[v21] = true
end
v1.PlayerAdded:Connect(function(p22)
	-- upvalues: (copy) v_u_2
	v_u_2[p22] = true
end)
v1.PlayerRemoving:Connect(function(p23)
	-- upvalues: (copy) v_u_2, (copy) v_u_3
	v_u_2[p23] = nil
	for v24 in pairs(v_u_3) do
		v24.sources[p23] = nil
	end
end)
return v_u_4