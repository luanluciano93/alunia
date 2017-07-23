-- DUCA EVENTO by luanluciano93

DUCA = {
	EVENT_MINUTES = 60,
	TELEPORT_POSITION = Position(154, 51, 7),
	STORAGE_TEAM = Storage.DucaTeam,
	TOTAL_PONTOS = Storage.DucaPoints,
	TOTAL_PLAYERS = 27000, -- global storage
	LEVEL_MIN = 100,
	REWARD_FIRST = {2160, 10},
	REWARD_SECOND = {2160, 5},

	TEAMS = {
		[1] = {color = "Black", temple = Position(574, 110, 7), outfit = {lookType = 128, lookAddons = 114, lookHead = 114, lookLegs = 114, lookBody = 114, lookFeet = 114}},
		[2] = {color = "White", temple = Position(540, 50, 7), outfit = {lookType = 128, lookAddons = 19, lookHead = 19, lookLegs = 19, lookBody = 19, lookFeet = 19}},
		[3] = {color = "Red", outfit = {lookType = 134, lookAddons = 94, lookHead = 94, lookLegs = 94, lookBody = 94, lookFeet = 94}},
		[4] = {color = "Green", outfit = {lookType = 134, lookAddons = 101, lookHead = 101, lookLegs = 101, lookBody = 101, lookFeet = 101}},
	},
}

function DucaTeleportCheck()
	local tile = Tile(DUCA.TELEPORT_POSITION)
	if tile then
		local item = tile:getItemById(1387)
		if item then
			item:remove()
			DucaFinishEvent()
			print(">>> Duca Event was finished. <<<")
		else		
			Game.broadcastMessage("Duca Event was started and will close in ".. DUCA.EVENT_MINUTES .." minutes.", MESSAGE_STATUS_WARNING)
			print(">>> Duca Event was started. <<<")

			local teleport = Game.createItem(1387, 1, DUCA.TELEPORT_POSITION)
			if teleport then
				teleport:setActionId(48000)
			end

			Game.setStorageValue(DUCA.TOTAL_PLAYERS, 0)
			addEvent(DucaTeleportCheck, DUCA.EVENT_MINUTES * 60 * 1000)
		end
	end
end

function DucaBalanceTeam()
	local time1, time2 = 0, 0
	for _, player in ipairs(Game.getPlayers()) do
		if player:getStorageValue(DUCA.STORAGE_TEAM) == 1 then
			time1 = time1 + 1
		elseif player:getStorageValue(DUCA.STORAGE_TEAM) == 2 then
			time2 = time2 + 1
		end
	end
	return (time1 <= time2) and 1 or 2
end

function DucaAddPlayerinTeam(uid, team)
	local player = Player(uid)
	player:setOutfit(DUCA.TEAMS[team].outfit)
	player:setStorageValue(DUCA.STORAGE_TEAM, team)
	player:sendTextMessage(MESSAGE_INFO_DESCR, "You will join the " .. DUCA.TEAMS[team].color .. " Team.")
	player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
end

function DucaRemovePlayer(uid)
	local player = Player(uid)
	player:removeCondition(CONDITION_INFIGHT)
	player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "You are dead in Duca Event and your Duca points is set to 0!")
	player:addHealth(player:getMaxHealth())
	player:addMana(player:getMaxMana())
	player:setStorageValue(DUCA.STORAGE_TEAM, 0)
	player:setStorageValue(DUCA.TOTAL_PONTOS, 0)
	player:unregisterEvent("Duca-Death")
	player:teleportTo(player:getTown():getTemplePosition())

	Game.setStorageValue(DUCA.TOTAL_PLAYERS, Game.getStorageValue(DUCA.TOTAL_PLAYERS) - 1)
end

function DucaUpdateRank()
	local participantes = {}
	for _, player in ipairs(Game.getPlayers()) do
		if player:getStorageValue(DUCA.STORAGE_TEAM) > 0 then
			table.insert(participantes, player.uid)
		end
	end

	table.sort(participantes, function(a, b) return Player(a):getStorageValue(DUCA.TOTAL_PONTOS) > Player(b):getStorageValue(DUCA.TOTAL_PONTOS) end)

	if (#participantes >= 1) then
		DucaAddPlayerinTeam(participantes[1], 4)
	end

	if (#participantes >= 11) then
		for i = 2, 11 do
			DucaAddPlayerinTeam(participantes[i], 3)
		end
	end

	if (#participantes > 11) then
		for x = 12, #participantes do
			if Player(participantes[x]):getStorageValue(DUCA.STORAGE_TEAM) >= 3 then
				DucaAddPlayerinTeam(participantes[x], DucaBalanceTeam())
			end
		end
	end	
end

function DucaFinishEvent()
	DucaUpdateRank()
	for _, player in ipairs(Game.getPlayers()) do
		if player:getStorageValue(DUCA.STORAGE_TEAM) == 4 then
			Game.broadcastMessage("Duca Event is finish. Congratulation to the player ".. player:getName() .." for being the event champion!", MESSAGE_STATUS_WARNING)
			local itemType = ItemType(DUCA.REWARD_FIRST[1])
			if itemType then
				local article = itemType:getArticle()
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received the reward of the Duca event is ' .. (#article > 0 and article .. ' ' or '') .. itemType:getName() .. '.')
				player:addItem(DUCA.REWARD_FIRST[1], DUCA.REWARD_FIRST[2])
			end
		elseif player:getStorageValue(DUCA.STORAGE_TEAM) == 3 then
			local itemType = ItemType(DUCA.REWARD_SECOND[1])
			if itemType then
				local article = itemType:getArticle()
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You received the reward of the Duca event is ' .. (#article > 0 and article .. ' ' or '') .. itemType:getName() .. '.')
				player:addItem(DUCA.REWARD_SECOND[1], DUCA.REWARD_SECOND[2])
			end
		end

		if player:getStorageValue(DUCA.STORAGE_TEAM) > 0 then
			DucaRemovePlayer(player.uid)
		end
	end
end
