dofile('data/lib/custom/duca.lua')

function onLogin(player)
	if player:getStorageValue(DUCA.STORAGE_TEAM) > 0 then
		DucaRemovePlayer(player.uid)
	end
	return true
end

function onLogout(player)
	if player:getStorageValue(DUCA.STORAGE_TEAM) > 0 then
		player:sendCancelMessage("You can not logout now!")
		return false
	end
	return true
end

function onPrepareDeath(player, killer)
	if player:getStorageValue(DUCA.STORAGE_TEAM) > 0 and killer:getStorageValue(DUCA.STORAGE_TEAM) > 0 then
		local pontos = {[1] = 1, [2] = 1, [3] = 10, [4] = 30,}
		local pontos_ganhos = pontos[player:getStorageValue(DUCA.STORAGE_TEAM)]
		killer:setStorageValue(DUCA.TOTAL_PONTOS, killer:getStorageValue(DUCA.TOTAL_PONTOS) + pontos_ganhos)
		killer:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You have ".. killer:getStorageValue(DUCA.TOTAL_PONTOS) .." duca points.")		
		DucaRemovePlayer(player.uid)
		DucaUpdateRank()
	end
	return false
end
