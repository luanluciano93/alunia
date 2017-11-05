function onKill(player, target)
	if target:isPlayer() or target:getMaster() then
		return true
	end

	if player:getTask() then
		local task = player:getTask()
		if table.contains(task.monsters_list, target:getName():lower()) and player:getStorageValue(task.storage) < task.amount then
			player:setStorageValue(task.storage, player:getStorageValue(task.storage) + 1)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, '[Task System] You kill ['..player:getStorageValue(task.storage)..'/'..task.amount..'] '..target:getName()..'.')
		end
	elseif player:getDailyTask() then
		local task = player:getDailyTask()
		if table.contains(task.monsters_list, target:getName():lower()) and player:getStorageValue(task.storage) < task.amount then
			player:setStorageValue(task.storage, player:getStorageValue(task.storage) + 1)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, '[Task System Daily] You kill ['..player:getStorageValue(task.storage)..'/'..task.amount..'] '..target:getName()..'.')
		end
	end

	return true
end
