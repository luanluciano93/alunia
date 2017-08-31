function onStepIn(cid, item, pos)
if item.uid == 60201 then

local pos = getPlayerPosition(cid)
local tppos = {x=1403, y=1599, z=11}

doTeleportThing(cid,tppos)
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_FIREAREA)


end
return 1
end
