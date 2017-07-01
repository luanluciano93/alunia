local chests = {
	[2005] = {itemid = 2453, count = 1}, -- sprite wand
	[2006] = {itemid = 6528, count = 1}, -- avenger
	[2007] = {itemid = 5803, count = 1}, -- arbalest
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid < 2005 or item.uid >= 2007 then
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