local ReplicatedStorage = game:GetService("ReplicatedStorage")

local StateMachine = require(ReplicatedStorage.ModulesClient.Systems.StateMachine)
local CharacterService = require(script.Parent.CharacterService)

local MovementService = {}
MovementService.wantsToRun = false

function MovementService.update(self: typeof(MovementService))
	local variation = self.wantsToRun and "Running" or "Walking"

	if CharacterService:isMoving() then
		StateMachine:Send("start" .. variation)
	else
		StateMachine:Send("stop" .. variation)
	end
end

return MovementService
