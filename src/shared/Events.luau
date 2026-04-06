local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packet = require(ReplicatedStorage.Packages.Packet)

local events = {
	movementStateChanged = Packet("MovementStateChanged", Packet.String),
	attackStateChanged = Packet("AttackStateChanged", Packet.String),
	toggleSheathe = Packet("ToggleSheathe", Packet.Boolean8),

	getSword = Packet("GetSword"):Response(Packet.Any :: Instance?),
}

return events
