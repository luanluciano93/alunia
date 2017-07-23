function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage("To repair your soft boots you need to be in protection zone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if player:getMoney() >= 20000 then
		if player:removeMoney(20000) then
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You repaired your soft boots.")
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			item:transform(2640) -- soft boots
		end
	else
		player:sendCancelMessage("You need a worn soft boots and 20000 gold coins to repair.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	
	return true
end
