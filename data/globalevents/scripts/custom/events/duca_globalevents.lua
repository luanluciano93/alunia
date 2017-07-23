dofile('data/lib/custom/duca.lua')

function onTime(interval)
	DucaTeleportCheck()
	return true
end
