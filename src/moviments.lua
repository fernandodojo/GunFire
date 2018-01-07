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
	x = 465,
	y = 565,
	w = 300,
	h = 10
	}

end

function moviments_update(dt)
	
	if love.keyboard.isDown("a") and player1.x > -300 and motionlimiter1 >0  and gamestate == "player1" and movimentflag1 then
		player1.x = player1.x - player1.speed * dt
		motionlimiter1 = motionlimiter1 - player1.speed * dt
		if play and noise then
			movimentsound:play()
		end
		gameraflag1 = true
	end
	if love.keyboard.isDown("d") and player1.x < 1050 and motionlimiter1 >0 and gamestate == "player1" and movimentflag1 then
		player1.x = player1.x + player1.speed * dt
		motionlimiter1 = motionlimiter1 - player1.speed * dt
		if play and noise then
			movimentsound:play()
		end
		gameraflag1 = true
	end
	--if love.keyboard.isDown("left") and player2.x > -300 and motionlimiter2 >0 and gamestate == "player2" and movimentsflag2 then
	if love.keyboard.isDown("kp4") and player2.x > -300 and motionlimiter2 >0 and gamestate == "player2" and movimentsflag2 then
		player2.x = player2.x - player2.speed * dt
		motionlimiter2 = motionlimiter2 - player1.speed * dt
		if play and noise then
			movimentsound:play()
		end
		gameraflag2 = true
	end
	--if love.keyboard.isDown("right") and player2.x < 1050 and motionlimiter2 >0 and gamestate == "player2" and movimentsflag2 then
	if love.keyboard.isDown("kp6") and player2.x < 1050 and motionlimiter2 >0 and gamestate == "player2" and movimentsflag2 then
		player2.x = player2.x + player2.speed * dt
		motionlimiter2 = motionlimiter2 - player1.speed * dt
		if play and noise then
			movimentsound:play()
		end
		gameraflag2 = true
	end

end

function moviments_draw()	
end