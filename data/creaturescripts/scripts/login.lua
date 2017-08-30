function onLogin(player)
	local loginStr = "Welcome to " .. configManager.getString(configKeys.SERVER_NAME) .. "!"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Please choose your outfit."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Your last visit was on %s.", os.date("%a %b %d %X %Y", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

	-- Stamina
	nextUseStaminaTime[player.uid] = 0

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(STORAGEVALUE_PROMOTION)
		if not promotion and value ~= 1 then
			player:setStorageValue(STORAGEVALUE_PROMOTION, 1)
		elseif value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("Rewards")
	player:registerEvent("Promotion")
	player:registerEvent("Yalahar")

	-- Custom
	player:sendVipDaysMessage()
	player:checkVipLogin()
	
	-- OPEN CHANNERLS (ABRIR CHANNELS)
	if table.contains({"Rookgaard", "Dawnport"}, player:getTown():getName())then
		player:openChannel(7) -- help channel

	else
		player:openChannel(7) -- help channel

	end
	
	
	if not player:isPremium() then
		player:addPremiumDays(365)
	end
	--
	
	player:sendTextMessage(messageType or MESSAGE_STATUS_CONSOLE_ORANGE, 'Welcome to Alunia-Yourots')
	player:sendTextMessage(messageType or MESSAGE_STATUS_CONSOLE_ORANGE, 'Promotion level 20 automatic')
	player:sendTextMessage(messageType or MESSAGE_STATUS_CONSOLE_ORANGE, 'Reports bugs please!')
	

	return true
end
