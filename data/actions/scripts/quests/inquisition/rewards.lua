local chests = {
	[2024] = {itemid = 8930, count = 1}, -- emerald sword
	[2025] = {itemid = 8918, count = 1}, -- speelbook of dark mysteries 
	[2026] = {itemid = 8888, count = 1}, -- master archer armor
	[2027] = {itemid = 8890, count = 1}, -- robe of the underworld	
	[2028] = {itemid = 8881, count = 1}, -- fireborn giant armor
	[2029] = {itemid = 8928, count = 1}, -- obsidian truncheon
	[2030] = {itemid = 8851, count = 1}, -- royal crossbow
	[2031] = {itemid = 8854, count = 1}, -- warsinger bow
	[2032] = {itemid = 8924, count = 1}, -- hellforget axe
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if chests[item.uid] then
		if player:getStorageValue(Storage.Inquisition) == 1 then
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
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. (#article > 0 and article .. ' ' or '') .. itemType:getName() .. ' and full demonhunter addon.')
				player:addItem(chest.itemid, chest.count)
				player:setStorageValue(Storage.Inquisition, 1)
				player:addOutfitAddon(288, 1)
				player:addOutfitAddon(289, 1)
				player:addOutfitAddon(288, 2)
				player:addOutfitAddon(289, 2)
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a ' .. itemType:getName() .. ' weighing ' .. itemWeight .. ' oz it\'s too heavy.')
			end
		end
	end

	return true
end