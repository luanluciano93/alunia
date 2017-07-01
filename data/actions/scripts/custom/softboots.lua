function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	
	if not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage("To repair your soft boots you need to be in protection zone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	if player:getItemCount(10021) >= 1 and player:getMoney() >= 20000 then
		if player:removeItem(10021, 1) and player:removeMoney(20000) then
			player:addItem(2640, 1) -- soft boots
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You repaired your soft boots.")
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		end
	else
		player:sendCancelMessage("You need a worn soft boots and 20000 gold coins to repair.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	
	return true
end
