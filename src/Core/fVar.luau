local fVar = {}

--Action Queue
fVar.actionQueue = {}

-- Constant Variable
fVar.SutaDistLimit = 15
fVar.SutaYoffset = 4

--Control Variable
fVar.isPlanting = false
fVar.isBuyingSeed = false
fVar.isBuyingGear = false
fVar.isProcessing = false
fVar.HarvestPause = false
fVar.Harvesting = false

function fVar.ResetControlVar()
	fVar.isPlanting = false
	fVar.isBuyingSeed = false
	fVar.isBuyingGear = false
	fVar.isProcessing = false
	fVar.HarvestPause = false
	fVar.Harvesting = false
end

function fVar.LockDownControlVar()
	fVar.isPlanting = true
	fVar.isBuyingSeed = true
	fVar.isBuyingGear = true
	fVar.isProcessing = true
	fVar.HarvestPause = true
	fVar.Harvesting = true
end

function fVar.IsBuying()
	return fVar.isBuyingSeed or fVar.isBuyingGear
end

return fVar
