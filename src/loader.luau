--!nocheck
-- Garden Horizons Remote Loader
-- This is the entry point that fetches everything from GitHub

local BaseUrl = "https://raw.githubusercontent.com/suta007/GHZ/refs/heads/master/src/"

local function GetRemote(path)
    local url = BaseUrl .. path .. ".luau"
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)
    if not success or not content then
        error("Remote Error: Could not fetch " .. path)
    end
    local func, err = loadstring(content)
    if not func then
        error("Compile Error in " .. path .. ": " .. tostring(err))
    end
    return func()
end

-- Inject a global or local require replacement for modules to use
-- For modules to be truly remote-friendly, they should use a shared loader.
-- We can set a global variable so we don't have to rewrite every require in every file 
-- if we want them to remain "local-friendly" but for this task, 
-- I'll define a global _G.GHZ_REQUIRE or similar.

getgenv().GHZ_REMOTE = GetRemote

local Main = GetRemote("Main")
Main.Initialize()
