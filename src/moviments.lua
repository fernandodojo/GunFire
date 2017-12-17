function moviments_load()
	motionlimiter1 = 50
	motionlimiter2 = 50

	motion1 = {
	x = 75,
	y = 565,
	w = 300,
	h = 10
	}
	motion2= {
	x = 475,
	y = 565,
	w = 300,
	h = 10
	}

end

function moviments_update(dt)
	if love.keyboard.isDown("a") and player1.x > 0 and motionlimiter1 >0  and gamestate == "player1" then
		player1.x = player1.x - player1.speed * dt
		motionlimiter1 = motionlimiter1 - player1.speed * dt
	end
	if love.keyboard.isDown("d") and player1.x < 800 and motionlimiter1 >0 and gamestate == "player1" then
		player1.x = player1.x + player1.speed * dt
		motionlimiter1 = motionlimiter1 - player1.speed * dt
	end
	if love.keyboard.isDown("left") and player2.x > 0 and motionlimiter2 >0 and gamestate == "player2"then
		player2.x = player2.x - player2.speed * dt
		motionlimiter2 = motionlimiter2 - player1.speed * dt
	end
	if love.keyboard.isDown("right") and player2.x < 800 and motionlimiter2 >0 and gamestate == "player2"then
		player2.x = player2.x + player2.speed * dt
		motionlimiter2 = motionlimiter2 - player1.speed * dt
	end

end

function moviments_draw()
	--BARRA DE MOVIMENTO--
	love.graphics.rectangle("line", motion1.x, motion1.y, motion1.w, motion1.h)
	love.graphics.rectangle("fill", motion1.x, motion1.y, motionlimiter1*6, motion1.h)
	--BARRA DE MOVIMENTO--

	--BARRA DE FORÇA--
	love.graphics.rectangle("line", motion2.x, motion2.y, motion2.w, motion2.h)
	love.graphics.rectangle("fill", motion2.x, motion2.y, motionlimiter2*6, motion2.h)
	--BARRA DE FORÇA--
	
end