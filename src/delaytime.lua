function delaytime_load()
	delay = {
	init = 6,
	temp = 6,
	print1 = 5
	}

	vento,gerador,gravity = 0,0,3
end

function delaytime_update(dt)
	math.randomseed(os.time())-- AUXILIAR DE GERAÇÃO DE NUMERO ALEATÓRIO--
	if delay.temp >0 then
		delay.temp = delay.temp - dt
		delay.print1 = math.floor(delay.temp)
	elseif delay.temp <=0 then
		delay.temp = delay.init
		random()
		if gamestate == "player1" then
			gamestate = "player2"
			strength2 = 0
			motionlimiter = 50
		elseif gamestate == "player2" then
			gamestate = "player1"
			strength1 = 0
			motionlimiter = 50			
		end
	end
end

function delaytime_draw()
	love.graphics.print(delay.print1, 395,25)
	if gamestate == "player1" then
		love.graphics.print("Player 1", 375, 0)
	elseif gamestate == "player2" then
		love.graphics.print("Player 2", 375, 0)
	end
	
	love.graphics.print("Vento", 460, 0)
	love.graphics.print(vento, 460,25)
	if vento> 0 then
		love.graphics.print("-->",475,25)
	elseif vento< 0 then
		love.graphics.print("<--",475,25)
	end
	
	love.graphics.print("Gravidade", 275, 0)
	love.graphics.print(gravity, 300,25)	
end
