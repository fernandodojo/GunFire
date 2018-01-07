gamefont = love.graphics.setNewFont("res/font/A-Space.otf", 13)
function game_load()
	cam = gamera.new(-3000,-600,6800,2000)
	cam:setScale(1.0)	
	play = true
	noise = true
	volume = 0.5
	mx = 0
	my = 0
	gravity = 4
	gamestate = "player1"
	ui_load()
	moviments_load()
	delaytime_load()
	aiming1_load()
	aiming2_load()
	player1_load()
	player2_load()
	shot1_load()
	shot2_load()
	floor_load()
	backgroud = love.graphics.newImage("res/img/background.jpg")
	speaker = love.graphics.newImage("res/img/speaker.png")
	nospeaker = love.graphics.newImage("res/img/nospeaker.png")
	mainsound = love.audio.newSource("res/sound/mainsoundtrack.ogg")
	shotsound = love.audio.newSource("res/sound/shot1.ogg")
	movimentsound = love.audio.newSource("res/sound/shipmoviment.ogg")
	loadingsound = love.audio.newSource("res/sound/loading.ogg")
	aimsound = love.audio.newSource("res/sound/aimsound.ogg")

	delayvolume = 3
	delayvolumeinit = 3
	volumeflag = false

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
		if key == "m" then
			if play == false then
			play = true
			elseif play then
				play = false
			end
		end
		if key == "n" then
			if noise == false then
			noise = true
			elseif noise then
				noise = false
			end
		end
	end

	function love.mousepressed(x, y, button)		
	end	
end

function game_update(dt)
	ui_update(dt)		
	moviments_update(dt)
	delaytime_update(dt)
	aiming1_update(dt)
	aiming2_update(dt)
	player1_update(dt)
	player2_update(dt)
	shot1_update(dt)
	shot2_update(dt)
	floor_update(dt)

	if delayvolume > 0 then
		delayvolume =  delayvolume - dt
	elseif delayvolume <= 0  then 
		delayvolume = delayvolumeinit
		volumeflag = false
	end

	if love.keyboard.isDown("l") then
		volumeflag = true
		volume = volume + 0.01
		if volume >= 1.0 then
			volume = 1.0
		end
	end
	if love.keyboard.isDown("k") then
		volumeflag = true
		volume = volume - 0.01
		if volume <= 0.0 then
			volume = 0.0
		end
	end

	love.audio.setVolume( volume )


	if play and noise then
		mainsound:play()
	end
	if not play or not noise then
		mainsound:pause()
	end

	if shotnumber == 0 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then
		cam:setPosition(400, 300)
	end
	if gamestate == "player1" and  gameraflag1 and shotnumber == 0 then --love.keyboard.isDown("lshift")
		cam:setPosition(player1.x, player1.y)
	end
	if gamestate == "player2" and gameraflag2 and shotnumber == 0 then --love.keyboard.isDown("up")
		cam:setPosition(player2.x, player2.y)
	end
end

function game_draw()
	love.graphics.setFont(gamefont)	
	cam:draw(function()
		love.graphics.setFont(gamefont)
		love.graphics.draw(backgroud,-3000, -600)			
		moviments_draw()
		delaytime_draw()
		aiming1_draw()
		aiming2_draw()
		floor_draw()
		player1_draw()
		player2_draw()	
		shot1_draw()
		shot2_draw()
	end)	
	ui_draw()	

	if volumeflag then		
		love.graphics.rectangle("line", 50, 50, 10, 100)
		love.graphics.rectangle("fill", 50, 150,10, volume*-100)
		love.graphics.print(math.ceil(volume*10), 30,48 )
	end
	if volume <=0 or not play then
		love.graphics.draw(nospeaker, 10, 0)
	end
end



