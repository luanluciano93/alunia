local chests = {
	[2012] = {itemid = 2495, count = 1}, -- demon legs
	[2013] = {itemid = 8905, count = 1}, -- raibow shield
	[2014] = {itemid = 8918, count = 1}, -- speelbook of dark mysteries
	[2015] = {itemid = 8851, count = 1}, -- royal crossbow
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid < 2012 or item.uid > 2015 then
		return false
	end

	if chests[item.uid] then
		if player:getStorageValue(Storage.DemonOak.Done) == 1 then
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
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. (#article > 0 and article .. ' ' or '') .. itemType:getName() .. ' and second demon addon.')
				player:addItem(chest.itemid, chest.count)
				player:addOutfitAddon(541, 2)
				player:addOutfitAddon(542, 2)
				player:setStorageValue(Storage.DemonOak.Done, 1)
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a ' .. itemType:getName() .. ' weighing ' .. itemWeight .. ' oz it\'s too heavy.')
			end
		end
	end

	return true
end