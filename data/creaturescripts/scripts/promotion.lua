function onAdvance(player, skill, oldLevel, newLevel)

	if skill ~= SKILL_LEVEL or newLevel <= oldLevel or newLevel ~= 20 then
		return true
	end

	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	player:setVocation(promotion)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You are now promoted.")

	return true
end
