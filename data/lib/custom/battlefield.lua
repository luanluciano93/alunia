-- BATTLEFIELD EVENTO by luanluciano93

BATTLEFIELD = {
	OPEN_GATE_MINUTES = 3,
	TELEPORT = {POSITION = Position(154, 51, 7), CLOSE_MINUTES = 10},
	STORAGE_TEAM = Storage.BattlefieldTeam,
	LAST_PLAYER = 27001, -- global storage
	TOTAL_PLAYERS = 27002, -- global storage
	LEVEL_MIN = 100,
	REWARD = {2160, 10},

	TEAMS = {
		[1] = {color = "Black Assassins", temple = Position(671, 108, 7), outfit = {lookType = 134, lookAddons = 114, lookHead = 114, lookLegs = 114, lookBody = 114, lookFeet = 114}},
		[2] = {color = "Red Barbarians", temple = Position(707, 111, 7), outfit = {lookType = 143, lookAddons = 94, lookHead = 94, lookLegs = 94, lookBody = 94, lookFeet = 94}},
	},
	
	ITEM_WALL = 1049,
	WALLS = {
		{x = 689, y = 108, z = 6},
		{x = 689, y = 109, z = 6},
		{x = 689, y = 110, z = 6},
		{x = 689, y = 111, z = 6},
	}
}

function BattlefieldTeleportCheck()
	local tile = Tile(BATTLEFIELD.TELEPORT.POSITION)
	if tile then
		local item = tile:getItemById(1387)
		if item then
			item:remove()

			if (Game.getStorageValue(BATTLEFIELD.TOTAL_PLAYERS) % 2) ~= 0 then
				BattlefieldRemovePlayer(Game.getStorageValue(BATTLEFIELD.LAST_PLAYER))
			end

			if Game.getStorageValue(BATTLEFIELD.TOTAL_PLAYERS) > 0 then
				Game.broadcastMessage("Battlefield will start in ".. BATTLEFIELD.OPEN_GATE_MINUTES .." minutes, please create your strategy!", MESSAGE_STATUS_WARNING)

				print("> BattleField Event will begin now. [".. Game.getStorageValue(BATTLEFIELD.TOTAL_PLAYERS) .."].")
			
				addEvent(BattlefieldCheckGate, BATTLEFIELD.OPEN_GATE_MINUTES * 60 * 1000)
			else
				print("> BattleField Event ended up not having the participation of players.")
			end
		else		
			Game.broadcastMessage("The BattleField Event was opened and will close in ".. BATTLEFIELD.TELEPORT.CLOSE_MINUTES .." minutes.", MESSAGE_STATUS_WARNING)
			Game.setStorageValue(BATTLEFIELD.TOTAL_PLAYERS, 0)

			print("> BattleField Event was opened teleport.")

			local teleport = Game.createItem(1387, 1, BATTLEFIELD.TELEPORT.POSITION)
			if teleport then
				teleport:setActionId(48001)
			end

			addEvent(BattlefieldTeleportCheck, BATTLEFIELD.TELEPORT.CLOSE_MINUTES * 60 * 1000)
		end
	end
end

function BattlefieldRemovePlayer(uid)
	local player = Player(uid)
	player:removeCondition(CONDITION_INFIGHT)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are dead in Battlefield Event!")
	player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
	player:setStorageValue(BATTLEFIELD.STORAGE_TEAM, 0)
	player:unregisterEvent("Battlefield-Death")
	player:teleportTo(player:getTown():getTemplePosition())

	Game.setStorageValue(BATTLEFIELD.TOTAL_PLAYERS, Game.getStorageValue(BATTLEFIELD.TOTAL_PLAYERS) - 1)
end

function BattlefieldCheckGate()	
	local wall = BATTLEFIELD.WALLS
	for i = 1, #wall do
		local tile = Tile(wall[i])
		if tile then
			local item = tile:getItemById(BATTLEFIELD.ITEM_WALL)
			if item then
				item:remove()
				if i == 1 then
					Game.broadcastMessage("The BattleEvent Event will begin now!", MESSAGE_STATUS_WARNING)
					BattlefieldMsg()
				end
			else
				Game.createItem(BATTLEFIELD.ITEM_WALL, 1, wall[i])
			end
		end
	end
end

function BattlefieldCountPlayers(team)	
	local x = 0
	for _, player in ipairs(Game.getPlayers()) do
		if player:getStorageValue(BATTLEFIELD.STORAGE_TEAM) == team then
			x = x + 1
		end
	end
	return x
end

function BattlefieldMsg()	
	for _, player in ipairs(Game.getPlayers()) do
		if player:getStorageValue(BATTLEFIELD.STORAGE_TEAM) > 0 then
			player:sendTextMessage(MESSAGE_INFO_DESCR, "[BattleField] ".. BATTLEFIELD.TEAMS[1].color .." ".. BattlefieldCountPlayers(1) .." x ".. BattlefieldCountPlayers(2) .." " .. BATTLEFIELD.TEAMS[2].color)
		end
	end
end
