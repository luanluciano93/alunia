COMBAT_POISONDAMAGE = COMBAT_EARTHDAMAGE
CONDITION_EXHAUST = CONDITION_EXHAUST_WEAPON
TALKTYPE_ORANGE_1 = TALKTYPE_MONSTER_SAY
TALKTYPE_ORANGE_2 = TALKTYPE_MONSTER_YELL

function pushThing(thing)
	local t = {uid = 0, itemid = 0, type = 0, actionid = 0}
	if thing ~= nil then
		if thing:isItem() then
			t.uid = thing:getUniqueId()
			t.itemid = thing:getId()
			if ItemType(t.itemid):hasSubType() then
				t.type = thing:getSubType()
			end
			t.actionid = thing:getActionId()
		elseif thing:isCreature() then
			t.uid = thing:getId()
			t.itemid = 1
			if thing:isPlayer() then
				t.type = 1
			elseif thing:isMonster() then
				t.type = 2
			else
				t.type = 3
			end
		end
	end
	return t
end

function isCreature(creature) return Creature(creature) ~= nil end
function isPlayer(creature) return Player(creature) ~= nil end
function isMonster(creature) return Monster(creature) ~= nil end
function isSummon(creature) return Creature(creature):getMaster() ~= nil end
function isNpc(creature) return Npc(creature) ~= nil end
function isItem(uid) return Item(uid) ~= nil end
function isContainer(uid) return Container(uid) ~= nil end

function getCreatureName(creature) local c = Creature(creature) return c ~= nil and c:getName() or false end
function getCreatureHealth(creature) local c = Creature(creature) return c ~= nil and c:getHealth() or false end
function getCreatureMaxHealth(creature) local c = Creature(creature) return c ~= nil and c:getMaxHealth() or false end
function getCreaturePosition(creature) local c = Creature(creature) return c ~= nil and c:getPosition() or false end
function getCreatureOutfit(creature) local c = Creature(creature) return c ~= nil and c:getOutfit() or false end
function getCreatureSpeed(creature) local c = Creature(creature) return c ~= nil and c:getSpeed() or false end
function getCreatureBaseSpeed(creature) local c = Creature(creature) return c ~= nil and c:getBaseSpeed() or false end

function getCreatureTarget(creature)
	local c = Creature(creature)
	if c ~= nil then
		local target = c:getTarget()
		return target ~= nil and target:getId() or 0
	end
	return false
end

function isInArray(array, value)
    for k, v in ipairs(array) do
        if value == v then
            return true
        end
    end
end

function getCreatureMaster(creature)
	local c = Creature(creature)
	if c ~= nil then
		local master = c:getMaster()
		return master ~= nil and master:getId() or c:getId()
	end
	return false
end

function getCreatureSummons(creature)
	local c = Creature(creature)
	if c == nil then
		return false
	end

	local result = {}
	for _, summon in ipairs(c:getSummons()) do
		result[#result + 1] = summon:getId()
	end
	return result
end

getCreaturePos = getCreaturePosition

function doCreatureAddHealth(creature, health) local c = Creature(creature) return c ~= nil and c:addHealth(health) or false end
function doRemoveCreature(creature) local c = Creature(creature) return c ~= nil and c:remove() or false end
function doCreatureSetLookDir(creature, direction) local c = Creature(creature) return c ~= nil and c:setDirection(direction) or false end
function doCreatureSay(creature, text, type, ...) local c = Creature(creature) return c ~= nil and c:say(text, type, ...) or false end
function doCreatureChangeOutfit(creature, outfit) local c = Creature(creature) return c ~= nil and c:setOutfit(outfit) or false end
function doSetCreatureDropLoot(creature, doDrop) local c = Creature(creature) return c ~= nil and c:setDropLoot(doDrop) or false end
function doChangeSpeed(creature, delta) local c = Creature(creature) return c ~= nil and c:changeSpeed(delta) or false end

doSetCreatureDirection = doCreatureSetLookDir

function registerCreatureEvent(creature, name) local c = Creature(creature) return c ~= nil and c:registerEvent(name) or false end
function unregisterCreatureEvent(creature, name) local c = Creature(creature) return c ~= nil and c:unregisterEvent(name) or false end

function getPlayerByName(name) local p = Player(name) return p ~= nil and p:getId() or false end
function getIPByPlayerName(name) local p = Player(name) return p ~= nil and p:getIp() or false end
function getPlayerGUID(player) local p = Player(player) return p ~= nil and p:getGuid() or false end
function getPlayerIp(player) local p = Player(player) return p ~= nil and p:getIp() or false end
function getPlayerAccountType(player) local p = Player(player) return p ~= nil and p:getAccountType() or false end
function getPlayerLastLoginSaved(player) local p = Player(player) return p ~= nil and p:getLastLoginSaved() or false end
function getPlayerName(player) local p = Player(player) return p ~= nil and p:getName() or false end
function getPlayerFreeCap(player) local p = Player(player) return p ~= nil and (p:getFreeCapacity() / 100) or false end
function getPlayerPosition(player) local p = Player(player) return p ~= nil and p:getPosition() or false end
function getPlayerMagLevel(player) local p = Player(player) return p ~= nil and p:getMagicLevel() or false end
function getPlayerAccess(player)
	if player == nil then
		return false
	end
	return player:getGroup():getAccess() and 1 or 0
end
function getPlayerSkill(player, skillId) local p = Player(player) return p ~= nil and p:getSkillLevel(skillId) or false end
function getPlayerMana(player) local p = Player(player) return p ~= nil and p:getMana() or false end
function getPlayerMaxMana(player) local p = Player(player) return p ~= nil and p:getMaxMana() or false end
function getPlayerLevel(player) local p = Player(player) return p ~= nil and p:getLevel() or false end
function getPlayerTown(player) local p = Player(player) return p ~= nil and p:getTown():getId() or false end
function getPlayerVocation(player) local p = Player(player) return p ~= nil and p:getVocation():getId() or false end
function getPlayerSoul(player) local p = Player(player) return p ~= nil and p:getSoul() or false end
function getPlayerSex(player) local p = Player(player) return p ~= nil and p:getSex() or false end
function getPlayerStorageValue(player, key) local p = Player(player) return p ~= nil and p:getStorageValue(key) or false end
function getPlayerBalance(player) local p = Player(player) return p ~= nil and p:getBankBalance() or false end
function getPlayerMoney(player) local p = Player(player) return p ~= nil and p:getMoney() or false end
function getPlayerGroupId(player) local p = Player(player) return p ~= nil and p:getGroup():getId() or false end
function getPlayerLookDir(player) local p = Player(player) return p ~= nil and p:getDirection() or false end
function getPlayerLight(player) local p = Player(player) return p ~= nil and p:getLight() or false end
function getPlayerDepotItems(player, depotId) local p = Player(player) return p ~= nil and p:getDepotItems(depotId) or false end
function getPlayerSkullType(player) local p = Player(player) return p ~= nil and p:getSkull() or false end
function getPlayerLossPercent(player) local p = Player(player) return p ~= nil and p:getDeathPenalty() or false end
function getPlayerMount(player, mountId) local p = Player(player) return p ~= nil and p:hasMount(mountId) or false end
function getPlayerPremiumDays(player) local p = Player(player) return p ~= nil and p:getPremiumDays() or false end
function getPlayerBlessing(player, blessing) local p = Player(player) return p ~= nil and p:hasBlessing(blessing) or false end
function getPlayerParty(player)
	if player == nil then
		return false
	end

	local party = player:getParty()
	if party == nil then
		return nil
	end
	return party:getLeader():getId()
end
function getPlayerGuildId(player)
	if player == nil then
		return false
	end

	local guild = player:getGuild()
	if guild == nil then
		return false
	end
	return guild:getId()
end
function getPlayerGuildLevel(player) local p = Player(player) return p ~= nil and p:getGuildLevel() or false end
function getPlayerGuildName(player)
	if player == nil then
		return false
	end

	local guild = player:getGuild()
	if guild == nil then
		return false
	end
	return guild:getName()
end
function getPlayerGuildRank(player)
	if player == nil then
		return false
	end

	local guild = player:getGuild()
	if guild == nil then
		return false
	end

	local rank = guild:getRankByLevel(player:getGuildLevel())
	return rank ~= nil and rank.name or false
end
function getPlayerGuildNick(player) local p = Player(player) return p ~= nil and p:getGuildNick() or false end
function getPlayerMasterPos(player) local p = Player(player) return p ~= nil and p:getTown():getTemplePosition() or false end
function getPlayerItemCount(player, itemId, ...) local p = Player(player) return p ~= nil and p:getItemCount(itemId, ...) or false end
function getPlayerSlotItem(player, slot)
	if player == nil then
		return pushThing(nil)
	end
	return pushThing(player:getSlotItem(slot))
end
function getPlayerItemById(player, deepSearch, itemId, ...)
	if player == nil then
		return pushThing(nil)
	end
	return pushThing(player:getItemById(itemId, deepSearch, ...))
end
function getPlayerFood(player)
	if player == nil then
		return false
	end
	local c = player:getCondition(CONDITION_REGENERATION, CONDITIONID_DEFAULT) return c ~= nil and math.floor(c:getTicks() / 1000) or 0
end
function canPlayerLearnInstantSpell(player, name) local p = Player(player) return p ~= nil and p:canLearnSpell(name) or false end
function getPlayerLearnedInstantSpell(player, name) local p = Player(player) return p ~= nil and p:hasLearnedSpell(name) or false end
function isPlayerGhost(player) local p = Player(player) return p ~= nil and p:isInGhostMode() or false end
function isPlayerPzLocked(player) local p = Player(player) return p ~= nil and p:isPzLocked() or false end
function isPremium(player) local p = Player(player) return p ~= nil and p:isPremium() or false end
function getPlayersByIPAddress(ip, mask)
	if mask == nil then mask = 0xFFFFFFFF end
	local masked = bit.band(ip, mask)
	local result = {}
	for _, player in ipairs(Game.getPlayers()) do
		if bit.band(player:getIp(), mask) == masked then
			result[#result + 1] = player:getId()
		end
	end
	return result
end
function getOnlinePlayers()
	local result = {}
	for _, player in ipairs(Game.getPlayers()) do
		result[#result + 1] = player:getName()
	end
	return result
end
function getPlayersByAccountNumber(accountNumber)
	local result = {}
	for _, player in ipairs(Game.getPlayers()) do
		if player:getAccountId() == accountNumber then
			result[#result + 1] = player:getId()
		end
	end
	return result
end
function getPlayerGUIDByName(name)
	local player = Player(name)
	if player ~= nil then
		return player:getGuid()
	end

	local resultId = db.storeQuery("SELECT `id` FROM `players` WHERE `name` = " .. db.escapeString(name))
	if resultId ~= false then
		local guid = result.getDataInt(resultId, "id")
		result.free(resultId)
		return guid
	end
	return 0
end
function getAccountNumberByPlayerName(name)
	local player = Player(name)
	if player ~= nil then
		return player:getAccountId()
	end

	local resultId = db.storeQuery("SELECT `account_id` FROM `players` WHERE `name` = " .. db.escapeString(name))
	if resultId ~= false then
		local accountId = result.getDataInt(resultId, "account_id")
		result.free(resultId)
		return accountId
	end
	return 0
end

getPlayerAccountBalance = getPlayerBalance
getIpByName = getIPByPlayerName

function setPlayerStorageValue(player, key, value) local p = Player(player) return p ~= nil and p:setStorageValue(key, value) or false end
function doPlayerSetBalance(player, balance) local p = Player(player) return p ~= nil and p:setBankBalance(balance) or false end
function doPlayerAddMoney(player, money) local p = Player(player) return p ~= nil and p:addMoney(money) or false end
function doPlayerRemoveMoney(player, money) local p = Player(player) return p ~= nil and p:removeMoney(money) or false end
function doPlayerAddSoul(player, soul) local p = Player(player) return p ~= nil and p:addSoul(soul) or false end
function doPlayerSetVocation(player, vocation) local p = Player(player) return p ~= nil and p:setVocation(Vocation(vocation)) or false end
function doPlayerSetTown(player, town) local p = Player(player) return p ~= nil and p:setTown(Town(town)) or false end
function setPlayerGroupId(player, groupId) local p = Player(player) return p ~= nil and p:setGroup(Group(groupId)) or false end
function doPlayerSetSex(player, sex) local p = Player(player) return p ~= nil and p:setSex(sex) or false end
function doPlayerSetGuildLevel(player, level) local p = Player(player) return p ~= nil and p:setGuildLevel(level) or false end
function doPlayerSetGuildNick(player, nick) local p = Player(player) return p ~= nil and p:setGuildNick(nick) or false end
function doShowTextDialog(player, itemId, text) local p = Player(player) return p ~= nil and p:showTextDialog(itemId, text) or false end
function doPlayerAddItemEx(player, uid, ...) local p = Player(player) return p ~= nil and p:addItemEx(Item(uid), ...) or false end
function doPlayerRemoveItem(player, itemid, count, ...) local p = Player(player) return p ~= nil and p:removeItem(itemid, count, ...) or false end
function doPlayerAddPremiumDays(player, days) local p = Player(player) return p ~= nil and p:addPremiumDays(days) or false end
function doPlayerRemovePremiumDays(player, days) local p = Player(player) return p ~= nil and p:removePremiumDays(days) or false end
function doPlayerAddBlessing(player, blessing) local p = Player(player) return p ~= nil and p:addBlessing(blessing) or false end
function doPlayerAddOutfit(player, lookType, addons) local p = Player(player) return p ~= nil and p:addOutfitAddon(lookType, addons) or false end
function doPlayerRemOutfit(player, lookType, addons)
	if player == nil then
		return false
	end
	if addons == 255 then
		return player:removeOutfit(lookType)
	else
		return player:removeOutfitAddon(lookType, addons)
	end
end
function canPlayerWearOutfit(player, lookType, addons) local p = Player(player) return p ~= nil and p:hasOutfit(lookType, addons) or false end
function doPlayerAddMount(player, mountId) local p = Player(player) return p ~= nil and p:addMount(mountId) or false end
function doPlayerRemoveMount(player, mountId) local p = Player(player) return p ~= nil and p:removeMount(mountId) or false end
function doPlayerSendCancel(player, text) local p = Player(player) return p ~= nil and p:sendCancelMessage(text) or false end
function doPlayerFeed(player, food) local p = Player(player) return p ~= nil and p:feed(food) or false end
function playerLearnInstantSpell(player, name) local p = Player(player) return p ~= nil and p:learnSpell(name) or false end
function doPlayerPopupFYI(player, message) local p = Player(player) return p ~= nil and p:popupFYI(message) or false end
function doSendTutorial(player, tutorialId) local p = Player(player) return p ~= nil and p:sendTutorial(tutorialId) or false end
function doAddMapMark(player, pos, type, description) local p = Player(player) return p ~= nil and p:addMapMark(pos, type, description or "") or false end
function doPlayerSendTextMessage(player, type, text, ...) local p = Player(player) return p ~= nil and p:sendTextMessage(type, text, ...) or false end
function doSendAnimatedText() debugPrint("Deprecated function.") return true end
function doPlayerAddExp(player, exp, useMult, ...)
	if player == nil then
		return false
	end

	if useMult then
		exp = exp * Game.getExperienceStage(player:getLevel())
	end
	return player:addExperience(exp, ...)
end
function doPlayerAddManaSpent(player, mana) local p = Player(player) return p ~= nil and p:addManaSpent(mana * configManager.getNumber(configKeys.RATE_MAGIC)) or false end
function doPlayerAddSkillTry(player, skillid, n) local p = Player(player) return p ~= nil and p:addSkillTries(skillid, n * configManager.getNumber(configKeys.RATE_SKILL)) or false end
function doPlayerAddMana(player, mana, ...) local p = Player(player) return p ~= nil and p:addMana(mana, ...) or false end
function doPlayerJoinParty(player, leaderId)
	if player == nil then
		return false
	end

	if player:getParty() ~= nil then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You are already in a party.")
		return true
	end

	local leader = Player(leaderId)
	if leader == nil then
		return false
	end

	local party = leader:getParty()
	if party == nil or party:getLeader() ~= leader then
		return true
	end

	for _, invitee in ipairs(party:getInvitees()) do
		if player ~= invitee then
			return true
		end
	end

	party:addMember(player)
	return true
end
function getPartyMembers(player)
	if player == nil then
		return false
	end

	local party = player:getParty()
	if party == nil then
		return false
	end

	local result = {party:getLeader():getId()}
	for _, member in ipairs(party:getMembers()) do
		result[#result + 1] = member:getId()
	end
	return result
end

doPlayerSendDefaultCancel = doPlayerSendCancel

function getMonsterTargetList(creature)
	local monster = Monster(creature)
	if monster == nil then
		return false
	end

	local result = {}
	for _, creature in ipairs(monster:getTargetList()) do
		if monster:isTarget(creature) then
			result[#result + 1] = creature:getId()
		end
	end
	return result
end
function getMonsterFriendList(creature)
	local monster = Monster(creature)
	if monster == nil then
		return false
	end

	local z = monster:getPosition().z

	local result = {}
	for _, creature in ipairs(monster:getFriendList()) do
		if not creature:isRemoved() and creature:getPosition().z == z then
			result[#result + 1] = creature:getId()
		end
	end
	return result
end
function doSetMonsterTarget(creature, target)
	local monster = Monster(creature)
	if monster == nil then
		return false
	end

	if monster:getMaster() ~= nil then
		return true
	end

	local target = Creature(creature)
	if target == nil then
		return false
	end

	monster:selectTarget(target)
	return true
end
function doMonsterChangeTarget(creature)
	local monster = Monster(creature)
	if monster == nil then
		return false
	end

	if monster:getMaster() ~= nil then
		return true
	end

	monster:searchTarget(1)
	return true
end
function doCreateNpc(name, pos, ...)
	local npc = Game.createNpc(name, pos, ...) return npc ~= nil and npc:setMasterPos(pos) or false
end
function doSummonCreature(name, pos, ...)
	local m = Game.createMonster(name, pos, ...) return m ~= nil and m:getId() or false
end
function doConvinceCreature(creature, target)
	local creature = Creature(creature)
	if creature == nil then
		return false
	end

	local targetCreature = Creature(target)
	if targetCreature == nil then
		return false
	end

	targetCreature:setMaster(creature)
	return true
end

function getTownId(townName) local t = Town(townName) return t ~= nil and t:getId() or false end
function getTownName(townId) local t = Town(townId) return t ~= nil and t:getName() or false end
function getTownTemplePosition(townId) local t = Town(townId) return t ~= nil and t:getTemplePosition() or false end

function doSetItemActionId(uid, actionId) local i = Item(uid) return i ~= nil and i:setActionId(actionId) or false end
function doTransformItem(uid, newItemId, ...) local i = Item(uid) return i ~= nil and i:transform(newItemId, ...) or false end
function doChangeTypeItem(uid, newType) local i = Item(uid) return i ~= nil and i:transform(i:getId(), newType) or false end
function doRemoveItem(uid, ...) local i = Item(uid) return i ~= nil and i:remove(...) or false end

function getContainerSize(uid) local c = Container(uid) return c ~= nil and c:getSize() or false end
function getContainerCap(uid) local c = Container(uid) return c ~= nil and c:getCapacity() or false end
function getContainerItem(uid, slot)
	local container = Container(uid)
	if container == nil then
		return pushThing(nil)
	end
	return pushThing(container:getItem(slot))
end

function doAddContainerItemEx(uid, virtualId)
	local container = Container(uid)
	if container == nil then
		return false
	end

	local res = container:addItemEx(Item(virtualId))
	if res == nil then
		return false
	end
	return res
end

function doSendMagicEffect(pos, magicEffect, ...) return Position(pos):sendMagicEffect(magicEffect, ...) end
function doSendDistanceShoot(fromPos, toPos, distanceEffect, ...) return Position(fromPos):sendDistanceEffect(toPos, distanceEffect, ...) end
function isSightClear(fromPos, toPos, floorCheck) return Position(fromPos):isSightClear(toPos, floorCheck) end

function getPromotedVocation(vocationId)
	local vocation = Vocation(vocationId)
	if vocation == nil then
		return 0
	end

	local promotedVocation = vocation:getPromotion()
	if promotedVocation == nil then
		return 0
	end
	return promotedVocation:getId()
end

function getGuildId(guildName)
	local resultId = db.storeQuery("SELECT `id` FROM `guilds` WHERE `name` = " .. db.escapeString(guildName))
	if resultId == false then
		return false
	end

	local guildId = result.getDataInt(resultId, "id")
	result.free(resultId)
	return guildId
end

function getHouseName(houseId) local h = House(houseId) return h ~= nil and h:getName() or false end
function getHouseOwner(houseId) local h = House(houseId) return h ~= nil and h:getOwnerGuid() or false end
function getHouseEntry(houseId) local h = House(houseId) return h ~= nil and h:getExitPosition() or false end
function getHouseTown(houseId) local h = House(houseId) if h == nil then return false end local t = h:getTown() return t ~= nil and t:getId() or false end
function getHouseTilesSize(houseId) local h = House(houseId) return h ~= nil and h:getTileCount() or false end

function isItemStackable(itemId) return ItemType(itemId):isStackable() end
function isItemRune(itemId) return ItemType(itemId):isRune() end
function isItemDoor(itemId) return ItemType(itemId):isDoor() end
function isItemContainer(itemId) return ItemType(itemId):isContainer() end
function isItemFluidContainer(itemId) return ItemType(itemId):isFluidContainer() end
function isItemMovable(itemId) return ItemType(itemId):isMovable() end
function isCorpse(uid) local i = Item(uid) return i ~= nil and ItemType(i:getId()):isCorpse() or false end

isItemMoveable = isItemMovable
isMoveable = isMovable

function getItemName(itemId) return ItemType(itemId):getName() end
function getItemWeight(itemId, ...) return ItemType(itemId):getWeight(...) / 100 end
function getItemDescriptions(itemId)
	local itemType = ItemType(itemId)
	return {
		name = itemType:getName(),
		plural = itemType:getPluralName(),
		article = itemType:getArticle(),
		description = itemType:getDescription()
	}
end
function getItemIdByName(name)
	local id = ItemType(name):getId()
	if id == 0 then
		return false
	end
	return id
end
function getItemWeightByUID(uid, ...)
	local item = Item(uid)
	if item == nil then
		return false
	end

	local itemType = ItemType(item:getId())
	return itemType:isStackable() and (itemType:getWeight(item:getCount(), ...) / 100) or (itemType:getWeight(1, ...) / 100)
end
function getItemRWInfo(uid)
	local item = Item(uid)
	if item == nil then
		return false
	end

	local rwFlags = 0
	local itemType = ItemType(item:getId())
	if itemType:isReadable() then
		rwFlags = bit.bor(rwFlags, 1)
	end

	if itemType:isWritable() then
		rwFlags = bit.bor(rwFlags, 2)
	end
	return rwFlags
end
function getContainerCapById(itemId) return ItemType(itemId):getCapacity() end
function getFluidSourceType(itemId) local it = ItemType(itemId) return it.id ~= 0 and it:getFluidSource() or false end

function doSetItemText(uid, text)
	local item = Item(uid)
	if item == nil then
		return false
	end

	if text ~= "" then
		item:setAttribute(ITEM_ATTRIBUTE_TEXT, text)
	else
		item:removeAttribute(ITEM_ATTRIBUTE_TEXT)
	end
	return true
end
function doSetItemSpecialDescription(uid, desc)
	local item = Item(uid)
	if item == nil then
		return false
	end

	if desc ~= "" then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, desc)
	else
		item:removeAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
	end
	return true
end
function doDecayItem(uid) local i = Item(uid) return i ~= nil and i:decay() or false end

function setHouseOwner(id, guid) local h = House(id) return h ~= nil and h:setOwnerGuid(guid) or false end
function getHouseRent(id) local h = House(id) return h ~= nil and h:getRent() or nil end
function getHouseAccessList(id, listId) local h = House(id) return h ~= nil and h:getAccessList(listId) or nil end
function setHouseAccessList(id, listId, listText) local h = House(id) return h ~= nil and h:setAccessList(listId, listText) or false end

function getHouseByPlayerGUID(playerGUID)
	for _, house in ipairs(Game.getHouses()) do
		if house:getOwnerGuid() == playerGUID then
			return house:getId()
		end
	end
	return nil
end

function getTileHouseInfo(pos)
	local t = Tile(pos)
	if t == nil then
		return false
	end
	local h = t:getHouse()
	return h ~= nil and h:getId() or false
end

function getTilePzInfo(position)
	local t = Tile(position)
	if t == nil then
		return false
	end
	return t:hasFlag(TILESTATE_PROTECTIONZONE)
end

function getTileInfo(position)
	local t = Tile(position)
	if t == nil then
		return false
	end

	local ret = pushThing(t:getGround())
	ret.protection = t:hasFlag(TILESTATE_PROTECTIONZONE)
	ret.nopz = ret.protection
	ret.nologout = t:hasFlag(TILESTATE_NOLOGOUT)
	ret.refresh = t:hasFlag(TILESTATE_REFRESH)
	ret.house = t:hasFlag(TILESTATE_HOUSE)
	ret.bed = t:hasFlag(TILESTATE_BED)
	ret.depot = t:hasFlag(TILESTATE_DEPOT)

	ret.things = t:getThingCount()
	ret.creatures = t:getCreatureCount()
	ret.items = t:getItemCount()
	ret.topItems = t:getTopItemCount()
	ret.downItems = t:getDownItemCount()
	return ret
end

function getTileItemByType(position, itemType)
	local t = Tile(position)
	if t == nil then
		return pushThing(nil)
	end
	return pushThing(t:getItemByType(itemType))
end

function getTileItemById(position, itemId, ...)
	local t = Tile(position)
	if t == nil then
		return pushThing(nil)
	end
	return pushThing(t:getItemById(itemId, ...))
end

function getTileThingByPos(position)
	local t = Tile(position)
	if t == nil then
		if position.stackpos == -1 then
			return -1
		end
		return pushThing(nil)
	end

	if position.stackpos == -1 then
		return t:getThingCount()
	end
	return pushThing(t:getThing(position.stackpos))
end

function getTileThingByTopOrder(position, topOrder)
	local t = Tile(position)
	if t == nil then
		return pushThing(nil)
	end
	return pushThing(t:getItemByTopOrder(topOrder))
end

function getTopCreature(position)
	local t = Tile(position)
	if t == nil then
		return pushThing(nil)
	end
	return pushThing(t:getTopCreature())
end

function queryTileAddThing(thing, position, ...) local t = Tile(position) return t ~= nil and t:queryAdd(thing, ...) or false end

function doTeleportThing(uid, dest, pushMovement)
	if type(uid) == "userdata" then
		if uid:isCreature() then
			return uid:teleportTo(dest, pushMovement or false)
		else
			return uid:moveTo(dest)
		end
	else
		if uid >= 0x10000000 then
			local creature = Creature(uid)
			if creature ~= nil then
				return creature:teleportTo(dest, pushMovement or false)
			end
		else
			local item = Item(uid)
			if item ~= nil then
				return item:moveTo(dest)
			end
		end
	end
	return false
end

function getThingPos(uid)
	local thing
	if uid >= 0x10000000 then
		thing = Creature(uid)
	else
		thing = Item(uid)
	end

	if thing == nil then
		return false
	end

	local stackpos = 0
	local tile = thing:getTile()
	if tile ~= nil then
		stackpos = tile:getThingIndex(thing)
	end

	local position = thing:getPosition()
	position.stackpos = stackpos
	return position
end

function doRelocate(fromPos, toPos)
	if fromPos == toPos then
		return false
	end	

	local fromTile = Tile(fromPos)
	if fromTile == nil then
		return false
	end

	if Tile(toPos) == nil then
		return false
	end

	for i = fromTile:getThingCount() - 1, 0, -1 do
		local thing = fromTile:getThing(i)
		if thing ~= nil then
			if thing:isItem() then
				if ItemType(thing:getId()):isMovable() then
					thing:moveTo(toPos)
				end
			elseif thing:isCreature() then
				thing:teleportTo(toPos)
			end
		end
	end		
	return true
end

function getThing(uid)
	return uid >= 0x10000000 and pushThing(Creature(uid)) or pushThing(Item(uid))
end

function getConfigInfo(info)
	if type(info) ~= "string" then
		return nil
	end
	dofile('config.lua')
	return _G[info]
end

function getWorldCreatures(type)
	if type == 0 then
		return Game.getPlayerCount()
	elseif type == 1 then
		return Game.getMonsterCount()
	elseif type == 2 then
		return Game.getNpcCount()
	end
	return Game.getPlayerCount() + Game.getMonsterCount() + Game.getNpcCount()
end

saveData = saveServer

function getGlobalStorageValue(key)
	return Game.getStorageValue(key) or -1
end

function setGlobalStorageValue(key, value)
	Game.setStorageValue(key, value)
	return true
end

getWorldType = Game.getWorldType

numberToVariant = Variant
stringToVariant = Variant
positionToVariant = Variant

function targetPositionToVariant(position)
	local variant = Variant(position)
	variant.type = VARIANT_TARGETPOSITION
	return variant
end

variantToNumber = Variant.getNumber
variantToString = Variant.getString
variantToPosition = Variant.getPosition

function doCreateTeleport(itemId, destination, position)
	local item = Game.createItem(itemId, 1, position)
	if not item:isTeleport() then
		item:remove()
		return false
	end
	item:setDestination(destination)
	return item:getUniqueId()
end

function getSpectators(centerPos, rangex, rangey, multifloor, onlyPlayers)
	local result = Game.getSpectators(centerPos, multifloor, onlyPlayers or false, rangex, rangex, rangey, rangey)
	if #result == 0 then
		return nil
	end

	for index, spectator in ipairs(result) do
		result[index] = spectator:getId()
	end
	return result
end

function broadcastMessage(message, messageType)
	Game.broadcastMessage(message, messageType)
	print("> Broadcasted message: \"" .. message .. "\".")
end
