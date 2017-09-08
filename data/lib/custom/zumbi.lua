ZUMBI = { -- Zumbi Event
	PositionTeleportOpen = Position(154, 51, 7), -- posicao de onde abrira o teleport para entrar no evento.
	TeleportTimeClose = 10, -- tempo que o tp ficara aberto (em minutes).
	PositionEnterEvent = Position(775, 100, 7), -- posicao de onde os players irao para dentro do evento.
	Reward = {2160, 10, "You won 100000 gold coins."}, -- recompensa: "itemid, quantidade, msg"
	TotalPlayers = Storage.Zumbi, -- global storage
	LevelMin = 50,
	storage = Storage.Zumbi,
}
