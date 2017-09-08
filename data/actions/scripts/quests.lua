local chests = {
	[1251] = {itemid = 2480, count = 1}, -- legion helmet	
	[1252] = {itemid = 7456, count = 1}, -- noble axe
	[1253] = {itemid = 2516, count = 1}, -- dragon shield	
	[1254] = {itemid = 11240, count = 1}, -- guardian boots	
	[1255] = {itemid = 11302, count = 1}, -- zaoan helmet	
	[1256] = {itemid = 11301, count = 1}, -- zaoan armor	
	[1257] = {itemid = 8905, count = 1}, -- raibow shield
	[1258] = {itemid = 2523, count = 1}, -- blessed shield
	[1259] = {itemid = 2493, count = 1}, -- demon helmet
	[1260] = {itemid = 2645, count = 1}, -- steel boots
	[1261] = {itemid = 2520, count = 1}, -- demon shield
	[1262] = {itemid = 2195, count = 1}, -- boots of haste 
	[1263] = {itemid = 6529, count = 1}, -- infernal bolt 
	[1264] = {itemid = 2365, count = 1}, -- backpack of holding 
	[1265] = {itemid = 5791, count = 1}, -- stuffed dragon
	[1266] = {itemid = 6132, count = 1}, -- soft boots
	[1267] = {itemid = 2361, count = 1}, -- frosen starlight
	[1268] = {itemid = 2354, count = 1}, -- ornamented ankh
	[1269] = {itemid = 2392, count = 1}, --	fire sword
	[1270] = {itemid = 2393, count = 1}, --	giant sword
	[1271] = {itemid = 2432, count = 1}, -- fire axe
	[1272] = {itemid = 7730, count = 1}, -- blue legs
	[1273] = {itemid = 9933, count = 1}, --	firewalker boots
	[1274] = {itemid = 2514, count = 1}, -- mastermind shield
	[1275] = {itemid = 2123, count = 1}, -- ring of the sky
	[1276] = {itemid = 2112, count = 1}, -- teddy bear
	[1277] = {itemid = 2472, count = 1}, -- magic plate armor
	[1278] = {itemid = 2477, count = 1}, -- knight legs
	[1279] = {itemid = 2488, count = 1}, -- crown legs
	[1280] = {itemid = 2506, count = 1}, -- dragon scale helmet
	[1281] = {itemid = 2454, count = 1}, -- war axe
	[1282] = {itemid = 2520, count = 1}, -- demon shield
	[1283] = {itemid = 2466, count = 1}, -- golden armor
	[1284] = {itemid = 2492, count = 1}, -- dragon scale mail
	[1285] = {itemid = 8885, count = 1}, -- divine plane
	[1286] = {itemid = 7388, count = 1}, -- vile axe
	[1287] = {itemid = 8878, count = 1}, -- crystalline armor
	[1288] = {itemid = 2470, count = 1}, -- golden legs
	[1289] = {itemid = 2474, count = 1}, -- winged helmet
	[1290] = {itemid = 7885, count = 1}, -- terra legs
	[1291] = {itemid = 8869, count = 1}, -- greenwood coat
	[1292] = {itemid = 8865, count = 1}, -- dark lord's cape
	[1293] = {itemid = 2522, count = 1}, -- great shield
	[1294] = {itemid = 8866, count = 1}, -- serpent coat
	[1295] = {itemid = 5908, count = 1}, -- obsidian knife
	[1296] = {itemid = 2342, count = 1}, -- helmet of the ancients
	[1297] = {itemid = 22726, count = 1}, -- melting horn
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.uid <= 1250 or item.uid >= 2000 then
		return false
	end

	if chests[item.uid] then
		if player:getStorageValue(item.uid) == 1 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'It\'s empty.')
			return true
		end

		local chest = chests[item.uid]
		local itemType = ItemType(chest.itemid)
		if itemType then
			local itemWeight = itemType:getWeight()
			local playerCap = player:getFreeCapacity()
			if playerCap >= itemWeight then
				local article = itemType:getArticle()
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have found ' .. (#article > 0 and article .. ' ' or '') .. itemType:getName() .. '.')
				player:addItem(chest.itemid, chest.count)
				player:setStorageValue(item.uid, 1)
			else
				player:sendTextMessage(MESSAGE_INFO_DESCR, 'You have found a ' .. itemType:getName() .. ' weighing ' .. itemWeight .. ' oz it\'s too heavy.')
			end
		end
	end

	return true
end
