function delaytime_load()
	delay = {
	init = 6,
	temp = 6,
	print1 = 5
	}

	vento = 0
	gerador = 0
	gravity = 3

end

function delaytime_update(dt)
	math.randomseed(os.time())-- AUXILIAR DE GERAÇÃO DE NUMERO ALEATÓRIO--
	if delay.temp >0 then
		delay.temp = delay.temp - dt
		delay.print1 = math.floor(delay.temp)
	elseif delay.temp <=0 then
		delay.temp = delay.init

		--GERADOR DE NUMEROA ALEATÓRIO--
		gerador = math.random(-5,10)
		if gerador < 0 then
		  vento = math.random(-5,5)
		  gravity = math.random(1,5)
		elseif gerador > 0 then
		  vento = 0
		  gravity = 3
		end
		--GERADOR DE NUMEROA ALEATÓRIO--

		if gamestate == "player1" then
			gamestate = "player2"
			strength2 = 0
		elseif gamestate == "player2" then
			gamestate = "player1"
			strength1 = 0			
		end
	end
end

function delaytime_draw()
	love.graphics.print(delay.print1, 375,100)
	if gamestate == "player1" then
		love.graphics.print("Player 1", 375, 75)
	elseif gamestate == "player2" then
		love.graphics.print("Player 2", 375, 75)
	end
	love.graphics.print(vento, 700,100)
	love.graphics.print("Vento", 700, 75)

	love.graphics.print(gravity, 600,100)
	love.graphics.print("Gravidade", 600, 75)

end
