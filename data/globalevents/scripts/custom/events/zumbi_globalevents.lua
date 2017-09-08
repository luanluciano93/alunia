dofile('data/lib/custom/zumbi.lua')

local function Zumbi_Verifica()
	local tile = Tile(ZUMBI.PositionTeleportOpen)
	if tile then
		local item = tile:getItemById(1387)
		if item then
			item:remove()
			Game.broadcastMessage("The Zumbi Event will begin now!", MESSAGE_STATUS_WARNING)
			Game.createMonster("Zumbi", ZUMBI.PositionEnterEvent)
			print(">>> Zumbi Event was started. <<<")
		else
			Game.broadcastMessage("The Zumbi Event was opened and will close in ".. ZUMBI.TeleportTimeClose .." minutes.", MESSAGE_STATUS_WARNING)
			Game.setStorageValue(ZUMBI.TotalPlayers, 0)

			local teleport = Game.createItem(1387, 1, ZUMBI.PositionTeleportOpen)
			if teleport then
				teleport:setActionId(48002)
			end

			addEvent(Zumbi_Verifica, ZUMBI.TeleportTimeClose * 60 * 1000)
		end
	end
end

function onTime(interval)
	Zumbi_Verifica()
	return true
end
