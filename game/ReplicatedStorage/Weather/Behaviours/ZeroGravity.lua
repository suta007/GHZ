local v_u_1 = game:GetService("Players")
local v2 = {}
local v_u_3 = nil
local v_u_4 = nil
local v_u_5 = {}
local v_u_6 = nil
local v_u_7 = {}
local function v_u_11(p8)
	-- upvalues: (copy) v_u_1, (ref) v_u_5
	local v9 = p8:WaitForChild("Humanoid", 5)
	if v9 then
		local v10 = v_u_1:GetPlayerFromCharacter(p8)
		if v10 then
			if not v_u_5[v10] then
				v_u_5[v10] = v9.JumpHeight
			end
			v9.JumpHeight = v_u_5[v10] * 1.8
			print((("[ZeroGravity] Set JumpHeight for %*: %*"):format(v10.Name, v9.JumpHeight)))
		end
	else
		return
	end
end
local function v_u_14(p12)
	-- upvalues: (copy) v_u_11, (ref) v_u_7
	if p12.Character then
		task.spawn(v_u_11, p12.Character)
	end
	v_u_7[p12] = p12.CharacterAdded:Connect(function(p13)
		-- upvalues: (ref) v_u_11
		task.spawn(v_u_11, p13)
	end)
end
function v2.Start(_, _)
	-- upvalues: (ref) v_u_4, (ref) v_u_3, (copy) v_u_1, (copy) v_u_11, (ref) v_u_7, (ref) v_u_6, (copy) v_u_14
	local v15 = script.Parent:FindFirstChild("Blackhole")
	if v15 then
		v_u_4 = workspace.Gravity
		workspace.Gravity = 80
		v_u_3 = v15:Clone()
		v_u_3.Parent = workspace
		for _, v16 in ipairs(v_u_1:GetPlayers()) do
			if v16.Character then
				task.spawn(v_u_11, v16.Character)
			end
			v_u_7[v16] = v16.CharacterAdded:Connect(function(p17)
				-- upvalues: (ref) v_u_11
				task.spawn(v_u_11, p17)
			end)
		end
		v_u_6 = v_u_1.PlayerAdded:Connect(v_u_14)
	else
		warn("[ZeroGravity] Blackhole model not found in weather content folder")
	end
end
function v2.Stop(_)
	-- upvalues: (ref) v_u_6, (copy) v_u_1, (ref) v_u_5, (ref) v_u_7, (ref) v_u_4, (ref) v_u_3
	if v_u_6 then
		v_u_6:Disconnect()
		v_u_6 = nil
	end
	for _, v18 in ipairs(v_u_1:GetPlayers()) do
		local v19 = v_u_5[v18]
		if v19 then
			local v20 = v18.Character
			local v21 = v20 and v20:FindFirstChildOfClass("Humanoid")
			if v21 then
				v21.JumpHeight = v19
			end
			v_u_5[v18] = nil
		end
		if v_u_7[v18] then
			v_u_7[v18]:Disconnect()
			v_u_7[v18] = nil
		end
	end
	v_u_5 = {}
	v_u_7 = {}
	if v_u_4 then
		workspace.Gravity = v_u_4
		v_u_4 = nil
	end
	if v_u_3 then
		v_u_3:Destroy()
		v_u_3 = nil
	end
end
return v2