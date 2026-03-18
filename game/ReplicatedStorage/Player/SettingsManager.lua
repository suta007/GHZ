local v1 = {}
local v2 = game:GetService("RunService")
local v_u_3 = {
	["MusicVolume"] = {
		["Type"] = "number",
		["Description"] = "Adjusts music volume.",
		["Default"] = 1
	},
	["SFXVolume"] = {
		["Type"] = "number",
		["Description"] = "Adjusts SFX volume.",
		["Default"] = 1
	},
	["WeatherVolume"] = {
		["Type"] = "number",
		["Description"] = "Adjusts weather volume.",
		["Default"] = 1
	},
	["LowDetail"] = {
		["Type"] = "boolean",
		["Description"] = "Adjusts visual effects.",
		["Default"] = false
	},
	["MusicMix"] = {
		["Type"] = "string",
		["Description"] = "Changes the music genre.",
		["Default"] = "Background"
	}
}
function v1.GetDefinitions()
	-- upvalues: (copy) v_u_3
	return v_u_3
end
if v2:IsServer() then
	function v1.UpdateSetting(p4, p5, p6, p7, p8)
		-- upvalues: (copy) v_u_3
		local v9 = v_u_3[p7]
		if v9 then
			if typeof(p8) == v9.Type then
				p5.Data.Settings[p7] = p8
				if p6 then
					p6:Set({ "Settings", p7 }, p8)
				end
				p4:SetAttribute(p7, p8)
			end
		else
			return
		end
	end
	function v1.InitPlayer(p10, p11)
		-- upvalues: (copy) v_u_3
		for v12, v13 in pairs(v_u_3) do
			local v14 = p11.Data.Settings[v12]
			if v14 == nil or not v14 then
				v14 = v13.Default
			end
			p10:SetAttribute(v12, v14)
		end
	end
end
return v1