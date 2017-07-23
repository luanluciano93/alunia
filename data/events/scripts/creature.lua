dofile('data/lib/custom/duca.lua')
dofile('data/lib/custom/battlefield.lua')

function Creature:onChangeOutfit(outfit)
	-- DUCA EVENT, BATTLEFIELD EVENT
	if self:isPlayer() then
		if self:getStorageValue(DUCA.STORAGE_TEAM) > 0 or self:getStorageValue(BATTLEFIELD.STORAGE_TEAM) > 0 then
			return false
		end
	end
	return true
end

function Creature:onAreaCombat(tile, isAggressive)
	return RETURNVALUE_NOERROR
end

function Creature:onTargetCombat(target)
	if not self then
		return true
	end

    if self:isPlayer() and target:isPlayer() then
		-- DUCA EVENT
		if self:getStorageValue(DUCA.STORAGE_TEAM) > 0 then
			if self:getStorageValue(DUCA.STORAGE_TEAM) == target:getStorageValue(DUCA.STORAGE_TEAM) then
				return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
		
		-- BATTLEFIELD EVENT
		elseif self:getStorageValue(BATTLEFIELD.STORAGE_TEAM) > 0 then
			if self:getStorageValue(BATTLEFIELD.STORAGE_TEAM) == target:getStorageValue(BATTLEFIELD.STORAGE_TEAM) then
				return RETURNVALUE_YOUMAYNOTATTACKTHISPLAYER
			end
        end
    end
	return RETURNVALUE_NOERROR
end
