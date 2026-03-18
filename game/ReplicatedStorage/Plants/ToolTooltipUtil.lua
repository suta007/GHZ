local v_u_11 = {
	["Build"] = function(p1)
		local v2 = p1:GetAttribute("Variant")
		local v3 = (not v2 or v2 == "") and "" or v2 .. " Variant"
		local v4 = p1:GetAttribute("Mutation")
		if v4 and v4 ~= "" then
			local v5 = {}
			for v6 in string.gmatch(v4, "([^,]+)") do
				table.insert(v5, v6:match("^%s*(.-)%s*$"))
			end
			if #v5 > 0 then
				if v3 ~= "" then
					v3 = v3 .. "\n"
				end
				v3 = v3 .. "Mutations: " .. table.concat(v5, ", ")
			end
		end
		local v7 = p1:GetAttribute("RipenessStage")
		if v7 and v7 ~= "" then
			if v3 ~= "" then
				v3 = v3 .. "\n"
			end
			local v8 = p1:GetAttribute("RipenessMultiplier")
			if v8 then
				return v3 .. " " .. v7 .. " (" .. string.format("%.1fx", v8) .. ")"
			end
			v3 = v3 .. v7
		end
		return v3
	end,
	["Apply"] = function(p9)
		-- upvalues: (copy) v_u_11
		local v10 = v_u_11.Build(p9)
		if v10 ~= "" then
			p9.ToolTip = v10
		end
	end
}
return v_u_11