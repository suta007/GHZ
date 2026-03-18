local v_u_1 = require(script.Parent:WaitForChild("SprinklerPlacementController"))
local v_u_2 = require(script.Parent:WaitForChild("SprinklerVFXController"))
return {
	["Activate"] = function(p3, p4, p5, p6)
		-- upvalues: (copy) v_u_1
		v_u_1.Activate(p3, p4, p5, p6)
	end,
	["Deactivate"] = function()
		-- upvalues: (copy) v_u_1
		v_u_1.Deactivate()
	end,
	["Init"] = function()
		-- upvalues: (copy) v_u_2
		v_u_2.Init()
	end
}