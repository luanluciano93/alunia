local config = {
	[1] = {
		2190 -- wand of vortex
	},
	[2] = {
		2182 -- snakebite rod
	},
	[3] = {
		2399 -- stars
	},
	[4] = {
		2428, -- sword
		8602 -- axe
	}
}

function onLogin(player)
	if player:getLastLoginSaved() ~= 0 then
		return true
	end
	
	local targetVocation = config[player:getVocation():getId()]
	if not targetVocation then
		return true
	end

	for i = 1, #targetVocation do
		player:addItem(targetVocation[i], 1)
	end

	player:addItem(2173) -- amulet of loss
	player:addItem(2463) -- plate armor
	player:addItem(2647) -- plate legs
	player:addItem(2457) -- steel helmet
	player:addItem(2525) -- dwarven shield
	player:addItem(2643) -- leather boots
	
	local backpack = player:addItem(1988)
	if not backpack then
		return true
	end

	backpack:addItem(2160, 1) -- crystal coin
	backpack:addItem(2120, 1) -- rope
	backpack:addItem(2789, 10) -- 10 brown mushrooms

	return true
end