dofile('data/lib/custom/zumbi.lua')

function onLogin(player)
	if player:getStorageValue(ZUMBI.storage) > 0 then
		player:setStorageValue(ZUMBI.storage, 0)
		player:teleportTo(player:getTown():getTemplePosition())
	end
	return true
end

function onLogout(player)
	if player:getStorageValue(ZUMBI.storage) > 0 then
		player:sendCancelMessage("You can not logout now!")
		return false
	end
	return true
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)

	if attacker:getMonster() and attacker:getName() == "Zumbi" and creature:isPlayer() then
		if Game.getStorageValue(ZUMBI.TotalPlayers) > 0 then
			if Game.getStorageValue(ZUMBI.TotalPlayers) == 1 then
				creature:say("ZUMBI EVENT WIN!", TALKTYPE_MONSTER_SAY)
				Game.broadcastMessage("The player ".. creature:getName() .." is win Zumbi Event.", MESSAGE_STATUS_WARNING)
				creature:sendTextMessage(MESSAGE_STATUS_WARNING, ZUMBI.Reward[3])
				creature:addItem(ZUMBI.Reward[1], ZUMBI.Reward[2])
			else
				attacker:say("DEAD!", TALKTYPE_MONSTER_SAY)

				local summon_position = creature:getPosition()
				Game.createMonster("Zumbi", summon_position)
			end

			player:unregisterEvent("Zumbi")
			Game.setStorageValue(ZUMBI.TotalPlayers, Game.getStorageValue(ZUMBI.TotalPlayers) - 1)
		end

		creature:teleportTo(creature:getTown():getTemplePosition())
		creature:setStorageValue(ZUMBI.storage, 0)
	end

	return primaryDamage, primaryType, -secondaryDamage, secondaryType
end
