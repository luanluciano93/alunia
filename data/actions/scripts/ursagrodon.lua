local itemId = {22729, 22730, 22731, 22732}
local porcentagem = 50

local function revertIce(toPosition)
	local tile = toPosition:getTile()
	if tile then
		local sprite = tile:getItemById(itemId[4])
		if sprite then
			sprite:transform(itemId[1])
		end
	end
end

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target.itemid == itemId[1] or target.itemid  == itemId[2] or target.itemid == itemId[3] then

		if player:hasMount(38) then
			return player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You already have the obedience of ursagrodon.')
		end

		local rand = math.random(1, 100)
		if rand <= porcentagem then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The ice cracked and the frozen creature with it - be more careful next time!')
			item:remove(1)
			target:transform(itemId[4])
			addEvent(revertIce, 600000, toPosition)
		else
			if target.itemid == itemId[1] then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You managed to melt about half of the ice blook. Quickly now, it\'s ice cold here and the ice block could freeze over again.')
				target:transform(itemId[2])
			elseif target.itemid == itemId[2] then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You managed to melt almost the whole block, only the feet of the creature are still stuck in the ice. Finish the job!')
				target:transform(itemId[3])
			elseif target.itemid == itemId[3] then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'The freed ursagrodon look at you with glowing, obedient eyes.')
				target:transform(itemId[4])
				player:addMount(38)
				item:remove(1)
				addEvent(revertIce, 600 * 1000, toPosition)
			end
		end
	end

	return true
end
