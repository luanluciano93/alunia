local pos = {
	[2200] = Position(368, 101, 13), -- demon helmet quest
	[2201] = Position(131, 192, 9), -- divine place quest
	[2202] = Position(144, 192, 9),	-- vile axe quest
	[2203] = Position(843, 249, 9),	-- inquisition quest
	[2204] = Position(392, 516, 10), -- inquisition quest
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local position = pos[item.uid]
	if not position then
		return true
	end

	local tile = position:getTile()
	if tile then
		local stone = tile:getItemById(1355)
		if stone then
			stone:remove()
		else
			Game.createItem(1355, 1, position)
		end
	end

	item:transform(item.itemid == 1945 and 1946 or 1945)

 	return true
end
