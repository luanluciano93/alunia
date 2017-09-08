local function doCheckHouses()

	local dias = 30
	local tempo = os.time() - (dias * 86400) 
	local registros = db.storeQuery("SELECT `houses`.`owner`, `houses`.`id` FROM `houses`,`players` WHERE `houses`.`owner` != 0 AND `houses`.`owner` = `players`.`id` AND `players`.`lastlogin` <= " .. tempo .. ";")

	if registros ~= false then
		local count = 0
		repeat
			count = count + 1
			local owner = result.getNumber(registros, "owner")
			local houseId = result.getNumber(registros, "id")
			local house = House(houseId)
			
			if house and (owner > 0) then
				print(house:getName())
				house:setOwnerGuid(0)
			end
		until not result.next(registros)

		print('house leave house count:' .. count)

		result.free(registros)
	end
end

function onStartup()
	addEvent(doCheckHouses, 60 * 1000)
	return true
end
