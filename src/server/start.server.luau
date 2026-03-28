-- Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

-- Requires --
local ModuleLoader = require(ReplicatedStorage.Packages.ModuleLoader)

-- Main --
ModuleLoader.ChangeSettings({
	FOLDER_SEARCH_DEPTH = 3,
	VERBOSE_LOADING = true,
})

ModuleLoader.Start(ServerStorage:WaitForChild("ServerModules"))
