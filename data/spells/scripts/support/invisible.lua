dofile('data/lib/custom/duca.lua')

local combat = Combat()
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
combat:setParameter(COMBAT_PARAM_AGGRESSIVE, false)

local condition = Condition(CONDITION_INVISIBLE)
condition:setParameter(CONDITION_PARAM_TICKS, 200000)
combat:setCondition(condition)

function onCastSpell(creature, variant)
	if creature:getStorageValue(DUCA.STORAGE_TEAM) > 0 then
		creature:sendCancelMessage("You can not use this spell in the Duca Event.")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
	else
		return combat:execute(creature, variant)
	end
end
