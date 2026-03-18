local v1 = game:GetService("ReplicatedStorage")
local v2 = require(v1.Plants.Definitions.PlantDataDefinitions)
local v_u_3 = v1:WaitForChild("Plants"):WaitForChild("Models", 10)
if not v_u_3 then
	warn("[PlantAssetDefinitions] Plants.Models folder not found in ReplicatedStorage!")
	return {}
end
local function v8(p4)
	-- upvalues: (copy) v_u_3
	local v5 = v_u_3:FindFirstChild(p4)
	if not v5 then
		return nil
	end
	local v6 = {}
	for _, v7 in v5:GetChildren() do
		if v7:IsA("Model") then
			table.insert(v6, v7)
		end
	end
	return #v6 > 0 and v6 and v6 or nil
end
local v9 = {}
for v10 in v2 do
	local v11 = {
		["template"] = v8(v10)
	}
	local v12 = v_u_3:FindFirstChild(v10)
	local v13
	if v12 then
		v13 = v12:FindFirstChild("FruitFolder")
		if not (v13 and v13:IsA("Folder")) then
			v13 = nil
		end
	else
		v13 = nil
	end
	v11.fruitTemplate = v13
	v9[v10] = v11
end
return v9