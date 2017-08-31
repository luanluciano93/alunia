local c = {
   [{1,5}] = {
     [15] = {itemid = 4856, count = 1, storage = 99962},
     [19] = {itemid = 2188, count = 1, storage = 99963},
     [20] = {itemid = 2160, count = 2, storage = 99964},
	 [33] = {itemid = 2187, count = 1, storage = 99965},
	 [33] = {itemid = 8900, count = 1, storage = 99966}
   },
[{2,6}] = {
     [15] = {itemid = 4856, count = 1, storage = 99962},
     [19] = {itemid = 2185, count = 1, storage = 99963},
     [20] = {itemid = 2160, count = 2, storage = 99964},
	 [33] = {itemid = 2183, count = 1, storage = 99965},
	 [33] = {itemid = 8900, count = 1, storage = 99966}
   },
  [{3,7}] = {
     [15] = {itemid = 4856, count = 1, storage = 99962},
     [20] = {itemid = 2160, count = 2, storage = 99963},
	 [19] = {itemid = 2476, count = 1, storage = 99964},
	 [25] = {itemid = 2477, count = 1, storage = 99965},
	 [33] = {itemid = 2497, count = 1, storage = 99966},
	 [35] = {itemid = 2536, count = 1, storage = 99967}
   },
   [{4,8}] = {
     [15] = {itemid = 4856, count = 1, storage = 99962},
     [20] = {itemid = 2160, count = 2, storage = 99963},
	 [19] = {itemid = 2476, count = 1, storage = 99964},
	 [25] = {itemid = 2477, count = 1, storage = 99965},
	 [33] = {itemid = 2497, count = 1, storage = 99966},
	 [35] = {itemid = 2536, count = 1, storage = 99967}
   }
}

function onAdvance(cid, skill, oldlevel, newlevel)
     if skill ~= SKILL_LEVEL then
         return true
     end

     for voc, x in pairs(c) do
         if isInArray(voc, getPlayerVocation(cid)) then
             for level, z in pairs(x) do
                 if newlevel >= level and getPlayerStorageValue(cid, z.storage) ~= 1 then
                     doPlayerAddItem(cid, z.itemid, z.count)
                     local item = getItemDescriptions(z.itemid)
                     doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Congratulations, you reached level "..level.." and received "..(z.count == 1 and item.article or z.count).." "..(z.count == 1 and item.name or item.plural)..".")
                     doSendMagicEffect(getPlayerPosition(cid), CONST_ME_FIREWORK_YELLOW)
                     setPlayerStorageValue(cid, z.storage, 1)
                 end
             end
         end
     end
     return true
end
