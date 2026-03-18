local v1 = game:GetService("Players")
game:GetService("UserInputService")
local v_u_2 = v1.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Sprinkler")
local v3 = v_u_2:WaitForChild("Container"):WaitForChild("Confirm")
v_u_2.Enabled = false
return {
	["Confirm"] = v3,
	["Open"] = function()
		-- upvalues: (copy) v_u_2
		v_u_2.Enabled = true
	end,
	["Close"] = function()
		-- upvalues: (copy) v_u_2
		v_u_2.Enabled = false
	end
}