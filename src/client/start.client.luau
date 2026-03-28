-- Services --
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Requires --
local ModuleLoader = require(ReplicatedStorage.Packages.ModuleLoader)

-- Main --
ModuleLoader.ChangeSettings({
	FOLDER_SEARCH_DEPTH = 3,
	VERBOSE_LOADING = true,
})

ModuleLoader.Start(ReplicatedStorage:WaitForChild("ClientModules"))
