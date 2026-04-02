--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local controllersFolder = clientModules.Controllers
local servicesFolder = clientModules.Services
local systemsFolder = clientModules.Systems

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
