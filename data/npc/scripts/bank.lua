local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
 
local count = {}
local transfer = {}
 
function onCreatureAppear(cid)          npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)       npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)        end
function onThink()      npcHandler:onThink()        end
 
local voices = { {text = 'Don\'t forget to deposit your money here in the Tibian Bank before you head out for adventure.'} }
if VoiceModule then
    npcHandler:addModule(VoiceModule:new(voices))
end

local function getMoneyCount(string)
	local b, e = string:find("%d+")
	local money = b and e and tonumber(string:sub(b, e)) or -1
	if tonumber(money) ~= nil and money > 0 and money < 4294967296 then
		return money
	end
	return -1
end

local function getMoneyWeight(money)
	local gold = money
	local crystal = math.floor(gold / 10000)
	gold = gold - crystal * 10000
	local platinum = math.floor(gold / 100)
	gold = gold - platinum * 100
	return (ItemType(2160):getWeight() * crystal) + (ItemType(2152):getWeight() * platinum) + (ItemType(2148):getWeight() * gold)
end

local function greetCallback(cid)
    count[cid], transfer[cid] = nil, nil
    return true
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    local player = Player(cid)
---------------------------- help ------------------------
    if msgcontains(msg, 'bank account') then
        npcHandler:say({
            'Every Tibian has one. The big advantage is that you can access your money in every branch of the Tibian Bank! ...',
            'Would you like to know more about the {basic} functions of your bank account, the {advanced} functions, or are you already bored, perhaps?'
        }, cid)
        npcHandler.topic[cid] = 0
        return true
---------------------------- balance ---------------------
    elseif msgcontains(msg, 'balance') then
        npcHandler.topic[cid] = 0
        if player:getBankBalance() >= 100000000 then
            npcHandler:say('I think you must be one of the richest inhabitants in the world! Your account balance is ' .. player:getBankBalance() .. ' gold.', cid)
            return true
        elseif player:getBankBalance() >= 10000000 then
            npcHandler:say('You have made ten millions and it still grows! Your account balance is ' .. player:getBankBalance() .. ' gold.', cid)
            return true
        elseif player:getBankBalance() >= 1000000 then
            npcHandler:say('Wow, you have reached the magic number of a million gp!!! Your account balance is ' .. player:getBankBalance() .. ' gold!', cid)
            return true
        elseif player:getBankBalance() >= 100000 then
            npcHandler:say('You certainly have made a pretty penny. Your account balance is ' .. player:getBankBalance() .. ' gold.', cid)
            return true
        else
            npcHandler:say('Your account balance is ' .. player:getBankBalance() .. ' gold.', cid)
            return true
        end
---------------------------- deposit ---------------------
    elseif msgcontains(msg, 'deposit') then
        count[cid] = player:getMoney()
        if count[cid] < 1 then
            npcHandler:say('You do not have enough gold.', cid)
            npcHandler.topic[cid] = 0
            return false
        end
        if msgcontains(msg, 'all') then
            count[cid] = player:getMoney()
            npcHandler:say('Would you really like to deposit ' .. count[cid] .. ' gold?', cid)
            npcHandler.topic[cid] = 2
            return true
        else
            if string.match(msg,'%d+') then
                count[cid] = getMoneyCount(msg)
                if count[cid] < 0 then
                    npcHandler:say('You do not have enough gold.', cid)
                    npcHandler.topic[cid] = 0
                    return false
                end
                npcHandler:say('Would you really like to deposit ' .. count[cid] .. ' gold?', cid)
                npcHandler.topic[cid] = 2
                return true
            else
                npcHandler:say('Please tell me how much gold it is you would like to deposit.', cid)
                npcHandler.topic[cid] = 1
                return true
            end
        end
    elseif npcHandler.topic[cid] == 1 then
        count[cid] = getMoneyCount(msg)
        if count[cid] > 0 then
            npcHandler:say('Would you really like to deposit ' .. count[cid] .. ' gold?', cid)
            npcHandler.topic[cid] = 2
            return true
        else
            npcHandler:say('You do not have enough gold.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
    elseif npcHandler.topic[cid] == 2 then
        if msgcontains(msg, 'yes') then
            if player:getMoney() >= tonumber(count[cid]) then
                player:depositMoney(count[cid])
                npcHandler:say('Alright, we have added the amount of ' .. count[cid] .. ' gold to your {balance}. You can {withdraw} your money anytime you want to.', cid)
            else
                npcHandler:say('You do not have enough gold.', cid)
            end
        elseif msgcontains(msg, 'no') then
            npcHandler:say('As you wish. Is there something else I can do for you?', cid)
        end
        npcHandler.topic[cid] = 0
        return true
---------------------------- withdraw --------------------
    elseif msgcontains(msg, 'withdraw') then
        if string.match(msg,'%d+') then
            count[cid] = getMoneyCount(msg)
            if count[cid] > 0 then
                npcHandler:say('Are you sure you wish to withdraw ' .. count[cid] .. ' gold from your bank account?', cid)
                npcHandler.topic[cid] = 7
            else
                npcHandler:say('There is not enough gold on your account.', cid)
                npcHandler.topic[cid] = 0
            end
            return true
        else
            npcHandler:say('Please tell me how much gold you would like to withdraw.', cid)
            npcHandler.topic[cid] = 6
            return true
        end
    elseif npcHandler.topic[cid] == 6 then
        count[cid] = getMoneyCount(msg)
        if count[cid] > 1 then
            npcHandler:say('Are you sure you wish to withdraw ' .. count[cid] .. ' gold from your bank account?', cid)
            npcHandler.topic[cid] = 7
        else
            npcHandler:say('There is not enough gold on your account.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
    elseif npcHandler.topic[cid] == 7 then
        if msgcontains(msg, 'yes') then
            if player:getFreeCapacity() >= getMoneyWeight(count[cid]) then
                if not player:withdrawMoney(count[cid]) then
                    npcHandler:say('There is not enough gold on your account.', cid)
                else
                    npcHandler:say('Here you are, ' .. count[cid] .. ' gold. Please let me know if there is something else I can do for you.', cid)
                end
            else
                npcHandler:say('Whoah, hold on, you have no room in your inventory to carry all those coins. I don\'t want you to drop it on the floor, maybe come back with a cart!', cid)
            end
            npcHandler.topic[cid] = 0
        elseif msgcontains(msg, 'no') then
            npcHandler:say('The customer is king! Come back anytime you want to if you wish to {withdraw} your money.', cid)
            npcHandler.topic[cid] = 0
        end
        return true
---------------------------- transfer --------------------
    elseif msgcontains(msg, 'transfer') then
        npcHandler:say('Please tell me the amount of gold you would like to transfer.', cid)
        npcHandler.topic[cid] = 11
    elseif npcHandler.topic[cid] == 11 then
        count[cid] = getMoneyCount(msg)
        if player:getBankBalance() < count[cid] then
            npcHandler:say('There is not enough gold on your account.', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        if count[cid] > 1 then
            npcHandler:say('Who would you like transfer ' .. count[cid] .. ' gold to?', cid)
            npcHandler.topic[cid] = 12
        else
            npcHandler:say('There is not enough gold on your account.', cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 12 then
        transfer[cid] = msg
        if player:getName() == transfer[cid] then
            npcHandler:say('Fill in this field with person who receives your gold!', cid)
            npcHandler.topic[cid] = 0
            return true
        end
        if playerExists(transfer[cid]) then
		 local arrayDenied = {"accountmanager", "rooksample", "druidsample", "sorcerersample", "knightsample", "paladinsample"}
		    if table.contains(arrayDenied, string.gsub(transfer[cid]:lower(), " ", "")) then
                npcHandler:say('This player does not exist.', cid)
                npcHandler.topic[cid] = 0
                return true
            end
            npcHandler:say('So you would like to transfer ' .. count[cid] .. ' gold to ' .. transfer[cid] .. '?', cid)
            npcHandler.topic[cid] = 13
        else
            npcHandler:say('This player does not exist.', cid)
            npcHandler.topic[cid] = 0
        end
    elseif npcHandler.topic[cid] == 13 then
        if msgcontains(msg, 'yes') then
            if not player:transferMoneyTo(transfer[cid], count[cid]) then
                npcHandler:say('You cannot transfer money to this account.', cid)
            else
                npcHandler:say('Very well. You have transferred ' .. count[cid] .. ' gold to ' .. transfer[cid] ..'.', cid)
                transfer[cid] = nil
            end
        elseif msgcontains(msg, 'no') then
            npcHandler:say('Alright, is there something else I can do for you?', cid)
        end
        npcHandler.topic[cid] = 0
	end
    return true
end
 
keywordHandler:addKeyword({'money'}, StdModule.say, {npcHandler = npcHandler, text = 'We can {change} money for you. You can also access your {bank account}.'})
keywordHandler:addKeyword({'change'}, StdModule.say, {npcHandler = npcHandler, text = 'There are three different coin types in Tibia: 100 gold coins equal 1 platinum coin, 100 platinum coins equal 1 crystal coin. So if you\'d like to change 100 gold into 1 platinum, simply say \'{change gold}\' and then \'1 platinum\'.'})
keywordHandler:addKeyword({'bank'}, StdModule.say, {npcHandler = npcHandler, text = 'We can {change} money for you. You can also access your {bank account}.'})
keywordHandler:addKeyword({'advanced'}, StdModule.say, {npcHandler = npcHandler, text = 'Your bank account will be used automatically when you want to {rent} a house or place an offer on an item on the {market}. Let me know if you want to know about how either one works.'})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, text = 'You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.'})
keywordHandler:addKeyword({'functions'}, StdModule.say, {npcHandler = npcHandler, text = 'You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.'})
keywordHandler:addKeyword({'basic'}, StdModule.say, {npcHandler = npcHandler, text = 'You can check the {balance} of your bank account, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I work in this bank. I can change money for you and help you with your bank account.'})
 
npcHandler:setMessage(MESSAGE_GREET, "Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Have a nice day.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Have a nice day.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Here. Don't forget that you need to buy a label too if you want to send a parcel. Always write the name of the {receiver} in the first line.")
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
