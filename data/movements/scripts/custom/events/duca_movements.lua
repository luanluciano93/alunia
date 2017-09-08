dofile('data/lib/custom/duca.lua')

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	if creature:getGroup():getAccess() then
		creature:teleportTo(DUCA.TEAMS[1].temple)
		return true
	end

	if creature:getLevel() < DUCA.LEVEL_MIN then
		creature:sendCancelMessage("You need level " .. DUCA.LEVEL_MIN .. " to enter in Duca event.")
		creature:teleportTo(fromPosition)
		return false
	end

	if creature:getItemCount(2165) >= 1 or creature:getSlotItem(CONST_SLOT_RING).itemid == 2202 then
		creature:sendCancelMessage("You can not enter stealth ring in the event.")
		creature:teleportTo(fromPosition)
		return false
	end

	for _, check in ipairs(Game.getPlayers()) do
		if creature:getIp() == check:getIp() and check:getStorageValue(DUCA.STORAGE_TEAM) > 0 then
			creature:sendCancelMessage("You already have another player inside the event.")
			creature:teleportTo(fromPosition)
			return false
		end
	end

	local team = DucaBalanceTeam()
	DucaAddPlayerinTeam(creature.uid, team)

	creature:teleportTo(DUCA.TEAMS[team].temple)
	creature:setStorageValue(DUCA.TOTAL_PONTOS, 0)
	creature:registerEvent("Duca-Death")

	Game.setStorageValue(DUCA.TOTAL_PLAYERS, Game.getStorageValue(DUCA.TOTAL_PLAYERS) + 1)

	return true
end