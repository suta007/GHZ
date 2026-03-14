local State = {}

State.isBuyingSeed = false
State.isBuyingGear = false
State.isPlanting = false
State.isProcessing = false
State.HarvestPause = false
State.isHarvesting = false
State.isQuestClaiming = false
State.isRemovePlants = false
State.isRemoveCrops = false
State.MannyMishapEnable = false
State.isAntiLag = false
State.IsLoading = true

State.HarVestCropsList = {}
State.actionQueue = {}
State.backupQueue = {}
State.bGuiSession = {}
State.MyPlantableParts = {}
State.MyPlot = nil
State.MySpawn = nil
State.MySpawnPoint = nil

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
