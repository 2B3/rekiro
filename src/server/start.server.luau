--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

--- Folders ---
local serverModules = ServerStorage.ModulesServer
local controllersFolder = serverModules.Controllers
local servicesFolder = serverModules.Services
local systemsFolder = serverModules.Systems

--- Requires ---
local Bootstrapper = require(ReplicatedStorage.Packages.Bootstrapper)

-- Automatic discovery (A-Z sorted)
local controllers = Bootstrapper.loadChildren(controllersFolder)
local services = Bootstrapper.loadChildren(servicesFolder)
local systems = Bootstrapper.loadChildren(systemsFolder)

Bootstrapper.run(services, ":init")
Bootstrapper.runAsync(services, ":start")

Bootstrapper.run(systems, ".init")
Bootstrapper.runConcurrent(systems, ".start")

Bootstrapper.run(controllers, ":init")
Bootstrapper.runAsync(controllers, ":start")
