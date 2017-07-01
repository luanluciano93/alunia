local config = {	
	[2033] = {storage = Storage.Inquisition, pos = Position(103, 36, 6), msg = "You need complet The Inquisition Quest!"},
}

function onStepIn(creature, item, position, fromPosition)	
	if not creature:isPlayer() then
		return true
	end

	local action = config[item.actionid]
	if not action then
		return true
	end
	
	if creature:getStorageValue(action.storage) >= 1 then
		creature:teleportTo(action.pos)
		creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	else
		creature:sendTextMessage(MESSAGE_INFO_DESCR, action.msg)
		creature:teleportTo(fromPosition, true)
	end

	return true
end