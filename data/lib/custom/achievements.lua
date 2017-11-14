achievements = {
	[1] = {name = "Teste!", description = "Teste msg."},
}

function Player.getAchievements(self)
	return self:getStorageValue(Storage.Achievements) > 0 and self:getStorageValue(Storage.Achievements) or 0
end

function Player.addAchievement(self, number)
	local achievement = achievements[number]
	if achievement then
		self:setStorageValue(Storage.Achievements, self:getAchievements() + 1)
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Congratulations! You earned the achievement \"" .. achievement.name .. "\".")
	end
	return true
end	
