local bullets2image, bullets2anim

function shot2_load()
	bullets2 = {}-- tabela de balas
	shotnumber = 0 -- declaração de variável para guardar numero de tiros na tela
	strength2 = 0 -- declaração de variável para guardar força(velocidade) de lançamento da bala
	
	strengthline2 = {
	x = 465,
	y = 530,
	w = 300,
	h = 14
	}

	life2 = {
	x = nil,
	y = nil,
	w = 50,
	h = 5
	}

	pontox2 = 0
	pontoy2 = 0

	decrelife2 = 0
	damage2 = 0
	selfdamage2 = 0

	--delay de impressão
	delayprintinit2 = 3
	delayprinttemp2 = 3
	printflag2 = false
	--delay de impressão

	--delay de impressão
	delayprintinitself2 = 3
	delayprinttempself2 = 3
	printflagself2 = false		
	--delay de impressão

	--delay de impressão de dano no piso
	delayfloorflag2 = 3
	delayfloorflaginit2 = 3
	printfloorflag2 = false		
	--delay de impressão de dano no piso

	bullets2image = love.graphics.newImage("/res/img/bullets2.png")
	local bullets2animgrid = anim.newGrid(256,256,bullets2image:getWidth(), bullets2image:getHeight())
	bullets2anim = anim.newAnimation(bullets2animgrid('1-8',1, '1-8', 2), 0.03)

	explosion2image = love.graphics.newImage("/res/img/bullets2.png")
	local explosion2animgrid = anim.newGrid(256,256,explosion2image:getWidth(), explosion2image:getHeight())
	explosion2anim = anim.newAnimation(explosion2animgrid('1-8',3, '1-8',4, '1-8', 5, '1-8',6, '1-8', 7, '1-8',8), 0.1)
end

function shot2_update(dt)
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--
	if printflag2 == true  and delayprinttemp2 > 0 then
		delayprinttemp2 = delayprinttemp2 - dt
	elseif 	delayprinttemp2 <= 0 then
		delayprinttemp2 = delayprintinit2
		printflag2 = false
		damage2 = 0
	end
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--

	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--
	if printflagself2 == true and delayprinttempself2 > 0 then
		delayprinttempself2 = delayprinttempself2 - dt
	elseif 	delayprinttempself2 <= 0 then
		delayprinttempself2 = delayprintinitself2
		printflagself2 = false
		selfdamage2 = 0	
	end
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--

	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO EM SI MESMO--
	if printfloorflag2 == true and delayfloorflag2 > 0 then
		delayfloorflag2 = delayfloorflag2 - dt
	elseif 	delayfloorflag2 <= 0 then
		delayfloorflag2 = delayfloorflaginit2
		printfloorflag2 = false
	end
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO EM SI MESMO--
	
	--condição para que regula quando vai haver incremento da força do tiro ao pressionar tecla "space", apenas quando for a vez de determinado jogador, impedindo o incremento da força do outro mesmo utilizando a mesma tecla
	if gamestate == "player2" then
		if love.keyboard.isDown("up") then
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
		v.dy = v.dy + gravity + vento2-- implementação da gravidade
		v.dx = v.dx + vento

		pontox2 = v.x
		pontoy2 = v.y

		if v.x> 790 or v.x < 10 or v.y > 600 or circlecolision(player1.x, player1.y, v.x, v.y, 20) or circlecolision(player2.x, player2.y, v.x, v.y, 25) then
			gamestate = "player1"
			delay.temp = delay.init
			shotnumber = shotnumber - 1
			strength1 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.
			motionlimiter2 = 50
			table.remove(bullets2, i)
		end

		-- DECRESCIMENTO DE VIDA --		
		decrelife2 = (strength2/100 + v.dy/100) 		 
		if circlecolision(player1.x, player1.y, v.x, v.y, 20) then --Decrescimento de vida quando detectado colisão da bala com o player
		  	player1.life = player1.life - decrelife2
			printflag2 = true
			damage2 = damage2 + decrelife2
		end
		if circlecolision(player2.x, player2.y, v.x, v.y, 25) then --Decrescimento de vida quando detectado colisão da bala com o player
			player2.life = player2.life - decrelife2/15
			printflagself2 = true
			selfdamage2 = selfdamage2 + decrelife2/15
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
					printfloorflag2 = true
					motionlimiter2 = 50
					table.remove(bullets2, i)					
				end
	    	end
	  	end
  		--REMOÇÃO BLOCO DE PISO -- 
	end

	--ATUALIZAÇÃO DA POSIÇÃO DA BARRA DE VIDA --
	life2.x = player2.x
	life2.y = player2.y - 35
	--ATUALIZAÇÃO DA POSIÇÃO DA BARRA DE VIDA --

	bullets2anim:update(dt)
	explosion2anim:update(dt)
end

function shot2_draw()
	love.graphics.setFont(gamefont)
	for i, v in ipairs(bullets2) do
		bullets2anim:draw(bullets2image,v.x, v.y, 0, 0.3, 0.3, bullets2image:getWidth()/16,bullets2image:getHeight()/16)
	end

	if printflag2 then
		explosion2anim:draw(explosion2image,player1.x, player1.y, 0, 0.8, 0.8, explosion2image:getWidth()/16,explosion2image:getHeight()/16)
	end
	if printflagself2 then
		explosion2anim:draw(explosion2image,player2.x, player2.y, 0, 0.8, 0.8, explosion2image:getWidth()/16,explosion2image:getHeight()/16)
	end
	if printfloorflag2 then
		explosion2anim:draw(explosion2image,pontox2, pontoy2, 0, 0.8, 0.8, explosion2image:getWidth()/16,explosion2image:getHeight()/16)
	end	

	-- BARRA DE VIDA --
	love.graphics.setColor(190, 0, 0) 
	love.graphics.rectangle("line", life2.x, life2.y, life2.w, life2.h)
	love.graphics.rectangle("fill", life2.x, life2.y, player2.life/2, life2.h)
	love.graphics.setColor(255,255,255)
	-- BARRA DE VIDA -- 

	-- DECRESCIMENTO DE VIDA --
	love.graphics.setColor(255,255,0)
	if printflag2 == true then		
		love.graphics.print(math.floor(damage2), player1.x - 15, player1.y - 65)
	end	
	love.graphics.setColor(255,255,255)
	-- DECRESCIMENTO DE VIDA --

	-- DECRESCIMENTO DE VIDA --
	love.graphics.setColor(255,255,0)
	if printflagself2 == true then		
		love.graphics.print(math.floor(selfdamage2), player2.x + 15, player2.y - 65)
	end	
	love.graphics.setColor(255,255,255)
	-- DECRESCIMENTO DE VIDA --

	--BARRA DE FORÇA--
	love.graphics.print(strength2, (strength2 + 772)/1.66, 531) -- impressão da força de tiro
	love.graphics.setColor(216, 136, 32)
	love.graphics.rectangle("line", strengthline2.x, strengthline2.y, strengthline2.w, strengthline2.h)
	love.graphics.rectangle("fill", strengthline2.x, strengthline2.y, strength2/1.66, strengthline2.h)
	love.graphics.setColor(255,255,255)
	--BARRA DE FORÇA--

	--MOSTRADOR DE ANGULO--
	love.graphics.print(math.ceil(math.deg(angle2)).."º", x2 -30, y2 - 30)
	--MOSTRADOR DE ANGULO--

	--DEBUGGING AND OLD CODE--
	--love.graphics.print(decrelife2, 770,0)
	--love.graphics.print(angle1, 0, 60)	
	--love.graphics.print(player2.life, player2.x + 10, player2.y - 40) -- impressão da quantidade de vida abaixo do jogador
	--DEBUGGING AND OLD CODE--	
end

function shot2_keypressed(key)
	--mx = x
	--my = y
	--angle2 = math.atan2(my-player2.y , mx - player2.x )

	direction2x = (strength2 - vento) * -math.cos(angle2)
	direction2y = (strength2 - vento) * -math.sin(angle2)

	if key == "kpenter" and shotnumber == 0 then
		table.insert(bullets2, {x = x2, y = y2 , dx = direction2x, dy = direction2y})
		shotnumber = shotnumber + 1

		table.insert(bullets2, {x = x2, y = y2, dx = direction2x + 5, dy = direction2y-20})
	end
end