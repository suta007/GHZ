local v_u_24 = {
	["ClassName"] = "Maid",
	["new"] = function()
		-- upvalues: (copy) v_u_24
		local v1 = v_u_24
		return setmetatable({
			["_tasks"] = {}
		}, v1)
	end,
	["isMaid"] = function(p2)
		local v3
		if type(p2) == "table" then
			v3 = p2.ClassName == "Maid"
		else
			v3 = false
		end
		return v3
	end,
	["__index"] = function(p4, p5)
		-- upvalues: (copy) v_u_24
		if v_u_24[p5] then
			return v_u_24[p5]
		else
			return p4._tasks[p5]
		end
	end,
	["__newindex"] = function(p6, p7, p8)
		-- upvalues: (copy) v_u_24
		if v_u_24[p7] ~= nil then
			error(("\'%s\' is reserved"):format((tostring(p7))), 2)
		end
		local v9 = p6._tasks
		local v10 = v9[p7]
		if v10 ~= p8 then
			v9[p7] = p8
			if v10 then
				if type(v10) == "function" then
					v10()
					return
				end
				if typeof(v10) == "RBXScriptConnection" then
					v10:Disconnect()
					return
				end
				if v10.Destroy then
					v10:Destroy()
				end
			end
		end
	end,
	["GiveTask"] = function(p11, p12)
		if not p12 then
			error("Task cannot be false or nil", 2)
		end
		local v13 = #p11._tasks + 1
		p11[v13] = p12
		if type(p12) == "table" and not p12.Destroy then
			warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
		end
		return v13
	end,
	["GivePromise"] = function(p_u_14, p15)
		if not p15:IsPending() then
			return p15
		end
		local v16 = p15.resolved(p15)
		local v_u_17 = p_u_14:GiveTask(v16)
		v16:Finally(function()
			-- upvalues: (copy) p_u_14, (copy) v_u_17
			p_u_14[v_u_17] = nil
		end)
		return v16
	end,
	["DoCleaning"] = function(p18)
		local v19 = p18._tasks
		for v20, v21 in pairs(v19) do
			if typeof(v21) == "RBXScriptConnection" then
				v19[v20] = nil
				v21:Disconnect()
			end
		end
		local v22, v23 = next(v19)
		while v23 ~= nil do
			v19[v22] = nil
			if type(v23) == "function" then
				v23()
			elseif typeof(v23) == "RBXScriptConnection" then
				v23:Disconnect()
			elseif v23.Destroy then
				v23:Destroy()
			end
			v22, v23 = next(v19)
		end
	end
}
v_u_24.Destroy = v_u_24.DoCleaning
return v_u_24