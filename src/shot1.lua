local bullets1image, bullets1anim

function shot1_load()
	bullets1 = {} -- tabela de balas
	shotnumber = 0 -- declaração de variável para guardar numero de tiros na tela
	strength1 = 0 -- declaração de variável para guardar força(velocidade) de lançamento da bala
	
	strengthline1 = {
	x = 75,
	y = 530,
	w = 300,
	h = 14
	}

	life1 = {
	x = nil,
	y = nil,
	w = 50,
	h = 5
	}

	decrelife1 = 0

	--delay de impressão
	delayprintinit1 = 3
	delayprinttemp1 = 3
	printflag1 = false		
	--delay de impressão

	--delay de impressão
	delayprintinitself1 = 3
	delayprinttempself1 = 3
	printflagself1 = false		
	--delay de impressão

	bullets1image = love.graphics.newImage("/res/img/bullets1.png")
	local bullets1animgrid = anim.newGrid(256,256,bullets1image:getWidth(), bullets1image:getHeight())
	bullets1anim = anim.newAnimation(bullets1animgrid('1-8',1, '1-8', 2), 0.03)	
end

function shot1_update(dt)
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--
	if printflag1 == true and delayprinttemp1 > 0 then
		delayprinttemp1 = delayprinttemp1 - dt
	elseif 	delayprinttemp1 <= 0 then
		delayprinttemp1 = delayprintinit1
		printflag1 = false	
	end
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--

	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--
	if printflagself1 == true and delayprinttempself1 > 0 then
		delayprinttempself1 = delayprinttempself1 - dt
	elseif 	delayprinttempself1 <= 0 then
		delayprinttempself1 = delayprintinitself1
		printflagself1 = false	
	end
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--
	
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

	for i, v in ipairs (bullets1) do
		v.x = v.x + v.dx * dt --+ (vento) --modificação de posição da bala atirando em direção ao mouse no eixo x
		v.y = v.y + v.dy * dt --modificação de posição da bala atirando em direção ao mouse no eixo y
		v.dy = v.dy + gravity + vento2 -- implementação da gravidade
		v.dx = v.dx + vento				

		if v.x> 790 or v.x < 10 or v.y > 600 or circlecolision(player2.x, player2.y, v.x, v.y, 20) then
			gamestate = "player2"
			table.remove(bullets1, i)
			shotnumber = shotnumber - 1
			delay.temp = delay.init
			strength2 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.
			motionlimiter1 = 50
		end
		
		-- DECRESCIMENTO DE VIDA --
		decrelife1 = (strength1/100 + v.dy/100) 				
		if circlecolision(player2.x, player2.y, v.x, v.y, 21) then --Decrescimento de vida quando detectado colisão da bala com o player
			player2.life = player2.life - decrelife1
			printflag1 = true
		end
		if circlecolision(player1.x, player1.y, v.x, v.y, 25)  then --Decrescimento de vida quando detectado colisão da bala com o player		
			player1.life = player1.life - decrelife1/15
			printflagself1 = true
		end
		-- DECRESCIMENTO DE VIDA --

		--REMOÇÃO BLOCO DE PISO --
		for k=0, 750, 50 do
	    	for l = 300, 480, 30 do
	    		if squarecollision(v.x-5, v.y-5, 10, 10, k, l, w, h) and floor[k][l] ==1 then
	        		floor[k][l] = 0
		        	gamestate = "player2"						
					shotnumber = shotnumber - 1
					delay.temp = delay.init
					strength2 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.	        		
					table.remove(bullets1, i)					
					maxheight1 = false
					motionlimiter1 = 50		      		
		      	end
	    	end
	  	end
  		--REMOÇÃO BLOCO DE PISO --
	end

	--ATUALIZAÇÃO DA POSIÇÃO DA BARRA DE VIDA --
	life1.x = player1.x - 50 
	life1.y = player1.y - 35
	--ATUALIZAÇÃO DA POSIÇÃO DA BARRA DE VIDA --

	bullets1anim:update(dt)
end

function shot1_draw()
	love.graphics.setFont(gamefont)
	for i, v in ipairs(bullets1) do
		bullets1anim:draw(bullets1image,v.x, v.y, 0, 0.3, 0.3, bullets1image:getWidth()/16,bullets1image:getHeight()/16)	
	end	

	-- BARRA DE VIDA --
	love.graphics.setColor(190, 0, 0) 
	love.graphics.rectangle("line", life1.x, life1.y, life1.w, life1.h)
	love.graphics.rectangle("fill", life1.x, life1.y, player1.life/2, life1.h)
	love.graphics.setColor(255,255,255)
	-- BARRA DE VIDA --

	-- DECRESCIMENTO DE VIDA --
	love.graphics.setColor(255,0,0)
	if printflag1 == true then		
		love.graphics.print(math.floor(player2.life), player2.x + 15, player2.y - 65)
	end
	love.graphics.setColor(255,255,255)
	-- DECRESCIMENTO DE VIDA --

	-- DECRESCIMENTO DE VIDA --
	love.graphics.setColor(255,0,0)
	if printflagself1 == true then		
		love.graphics.print(math.floor(player1.life), player1.x -15, player1.y - 65)
	end
	love.graphics.setColor(255,255,255)
	-- DECRESCIMENTO DE VIDA --

	--BARRA DE FORÇA--	
	love.graphics.print(strength1, (strength1 + 126)/1.66, 531)	
	love.graphics.setColor(216, 136, 32)
	love.graphics.rectangle("line", strengthline1.x, strengthline1.y, strengthline1.w, strengthline1.h)
	love.graphics.rectangle("fill", strengthline1.x, strengthline1.y, strength1/1.66, strengthline1.h)
	love.graphics.setColor(255,255,255)
	--BARRA DE FORÇA--

	--MOSTRADOR DE ANGULO--
	love.graphics.print(math.ceil(math.deg(-angle1)).."º", x1, y1 - 30)
	--MOSTRADOR DE ANGULO--

	--DEBUGGING AND OLD CODE--
	--love.graphics.print(decrelife1, 0,0)	
	--love.graphics.print(angle2, 0, 60)
	--love.graphics.print(player1.life, player1.x - 30, player1.y - 40) -- impressão da quantidade de vida abaixo do jogador
	--DEBUGGING AND OLD CODE--	
end

function shot1_mousepressed(x, y, button)
	--DEBUGGING AND OLD CODE--
	--mx = x
	--my = y
	--angle = math.atan2(x1-player1.y , y1 - player1.x )
	--DEBUGGING AND OLD CODE--

	direction1x = (strength1 + vento) * math.cos(angle1)
	direction1y = (strength1+ vento) * math.sin(angle1)	

	if button == 1 and shotnumber ==0 then
		table.insert (bullets1 , {x = x1, y = y1, dx = direction1x, dy = direction1y})
		shotnumber = shotnumber + 1		
		
		table.insert (bullets1 , {x = x1, y = y1, dx = direction1x - 5, dy = direction1y-20})		
	end
end