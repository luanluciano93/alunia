local potions = {
-- Config
	titleMsg = "Choose your Potion",
	mainMsg = "Please select how many potions you would like to buy.",
	moneyMsg = "You do not have enough money!", -- This is the message the player will recieve when he does not have enough money.
	capacityMsg = "I need more cap", -- This is the message the player will recieve when he does not have enough capactiy.
	buyMsg = "You have bought ", -- This is the message the player will recieve when he succesfully buys.
-- End Config

	-- Change prices in this table here price10 = price for 10 potions etc.
    [1] = {potion = "Health Potion", itemID = 7618, price10 = 450, price50 = 2250, price100 = 4500},
    [2] = {potion = "Strong Health Potion", itemID = 7588, price10 = 1000, price50 = 5000, price100 = 10000},
    [3] = {potion = "Great Health Potion", itemID = 7591, price10 = 1900, price50 = 9500, price100 = 19000},
    [4] = {potion = "Ultimate Health Potion", itemID = 8473, price10 = 3100, price50 = 15500, price100 = 31000},
    [5] = {potion = "Supreme Health Potion", itemID = 7618, price10 = 760, price50 = 760, price100 = 760},
    [6] = {potion = "Mana Potion", itemID = 7620, price10 = 500, price50 = 2500, price100 = 5000},
    [7] = {potion = "Strong Mana Potion", itemID = 7589, price10 = 800, price50 = 4000, price100 = 8000},
    [8] = {potion = "Great Mana Potion", itemID = 7590, price10 = 1200, price50 = 6000, price100 = 12000},
    [9] = {potion = "Ultimate Mana Potion", itemID = 7618, price10 = 760, price50 = 760, price100 = 760},
    [10] = {potion = "Great Spirit Potion", itemID = 8472, price10 = 1900, price50 = 9500, price100 = 19000},
    [11] = {potion = "Ultimate Spirit Potion", itemID = 7618, price10 = 760, price50 = 760, price100 = 760},
}

function onUse(player, item, fromPosition, itemEx, toPosition, isHotkey)
    player:sendShopWindow(potions)
    return true
end
