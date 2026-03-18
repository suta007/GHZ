local v1 = {}
local v_u_2 = {}
local v_u_3 = {}
local v_u_4 = {}
function v1.OnPreloadPlot(p5)
	-- upvalues: (copy) v_u_2
	local v6 = v_u_2
	table.insert(v6, p5)
end
function v1.FirePreloadPlot(p7)
	-- upvalues: (copy) v_u_2
	for _, v8 in v_u_2 do
		task.spawn(v8, p7)
	end
end
function v1.OnLocalHarvestPlant(p9)
	-- upvalues: (copy) v_u_3
	local v10 = v_u_3
	table.insert(v10, p9)
end
function v1.FireLocalHarvestPlant(p11)
	-- upvalues: (copy) v_u_3
	for _, v12 in v_u_3 do
		task.spawn(v12, p11)
	end
end
function v1.OnLocalHarvestFruit(p13)
	-- upvalues: (copy) v_u_4
	local v14 = v_u_4
	table.insert(v14, p13)
end
function v1.FireLocalHarvestFruit(p15, p16)
	-- upvalues: (copy) v_u_4
	for _, v17 in v_u_4 do
		task.spawn(v17, p15, p16)
	end
end
return v1