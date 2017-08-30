local chests = {
	[3003] = {itemid = 12643, count = 1}, -- draken robe
	[3004] = {itemid = 12642, count = 1}, -- draken mail
	[3005] = {itemid = 12645, count = 1}, -- helmet
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid < 3002 or item.uid >= 3006 then
		return false
	end

	if chests[item.uid] then
		if player:getStorageValue(Storage.POIQuestChests) == 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'It\'s empty.')
			return true
		end

		local chest = chests[item.uid]
		local itemType = ItemType(chest.itemid)
		if itemType then
			local itemWeight = itemType:getWeight()
			local playerCap = player:getFreeCapacity()
			if playerCap >= itemWeight then
				local article = itemType:getArticle()
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. (#article > 0 and article .. ' ' or '') .. itemType:getName() .. '.')
				player:addItem(chest.itemid, chest.count)
				player:setStorageValue(Storage.POIQuestChests, 1)
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a ' .. itemType:getName() .. ' weighing ' .. itemWeight .. ' oz it\'s too heavy.')
			end
		end
	end

	return true
end
