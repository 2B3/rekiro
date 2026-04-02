local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterService = require(ReplicatedStorage.ModulesClient.Services.CharacterService)
local module = {}

function onCharacterReady()
	for _, v in CharacterService.HumanoidRootPart:GetChildren() do
		if v:IsA("Sound") then
			v:Destroy()
		end
	end
end

function module:start()
	CharacterService.characterReady:Connect(onCharacterReady)
	if CharacterService:isReady() then
		onCharacterReady()
	end
end

return module
