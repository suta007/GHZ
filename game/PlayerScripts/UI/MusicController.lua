local v1 = game:GetService("SoundService")
local v_u_2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("TweenService")
local v4 = require(v_u_2.MusicMixes)
local v_u_5 = v4.jslakjfslakf or v4.Background
local v_u_6 = v1:WaitForChild("Music")
local v_u_7 = nil
local v_u_8 = {}
local function v_u_18()
	-- upvalues: (copy) v_u_5, (ref) v_u_8
	local v9 = v_u_5:GetChildren()
	v_u_8 = {}
	for _, v10 in v9 do
		local v11 = v_u_8
		table.insert(v11, v10)
	end
	for v12 = #v_u_8, 2, -1 do
		local v13 = math.random(1, v12)
		local v14 = v_u_8
		local v15 = v_u_8
		local v16 = v_u_8[v13]
		local v17 = v_u_8[v12]
		v14[v12] = v16
		v15[v13] = v17
	end
end
task.spawn(function()
	-- upvalues: (ref) v_u_8, (copy) v_u_18, (copy) v_u_6, (ref) v_u_7, (copy) v_u_2
	::l0::
	while true do
		if #v_u_8 == 0 then
			v_u_18()
		end
		if #v_u_8 ~= 0 then
			break
		end
		task.wait(1)
	end
	local v19 = table.remove(v_u_8, 1):Clone()
	v19.Parent = v_u_6
	v_u_7 = v19
	if v_u_2:GetAttribute("WeatherMusicPlaying") == true then
		v19.Volume = 0
	else
		v19.Volume = 0.5
	end
	v19:Play()
	while v19 and (v19.IsPlaying and v19.IsPlaying) do
		task.wait(0.5)
	end
	if v_u_2:GetAttribute("WeatherMusicPlaying") == true == false and v19.Volume < 0.5 then
		task.wait(1)
	end
	v_u_7 = nil
	v19:Destroy()
	goto l0
end)
v_u_2:GetAttributeChangedSignal("WeatherMusicPlaying"):Connect(function()
	-- upvalues: (copy) v_u_2, (ref) v_u_7, (copy) v_u_3
	local v20 = v_u_2:GetAttribute("WeatherMusicPlaying")
	if v_u_7 then
		if v20 then
			v_u_3:Create(v_u_7, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				["Volume"] = 0
			}):Play()
			return
		end
		v_u_3:Create(v_u_7, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			["Volume"] = 0.5
		}):Play()
	end
end)