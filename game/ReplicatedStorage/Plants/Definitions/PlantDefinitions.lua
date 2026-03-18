game:GetService("ReplicatedStorage")
local v1 = require(script.Parent:WaitForChild("PlantDataDefinitions"))
local v2 = require(script.Parent:WaitForChild("PlantAssetDefinitions"))
local v3 = {}
if v2 and type(v2) == "table" then
	for v4, v5 in pairs(v1) do
		v3[v4] = {}
		for v6, v7 in pairs(v5) do
			v3[v4][v6] = v7
		end
		local v8 = v2[v4]
		if v8 then
			for v9, v10 in pairs(v8) do
				v3[v4][v9] = v10
			end
		end
		v3[v4].id = v4
	end
	return v3
end
warn("[PlantDefinitions] PlantAssetDefinitions failed to load! Using data-only definitions.")
for v11, v12 in pairs(v1) do
	v3[v11] = {}
	for v13, v14 in pairs(v12) do
		v3[v11][v13] = v14
	end
	v3[v11].id = v11
end
return v3