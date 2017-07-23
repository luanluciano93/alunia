dofile('data/lib/custom/battlefield.lua')

local function BattlefieldWinners(team)
	for _, uid in ipairs(Game.getPlayers()) do
		if Player(uid):getStorageValue(BATTLEFIELD.STORAGE_TEAM) == team then	
			Player(uid):sendTextMessage(MESSAGE_INFO_DESCR, "Congratulations, your team won the battlefield event.")
			Player(uid):addItem(BATTLEFIELD.REWARD[1], BATTLEFIELD.REWARD[2])
			BattlefieldRemovePlayer(uid)
		end
	end

	Game.broadcastMessage("The BattleEvent is finish, team ".. BATTLEFIELD.TEAMS[team].color .." win.", MESSAGE_STATUS_WARNING)
	BattlefieldCheckGate()

	print("> BattleField Event was finished.")
end

function onLogin(player)
	if player:getStorageValue(BATTLEFIELD.STORAGE_TEAM) > 0 then
		BattlefieldRemovePlayer(player.uid)
	end
	return true
end

function onLogout(player)
	if player:getStorageValue(BATTLEFIELD.STORAGE_TEAM) > 0 then
		player:sendCancelMessage("You can not logout now!")
		return false
	end
	return true
end

function onPrepareDeath(player, killer)

	if player:getStorageValue(BATTLEFIELD.STORAGE_TEAM) > 0 then
		local team = player:getStorageValue(BATTLEFIELD.STORAGE_TEAM)
		BattlefieldRemovePlayer(player.uid)
		Game.setStorageValue(BATTLEFIELD.TOTAL_PLAYERS, Game.getStorageValue(BATTLEFIELD.TOTAL_PLAYERS) - 1)
		
		if BattlefieldCountPlayers(team) == 0 then
			BattlefieldWinners((team == 1) and 2 or 1)
		else
			BattlefieldMsg()
		end		
	end

	return false
end
