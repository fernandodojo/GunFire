delayfont = love.graphics.setNewFont("res/font/A-Space.otf", 18)
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

	starimage = love.graphics.newImage("res/img/star2.png")
	staranimgrid = anim.newGrid(256,256,starimage:getWidth(), starimage:getHeight())
	staranim = anim.newAnimation(staranimgrid('1-17', 1),0.07)
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
		star.x = star.x +(7* ventohorizontal) * dt
		if star.x < 50 then
			star.x = 50
		elseif star.x > 750 then
			star.x = 750
		end
	end
	if star.y >= 65 and star.y <= 250 then 
		star.y = star.y +(7* ventovertical) * dt
		if star.y < 65 then
			star.y = 65
		elseif star.y > 250 then
			star.y = 250
		end
	end
	staranim:update(dt)
end

function delaytime_draw()
	--love.graphics.circle("line", star.x, star.y, 10)
	staranim:draw(starimage,star.x, star.y, 0, 0.5, 0.5, starimage:getWidth()/34,starimage:getHeight()/2)
end
