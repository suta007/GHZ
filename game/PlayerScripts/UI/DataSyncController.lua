local v1 = game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvents"):WaitForChild("DataService")
local v_u_2 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
v1.OnClientEvent:Connect(function(p3, p4)
	-- upvalues: (copy) v_u_2
	if p3 == "SaveStarted" then
		return
	elseif p3 ~= "SaveSuccess" then
		if p3 == "ServiceStatus" then
			if p4 then
				warn("DataStore service is in critical state!")
				return
			end
		else
			local v5 = p3 == "DataLoaded" and v_u_2:FindFirstChild("LoadingScreen")
			if v5 then
				v5:Destroy()
			end
		end
	end
end)