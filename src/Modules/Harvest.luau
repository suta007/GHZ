--!nocheck
local Harvest = {}
local Registry = nil
local State = nil
local Utils = nil
local Network = nil

local CollectionService = game:GetService("CollectionService")

local Options = {} 

function Harvest.Initialize(reg)
	Registry = reg
	State = reg.State
	Utils = reg.Utils
	Network = reg.Network
end

function Harvest.SetOptions(opts)
	Options = opts
end

function Harvest.Scan()
	if not Options.ddHarvestList then return end
	local targets = Options.ddHarvestList.Value
	if #targets == 0 then return end

	local crops = CollectionService:GetTagged("HarvestPart")
	table.clear(State.HarVestCropsList)

	for _, crop in ipairs(crops) do
		local plantModel = crop.Parent
		if plantModel and targets[plantModel.Name] then
			table.insert(State.HarVestCropsList, crop)
		end
	end
end

function Harvest.Run()
	if State.isHarvesting or #State.HarVestCropsList == 0 then return end
	State.isHarvesting = true

	while #State.HarVestCropsList > 0 and Options.tgHarvestEnable.Value do
		if State.HarvestPause then break end
		local crop = table.remove(State.HarVestCropsList, 1)
		if crop and crop.Parent then
			Utils.TweenToTarget(crop.CFrame, Options.slWalkSpeed and Options.slWalkSpeed.Value or 50)
			Network.Events.HarvestFruit:FireServer(crop)
			task.wait(0.1)
		end
	end

	State.isHarvesting = false
end

return Harvest
