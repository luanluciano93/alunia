local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then return false end
	local player = Player(cid)
	local msg = msg:lower()
	------------------------------------------------------------------
	if npcHandler.topic[cid] == 0 and (msgcontains(msg, "task") or msgcontains(msg, 'mission') or msgcontains(msg, 'tasks')) then
		if player:getTask() then
			local task = player:getTask()
			if player:getStorageValue(task.storage) == task.amount then
				player:taskReward(task.pointsTask, task.items, task.exp, task.storage, task_current)
				npcHandler:say(txt, cid) -- problema
				npcHandler:releaseFocus(cid)
			end
		elseif player:getDailyTask() then
			local task = player:getDailyTask()
			if player:getStorageValue(task.storage) == task.amount then
				player:taskReward(task.pointsTask, task.items, task.exp, task.storage, task_daily_current)
				player:setStorageValue(task_daily_time, 1 * 60 * 60 * 24 + os.time())
				npcHandler:say(txt, cid) -- problema
				npcHandler:releaseFocus(cid)
			end
		end
		
		npcHandler:say("Great, would you like to do a {task} or a {daily} task? or would you like to {quit} a task you are doing?", cid)
		npcHandler.topic[cid] = 1
	------------------------------------------------------------------
	elseif npcHandler.topic[cid] == 1 and msgcontains(msg, "task") then
		if player:getStorageValue(task_delay) < os.time() then
			if player:getStorageValue(task_current) <= 0 then
				local text = "You can choose between tasks:"
				for _, task in pairs(task_monsters) do
					text = text .." {"..task.name.."},"
				end
				npcHandler:say(text.." tell me which one you want to do?", cid)
				npcHandler.topic[cid] = 2
			else
				npcHandler:say("You are already doing a task. You can only do one at a time. Say {!task} to see information about your current task. Or use {quit} to cancel it task.", cid)
			end
		else
			npcHandler:say("I'm not allowed to give you any assignments, because you abandoned the previous assignment. Wait for the 2 hours of punishment to end.", cid)
		end	
	elseif npcHandler.topic[cid] == 2 then
		for task_number, task in pairs(task_monsters) do 
			if msg == task.name then
				npcHandler:say("Very well, you are now doing the task of {"..task.name:gsub("^%l", string.upper).."}, you need to kill "..task.amount .." from them. Good luck!", cid)
				player:setStorageValue(task_current, task_number)
				player:setStorageValue(task.storage, 0)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say("Sorry we do not have this task.", cid)
			end
		end
	------------------------------------------------------------------
	elseif msgcontains(msg, "daily") then
		if player:getStorageValue(task_daily_time) < os.time() then
			if player:getStorageValue(task_delay) < os.time() then
				if player:getStorageValue(task_daily_current) <= 0 then
					local text = "You can choose between daily tasks:"
					for _, task in pairs(task_daily) do
						text = text .." {"..task.name.."},"
					end
					npcHandler:say(text.." tell me which one you want to do?", cid)
					npcHandler.topic[cid] = 3
				else
					npcHandler:say("You are already doing a daily task. You can only do one per day. Say {!task} to see information about your current task. Or use {quit} to cancel it daily task.", cid)
				end
			else
				npcHandler:say("I'm not allowed to give you any assignments, because you abandoned the previous assignment. Wait for the 2 hours of punishment to end.", cid)
			end
		else
			npcHandler:say("You have completed today's daily task, expect to spend 24 hours to do it again.", cid)
		end
	elseif npcHandler.topic[cid] == 3 then
		for task_number, task in pairs(task_daily) do 
			if msg == task.name then
				npcHandler:say("Very well, you are now doing the daily task of {"..task.name:gsub("^%l", string.upper).."}, you need to kill "..task.amount.." from them. Good luck!", cid)
				player:setStorageValue(task_daily_current, task_number)
				player:setStorageValue(task.storage, 0)
				npcHandler:releaseFocus(cid)
			else
				npcHandler:say("Sorry we do not have this daily task.", cid)
			end
		end
	------------------------------------------------------------------
	elseif msgcontains(msg, "quit") then
		if npcHandler.topic[cid] == 0 then
			npcHandler:say("What kind of task do you want to quit, {task} or {daily}?", cid)
			npcHandler.topic[cid] = 4
		end
	elseif npcHandler.topic[cid] == 4 and msgcontains(msg, "task") then
		if player:getTask() then
			npcHandler:say("Unfortunate this situation, had faith that you would bring me this mission made, more was wrong. As punishment will be 2 hours without being able to do any task.", cid)
			player:setStorageValue(task_delay, os.time() + task_time * 60 * 60)
			player:setStorageValue(player:getTask().storage, 0)
			player:setStorageValue(task_current, 0)
			npcHandler:releaseFocus(cid)
		else
			npcHandler:say("You are not doing any task to be able to abandon it.", cid)
		end
	elseif npcHandler.topic[cid] == 4 and msgcontains(msg, "daily") then
		if player:getDailyTask() then
			npcHandler:say("Unfortunate this situation, had faith that you would bring me this mission made, more was wrong. As punishment will be 2 hours without being able to do any task.", cid)
			player:setStorageValue(task_delay, os.time() + task_time * 60 * 60)
			player:setStorageValue(player:getDailyTask().storage, 0)
			player:setStorageValue(task_daily_current, 0)
			npcHandler:releaseFocus(cid)
		else
			npcHandler:say("You are not doing any daily task to be able to abandon it.", cid)
		end
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)npcHandler:setMessage(MESSAGE_FAREWELL, 'Happy hunting, old chap!')
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
