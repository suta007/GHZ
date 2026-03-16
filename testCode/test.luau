local CollectionService = game:GetService("CollectionService")
local function fff(arg)
	local fruit = arg.Parent.Parent
	if fruit then
		local fruitName = fruit:GetAttribute("PlantType") or (fruit.Parent and fruit.Parent:GetAttribute("PlantType")) or "Fruit"
		rconsoleprint(fruitName)
		print(fruitName)
	end
end

CollectionService:GetInstanceAddedSignal("HarvestPrompt"):Connect(fff)
