function shot1_load()
	bullets1 = {}
	angle1 = 0
	shotnumber = 0
	strength1 = 0
	gravity = 5


end

function shot1_update(dt)
	--condição para que regula quando vai haver incremento da força do tiro ao pressionar tecla "space", apenas quando for a vez de determinado jogador, impedindo o incremento da força do outro mesmo utilizando a mesma tecla
	if gamestate == "player1" then
		if love.keyboard.isDown("space") then
			if strength1 >=500 then
				strength1 = 500
			else
				strength1 = strength1 + 10
			end
		end
	end

	for i, v in ipairs(bullets1) do
		v.x = v.x + v.dx * dt --modificação de posição da bala atirando em direção ao mouse
		v.y = v.y + v.dy * dt
		v.dy = v.dy + gravity -- implementação da gravidade

		if v.x> 790 or v.x < 10 or v.y > 600 or circlecolision(player2.x, player2.y, v.x, v.y, 18) then
			gamestate = "player2"
			table.remove(bullets1, i)
			shotnumber = shotnumber - 1
			strength2 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.
		end
		if circlecolision(player2.x, player2.y, v.x, v.y, 18) then --Decrescimento de vida quando detectado colisão da bala com o player
			player2.life = player2.life - 10
		end

		--Remoção de bloco do piso
		for k=10, 810, 30 do
	    	for l = 300, 400, 30 do
	    		if circlecolision(v.x, v.y, k, l, 10 + circle.r) and floor[k][l] ==1 then
	        		floor[k][l] = 0
		        	gamestate = "player2"						
					shotnumber = shotnumber - 1
					strength2 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.	        		
					table.remove(bullets1, i)
		      		
		      	end
	    	end
	  	end
  		--Remoção de bloco do piso
	end



end

function shot1_draw()
	for i, v in ipairs(bullets1) do
		love.graphics.circle("fill", v.x, v.y, 10)
		if circlecolision(player2.x, player2.y, v.x, v.y, 20) then
			love.graphics.print("ok2", 400, 40)
			--gamestate = "player2"
		end
	end

	--love.graphics.print(angle1, 0, 30)
	--love.graphics.print(angle2, 0, 60)
	love.graphics.print(strength1, 50, 550) -- impressão da força de tiro
	love.graphics.print(player1.life, player1.x - 30, player1.y - 40) -- impressão da quantidade de vida abaixo do jogador


end

function shot1_mousepressed(x, y, button)
	mx = x
	my = y

	angle1 = math.atan2(my-player1.y , mx - player1.x )

	direction1x = strength1 * math.cos(angle1)
	direction1y = strength1 * math.sin(angle1)

	if button == 1 and shotnumber == 0 then

		table.insert (bullets1 , {x = player1.x, y = player1.y, dx = direction1x , dy = direction1y})
		shotnumber = shotnumber + 1

		--gamestate = "player2"
	end
end
