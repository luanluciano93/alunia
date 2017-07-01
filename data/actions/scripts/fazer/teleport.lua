local config = {
	[30000] = Position(282, 220, 7),
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local actionId = config[item.actionid]
	if not actionId then
		return true
	end

	player:teleportTo(actionId)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
 
 	return true
end