local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

local packets = CollectionService:GetTagged("Packets")[1]
if not packets then error("Could not find packets module.") end
packets = require(packets)

local players = {}
local playerNumbers = {}

packets.Loaded.OnServerEvent:Connect(function(player)
	local index = 1
	while true do
		if not players[index] then
			-- Empty index, so we put the player here.
			players[index] = player
			playerNumbers[player] = index
			return
		end
		index += 1
	end
end)
Players.PlayerRemoving:Connect(function(player)
	players[playerNumbers[player]] = nil
	playerNumbers[player] = nil
end)

return players, playerNumbers
