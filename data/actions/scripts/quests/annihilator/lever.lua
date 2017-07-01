local config = {
	centerDemonRoomPosition = Position(193, 118, 10),
	playerPositions = {
		Position(191, 118, 9),
		Position(192, 118, 9),
		Position(193, 118, 9),
		Position(194, 118, 9)
	},
	newPositions = {
		Position(190, 118, 10),
		Position(191, 118, 10),
		Position(192, 118, 10),
		Position(193, 118, 10)
	},
	demonPositions = {
		Position(194, 118, 10),
		Position(195, 118, 10),
		Position(190, 116, 10),
		Position(192, 116, 10),
		Position(191, 120, 10),
		Position(193, 120, 10)
	}
}


function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1946 then
		local storePlayers, playerTile = {}

		for i = 1, #config.playerPositions do
			playerTile = Tile(config.playerPositions[i]):getTopCreature()
			if not playerTile or not playerTile:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "You need 4 players.")
				return true
			end

			if playerTile:getLevel() < 100 then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "All the players need to be level 100 or higher.")
				return true
			end
			
			if playerTile:getStorageValue(Storage.Annihilator) == 1 then
				player:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end

		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 3, 3, 2, 2)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_SMALL, "A team is already inside the quest room.")
				return true
			end

			spec:remove()
		end

		for i = 1, #config.demonPositions do
			Game.createMonster("Demon", config.demonPositions[i])
		end

		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.playerPositions[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setDirection(DIRECTION_EAST)
		end
	end

	item:transform(item.itemid == 1946 and 1945 or 1946)
	return true
end