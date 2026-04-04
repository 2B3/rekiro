local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CharacterService = require(ReplicatedStorage.ModulesClient.Services.CharacterService)
local module = {}

function onCharacterReady()
	for _, child in CharacterService.HumanoidRootPart:GetChildren() do
		if child:IsA("Sound") then
			child:Destroy()
		end
	end

	CharacterService.HumanoidRootPart.ChildAdded:Connect(function(child)
		if child:IsA("Sound") then
			child:Destroy()
		end
	end)
end

function module:start()
	CharacterService.characterReady:Connect(onCharacterReady)
	if CharacterService:isReady() then
		onCharacterReady()
	end
end

return module
