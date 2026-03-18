local v1 = {}
local v_u_2 = game:GetService("Players").LocalPlayer
function v1.Teleport(p3)
	-- upvalues: (copy) v_u_2
	local v4 = v_u_2.Character
	if v4 and v4:FindFirstChild("HumanoidRootPart") then
		v4.HumanoidRootPart.CFrame = p3 * CFrame.new(0, 3, 0)
	end
end
return v1