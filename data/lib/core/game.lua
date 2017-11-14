function Game.broadcastMessage(message, messageType)
	if not messageType then
		messageType = MESSAGE_STATUS_WARNING
	end

	for _, player in ipairs(Game.getPlayers()) do
		player:sendTextMessage(messageType, message)
	end
end

function Game.convertIpToString(ip)
	local band = bit.band
	local rshift = bit.rshift
	return string.format("%d.%d.%d.%d",
		band(ip, 0xFF),
		band(rshift(ip, 8), 0xFF),
		band(rshift(ip, 16), 0xFF),
		rshift(ip, 24)
	)
end

function Game.getReverseDirection(direction)
	if direction == DIRECTION_WEST then
		return DIRECTION_EAST
	elseif direction == DIRECTION_EAST then
		return DIRECTION_WEST
	elseif direction == DIRECTION_NORTH then
		return DIRECTION_SOUTH
	elseif direction == DIRECTION_SOUTH then
		return DIRECTION_NORTH
	elseif direction == DIRECTION_NORTHWEST then
		return DIRECTION_SOUTHEAST
	elseif direction == DIRECTION_NORTHEAST then
		return DIRECTION_SOUTHWEST
	elseif direction == DIRECTION_SOUTHWEST then
		return DIRECTION_NORTHEAST
	elseif direction == DIRECTION_SOUTHEAST then
		return DIRECTION_NORTHWEST
	end
	return DIRECTION_NORTH
end

function Game.getSkillType(weaponType)
	if weaponType == WEAPON_CLUB then
		return SKILL_CLUB
	elseif weaponType == WEAPON_SWORD then
		return SKILL_SWORD
	elseif weaponType == WEAPON_AXE then
		return SKILL_AXE
	elseif weaponType == WEAPON_DISTANCE then
		return SKILL_DISTANCE
	elseif weaponType == WEAPON_SHIELD then
		return SKILL_SHIELD
	end
	return SKILL_FIST
end

if not globalStorageTable then
	globalStorageTable = {}
end

function Game.getStorageValue(key)
	return globalStorageTable[key]
end

function Game.setStorageValue(key, value)
	globalStorageTable[key] = value
end
