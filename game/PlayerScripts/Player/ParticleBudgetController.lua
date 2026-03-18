local v1 = game:GetService("RunService")
local v2 = game:GetService("CollectionService")
local v_u_3 = game:GetService("Workspace").CurrentCamera
local v_u_4 = {}
local v_u_5 = {}
local v_u_6 = {}
local v_u_7 = {}
local v_u_8 = {}
local v_u_9 = {}
local v_u_10 = {}
local v_u_11 = {}
local v_u_12 = {}
local v_u_13 = {}
local v_u_14 = {}
local v_u_15 = {}
local function v_u_34(p16)
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_4
	if v_u_5[p16] then
		return
	else
		local v17 = p16.Parent
		local v18
		if v17 then
			if v17:IsA("BasePart") then
				v18 = v17.Position
			elseif v17:IsA("Attachment") then
				v18 = v17.WorldPosition
			else
				v18 = nil
			end
		else
			v18 = nil
		end
		if v18 then
			local v19 = v18.X
			local v20 = v18.Z
			local v21 = v19 / 4
			local v22 = math.floor(v21)
			local v23 = v20 / 4
			local v24 = v22 .. "_" .. math.floor(v23)
			v_u_5[p16] = p16.Rate
			v_u_6[p16] = v24
			if not v_u_4[v24] then
				local v25 = v_u_4
				local v26 = {
					["emitters"] = {}
				}
				local v27, v28 = v24:match("^(-?%d+)_(-?%d+)$")
				local v29 = tonumber(v27)
				local v30 = tonumber(v28)
				local v31 = (v29 + 0.5) * 4
				local v32 = (v30 + 0.5) * 4
				v26.center = Vector3.new(v31, 0, v32)
				v26.count = 0
				v25[v24] = v26
			end
			v_u_4[v24].emitters[p16] = true
			local v33 = v_u_4[v24]
			v33.count = v33.count + 1
		end
	end
end
local function v_u_37(p35)
	local v36 = p35.Parent
	while v36 do
		if v36:IsA("Attachment") and v36.Name == "PreviewOutline" then
			return true
		end
		if v36:IsA("Model") then
			break
		end
		v36 = v36.Parent
	end
	return false
end
local function v_u_56(p38)
	-- upvalues: (copy) v_u_11, (copy) v_u_37, (copy) v_u_12, (copy) v_u_10
	if v_u_11[p38] then
		return
	elseif v_u_37(p38) then
		return
	else
		local v39 = p38.Parent
		local v40
		if v39 then
			if v39:IsA("BasePart") then
				v40 = v39.Position
			elseif v39:IsA("Attachment") then
				v40 = v39.WorldPosition
			else
				v40 = nil
			end
		else
			v40 = nil
		end
		if v40 then
			local v41 = v40.X
			local v42 = v40.Z
			local v43 = v41 / 4
			local v44 = math.floor(v43)
			local v45 = v42 / 4
			local v46 = v44 .. "_" .. math.floor(v45)
			v_u_11[p38] = p38.Rate
			v_u_12[p38] = v46
			if not v_u_10[v46] then
				local v47 = v_u_10
				local v48 = {
					["emitters"] = {}
				}
				local v49, v50 = v46:match("^(-?%d+)_(-?%d+)$")
				local v51 = tonumber(v49)
				local v52 = tonumber(v50)
				local v53 = (v51 + 0.5) * 4
				local v54 = (v52 + 0.5) * 4
				v48.center = Vector3.new(v53, 0, v54)
				v48.count = 0
				v47[v46] = v48
			end
			v_u_10[v46].emitters[p38] = true
			local v55 = v_u_10[v46]
			v55.count = v55.count + 1
		end
	end
end
local function v_u_63(p57)
	-- upvalues: (copy) v_u_34, (copy) v_u_7, (copy) v_u_6, (copy) v_u_4, (copy) v_u_5, (copy) v_u_8, (copy) v_u_9
	for _, v58 in p57:GetDescendants() do
		if v58:IsA("ParticleEmitter") then
			v_u_34(v58)
		end
	end
	if not v_u_7[p57] then
		v_u_7[p57] = { p57.DescendantAdded:Connect(function(p59)
				-- upvalues: (ref) v_u_34
				if p59:IsA("ParticleEmitter") then
					v_u_34(p59)
				end
			end), (p57.DescendantRemoving:Connect(function(p60)
				-- upvalues: (ref) v_u_6, (ref) v_u_4, (ref) v_u_5, (ref) v_u_8, (ref) v_u_9
				if p60:IsA("ParticleEmitter") then
					local v61 = v_u_6[p60]
					if not v61 then
						return
					end
					local v62 = v_u_4[v61]
					if v62 then
						v62.emitters[p60] = nil
						v62.count = v62.count - 1
						if v62.count <= 0 then
							v_u_4[v61] = nil
						end
					end
					v_u_6[p60] = nil
					v_u_5[p60] = nil
					v_u_8[p60] = nil
					v_u_9[p60] = nil
				end
			end)) }
	end
end
local function v_u_69(p64)
	-- upvalues: (copy) v_u_7, (copy) v_u_6, (copy) v_u_4, (copy) v_u_5, (copy) v_u_8, (copy) v_u_9
	if v_u_7[p64] then
		for _, v65 in v_u_7[p64] do
			v65:Disconnect()
		end
		v_u_7[p64] = nil
	end
	for _, v66 in p64:GetDescendants() do
		if v66:IsA("ParticleEmitter") then
			local v67 = v_u_6[v66]
			if v67 then
				local v68 = v_u_4[v67]
				if v68 then
					v68.emitters[v66] = nil
					v68.count = v68.count - 1
					if v68.count <= 0 then
						v_u_4[v67] = nil
					end
				end
				v_u_6[v66] = nil
				v_u_5[v66] = nil
				v_u_8[v66] = nil
				v_u_9[v66] = nil
			end
		end
	end
end
local function v_u_76(p70)
	-- upvalues: (copy) v_u_56, (copy) v_u_13, (copy) v_u_12, (copy) v_u_10, (copy) v_u_11, (copy) v_u_14, (copy) v_u_15
	for _, v71 in p70:GetDescendants() do
		if v71:IsA("ParticleEmitter") then
			v_u_56(v71)
		end
	end
	if not v_u_13[p70] then
		v_u_13[p70] = { p70.DescendantAdded:Connect(function(p72)
				-- upvalues: (ref) v_u_56
				if p72:IsA("ParticleEmitter") then
					v_u_56(p72)
				end
			end), (p70.DescendantRemoving:Connect(function(p73)
				-- upvalues: (ref) v_u_12, (ref) v_u_10, (ref) v_u_11, (ref) v_u_14, (ref) v_u_15
				if p73:IsA("ParticleEmitter") then
					local v74 = v_u_12[p73]
					if not v74 then
						return
					end
					local v75 = v_u_10[v74]
					if v75 then
						v75.emitters[p73] = nil
						v75.count = v75.count - 1
						if v75.count <= 0 then
							v_u_10[v74] = nil
						end
					end
					v_u_12[p73] = nil
					v_u_11[p73] = nil
					v_u_14[p73] = nil
					v_u_15[p73] = nil
				end
			end)) }
	end
end
local function v_u_82(p77)
	-- upvalues: (copy) v_u_13, (copy) v_u_12, (copy) v_u_10, (copy) v_u_11, (copy) v_u_14, (copy) v_u_15
	if v_u_13[p77] then
		for _, v78 in v_u_13[p77] do
			v78:Disconnect()
		end
		v_u_13[p77] = nil
	end
	for _, v79 in p77:GetDescendants() do
		if v79:IsA("ParticleEmitter") then
			local v80 = v_u_12[v79]
			if v80 then
				local v81 = v_u_10[v80]
				if v81 then
					v81.emitters[v79] = nil
					v81.count = v81.count - 1
					if v81.count <= 0 then
						v_u_10[v80] = nil
					end
				end
				v_u_12[v79] = nil
				v_u_11[v79] = nil
				v_u_14[v79] = nil
				v_u_15[v79] = nil
			end
		end
	end
end
local v_u_83 = 0
local function v_u_103()
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_9, (copy) v_u_5, (copy) v_u_8
	local v84 = v_u_3.CFrame
	local v85 = v84.Position
	local v86 = v84.LookVector
	for _, v87 in v_u_4 do
		if v87.count ~= 0 then
			local v88 = v87.center.X - v85.X
			local v89 = v87.center.Z - v85.Z
			local v90 = Vector3.new(v88, 0, v89)
			local v91 = v90.Magnitude
			local v92
			if v91 > 1 then
				v92 = v86.X * v90.X / v91 + v86.Z * v90.Z / v91 < -0.2
			else
				v92 = false
			end
			if v92 then
				for v93 in v87.emitters do
					if v93.Parent and v_u_9[v93] ~= false then
						v93.Enabled = false
						v_u_9[v93] = false
					end
				end
			else
				local v94
				if v91 <= 0 then
					v94 = 1
				elseif v91 >= 50 then
					v94 = 0
				else
					local v95 = 1 - v91 / 50
					v94 = v95 * v95
				end
				if v94 <= 0 then
					for v96 in v87.emitters do
						if v96.Parent and v_u_9[v96] ~= false then
							v96.Enabled = false
							v_u_9[v96] = false
						end
					end
				else
					local v97 = v94 * 75 / v87.count
					for v98 in v87.emitters do
						if v98.Parent then
							local v99 = v_u_5[v98]
							if v99 then
								if v_u_9[v98] ~= true then
									v98.Enabled = true
									v_u_9[v98] = true
								end
								local v100 = math.min(v99, v97) + 0.5
								local v101 = math.floor(v100)
								local v102 = math.max(0, v101)
								if v_u_8[v98] ~= v102 then
									v98.Rate = v102
									v_u_8[v98] = v102
								end
							end
						end
					end
				end
			end
		end
	end
end
local v_u_104 = 0.2
local function v_u_123()
	-- upvalues: (copy) v_u_3, (copy) v_u_10, (copy) v_u_15, (copy) v_u_11, (copy) v_u_14
	local v105 = v_u_3.CFrame
	local v106 = v105.Position
	local v107 = v105.LookVector
	for _, v108 in v_u_10 do
		if v108.count ~= 0 then
			local v109 = v108.center.X - v106.X
			local v110 = v108.center.Z - v106.Z
			local v111 = Vector3.new(v109, 0, v110)
			local v112 = v111.Magnitude
			local v113
			if v112 > 1 then
				v113 = v107.X * v111.X / v112 + v107.Z * v111.Z / v112 < -0.2
			else
				v113 = false
			end
			if v113 then
				for v114 in v108.emitters do
					if v114.Parent and v_u_15[v114] ~= false then
						v114.Enabled = false
						v_u_15[v114] = false
					end
				end
			else
				local v115
				if v112 <= 0 then
					v115 = 1
				elseif v112 >= 125 then
					v115 = 0
				else
					local v116 = 1 - v112 / 125
					v115 = v116 * v116
				end
				if v115 <= 0 then
					for v117 in v108.emitters do
						if v117.Parent and v_u_15[v117] ~= false then
							v117.Enabled = false
							v_u_15[v117] = false
						end
					end
				else
					for v118 in v108.emitters do
						if v118.Parent then
							local v119 = v_u_11[v118]
							if v119 then
								if v_u_15[v118] ~= true then
									v118.Enabled = true
									v_u_15[v118] = true
								end
								local v120 = v119 * v115 + 0.5
								local v121 = math.floor(v120)
								local v122 = math.max(0, v121)
								if v_u_14[v118] ~= v122 then
									v118.Rate = v122
									v_u_14[v118] = v122
								end
							end
						end
					end
				end
			end
		end
	end
end
for _, v124 in { "Plant", "Fruit" } do
	for _, v125 in v2:GetTagged(v124) do
		v_u_63(v125)
	end
	v2:GetInstanceAddedSignal(v124):Connect(function(p126)
		-- upvalues: (copy) v_u_63
		v_u_63(p126)
	end)
	v2:GetInstanceRemovedSignal(v124):Connect(function(p127)
		-- upvalues: (copy) v_u_69
		v_u_69(p127)
	end)
end
for _, v128 in v2:GetTagged("Sprinkler") do
	v_u_76(v128)
end
v2:GetInstanceAddedSignal("Sprinkler"):Connect(function(p129)
	-- upvalues: (copy) v_u_76
	v_u_76(p129)
end)
v2:GetInstanceRemovedSignal("Sprinkler"):Connect(function(p130)
	-- upvalues: (copy) v_u_82
	v_u_82(p130)
end)
v1.Heartbeat:Connect(function()
	-- upvalues: (ref) v_u_83, (copy) v_u_103, (ref) v_u_104, (copy) v_u_123
	local v131 = os.clock()
	if v131 - v_u_83 >= 0.4 then
		v_u_83 = v131
		v_u_103()
	end
	if v131 - v_u_104 >= 0.4 then
		v_u_104 = v131
		v_u_123()
	end
end)
task.spawn(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_6, (copy) v_u_4, (copy) v_u_8, (copy) v_u_9, (copy) v_u_11, (copy) v_u_12, (copy) v_u_10, (copy) v_u_14, (copy) v_u_15
	while true do
		task.wait(15)
		for v132 in v_u_5 do
			if not v132.Parent then
				local v133 = v_u_6[v132]
				if v133 then
					local v134 = v_u_4[v133]
					if v134 then
						v134.emitters[v132] = nil
						v134.count = v134.count - 1
						if v134.count <= 0 then
							v_u_4[v133] = nil
						end
					end
					v_u_6[v132] = nil
					v_u_5[v132] = nil
					v_u_8[v132] = nil
					v_u_9[v132] = nil
				end
				v_u_8[v132] = nil
				v_u_9[v132] = nil
			end
		end
		for v135 in v_u_11 do
			if not v135.Parent then
				local v136 = v_u_12[v135]
				if v136 then
					local v137 = v_u_10[v136]
					if v137 then
						v137.emitters[v135] = nil
						v137.count = v137.count - 1
						if v137.count <= 0 then
							v_u_10[v136] = nil
						end
					end
					v_u_12[v135] = nil
					v_u_11[v135] = nil
					v_u_14[v135] = nil
					v_u_15[v135] = nil
				end
				v_u_14[v135] = nil
				v_u_15[v135] = nil
			end
		end
	end
end)