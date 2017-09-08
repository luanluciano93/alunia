local potions = {
	[2033] = { -- Health
		[1] = { -- Mage
			[1] = {id = 7618, price = 5000, level = {1, math.huge}}, -- health_potion
		},
		[2] = { -- Paladin
			[1] = {id = 7618, price = 5000, level = {1, 50}}, -- health_potion
			[2] = {id = 7588, price = 10000, level = {50, 80}}, -- strong potion
			[3] = {id = 8472, price = 19000, level = {80, math.huge}}, -- spirit potion
		},
		[3] = { -- Knight
			[1] = {id = 7618, price = 5000, level = {1, 50}}, -- health_potion
			[2] = {id = 7588, price = 10000, level = {50, 80}}, -- strong potion
			[3] = {id = 7591, price = 19000, level = {80, 130}}, -- great potion
			[4] = {id = 8473, price = 31000, level = {130, math.huge}}, -- ultimate potion
		},
	},

	[2034] = { -- Mana
		[1] = { -- Mage
			[1] = {id = 7620, price = 5000, level = {1, 50}}, -- mana potion
			[2] = {id = 7589, price = 8000, level = {50, 80}}, -- strong potion
			[3] = {id = 7590, price = 12000, level = {80, math.huge}}, -- great potion
		},
		[2] = { -- Paladin
			[1] = {id = 7620, price = 5000, level = {1, 50}}, -- mana potion
			[2] = {id = 7589, price = 8000, level = {50, math.huge}}, -- strong potion
		},
		[3] = { -- Knight
			[1] = {id = 7620, price = 5000, level = {1, math.huge}}, -- mana potion
		},
	}
}

function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)

	item:transform(item.itemid == 1945 and 1946 or 1945)
	
	local group = 0
	if player:isMage() then 
		group = 1
	elseif player:isPaladin() then 
		group = 2
	elseif player:isKnight() then
		group = 3
	end

	local pot = potions[item.actionid][group]
	if not pot then
		return true
	end

	for _, v in ipairs(pot) do
		if player:getLevel() >= v.level[1] and player:getLevel() < v.level[2] then
			if player:getMoney() >= v.price then
				if player:removeMoney(v.price) then
					player:addItem(v.id, 100)
				end
			else
				return player:sendCancelMessage("You do not have enough money.")
			end
		end
	end

	item:transform(item.itemid == 1945 and 1946 or 1945)
	
	return true
end
