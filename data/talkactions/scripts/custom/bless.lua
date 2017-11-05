local bless = 5
local price_bless = 2000

function getCost(level)
	if level <= 30 then
		return price_bless * bless
	elseif level >= 120 then
		return 10 * price_bless * bless
	else
		return ((level - 20) * price_bless * bless) 
	end
end

function onSay(player, words, param)

	if not Tile(player:getPosition()):hasFlag(TILESTATE_PROTECTIONZONE) then
		player:sendCancelMessage("To buy bless you need to be in protection zone.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end	
	
	for i = 1, bless do
		if player:hasBlessing(i) then
			player:sendCancelMessage("You already have all blessings.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return false
		end
	end

	local money = getCost(player:getLevel())

	if player:removeMoney(money) then
		for i = 1, bless do
			player:addBlessing(i)
		end

		player:sendTextMessage(MESSAGE_INFO_DESCR, "You have been blessed by the gods!")
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	else
		player:sendCancelMessage("You don't have ".. money .." gold coints to buy bless.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end

	return true
end
