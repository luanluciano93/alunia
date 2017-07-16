function onStepIn(creature, item, position, fromPosition)	
	if not creature:isPlayer() then
		return false
	end
	
	if item.actionid == 2035 then
		creature:setStorageValue(Storage.PvpArena, 1)
		creature:sendTextMessage(MESSAGE_INFO_DESCR, "You entered PVP Arena.")
		creature:registerEvent("Arena-Death")

	elseif item.actionid == 2036 then
		creature:setStorageValue(Storage.PvpArena, 0)
		creature:sendTextMessage(MESSAGE_INFO_DESCR, "You left PVP Arena.")
		creature:removeCondition(CONDITION_INFIGHT)
		creature:addHealth(creature:getMaxHealth())
		creature:addMana(creature:getMaxMana())
		creature:unregisterEvent("Arena-Death")
	end

	return true
end
