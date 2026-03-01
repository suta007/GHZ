local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")
local GetShopData = RemoteEvents:WaitForChild("GetShopData")

local args = {
	"SeedShop",
}
local SeedShop = GetShopData:InvokeServer(unpack(args))

for Name, Seed in pairs(SeedShop.Items) do
	print(Name)
	print(Seed.Amount)
end
