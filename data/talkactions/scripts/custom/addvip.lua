function onSay(player, words, param)
	if not player:getGroup():getAccess() then
		return true
	end

	if player:getAccountType() < ACCOUNT_TYPE_GOD then
		return false
	end

	local split = param:split(",")
	local target = Player(split[1])
	
	if target ~= nil then
		local count = tonumber(split[2])
		if count == nil then
			count = 1
		end

		target:addVipDays(count)
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, "Added ".. count .." day(s) of VIP account in the character ".. split[1] ..".")
	else
		player:sendCancelMessage("Player not found.")
	end
end
