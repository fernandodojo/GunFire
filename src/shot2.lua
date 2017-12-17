function shot2_load()
	bullets2 = {}-- tabela de balas
	angle2 = 0 --declaração de variável para guardar o angulo de tiro
	shotnumber = 0 -- declaração de variável para guardar numero de tiros na tela
	strength2 = 0 -- declaração de variável para guardar força(velocidade) de lançamento da bala
	
	strengthline2 = {
	x = 460,
	y = 540,
	w = 300,
	h = 10
	}

	life2 = {
	x = nil,
	y = nil,
	w = 50,
	h = 5
	}

	maxheight2 = false
	decrelife2 = 0

end

function shot2_update(dt)
	--CALCULO PARA NIVEL DE DECRESCIMENTO DE VIDA--
	if maxheight2 then	
		decrelife2 = (10 * (strength2/300)* (gravity/5)) * 2
	else
		decrelife2 = (10 * (strength2/300)* (gravity/5))
	end
	--CALCULO PARA NIVEL DE DECRESCIMENTO DE VIDA--

	--condição para que regula quando vai haver incremento da força do tiro ao pressionar tecla "space", apenas quando for a vez de determinado jogador, impedindo o incremento da força do outro mesmo utilizando a mesma tecla
	if gamestate == "player2" then
		if love.keyboard.isDown("space") then
			if strength2 >=500 then
				strength2 = 500
			else
				strength2 = strength2 + 3
			end
		end
	end

	--BUG FIX--
	--Concerta impedimento de atirar quando é decrementado mais de 1 ao remover mais de 1 piso.
	if shotnumber < 0 then
		shotnumber = 0
	end
	-- BUG FIX--

	for i, v in ipairs (bullets2) do
		v.x = v.x + v.dx * dt ---(vento)--modificação de posição da bala atirando em direção ao mouse
		v.y = v.y + v.dy * dt
		v.dy = v.dy + gravity + vento-- implementação da gravidade
		v.dx = v.dx + vento

		if v.x> 790 or v.x < 10 or v.y > 600 or circlecolision(player1.x, player1.y, v.x, v.y, 19) then
			gamestate = "player1"			
			table.remove(bullets2, i)
			delay.temp = delay.init
			shotnumber = shotnumber - 1
			strength1 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.
			random()
			motionlimiter = 50
		end

		-- DECRESCIMENTO DE VIDA --
		if v.y< 100 then
			maxheight2 = true
		end 
		if circlecolision(player1.x, player1.y, v.x, v.y, 19) then --Decrescimento de vida quando detectado colisão da bala com o player
		  player1.life = player1.life - decrelife2
		end
		if circlecolision(player2.x, player2.y, v.x, v.y, 30) then --Decrescimento de vida quando detectado colisão da bala com o player
			player2.life = player2.life - 0.2	
		end
		-- DECRESCIMENTO DE VIDA --

		--REMOÇÃO BLOCO DE PISO --
		for k=0, 750, 50 do
	    	for l = 300, 480, 30 do
	    		if squarecollision(v.x-5, v.y-5,10, 10, k, l, w, h) and floor[k][l] ==1 then
	        		floor[k][l] = 0
	        		gamestate = "player1"	        		
	        		shotnumber = shotnumber - 1
	        		delay.temp = delay.init
					strength1 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.	        		
					table.remove(bullets2, i)
					random()
					maxheight2 = false
					motionlimiter = 500					
				end
	    	end
	  	end
  		--REMOÇÃO BLOCO DE PISO -- 
	end	
	--ATUALIZAÇÃO DA POSIÇÃO DA BARRA DE VIDA --
	life2.x = player2.x
	life2.y = player2.y - 35
	--ATUALIZAÇÃO DA POSIÇÃO DA BARRA DE VIDA --
end

function shot2_draw()
	for i, v in ipairs(bullets2) do
		love.graphics.circle("fill", v.x, v.y, 5)
		--love.graphics.rectangle("line", v.x-5, v.y-5, 10, 10)		
	end	

	-- BARRA DE VIDA -- 
	love.graphics.rectangle("line", life2.x, life2.y, life2.w, life2.h)
	love.graphics.rectangle("fill", life2.x, life2.y, player2.life/2, life2.h)
	-- BARRA DE VIDA -- 

	--BARRA DE VELOCIDADE--
	love.graphics.print(strength2, (strength2 + 762)/1.66, 550) -- impressão da força de tiro
	love.graphics.rectangle("line", strengthline2.x, strengthline2.y, strengthline2.w, strengthline2.h)
	love.graphics.rectangle("fill", strengthline2.x, strengthline2.y, strength2/1.66, strengthline2.h)
	--BARRA DE VELOCIDADE--

	--DEBUGGING AND OLD CODE--
	--love.graphics.print(tostring(maxheight2), 750,25)
	--love.graphics.print(decrelife2, 770,0)
	--love.graphics.print(angle1, 0, 60)
	--love.graphics.print(angle2, 0, 80)
	--love.graphics.print(player2.life, player2.x + 10, player2.y - 40) -- impressão da quantidade de vida abaixo do jogador
	--DEBUGGING AND OLD CODE--	
end

function shot2_mousepressed(x, y, button)
	--mx = x
	--my = y

	--angle2 = math.atan2(my-player2.y , mx - player2.x )

	direction2x = (strength2 - vento) * -math.cos(angle2)
	direction2y = (strength2 - vento) * -math.sin(angle2)

	if button == 1 and shotnumber == 0 then
		table.insert(bullets2, {x = x2, y = y2 , dx = direction2x, dy = direction2y})
		shotnumber = shotnumber + 1

		table.insert(bullets2, {x = x2, y = y2 , dx = direction2x, dy = direction2y+ 10})
	end
end
