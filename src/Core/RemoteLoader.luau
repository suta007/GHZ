--!nocheck
local RemoteLoader = {}

local BaseUrl = "https://raw.githubusercontent.com/suta007/GHZ/refs/heads/master/src/"
local Cache = {}

function RemoteLoader.Get(path)
	if Cache[path] then
		return Cache[path]
	end

	local fullUrl = BaseUrl .. path .. ".luau"
	local success, content = pcall(function()
		return game:HttpGet(fullUrl)
	end)

	if not success or not content then
		error("Failed to fetch remote module: " .. path .. " from " .. fullUrl)
	end

	local func, err = loadstring(content)
	if not func then
		error("Failed to compile remote module: " .. path .. "\nError: " .. tostring(err))
	end

	local result = func()
	Cache[path] = result
	return result
end

return RemoteLoader
