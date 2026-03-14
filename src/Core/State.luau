--!nocheck
local State = {
	IsLoading = true,
	
	-- Control Flags
	isBuyingSeed = false,
	isBuyingGear = false,
	isPlanting = false,
	isProcessing = false,
	HarvestPause = false,
	isHarvesting = false,
	isQuestClaiming = false,
	isRemovePlants = false,
	isRemoveCrops = false,
	
	MannyMishapEnable = false,
	isAntiLag = false,
	
	-- Data Containers
	HarVestCropsList = {},
	actionQueue = {},
	backupQueue = {},
	
	-- Plot Specific
	MyPlot = nil,
	MySpawn = nil,
	MySpawnPoint = nil,
	MyPlantableParts = {},
	
	-- ESP/Session Data
	bGuiSession = {},
}

function State:ResetControlVariable()
	self.isBuyingSeed = false
	self.isBuyingGear = false
	self.isPlanting = false
	self.isProcessing = false
	self.HarvestPause = false
	self.isHarvesting = false
	self.isQuestClaiming = false
	self.isRemovePlants = false
	self.isRemoveCrops = false

	table.clear(self.HarVestCropsList)
	table.clear(self.actionQueue)
end

function State:LockDownControlVariable()
	self.isBuyingSeed = true
	self.isBuyingGear = true
	self.isPlanting = true
	self.isProcessing = true
	self.HarvestPause = true
	self.isHarvesting = true
	self.isQuestClaiming = true
	self.isRemovePlants = true
	self.isRemoveCrops = true
	self.backupQueue = table.clone(self.actionQueue)
	table.clear(self.actionQueue)
end

return State
