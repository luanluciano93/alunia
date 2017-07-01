local chests = {
	[2000] = {itemid = 8882, count = 1}, -- Earthborn Titan Armor	
	[2001] = {itemid = 8883, count = 1}, -- Windborn colossus Armor
	[2002] = {itemid = 2537, count = 1}, -- Amazon Shield	
	[2003] = {itemid = 12643, count = 1}, -- Royal Scale Robe
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid <= 1999 or item.uid >= 2004 then
		return false
	end

	if chests[item.uid] then
		if player:getStorageValue(Storage.BigQuest) == 1 then
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
				player:setStorageValue(Storage.BigQuest, 1)
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a ' .. itemType:getName() .. ' weighing ' .. itemWeight .. ' oz it\'s too heavy.')
			end
		end
	end

	return true
end