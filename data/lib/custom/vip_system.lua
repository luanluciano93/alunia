-- ALTER TABLE `accounts` ADD `vip_time` BIGINT(20) NOT NULL DEFAULT 0;

-- player:getVipTime()
function Player.getVipTime(self)
	local resultId = db.storeQuery("SELECT `vip_time` FROM `accounts` WHERE `id` = '".. self:getAccountId() .."';")
	local time = resultId ~= false and result.getNumber(resultId, "vip_time") or 0
	result.free(resultId)
	return time
end

-- player:isVip()
function Player.isVip(self)
	return self:getVipTime() > os.time() and true or false
end

-- player:addVipDays(days)
function Player.addVipDays(self, days)
	return(self:isVip() and tonumber((days * 86400))) and db.query("UPDATE `accounts` SET `vip_time` = '".. (self:getVipTime() + (days * 86400)) .."' WHERE `id` ='".. self:getAccountId() .."' LIMIT 1 ;") or db.query("UPDATE `accounts` SET `vip_time` = '".. (os.time() + (days * 86400)) .."' WHERE `id` ='".. self:getAccountId() .."' LIMIT 1 ;")
end

-- player:removeVipDays(days)
function Player.removeVipDays(self, days)
	return(self:isVip() and tonumber((days * 86400))) and db.query("UPDATE `accounts` SET `vip_time` = '".. (self:getVipTime() - (days * 86400)) .."' WHERE `id` ='".. self:getAccountId() .."' LIMIT 1 ;") or db.query("UPDATE `accounts` SET `vip_time` = '".. (os.time() - (days * 86400)) .."' WHERE `id` ='".. self:getAccountId() .."' LIMIT 1 ;")
end

-- player:setVipDays(days)
function Player.setVipDays(self, days)
	return db.query("UPDATE `accounts` SET `vip_time` = '".. (os.time() - (days * 86400)) .."' WHERE `id` ='".. self:getAccountId() .."' LIMIT 1 ;")
end

-- player:removeVip()
function Player.removeVip(self)
	db.query("UPDATE `accounts` SET `vip_time` = '0' WHERE `id` ='".. self:getAccountId() .."' LIMIT 1 ;")
end

-- player:sendVipDaysMessage()
function Player.sendVipDaysMessage(self)
	if self:isVip() then
		local vipTime = self:getVipTime() - os.time()
		local vipDays = 1 + (math.floor(vipTime / 86400))
		return self:getVipTime() ~= false and self:sendTextMessage(MESSAGE_STATUS_CONSOLE_BLUE, 'You have '.. vipDays .. ' vip day(s) in your account and bonus of +20% more experience.')
	end
end

-- player:checkVipLogin()
function Player.checkVipLogin(self)
	if self:getVipTime() > 0 and not self:isVip() then
		return self:removeVip() and self:teleportTo(self:getTown():getTemplePosition())
	end
end