local v1 = game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = require(v2:WaitForChild("RNGPacks"):WaitForChild("RNGPackManager"))
local v_u_4 = v1.LocalPlayer
local v_u_5 = v_u_4:WaitForChild("PlayerGui"):WaitForChild("RNGPack")
local v_u_6 = v_u_5:WaitForChild("MainFrame")
local v_u_7 = {}
local function v_u_9(p_u_8)
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_3, (copy) v_u_5
	if p_u_8:IsA("Tool") and p_u_8:GetAttribute("IsCrate") then
		if not v_u_7[p_u_8] then
			v_u_7[p_u_8] = true
			p_u_8.Activated:Connect(function()
				-- upvalues: (ref) v_u_6, (ref) v_u_3, (copy) p_u_8, (ref) v_u_5
				v_u_6.Visible = false
				v_u_3.Initiate(p_u_8, v_u_5, v_u_6)
			end)
			p_u_8.AncestryChanged:Connect(function()
				-- upvalues: (copy) p_u_8, (ref) v_u_7
				if not p_u_8.Parent then
					v_u_7[p_u_8] = nil
				end
			end)
		end
	else
		return
	end
end
local function v_u_12(p10)
	-- upvalues: (copy) v_u_9
	p10.ChildAdded:Connect(v_u_9)
	for _, v11 in pairs(p10:GetChildren()) do
		v_u_9(v11)
	end
end
local function v_u_15()
	-- upvalues: (copy) v_u_4, (copy) v_u_9
	local v13 = v_u_4:WaitForChild("Backpack", 10)
	if v13 then
		v13.ChildAdded:Connect(v_u_9)
		for _, v14 in pairs(v13:GetChildren()) do
			v_u_9(v14)
		end
	end
end
v_u_15()
if v_u_4.Character then
	v_u_12(v_u_4.Character)
end
v_u_4.CharacterAdded:Connect(function(p16)
	-- upvalues: (copy) v_u_12, (copy) v_u_15
	v_u_12(p16)
	v_u_15()
end)