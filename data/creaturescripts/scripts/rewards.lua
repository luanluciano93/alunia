local table = {
	-- [20] = {type = "item", id = {2160, 2}, msg = "Voce ganhou 2 crystal coins por alcancar o level 20!"},
	[50] = {type = "bank", id = {50000, 0}, msg = "You have received 50000 gold coins in your bank for advancing to level 50."},
	[100] = {type = "mount", id = {22, 0}, msg = "You have received the mount rented horse reaching level 100."},
	[200] = {type = "mount", id = {34, 0}, msg = "You have received the mount steelbeak reaching level 200."},
	[250] = {type = "addon", id = {666, 667}, msg = "You have received the outfit death herald addons reaching level 250."},
	[300] = {type = "mount", id = {17, 0}, msg = "You have received the mount war horse reaching level 300."},
	[350] = {type = "addon", id = {471, 472}, msg = "You have received the outfit entrepreneur addons reaching level 350."},
	[400] = {type = "mount", id = {54, 0}, msg = "You have received the mount woodland prince reaching level 400."},
	[450] = {type = "addon", id = {732, 733}, msg = "You have received the outfit seaweaver addons reaching level 450."},
	[500] = {type = "mount", id = {49, 0}, msg = "You have received the mount jade pincer reaching level 500."},
}

function onAdvance(player, skill, oldLevel, newLevel)

	if skill ~= SKILL_LEVEL or newLevel <= oldLevel then
		return true
	end

	for level, _ in pairs(table) do
		if newLevel >= level and player:getStorageValue(Storage.RewardSystem) < level then
			if table[level].type == "item" then	
				player:addItem(table[level].id[1], table[level].id[2])
			elseif table[level].type == "bank" then
				player:setBankBalance(player:getBankBalance() + table[level].id[1])
			elseif table[level].type == "addon" then
				player:addOutfitAddon(table[level].id[1], 3)
				player:addOutfitAddon(table[level].id[2], 3)
			elseif table[level].type == "mount" then
				player:addMount(table[level].id[1])
			else
				return false
			end

			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, table[level].msg)
			player:setStorageValue(Storage.RewardSystem, level)
		end
	end

	player:addHealth(player:getMaxHealth())
	player:save()

	return true
end
