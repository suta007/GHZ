local v_u_1 = {}
v_u_1.__index = v_u_1
function v_u_1.new(p2)
	-- upvalues: (copy) v_u_1
	local v3 = v_u_1
	local v4 = setmetatable({}, v3)
	v4._systemName = p2 or "System"
	return v4
end
function v_u_1.Log(_, ...) end
function v_u_1.Warn(p5, ...)
	warn(("[%*]:"):format(p5._systemName), ...)
end
function v_u_1.Error(p6, ...)
	warn(("[%*] ERROR:"):format(p6._systemName), ...)
end
function v_u_1.Info(p7, ...)
	print(("[%*]:"):format(p7._systemName), ...)
end
return v_u_1