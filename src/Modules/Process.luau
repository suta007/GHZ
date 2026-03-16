local Process = {}
local reg
local fVar

function Process.Initialize(Registry)
	reg = Registry
	fVar = reg.fVar
end

function Process.processQueue()
	if fVar.isProcessing then return end
	fVar.isProcessing = true
	fVar.HarvestPause = true
	task.wait(0.2)

	while #fVar.actionQueue > 0 do
		local taskData = table.remove(fVar.actionQueue, 1)
		pcall(function()
			if taskData.args ~= nil then
				taskData.FuncName(taskData.args)
			else
				taskData.FuncName()
			end
		end)
	end
	fVar.isProcessing = false
	fVar.HarvestPause = false
	task.wait(0.5)
end

return Process
