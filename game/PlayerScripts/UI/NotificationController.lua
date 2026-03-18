local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = require(v1:WaitForChild("Player"):WaitForChild("NotificationService"))
local v3 = v1:WaitForChild("RemoteEvents")
v3.Admin.OnClientEvent:Connect(function(p4)
	-- upvalues: (copy) v_u_2
	local v5 = p4.authorId
	local v6 = p4.message
	v_u_2.AdminMessage(v5, v6, 5)
end)
v3.Notification.OnClientEvent:Connect(function(p7, p8, p9, p10)
	-- upvalues: (copy) v_u_2
	if p10 then
		v_u_2.NotifySound(p7, p8, p9)
	else
		v_u_2.Notify(p7, p8, p9)
	end
end)