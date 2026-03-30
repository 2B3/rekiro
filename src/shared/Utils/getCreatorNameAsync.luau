local GroupService = game:GetService("GroupService")
local Players = game:GetService("Players")

--[[
   Sends a query to Roblox website to get the creatorName.
   Return the group name if the `CreatorType` is `Group`.

   @return string? creatorName
]]
local function getCreatorNameAsync(): string?
	local creatorId = game.CreatorId :: number

	if game.CreatorType == Enum.CreatorType.Group then
		local groupInfo = GroupService:GetGroupInfoAsync(creatorId)
		return if groupInfo then groupInfo.Name else nil
	else
		return Players:GetNameFromUserIdAsync(creatorId)
	end
end

return getCreatorNameAsync
