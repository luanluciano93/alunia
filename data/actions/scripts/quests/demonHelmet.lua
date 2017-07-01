function onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if player:getStorageValue(Storage.DemonHelmetAddon) == -1 then
		player:addOutfitAddon(541, 1)
		player:addOutfitAddon(542, 1)
		player:setStorageValue(Storage.DemonHelmetAddon, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found a first demon addon.")
	end
	
	return true
end	