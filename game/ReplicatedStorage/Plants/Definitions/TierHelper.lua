local v_u_1 = {}
local v2 = {
	["Id"] = "Common",
	["Color"] = "#A7A7A7",
	["Image"] = "rbxassetid://114037657912448",
	["Stars"] = {
		["Number"] = 1,
		["Color"] = "Bronze"
	}
}
v_u_1.Common = v2
local v3 = {
	["Id"] = "Uncommon",
	["Color"] = "#34D034",
	["Image"] = "rbxassetid://82807667238724",
	["Stars"] = {
		["Number"] = 2,
		["Color"] = "Bronze"
	}
}
v_u_1.Uncommon = v3
local v4 = {
	["Id"] = "Rare",
	["Color"] = "#0066FF",
	["Image"] = "rbxassetid://139210607597073",
	["Stars"] = {
		["Number"] = 3,
		["Color"] = "Bronze"
	}
}
v_u_1.Rare = v4
local v5 = {
	["Id"] = "Epic",
	["Color"] = "#8A1EC8",
	["Image"] = "rbxassetid://117042561273806",
	["Stars"] = {
		["Number"] = 1,
		["Color"] = "Silver"
	}
}
v_u_1.Epic = v5
local v6 = {
	["Id"] = "Legendary",
	["Color"] = "#FFDC2F",
	["Image"] = "rbxassetid://108307213649542",
	["Stars"] = {
		["Number"] = 2,
		["Color"] = "Silver"
	}
}
v_u_1.Legendary = v6
local v7 = {
	["Id"] = "Mythical",
	["Color"] = "#954FFF",
	["Image"] = "rbxassetid://77071748561768",
	["Stars"] = {
		["Number"] = 3,
		["Color"] = "Silver"
	}
}
v_u_1.Mythical = v7
local v8 = {
	["Id"] = "Divine",
	["Color"] = "#FF9830",
	["Image"] = "",
	["Stars"] = {
		["Number"] = 3,
		["Color"] = "Silver"
	}
}
v_u_1.Divine = v8
v_u_1.Celestial = {
	["Id"] = "Celestial",
	["gradient"] = {
		"#FF9D13",
		"#AC1DFF",
		"#0004FF",
		"#FF9D13"
	}
}
v_u_1.Transcendent = {
	["Id"] = "Transcendent",
	["Color"] = "#FFFFFF"
}
v_u_1.Eternal = {
	["Id"] = "Eternal",
	["Color"] = "#FFFFFF"
}
return {
	["GetTier"] = function(_, p9)
		-- upvalues: (copy) v_u_1
		return v_u_1[p9]
	end,
	["GetColor"] = function(p10, p11)
		local v12 = p10:GetTier(p11)
		if v12 then
			return Color3.fromHex(v12.Color)
		else
			return Color3.new(0, 0, 0)
		end
	end,
	["GetImage"] = function(p13, p14)
		local v15 = p13:GetTier(p14)
		return not v15 and "rbxassetid://0" or v15.Image
	end,
	["GetStars"] = function(p16, p17)
		local v18 = p16:GetTier(p17)
		if v18 then
			return v18.Stars
		end
	end
}