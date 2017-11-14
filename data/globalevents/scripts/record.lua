function onRecord(current, old)
	Game.broadcastMessage("New record: " .. current .. " players are logged in.", MESSAGE_STATUS_DEFAULT)
	print("New record: " .. current .. " players are logged in.")
	return true
end
