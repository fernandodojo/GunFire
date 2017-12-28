gamefont = love.graphics.setNewFont("res/font/A-Space.otf", 13)
function game_load()
	play = true
	volume = 0.5
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
	mainsound = love.audio.newSource("res/sound/mainsoundtrack.ogg")
	shotsound = love.audio.newSource("res/sound/shot1.wav")
	movimentsound = love.audio.newSource("res/sound/shipmoviment.ogg")
	loadingsound = love.audio.newSource("res/sound/loading.ogg")
	aimsound = love.audio.newSource("res/sound/aimsound.ogg")
	

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
	moviments_update(dt)
	delaytime_update(dt)
	aiming1_update(dt)
	aiming2_update(dt)
	player1_update(dt)
	player2_update(dt)
	shot1_update(dt)
	shot2_update(dt)
	floor_update(dt)

	if love.keyboard.isDown("m") then		
		play = false

	end
	if love.keyboard.isDown("n") then		
		play = true
	end

	if love.keyboard.isDown("o") then
		volume = volume + 0.01
		if volume >= 1.0 then
			volume = 1.0
		end
	end
	if love.keyboard.isDown("l") then
		volume = volume - 0.01
		if volume <= 0.0 then
			volume = 0.0
		end
	end

	love.audio.setVolume( volume )


	if play then
		mainsound:play()
	end
	if not play then
		mainsound:pause()
	end
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

	if love.keyboard.isDown("o")  or love.keyboard.isDown("l") then
		love.graphics.rectangle("line", 50, 50, 10, 100)
		love.graphics.rectangle("fill", 50, 150,10, volume*-100)
		love.graphics.print(math.ceil(volume*10), 30,48 )
	end		
end



