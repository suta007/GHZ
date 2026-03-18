local v1 = {}
local v_u_2 = {}
function v1.Register(p3, p4)
	-- upvalues: (copy) v_u_2
	v_u_2[p3] = p4
end
function v1.Get(p5)
	-- upvalues: (copy) v_u_2
	return v_u_2[p5]
end
return v1