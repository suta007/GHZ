SetupTracker = function()
	local PlantFolder = GetPlantsFolder()
	if PlantFolder then
		-- ดักจับเฉพาะของที่งอกใหม่ในสวนของเราโดยตรง (ลดภาระเครื่องได้เยอะมาก)
		PlantFolder.DescendantAdded:Connect(function(newObj)
			task.wait()
			if IsFruit(newObj) then
				if Options.tgHideFruit.Value then SetVisibility(newObj, true) end
			else
				if Options.tgHidePlant.Value then SetVisibility(newObj, true) end
			end
		end)
	end
end
