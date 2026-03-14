--!nocheck
-- Horizon Modular Loader
-- Use this script to load the modular version from the src folder

local success, Main = pcall(function()
    return require(game:GetService("ProjectService").src.Main) -- Replace with your actual path for loading local files
end)

if success then
    Main.Initialize()
else
    warn("Failed to load Garden Horizons Modular: " .. tostring(Main))
end
