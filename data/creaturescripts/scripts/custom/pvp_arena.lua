local exit = Position(125, 31, 9)

function onLogin(player)
	if player:getStorageValue(Storage.PvpArena) > 0 then
		player:setStorageValue(Storage.PvpArena, 0)
	end
	return true
end

function onLogout(player)
	if player:getStorageValue(Storage.PvpArena) > 0 then
		player:sendCancelMessage("You can not logout now!")
		return false
	end
	return true
end

function onPrepareDeath(player, killer)
	if player:getStorageValue(Storage.PvpArena) > 0 and killer:getStorageValue(Storage.PvpArena) > 0 then
		player:removeCondition(CONDITION_INFIGHT)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are dead in PVP Arena!")
		player:addHealth(player:getMaxHealth())
		player:addMana(player:getMaxMana())
		player:setStorageValue(Storage.PvpArena, 0)
		player:unregisterEvent("Arena-Death")
		player:teleportTo(exit)
		killer:getPosition():sendMagicEffect(CONST_ME_GROUNDSHAKER)
		return false
	end
end
