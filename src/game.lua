function game_load()
	gamestate = "player1"
	moviments_load()
	delaytime_load()
	aiming1_load()
	aiming2_load()
	player1_load()
	player2_load()
	shot1_load()
	shot2_load()
	floor_load()
	function love.mousepressed(x, y, button)
	if gamestate == "player1" and state == "game" then
		shot1_mousepressed(x, y, button)
	end
	if gamestate == "player2" and state == "game" then
		shot2_mousepressed(x, y, button)
	end
end

end

function game_update(dt)
	moviments_update(dt)
	delaytime_update(dt)
	aiming1_update(dt)
	aiming2_update(dt)
	player1_update(dt)
	player2_update(dt)
	shot1_update(dt)
	shot2_update(dt)
	floor_update(dt)
end

function game_draw()
	moviments_draw()
	delaytime_draw()
	aiming1_draw()
	aiming2_draw()
	player1_draw()
	player2_draw()
	shot1_draw()
	shot2_draw()
	floor_draw()
end

function love.mousepressed(x, y, button)
	if gamestate == "player1" and state == "game" then
		shot1_mousepressed(x, y, button)
	end
	if gamestate == "player2" and state == "game" then
		shot2_mousepressed(x, y, button)
	end
end
