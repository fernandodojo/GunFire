local delayfont = love.graphics.setNewFont("res/font/A-Space.otf", 18)
function delaytime_load()
	delay = {
	init = 31,
	temp = 31,
	print1 = 30
	}

	delayrandom={
	init = 5,
	temp = 5
	}
end

function delaytime_update(dt)
	math.randomseed(os.time())-- AUXILIAR DE GERAÇÃO DE NUMERO ALEATÓRIO--
	if delay.temp >0 then
		delay.temp = delay.temp - dt
		delay.print1 = math.floor(delay.temp)
	elseif delay.temp <=0 then
		delay.temp = delay.init
		--random()
		if gamestate == "player1" then
			gamestate = "player2"
			strength2 = 0
			motionlimiter2 = 50
		elseif gamestate == "player2" then
			gamestate = "player1"
			strength1 = 0
			motionlimiter1 = 50			
		end
	end

	if delayrandom.temp > 0 then
		delayrandom.temp = delayrandom.temp - dt
	elseif delayrandom.temp<=0 then
		delayrandom.temp = delayrandom.init
		random()
	end
end

function delaytime_draw()
	love.graphics.setFont(delayfont)
	love.graphics.print(delay.print1, 395,25)
	if gamestate == "player1" then
		love.graphics.print("Player 1", 360, 0)
	elseif gamestate == "player2" then
		love.graphics.print("Player 2", 360, 0)
	end
	
	love.graphics.print("Vento", 580, 0)
	love.graphics.print(vento, 590,25)
	if vento> 0 then
		love.graphics.print("-->",615,25)
	elseif vento< 0 then
		love.graphics.print("<--",615,25)
	end
	
	love.graphics.print("Gravidade", 150, 0)
	love.graphics.print(gravity, 200,25)

	love.graphics.print(vento2, 0,0)
	love.graphics.print(delayrandom.temp, 0,50)
end
