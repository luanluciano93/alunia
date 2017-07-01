local chests = {
	[2008] = {itemid = 2494, count = 1}, -- demon armor
	[2009] = {itemid = 2400, count = 1}, -- sov
	[2010] = {itemid = 2431, count = 1}, -- sca
	[2011] = {itemid = 2421, count = 1}, -- thunder hammer
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if chests[item.uid] then
		if player:getStorageValue(Storage.Annihilator) == 1 then
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
				player:setStorageValue(Storage.Annihilator, 1)
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a ' .. itemType:getName() .. ' weighing ' .. itemWeight .. ' oz it\'s too heavy.')
			end
		end
	end

	return true
end