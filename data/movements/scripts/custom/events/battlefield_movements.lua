dofile('data/lib/custom/battlefield.lua')

local function BattlefieldBalanceTeam()
	local time1, time2 = 0, 0
	for _, uid in ipairs(Game.getPlayers()) do
		if uid:getStorageValue(BATTLEFIELD.STORAGE_TEAM) == 1 then
			time1 = time1 + 1
		elseif uid:getStorageValue(BATTLEFIELD.STORAGE_TEAM) == 2 then
			time2 = time2 + 1
		end
	end
	return (time1 <= time2) and 1 or 2
end

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return false
	end

	if creature:getGroup():getAccess() then
		creature:teleportTo(BATTLEFIELD.TEAMS[1].temple)
		return true
	end

	if creature:getLevel() < BATTLEFIELD.LEVEL_MIN then
		creature:sendCancelMessage("You need level " .. BATTLEFIELD.LEVEL_MIN .. " to enter in Battlefield event.")
		creature:teleportTo(fromPosition)
		return false
	end

	if creature:getItemCount(2165) >= 1 or creature:getSlotItem(CONST_SLOT_RING).itemid == 2202 then
		creature:sendCancelMessage("You can not enter stealth ring in the event.")
		creature:teleportTo(fromPosition)
		return false
	end

	for _, check in ipairs(Game.getPlayers()) do
		if creature:getIp() == check:getIp() and check:getStorageValue(BATTLEFIELD.STORAGE_TEAM) > 0 then
			creature:sendCancelMessage("You already have another player inside the event.")
			creature:teleportTo(fromPosition)
			return false
		end
	end

	local team = BattlefieldBalanceTeam()
	creature:setOutfit(BATTLEFIELD.TEAMS[team].outfit)
	creature:setStorageValue(BATTLEFIELD.STORAGE_TEAM, team)
	creature:sendTextMessage(MESSAGE_INFO_DESCR, "You will join the " .. BATTLEFIELD.TEAMS[team].color .. ".")
	creature:addHealth(creature:getMaxHealth())
	creature:addMana(creature:getMaxMana())
	creature:registerEvent("Battlefield-Death")
	creature:teleportTo(BATTLEFIELD.TEAMS[team].temple)

	Game.setStorageValue(BATTLEFIELD.LAST_PLAYER, creature.uid)
	Game.setStorageValue(BATTLEFIELD.TOTAL_PLAYERS, Game.getStorageValue(BATTLEFIELD.TOTAL_PLAYERS) + 1)

	return true
end
