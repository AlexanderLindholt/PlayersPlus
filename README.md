<div align="center">
<h1>Players+</h1>
A players list that only includes ready clients, and retains all player numbers.
</div>
<br>
​<br>
<br>

# ⚡ How it's better.
This extremely simple custom player list will only include ready clients,<br>
ensuring you never try to communicate with clients that are not yet ready.

Additionally, it retains all player numbers (indices), which<br>
is very useful for certain games where you allow rejoining.

<br>

# ⚙️ Setup
Install [Packet+](https://github.com/AlexanderLindholt/PacketPlus) if not already installed.

Ensure an empty `Loaded` packet in your packet definitions module:
```luau
local Packet = require(script.Packet)

return {
	Loaded = Packet()
	-- The rest of your packets.
}
```

It's crucial that you fire the `Loaded` packet whenever you're ready to communicate with the server:
```luau
local packets = require(path.to.Packets)

-- Make sure you're ready first.

-- Then we notify the server that we're ready.
packets.Loaded:Fire()
```

<br>

# 💡 How to use
To get the players list:
```luau
local players = require(path.to.Players)

for number, player in players do
	print("Player number "..number.." is "..player.Name.."!") -- Player number 1 is CoolGuy123!
end
```

To listen to player added:
```luau
local packets = require(path.to.Packets)

packets.Loaded.OnServerEvent:Connect(function(player)
	print(player.Name.." is ready!") -- CoolGuy123 is ready!
end)
```
> [!warning]
> If you connect to the `Loaded` packet before requiring Players+, the player will not be apart of the players list immediately for the connected function. Therefore it is recommended to require Players+ first.

To listen to player removal:
```luau
local Players = game:GetService("Players")

Players.PlayerRemoving:Connect(function(player)
	print(player.Name.." left the game!") -- CoolGuy123 left the game!
end)
```
