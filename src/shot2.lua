function shot2_load()
	bullets2 = {}
	angle2 = 0
	shotnumber = 0
	strength2 = 0
	gravity = 5

end

function shot2_update(dt)
	--condição para que regula quando vai haver incremento da força do tiro ao pressionar tecla "space", apenas quando for a vez de determinado jogador, impedindo o incremento da força do outro mesmo utilizando a mesma tecla
	if gamestate == "player2" then
		if love.keyboard.isDown("space") then
			if strength2 >=500 then
				strength2 = 500
			else
				strength2 = strength2 + 10
			end
		end
	end

	for i, v in ipairs (bullets2) do
		v.x = v.x + v.dx * dt --modificação de posição da bala atirando em direção ao mouse
		v.y = v.y + v.dy * dt
		v.dy = v.dy + gravity -- implementação da gravidade

		if v.x> 790 or v.x < 10 or v.y > 600 or circlecolision(player1.x, player1.y, v.x, v.y, 18) then
			gamestate = "player1"
			table.remove(bullets2, i)
			shotnumber = shotnumber - 1
			strength1 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.
		end
		if circlecolision(player1.x, player1.y, v.x, v.y, 18) then --Decrescimento de vida quando detectado colisão da bala com o player
		  player1.life = player1.life - 10
		end
		--Remoção de bloco do piso
		for k=10, 790, 20 do
	    	for l = 300, 400, 20 do
	    		if circlecolision(v.x, v.y, k, l, 10 + circle.r) and floor[k][l] ==1 then
	        		floor[k][l] = 0
	        		gamestate = "player1"
	        		shotnumber = shotnumber - 1
					strength1 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.	        		
					table.remove(bullets2, i)					
				end
	    	end
	  	end
  		--Remoção de bloco do piso
	end


end

function shot2_draw()
	for i,v in ipairs(bullets2) do
		love.graphics.circle("fill", v.x, v.y, 10)
		if circlecolision(player1.x, player1.y, v.x, v.y, 20) then
			love.graphics.print("ok", 400, 0)
			--gamestate = "player1"
		end
	end

	--love.graphics.print(angle1, 0, 60)
	--love.graphics.print(angle2, 0, 80)
	love.graphics.print(strength2, 730, 550) -- impressão da força de tiro
	love.graphics.print(player2.life, player2.x + 10, player2.y - 40) -- impressão da quantidade de vida abaixo do jogador


end

function shot2_mousepressed(x, y, button)
	mx = x
	my = y

	angle2 = math.atan2(my-player2.y , mx - player2.x )

	direction2x = strength2 * math.cos(angle2)
	direction2y = strength2 * math.sin(angle2)

	if button == 1 and shotnumber == 0 then
		table.insert(bullets2, {x = player2.x, y = player2.y , dx = direction2x, dy = direction2y})
		shotnumber = shotnumber + 1


	end
end
