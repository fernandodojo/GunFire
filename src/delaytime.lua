local delayfont = love.graphics.setNewFont("res/font/A-Space.otf", 18)
function delaytime_load()
	delay = {
	init = 31,
	temp = 31,
	print1 = 30
	}

	delayrandom={
	init = 10,
	temp = 10
	}

	star = {
	x = 400,
	y =100 ,
	speed = 10	 
	}

	--starimage = love.graphics.newImage("res/img/star.png")
	starimage = love.graphics.newImage("res/img/star2.png")
	staranimgrid = anim.newGrid(256,256,starimage:getWidth(), starimage:getHeight())
	staranim = anim.newAnimation(staranimgrid('1-17', 1),0.07)

	

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

	if star.x >= 50 and star.x <= 750 then 
		star.x = star.x +(7* vento) * dt
		if star.x < 50 then
			star.x = 50
		elseif star.x > 750 then
			star.x = 750
		end
	end
	if star.y >= 65 and star.y <= 250 then 
		star.y = star.y +(7* vento2) * dt
		if star.y < 65 then
			star.y = 65
		elseif star.y > 250 then
			star.y = 250
		end
	end
	--sentinel2.x =star.x + 400
	--sentinel2.y = star.y
	

	staranim:update(dt)
	--sentinel2anim:update(dt)
end

function delaytime_draw()
	love.graphics.setFont(delayfont)
	love.graphics.print(delay.print1, 395,25)
	if gamestate == "player1" then
		love.graphics.print("Player 1", 360, 0)
	elseif gamestate == "player2" then
		love.graphics.print("Player 2", 360, 0)
	end

	--love.graphics.circle("line", star.x, star.y, 10)
	--love.graphics.circle("line", sentinel2.x, sentinel2.y, 10)

	staranim:draw(starimage,star.x, star.y, 0, 0.5, 0.5, starimage:getWidth()/34,starimage:getHeight()/2)
	--sentinel2anim:draw(sentinel2image,sentinel2.x, sentinel2.y-5, 0, 0.11, 0.11, sentinel2image:getWidth()/6,sentinel2image:getHeight()/2)

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
