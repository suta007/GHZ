local v1 = game:GetService("Players")
local v2 = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local v_u_3 = game:GetService("TweenService")
local v4 = game:GetService("ReplicatedStorage")
local v_u_5 = require(v4.Economy.Formatter.NumberFormatter)
local v6 = v2:WaitForChild("ShillingsCurrency")
local v7 = v1.LocalPlayer
local v_u_8 = v6:WaitForChild("CurrencyAmount")
local v_u_9 = {}
script.Amount:GetPropertyChangedSignal("Value"):Connect(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_8
	v_u_8.Text = "$" .. v_u_5:FormatNumberShort(script.Amount.Value)
end)
function v_u_9.UpdateValue(_, p10)
	-- upvalues: (copy) v_u_3
	v_u_3:Create(script.Amount, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		["Value"] = p10
	}):Play()
end
function v_u_9.GetValue(_)
	return script.Amount.Value
end
local v11 = v7:WaitForChild("leaderstats", 10)
local v_u_12 = v11 and v11:WaitForChild("Shillings", 10)
if v_u_12 then
	v_u_9:UpdateValue(v_u_12.Value)
	v_u_8.Text = "$" .. v_u_5:FormatNumberShort(v_u_12.Value)
	v_u_12:GetPropertyChangedSignal("Value"):Connect(function()
		-- upvalues: (copy) v_u_9, (copy) v_u_12
		v_u_9:UpdateValue(v_u_12.Value)
	end)
end
return v_u_9