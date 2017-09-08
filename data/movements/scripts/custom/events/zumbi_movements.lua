dofile('data/lib/custom/zumbi.lua')

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	if creature:getGroup():getAccess() then
		creature:teleportTo(ZUMBI.PositionEnterEvent)
		return true
	end

	if creature:getLevel() < ZUMBI.LevelMin then
		creature:sendCancelMessage("You need level " .. ZUMBI.LevelMin .. " to enter in Zumbi event.")
		creature:teleportTo(fromPosition)
		return false
	end

	creature:addHealth(creature:getMaxHealth())
	creature:addMana(creature:getMaxMana())
	creature:sendTextMessage(MESSAGE_STATUS_WARNING, "Get ready for the Zombie Event!")
	creature:teleportTo(ZUMBI.PositionEnterEvent)
	creature:registerEvent("Zumbi")
	creature:setStorageValue(ZUMBI.storage, 1)

	Game.setStorageValue(ZUMBI.TotalPlayers, Game.getStorageValue(ZUMBI.TotalPlayers) + 1)

	return true
end
