function moviments_load()
	motionlimiter = 50
end

function moviments_update(dt)
	if love.keyboard.isDown("a") and player1.x > 0 and motionlimiter >0  and gamestate == "player1" then
		player1.x = player1.x - player1.speed * dt
		motionlimiter = motionlimiter - player1.speed * dt
	end
	if love.keyboard.isDown("d") and player1.x < 800 and motionlimiter >0 and gamestate == "player1" then
		player1.x = player1.x + player1.speed * dt
		motionlimiter = motionlimiter - player1.speed * dt
	end
	if love.keyboard.isDown("left") and player2.x > 0 and motionlimiter >0 and gamestate == "player2"then
		player2.x = player2.x - player2.speed * dt
		motionlimiter = motionlimiter - player1.speed * dt
	end
	if love.keyboard.isDown("right") and player2.x < 800 and motionlimiter >0 and gamestate == "player2"then
		player2.x = player2.x + player2.speed * dt
		motionlimiter = motionlimiter - player1.speed * dt
	end

end

function moviments_draw()
	
end