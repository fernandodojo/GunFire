local delayfont = love.graphics.setNewFont("res/font/A-Space.otf", 18)
function delaytime_load()
	delay = {
	init = 31,
	temp = 31,
	print1 = 30
	}

	delayrandom={
	init = 15,
	temp = 15
	}

	arrows={
	left = love.graphics.newImage("res/img/left.png"),
	right = love.graphics.newImage("res/img/right.png"),
	up = love.graphics.newImage("res/img/up.png"),
	down = love.graphics.newImage("res/img/down.png"),
	downleft = love.graphics.newImage("res/img/downleft.png"),
	upleft = love.graphics.newImage("res/img/upleft.png"),
	downright = love.graphics.newImage("res/img/downright.png"),
	upright = love.graphics.newImage("res/img/upright.png"),
	fastleft = love.graphics.newImage("res/img/fastleft.png"),
	fastright = love.graphics.newImage("res/img/fastright.png"),
	fastdown = love.graphics.newImage("res/img/fastdown.png"),
	fastdownleft = love.graphics.newImage("res/img/fastdownleft.png"),
	fastupleft = love.graphics.newImage("res/img/fastupleft.png"),
	fastdownright = love.graphics.newImage("res/img/fastdownright.png"),
	fastupright = love.graphics.newImage("res/img/fastupright.png"),
	fastdowndownright = love.graphics.newImage("res/img/fastdowndownright.png"),
	fastdowndownleft = love.graphics.newImage("res/img/fastdowndownleft.png"),
	}
end

function delaytime_update(dt)
	math.randomseed(os.time())-- AUXILIAR DE GERAÇÃO DE NUMERO ALEATÓRIO--
	if delay.temp >0 then
		delay.temp = delay.temp - dt
		delay.print1 = math.floor(delay.temp)
	elseif delay.temp <=0 then
		delay.temp = delay.init
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
	
	if vento2 == -1 then
		if vento == 0 then
			love.graphics.draw(arrows.up,605,25, 0, 0.3)
		elseif vento == 1 then
			love.graphics.draw(arrows.upright,605,25, 0, 0.3)
		elseif vento == -1 then
			love.graphics.draw(arrows.upleft,605,25, 0, 0.3)
		elseif vento == 2 then
			love.graphics.draw(arrows.fastupright,605,25, 0, 0.3)
		elseif vento == -2  then
			love.graphics.draw(arrows.fastupleft,605,25, 0, 0.3)
		end		
	elseif vento2 == 0 then
		if vento ==-1 then
			love.graphics.draw(arrows.left,605,25, 0, 0.3)
		elseif vento == 1 then
			love.graphics.draw(arrows.right,605,25, 0, 0.3)
		elseif vento == -2 then
		love.graphics.draw(arrows.fastleft,605,25, 0, 0.3)
		elseif vento == 2 then
		love.graphics.draw(arrows.fastright,605,25, 0, 0.3)
		end
	elseif vento2 == 1 then
		if vento == 0 then
		love.graphics.draw(arrows.down,605,25, 0, 0.3)
		elseif vento ==1 then
		love.graphics.draw(arrows.downright,605,25, 0, 0.3)
		elseif vento== -1 then
		love.graphics.draw(arrows.downleft,605,25, 0, 0.3)
		elseif vento ==2 then
		love.graphics.draw(arrows.fastdownright,605,25, 0, 0.3)
		elseif vento== -2 then
		love.graphics.draw(arrows.fastdownleft,605,25, 0, 0.3)
		end
	elseif vento2 ==2 then
		if vento == 0 then
		love.graphics.draw(arrows.fastdown,605,25, 0, 0.3)
		elseif vento ==2  then
		love.graphics.draw(arrows.fastdowndownright,605,25, 0, 0.3)
		elseif vento== -2 then
		love.graphics.draw(arrows.fastdowndownleft,605,25, 0, 0.3)
		end		
	end
end
