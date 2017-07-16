local POSITION_DEMON_OAK = Position(61, 129, 7)

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.DemonOak.Done) >= 1 then
		player:teleportTo(Position(61, 116, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	if player:getLevel() < 120 then
		player:say("LEAVE LITTLE FISH, YOU ARE NOT WORTH IT!", TALKTYPE_MONSTER_YELL, false, player, POSITION_DEMON_OAK)
		player:teleportTo(Position(61, 116, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	if #Game.getSpectators(POSITION_DEMON_OAK, false, true, 9, 9, 6, 6) == 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'Go talk with Odralk and get the Hallowed Axe to kill The Demon Oak.')
		player:teleportTo(Position(61, 121, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:setStorageValue(Storage.DemonOak.Progress, 1)
		player:say("I AWAITED YOU! COME HERE AND GET YOUR REWARD!", TALKTYPE_MONSTER_YELL, false, player, POSITION_DEMON_OAK)
	else
		player:teleportTo(Position(61, 116, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end
