local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local packets = CollectionService:GetTagged("Packets")[1]
if not packets then error("Could not find packets module.") end
packets = require(packets)

local players = {}

packets.Loaded.OnServerEvent:Connect(function(player)
	local index = 0
	while true do
		index += 1
		if not players[index] then
			-- Empty index, so we put the player here.
			players[index] = player
			return
		end
	end
end)
Players.PlayerRemoving:Connect(function(player)
	for index, plr in players do
		if plr == player then
			-- Found the player, so we clear the index.
			players[index] = nil
			return
		end
	end
end)

return players
