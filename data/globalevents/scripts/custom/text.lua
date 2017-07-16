local effects = {
	{position = Position(151, 48, 7), text = 'VIP', effect = CONST_ME_GROUNDSHAKER},
	{position = Position(155, 47, 7), text = 'TRAINERS', effect = CONST_ME_GROUNDSHAKER},
	{position = Position(151, 52, 7), text = 'TELEPORTS', effect = CONST_ME_GROUNDSHAKER},
	{position = Position(151, 54, 7), text = 'PVP ARENA', effect = CONST_ME_GROUNDSHAKER},
}

function onThink(interval)
	for i = 1, #effects do
		local settings = effects[i]
		local spectators = Game.getSpectators(settings.position, false, true, 7, 7, 5, 5)
		if #spectators > 0 then
			if settings.text then
				for i = 1, #spectators do
					spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
				end
			end
			
			if settings.effect then
				settings.position:sendMagicEffect(settings.effect)
			end
		end
	end
	return true
end