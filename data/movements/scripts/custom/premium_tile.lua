function onStepIn(creature, item, position, fromPosition)	
	if not creature:isPlayer() then
		return false
	end

	if not creature:isPremium() then
		creature:sendTextMessage(MESSAGE_INFO_DESCR, "You are not premium account.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		creature:teleportTo(fromPosition, true)
	end

	return true
end
