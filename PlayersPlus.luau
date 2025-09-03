-- Services.
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")

-- Network packets.
local packets = CollectionService:GetTagged("Packets")[1]
if not packets then error("Could not find packets module.") end
packets = require(packets)

-- Player tables.
local players = {}
local playerNumbers = {}

-- Player insertion.
packets.Loaded.OnServerEvent:Connect(function(player)
	local index = 1
	while true do
		if not players[index] then
			-- Found the smallest available number for the player.
			players[index] = player
			playerNumbers[player] = index
			return
		end
		index += 1
	end
end)
-- Player removal.
Players.PlayerRemoving:Connect(function(player)
	if not playerNumbers[player] then return end -- Skip if player was never added to list.
	
	players[playerNumbers[player]] = nil
	playerNumbers[player] = nil
end)

-- Types.
export type Players = {[number]: Player}
export type PlayerNumbers = {[Player]: number}

-- Function for returning lists. Unfortunately modules can't return tuples.
return function()
	return players, playerNumbers
end :: () -> (Players, PlayerNumbers)
