local config = {
	[2016] = {text = 'You have touched Infernatil\'s throne and absorbed some of his spirit.', effect = CONST_ME_FIREAREA},
	[2017] = {text = 'You have touched Tafariel\'s throne and absorbed some of his spirit.', effect = CONST_ME_MORTAREA},
	[2018] = {text = 'You have touched Verminor\'s throne and absorbed some of his spirit.', effect = CONST_ME_POISONAREA},
	[2019] = {text = 'You have touched Apocalypse\'s throne and absorbed some of his spirit.', effect = CONST_ME_EXPLOSIONAREA},
	[2020] = {text = 'You have touched Ashfalor\'s throne and absorbed some of his spirit.', effect = CONST_ME_FIREAREA},
	[2021] = {text = 'You have touched Bazir\'s throne and absorbed some of his spirit.', effect = CONST_ME_MAGIC_GREEN},
	[2022] = {text = 'You have touched Pumin\'s throne and absorbed some of his spirit.', effect = CONST_ME_MORTAREA}
}

function onStepIn(creature, item, position, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local throne = config[item.uid]
	if not throne then
		return true
	end

	if creature:getStorageValue(item.uid) == -1 then
		creature:setStorageValue(item.uid, 1)
		creature:getPosition():sendMagicEffect(throne.effect)
		creature:say(throne.text, TALKTYPE_MONSTER_SAY)
	else
		creature:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
		creature:say('Begone!', TALKTYPE_MONSTER_SAY)
		creature:teleportTo(fromPosition)
	end
	return true
end