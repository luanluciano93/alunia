task_monsters = {
	[1] = {name = "troll", storage = 5101, monsters_list = {"troll","frost troll","island troll","furious troll","swamp troll"}, amount = 100, exp = 20000, pointsTask = 1, items = {{id = 2160, count = 2}}},
}

task_daily = {
	[1] = {name = "fire elementals", storage = 5201, monsters_list = {"fire elemental","massive fire elemental","blazing fire elemental","blistering fire elemental"}, amount = 70, exp = 50000, pointsTask = 1, items = {{id = 2160, count = 1}}},
}

-- lembrando que os monsters na "name" e na "monsters_list" devem ser sempre em letra minuscula!

task_current = 5000 -- storage que verifica se esta fazendo alguma task e ver qual - task normal
task_points = 5001 -- storage que retorna a quantidade de pontos task que o player tem.
task_delay = 5002 -- storage de delay para nao poder fazer a task novamente caso ela for abandonada.
task_time = 2 -- tempo em horas em que o player ficara sem fazer a task como punicao
task_rank = 5003 -- storage do rank task
task_daily_current = 5004 -- storage que verifica se esta fazendo alguma task e ver qual - task daily
task_daily_time = 5005 -- storage do tempo da task daily, no caso para verificar e add 24 horas para fazer novamente a task daily

local ranks_task = {
	[{1, 20}] = "Newbie", 
	[{21, 50}] = "Elite",
	[{51, 100}] = "Master",
	[{101, 200}] = "Destroyer",		
	[{201, math.huge}] = "Juggernaut"
}

function Player.getTask(self)
	return self:getStorageValue(task_current) > 0 and task_monsters[self:getStorageValue(task_current)] or false
end

function Player.getDailyTask(self)
	return self:getStorageValue(task_daily_current) > 0 and task_daily[self:getStorageValue(task_daily_current)] or false
end

function Player.getTaskPoints(self)
	return self:getStorageValue(task_points) > 0 and self:getStorageValue(task_points) or 0
end

function Player.addTaskPoints(self, count)
	return self:setStorageValue(task_points, self:getTaskPoints() + count)
end

function Player.removeTaskPoints(self, count)
	return self:setStorageValue(task_points, self:getTaskPoints() - count)
end

function Player.rankTask(self)
	local pontos = self:getTaskPoints()
	for rank, rankName in pairs(ranks_task) do
		if pontos >= rank[1] and pontos <= rank[2] then
			return rankName
		end
	end
	return 0
end

function getItemsFromTable(itemtable)
	local text = ""
	for v = 1, #itemtable do
		local count, info = itemtable[v].count, ItemType(itemtable[v].id)
		local ret = ", "
		if v == 1 then
			ret = ""
		elseif v == #itemtable then
			ret = " - "
		end
		text = text .. ret
		text = text .. (count > 1 and count or info:getArticle()).." "..(count > 1 and info:getPluralName() or info:getName())
	end
	return text
end

function Player.taskReward(self, points, items, exp, storage_task, storage_task_current)
	local txt = "Thanks for doing the task, your awards are: "..points.." task points, "
	if #getItemsFromTable(items) > 0 then
		txt = txt.." "..getItemsFromTable(items)..", "
		for x = 1, #items do
			self:addItem(items[x].id, items[x].count)
		end
	end
	if exp > 0 then
		txt = txt.." "..exp.." of experience, "
		self:addExperience(exp)
	end
	text = txt.." and even more!"
	self:addTaskPoints(points)
	self:setStorageValue(storage_task, 0)
	self:setStorageValue(storage_task_current, 0)
	return txt
end
