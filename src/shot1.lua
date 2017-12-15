function shot1_load()
	bullets1 = {} -- tabela de balas
	angle1 = 0 --declaração de variável para guardar o angulo de tiro
	shotnumber = 0 -- declaração de variável para guardar numero de tiros na tela
	strength1 = 0 -- declaração de variável para guardar força(velocidade) de lançamento da bala
	
	strengthline1 = {
	x = 60,
	y = 540,
	w = 300,
	h = 10
	}

	life1 = {
	x = nil,
	y = nil,
	w = 50,
	h = 5
	}

	maxheight1 = false
	decrelife1 = 0

end

function shot1_update(dt)
	--CALCULO PARA NIVEL DE DECRESCIMENTO DE VIDA--
	if maxheight1 then	
		decrelife1 = (10 * (strength1/300)* (gravity/5)) * 2
	else
		decrelife1 = (10 * (strength1/300)* (gravity/5))
	end
	--CALCULO PARA NIVEL DE DECRESCIMENTO DE VIDA--

	--condição para que regula quando vai haver incremento da força do tiro ao pressionar tecla "space", apenas quando for a vez de determinado jogador, impedindo o incremento da força do outro mesmo utilizando a mesma tecla
	if gamestate == "player1" then 
		if love.keyboard.isDown("space") then
			if strength1 >=500 then
				strength1 = 500
			else
				strength1 = strength1 + 3
			end
		end
	end

	--BUG FIX--
	--Concerta impedimento de atirar quando é decrementado mais de 1 ao remover mais de 1 piso.
	if shotnumber < 0 then
		shotnumber = 0
	end
	-- BUG FIX--

	for i, v in ipairs(bullets1) do
		v.x = v.x + v.dx * dt --+ (vento) --modificação de posição da bala atirando em direção ao mouse no eixo x
		v.y = v.y + v.dy * dt --modificação de posição da bala atirando em direção ao mouse no eixo y
		v.dy = v.dy + gravity -- implementação da gravidade
		v.dx = v.dx + vento

		if v.x> 790 or v.x < 10 or v.y > 600 or circlecolision(player2.x, player2.y, v.x, v.y, 19) then
			gamestate = "player2"
			table.remove(bullets1, i)
			shotnumber = shotnumber - 1
			delay.temp = delay.init
			strength2 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.
			random()
			motionlimiter = 50
		end
		
		-- DECRESCIMENTO DE VIDA --
		if v.y< 100 then
			maxheight1 = true
		end		
		if circlecolision(player2.x, player2.y, v.x, v.y, 19) then --Decrescimento de vida quando detectado colisão da bala com o player
			player2.life = player2.life - decrelife1
		end
		if circlecolision(player1.x, player1.y, v.x, v.y, 30)  then --Decrescimento de vida quando detectado colisão da bala com o player		
			player1.life = player1.life - 0.2		
		end
		-- DECRESCIMENTO DE VIDA --

		--REMOÇÃO BLOCO DE PISO --
		for k=0, 750, 50 do
	    	for l = 300, 480, 30 do
	    		if squarecolission(v.x, v.y,5, k, l, w, h) and floor[k][l] ==1 then
	        		floor[k][l] = 0
		        	gamestate = "player2"						
					shotnumber = shotnumber - 1
					delay.temp = delay.init
					strength2 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.	        		
					table.remove(bullets1, i)
					random()
					maxheight1 = false
					motionlimiter = 50		      		
		      	end
	    	end
	  	end
  		--REMOÇÃO BLOCO DE PISO --
	end
	--ATUALIZAÇÃO DA POSIÇÃO DA BARRA DE VIDA --
	life1.x = player1.x - 50 
	life1.y = player1.y - 35
	--ATUALIZAÇÃO DA POSIÇÃO DA BARRA DE VIDA --
end

function shot1_draw()
	for i, v in ipairs(bullets1) do
		love.graphics.circle("fill", v.x, v.y, 5)		
	end	

	-- BARRA DE VIDA -- 
	love.graphics.rectangle("line", life1.x, life1.y, life1.w, life1.h)
	love.graphics.rectangle("fill", life1.x, life1.y, player1.life/2, life1.h)
	-- BARRA DE VIDA --

	--BARRA DE VELOCIDADE--
	love.graphics.print(strength1, (strength1 + 98)/1.66, 550)	--
	love.graphics.rectangle("line", strengthline1.x, strengthline1.y, strengthline1.w, strengthline1.h)
	love.graphics.rectangle("fill", strengthline1.x, strengthline1.y, strength1/1.66, strengthline1.h)
	--BARRA DE VELOCIDADE--

	--DEBUGGING AND OLD CODE--
	--love.graphics.print(tostring(maxheight1), 0,25)
	--love.graphics.print(decrelife1, 0,0)
	--love.graphics.print(angle1, 0, 30)
	--love.graphics.print(angle2, 0, 60)
	--love.graphics.print(player1.life, player1.x - 30, player1.y - 40) -- impressão da quantidade de vida abaixo do jogador
	--DEBUGGING AND OLD CODE--
end

function shot1_mousepressed(x, y, button)
	mx = x
	my = y

	angle1 = math.atan2(my-player1.y , mx - player1.x )

	direction1x = (strength1 + vento) * math.cos(angle1)
	direction1y = (strength1+ vento) * math.sin(angle1)	

	if button == 1 and shotnumber ==0 then
		table.insert (bullets1 , {x = player1.x, y = player1.y -32, dx = direction1x, dy = direction1y})
		shotnumber = shotnumber + 1
		
		table.insert (bullets1 , {x = player1.x, y = player1.y -32, dx = direction1x, dy = direction1y+10 })	
	end
end
