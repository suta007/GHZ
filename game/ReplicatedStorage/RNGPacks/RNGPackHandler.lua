local v1 = game:GetService("ReplicatedStorage"):WaitForChild("RNGPacks")
local v2 = require(v1:WaitForChild("SeedPackDefinitions"))
local v3 = {
	["Packs"] = {}
}
for v4, v5 in pairs(v2) do
	v3.Packs[v4] = v5
end
return v3