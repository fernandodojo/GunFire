gamefont = love.graphics.setNewFont("res/font/A-Space.otf", 13)
function game_load()
	mx = 0
	my = 0
	gravity = 4
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
	backgroud = love.graphics.newImage("res/img/background.png")
	mainsound = love.audio.newSource("res/sound/mainsoundtrack.wav")
	function love.keypressed(key)
		if gamestate == "player1" and state == "game" then
			shot1_keypressed(key)
		end
		if gamestate == "player2" and state == "game" then
			shot2_keypressed(key)
		end
		if key == "escape" then
		love.event.quit()
		end
	end

	function love.mousepressed(x, y, button)		
	end
end

function game_update(dt)
	mainsound:play()
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
	love.graphics.setFont(gamefont)
	love.graphics.draw(backgroud,0, 0)
	moviments_draw()
	delaytime_draw()
	aiming1_draw()
	aiming2_draw()
	floor_draw()
	player1_draw()
	player2_draw()
	shot1_draw()
	shot2_draw()			
end
