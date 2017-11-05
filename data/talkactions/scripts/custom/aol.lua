local price_aol = 10000

function onSay(player, words, param)

	if not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage("To buy amulet of loss you need to be in protection zone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	if player:getMoney() >= price_aol then
		if player:removeMoney(price_aol) then
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
			player:addItem(2173, 1)
		end
	else
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		player:sendCancelMessage("You don't have 10000 gold coins to buy an amulet of loss.")
	end

	return false
end
