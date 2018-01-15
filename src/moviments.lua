function moviments_load()
	motionlimiter1 = 50 --limitação de movimento de cada player por pixels
	motionlimiter2 = 50

	motion1 = { --barra q sinalização quanto o player ainda pode andar
	x = 75,
	y = 565,
	w = 300,
	h = 10
	}
	motion2= { --barra q sinalização quanto o player ainda pode andar
	x = 465,
	y = 565,
	w = 300,
	h = 10
	}

end

function moviments_update(dt)
	
	--[[condição que permitem a movimentaçãos dos jogadores apenas se estiverem dentro da area de movimentação, assim como distancia permitida por vez sobrando,
	 a respectiva vez do jogador e principalmente se o player não tiver feito nenhum disparo.]]
	if love.keyboard.isDown("a") and player1.x > -300 and motionlimiter1 >0  and gamestate == "player1" and movimentflag1 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then
		player1.x = player1.x - player1.speed * dt
		motionlimiter1 = motionlimiter1 - player1.speed * dt
		if play and noise then -- ativação do som ao realizar movimento
			movimentsound:play()
		end
		gameraflag1 = true -- ativação da flag de camera quando ocorre movimento do player1
	end
	if love.keyboard.isDown("d") and player1.x < 1050 and motionlimiter1 >0 and gamestate == "player1" and movimentflag1  and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then
		player1.x = player1.x + player1.speed * dt
		motionlimiter1 = motionlimiter1 - player1.speed * dt
		if play and noise then
			movimentsound:play()
		end
		gameraflag1 = true -- ativação da flag de camera quando ocorre movimento do player1
	end
	if love.keyboard.isDown("left") and player2.x > -300 and motionlimiter2 >0 and gamestate == "player2" and movimentsflag2 then
	--if love.keyboard.isDown("kp4") and player2.x > -300 and motionlimiter2 >0 and gamestate == "player2" and movimentsflag2 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then
		player2.x = player2.x - player2.speed * dt
		motionlimiter2 = motionlimiter2 - player1.speed * dt
		if play and noise then
			movimentsound:play()
		end
		gameraflag2 = true -- ativação da flag de camera quando ocorre movimento do player2
	end
	if love.keyboard.isDown("right") and player2.x < 1050 and motionlimiter2 >0 and gamestate == "player2" and movimentsflag2 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then
	--if love.keyboard.isDown("kp6") and player2.x < 1050 and motionlimiter2 >0 and gamestate == "player2" and movimentsflag2 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then
		player2.x = player2.x + player2.speed * dt
		motionlimiter2 = motionlimiter2 - player1.speed * dt
		if play and noise then
			movimentsound:play()
		end
		gameraflag2 = true -- ativação da flag de camera quando ocorre movimento do player2
	end

end

function moviments_draw()	
end