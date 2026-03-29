--- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local clientModules = ReplicatedStorage.ModulesClient
local controllers = clientModules.Controllers

--- Requires ---
local AnimationController = require(controllers.AnimationController)

--- Definition ---
local regularRunning = {

	OnEntry = function()
		AnimationController:PlayAnimation("Movement", "Run", 0.2)
	end,

	OnExit = function()
		AnimationController:StopAnimation("Movement", "Run")
	end,
}

return regularRunning
