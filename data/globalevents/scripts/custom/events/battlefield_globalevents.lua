dofile('data/lib/custom/battlefield.lua')

function onTime(interval)
	BattlefieldTeleportCheck()
	return true
end
