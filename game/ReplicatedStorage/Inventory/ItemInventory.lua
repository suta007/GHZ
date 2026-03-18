local v_u_26 = {
	["getItemCount"] = function(p1)
		return p1:GetAttribute("ItemCount") or 1
	end,
	["setItemCount"] = function(p2, p3)
		-- upvalues: (copy) v_u_26
		p2:SetAttribute("ItemCount", p3)
		v_u_26.updateToolName(p2)
	end,
	["decrementItemCount"] = function(p4)
		-- upvalues: (copy) v_u_26
		local v5 = v_u_26.getItemCount(p4) - 1
		local v6 = math.max(0, v5)
		v_u_26.setItemCount(p4, v6)
		return v6
	end,
	["incrementItemCount"] = function(p7)
		-- upvalues: (copy) v_u_26
		local v8 = v_u_26.getItemCount(p7) + 1
		v_u_26.setItemCount(p7, v8)
		return v8
	end,
	["consumeTool"] = function(p9)
		-- upvalues: (copy) v_u_26
		if v_u_26.getItemCount(p9) > 1 then
			v_u_26.decrementItemCount(p9)
			return false
		else
			p9:Destroy()
			return true
		end
	end,
	["getBaseName"] = function(p10)
		return p10:GetAttribute("BaseName") or p10.Name
	end,
	["updateToolName"] = function(p11)
		-- upvalues: (copy) v_u_26
		if p11:GetAttribute("IsHarvested") then
			return
		elseif p11:GetAttribute("HarvestedFrom") or p11:GetAttribute("FruitValue") then
			return
		else
			local v12 = v_u_26.getItemCount(p11)
			local v13 = p11:GetAttribute("BaseName") or p11.Name
			if not p11:GetAttribute("BaseName") then
				p11:SetAttribute("BaseName", p11.Name)
			end
			if v12 > 1 then
				p11.Name = "x" .. v12 .. " " .. v13
			else
				p11.Name = v13
			end
		end
	end,
	["setupItem"] = function(p14, p15)
		-- upvalues: (copy) v_u_26
		if not p14:GetAttribute("BaseName") then
			p14:SetAttribute("BaseName", p14.Name)
		end
		v_u_26.setItemCount(p14, p15)
	end,
	["findItemInBackpack"] = function(p16, p17)
		for _, v18 in p16:GetChildren() do
			if v18:IsA("Tool") and (not v18:GetAttribute("IsHarvested") and v18:GetAttribute("BaseName") == p17) then
				return v18
			end
		end
		return nil
	end,
	["mergeItemsInBackpack"] = function(p19)
		-- upvalues: (copy) v_u_26
		local v20 = {}
		for _, v21 in p19:GetChildren() do
			if v21:IsA("Tool") and (v21:GetAttribute("BaseName") and not v21:GetAttribute("IsHarvested")) then
				local v22 = v21:GetAttribute("BaseName")
				if v20[v22] then
					local v23 = v_u_26.getItemCount(v21)
					local v24 = v20[v22]
					local v25 = v_u_26.getItemCount(v24)
					v_u_26.setItemCount(v24, v25 + v23)
					v21:Destroy()
				else
					v20[v22] = v21
				end
			end
		end
	end
}
return v_u_26