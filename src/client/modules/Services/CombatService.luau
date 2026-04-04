--- Services ---
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--- Folders ---
local packages = ReplicatedStorage.Packages

--- Requires ---
local CharacterService = require(script.Parent.CharacterService)
local WCS = require(packages.WCS)

--- Variables ---
local CombatService = {}
CombatService.client = WCS.CreateClient()

local characterClass = WCS.Character

--- Public Methods ---

--[=[
   Return the current WCS Character object.

   @return WCSCharacter?
]=]
function CombatService.getWCSCharacter(): WCS.Character?
	local characterModel = CharacterService.Character
	if not characterModel then
		return
	end

	return characterClass.GetCharacterFromInstance(characterModel)
end

return CombatService
