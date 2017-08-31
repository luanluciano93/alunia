function onStepIn(cid, item, pos)
if item.uid == 60202 then

local pos = getPlayerPosition(cid)
local tppos = {x=1450, y=1616, z=11}

doTeleportThing(cid,tppos)
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_FIREAREA)


end
return 1
end
