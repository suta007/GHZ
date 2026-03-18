local v2 = {
	["FormatFull"] = function(_, p1)
		return tostring(p1):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
	end
}
local v_u_3 = {
	"K",
	"M",
	"B",
	"T",
	"QA",
	"QI",
	"SX",
	"SP",
	"OC",
	"NO",
	"DE",
	"UN",
	"DU",
	"TR"
}
function v2.FormatNumberShort(_, p4)
	-- upvalues: (copy) v_u_3
	if not tonumber(p4) then
		return p4
	end
	if p4 < 10000 then
		return math.floor(p4)
	end
	local v5 = math.log10(p4) / 3
	local v6 = math.floor(v5) * 3
	local v7 = p4 / 10 ^ v6
	local v8 = tostring(v7):sub(1, 5):gsub("%.0+$", "")
	local v9 = v_u_3
	local v10 = v6 / 3
	local v11 = v9[math.floor(v10)]
	return v8 .. tostring(v11)
end
function v2.FormatTime(_, p12)
	local v13 = p12 < 0 and 0 or p12
	local v14 = v13 / 86400
	local v15 = math.floor(v14)
	local v16 = v13 % 86400 / 3600
	local v17 = math.floor(v16)
	local v18 = v13 % 3600 / 60
	local v19 = math.floor(v18)
	local v20 = v13 % 60
	local v21 = math.floor(v20)
	if v15 > 0 then
		return string.format("%dd %dh", v15, v17)
	elseif v17 > 0 then
		return string.format("%d:%02d:%02d", v17, v19, v21)
	else
		return string.format("%d:%02d", v19, v21)
	end
end
return v2