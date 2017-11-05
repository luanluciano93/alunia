function onSay(player, words, param)
	local text = '-------------------|    Tasks System Infos    |-------------------\n\n'
	if player:getTaskPoints() > 0 then
		text = text .. '* You have '..player:getTaskPoints()..' task points and your task rank is '..player:rankTask()..'.'
	end

	if player:getTask() then
		local task = player:getTask()
		text = text .. '\n\n\n ---------------------|    Task System     |--------------------- \n\n[*] Current Task [*]: '..task.name..' - You need kill: '..task.amount..'.\n[*] Rewards [*]: '..getItemsFromTable(task.items)..' - '..task.pointsTask..' Task Points. \n[*] Progress [*]: ['..player:getStorageValue(task.storage)..'/'..task.amount..']\n[*] Task Status [*]: '..(player:getStorageValue(task.storage) == task.amount and 'Complete' or 'Incomplete')..'!'			
	else
		text = text .. '\n\n\n ---------------------|    Task System     |--------------------- \n\n * You are not doing any task.'
	end

	if player:getDailyTask() then
		local task = player:getDailyTask()
		text = text .. '\n\n\n ---------------------|    Daily Task     |--------------------- \n\n[*] Current Task [*]: '..task.name..' - You need kill: '..task.amount..'.\n[*] Rewards [*]: '..getItemsFromTable(task.items)..' - '..task.pointsTask..' Task Points. \n[*] Progress [*]: ['..(player:getStorageValue(task.storage))..'/'..task.amount..']\n[*] Task Status [*]: '..(player:getStorageValue(task.storage) == task.amount and 'Complete' or 'Incomplete')..'!'			
	else
		text = text .. '\n\n\n ---------------------|    Daily Task     |--------------------- \n\n * You are not doing any daily task.'
	end

	return false,  player:popupFYI(text)
end
