local fVar = {}
local reg

--Action Queue
fVar.actionQueue = {}

-- Constant Variable
fVar.SutaDistLimit = 15
fVar.SutaYoffset = 4
fVar.Pos = {
	GearShop = CFrame.new(211.64, 205.50, 608.18),
	SeedShop = CFrame.new(176.70, 205.50, 672.00),
	Botanist = CFrame.new(214.00, 205.50, 621.05),
	Sell = CFrame.new(149.40, 205.50, 672.00),
	Quest = CFrame.new(111.52, 205.50, 635.02),
	Strange = CFrame.new(168.74, 270.57, 768.77),
}

--Control Variable
fVar.isPlanting = false
fVar.isBuyingSeed = false
fVar.isBuyingGear = false
fVar.isProcessing = false
fVar.isSelling = false
fVar.HarvestPause = false
fVar.isHarvesting = false
fVar.isQuestClaiming = false
fVar.isRemovePlants = false
fVar.isRemoveCrops = false

function fVar.ResetControlVar()
	fVar.isPlanting = false
	fVar.isBuyingSeed = false
	fVar.isBuyingGear = false
	fVar.isProcessing = false
	fVar.isSelling = false
	fVar.HarvestPause = false
	fVar.isHarvesting = false
	fVar.isQuestClaiming = false
	fVar.isRemovePlants = false
	fVar.isRemoveCrops = false

	table.clear(fVar.actionQueue)
end

function fVar.LockDownControlVar()
	fVar.isPlanting = true
	fVar.isBuyingSeed = true
	fVar.isBuyingGear = true
	fVar.isProcessing = true
	fVar.isSelling = true
	fVar.HarvestPause = true
	fVar.isHarvesting = true
	fVar.isQuestClaiming = true
	fVar.isRemovePlants = true
	fVar.isRemoveCrops = true
end

function fVar.IsBuying()
	return fVar.isBuyingSeed or fVar.isBuyingGear or fVar.isSelling
end

return fVar
