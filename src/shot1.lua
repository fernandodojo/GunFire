--https://www.love2d.org/forums/viewtopic.php?f=4&t=35233#p104896
local bullets1image, bullets1anim

function shot1_load()	
	bullets1 = {} -- tabela de balas
	shotnumber = 0 -- declaração de variável para guardar numero de tiros na tela
	strength1 = 0 -- declaração de variável para guardar força(velocidade) de lançamento da bala
		
	strengthline1 = { --coordenadas da barra de força
	x = 75,
	y = 530,
	w = 300,
	h = 14
	}

	life1 = { --coordenadas da barra de vida 
	x = nil,
	y = nil,
	w = 50,
	h = 5
	}

	pontox1 = 0 -- ultima localização no eixo x da bala
	pontoy1 = 0 --ultima localização no eixo y da bala

	decrelife1 = 0 -- variavel q guarda quanto deve ser decrescido de vida do player
	damage1 = 0	-- variavel responsavel por receber o valor do dano final para exclusivamente ser impresso respeitando o daley de sua impressão.
	selfdamage1 = 0 -- variavel responsavel por receber o valor do dano final em si mesmo para exclusivamente ser impresso respeitando o daley de sua impressão.

	movimentflag1 = true -- flag responsavel por limitar o movimento do player quando após o mesmo atirar.
	gameraflag1 = false -- flag responsavel por ativar  um delay para q a camera zom mantenha o foco na jogada do respectivo player

	--delay de impressão
	delayprintinit1 = 2
	delayprinttemp1 = 2
	printflag1 = false		
	--delay de impressão

	--delay de impressão de dano proprio
	delayprintinitself1 = 2
	delayprinttempself1 = 2
	printflagself1 = false		
	--delay de impressão de dano proprio

	--delay de impressão de dano no piso animação
	delayfloorflag1 = 2
	delayfloorflaginit1 = 2
	printfloorflag1 = false		
	--delay de impressão de dano no piso animação

	bullets1image = love.graphics.newImage("/res/img/bullets1.png")
	local bullets1animgrid = anim.newGrid(256,256,bullets1image:getWidth(), bullets1image:getHeight())
	bullets1anim = anim.newAnimation(bullets1animgrid('1-8',1, '1-8', 2), 0.03)

	explosion1image = love.graphics.newImage("/res/img/bullets1.png")
	local explosion1animgrid = anim.newGrid(256,256,explosion1image:getWidth(), explosion1image:getHeight())
	explosion1anim = anim.newAnimation(explosion1animgrid('1-8',4, '1-8',6, '1-8', 7, '1-8',8), 0.06)

	explosion1sound = love.audio.newSource("res/sound/explosion1.ogg")
end

function shot1_update(dt)	
--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--
	--verifica se a flag de impressão foi ativada após dano.. se isso for verdade e o delay definido for maior q zero, então o dano continuará a ser impresso.
	--se o delay for menor ou igual a zero, ele voltara a ter seu valor inicial, assim como as flags de impressão de dano, de ativação de camera e a variavel q guardo a quantidade de dano
	if printflag1 == true and delayprinttemp1 > 0 then
		delayprinttemp1 = delayprinttemp1 - dt
	elseif 	delayprinttemp1 <= 0 then 
		delayprinttemp1 = delayprintinit1
		delay.temp = delay.init
		printflag1 = false
		gameraflag1 = false
		damage1 = 0	
	end
--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--

--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO EM SI MESMO--
	--verifica se a flag de impressão foi ativada após dano.. se isso for verdade e o delay definido for maior q zero, então o dano continuará a ser impresso.
	--se o delay for menor ou igual a zero, ele voltara a ter seu valor inicial, assim como as flags de impressão de dano, de ativação de camera e a variavel q guardo a quantidade de dano
	if printflagself1 == true and delayprinttempself1 > 0 then
		delayprinttempself1 = delayprinttempself1 - dt
	elseif 	delayprinttempself1 <= 0 then
		delayprinttempself1 = delayprintinitself1
		delay.temp = delay.init
		printflagself1 = false
		gameraflag1 = false
		selfdamage1 = 0	
	end
--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO EM SI MESMO--

--FLAG DE DELAY DE ANIMAÇÃO APÓS DANO NO PISO--
	if printfloorflag1 == true and delayfloorflag1 > 0 then
		delayfloorflag1 = delayfloorflag1 - dt
	elseif 	delayfloorflag1 <= 0 then
		delayfloorflag1 = delayfloorflaginit1
		delay.temp = delay.init
		printfloorflag1 = false
		gameraflag1 = false
	end
--FLAG DE DELAY DE ANIMAÇÃO APÓS DANO NO PISO--

	--condição para que regula quando vai haver incremento da força do tiro ao pressionar tecla "space", apenas quando for a vez de determinado jogador, impedindo o incremento da força do outro mesmo utilizando a mesma tecla
	if gamestate == "player1" then 
		if love.keyboard.isDown("lshift") then
			gameraflag1 = true
			if strength1 >=500 then
				strength1 = 500
			else
				strength1 = strength1 + 3
			end
			if play and noise then 
				loadingsound:play()
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
		v.x = v.x + v.dx * dt --+ (ventohorizontal) --modificação de posição da bala atirando em direção ao angulo da mira no eixo x
		v.y = v.y + v.dy * dt --modificação de posição da bala atirando em direção angulo da mira no eixo y
		v.dy = v.dy + gravity + ventovertical -- implementação da gravidade + atuação do vento
		v.dx = v.dx + ventohorizontal	--implementação da atuação do vento na horizontal			

		pontox1 = v.x --a ultima posição da bala recebera a posição enquanto a bala não for removida
		pontoy1 = v.y --a ultima posição da bala recebera a posição enquanto a bala não for removida
		
		cam:setPosition(v.x, v.y) -- a camera seguira a bala sempre que houver bala na tela
				
		if v.y > 600 then --se a bala alcançar a coordenada 600 no eixo y, a mesma ativará uma flag para impressão da animação
			printfloorflag1 = true
		end
		
		if v.x> 3800 or v.x < -3000 or v.y > 600 or circlecolision(player2.x, player2.y, v.x, v.y, 25) or  circlecolision(player1.x, player1.y, v.x, v.y, 25)then
			--limitação de existencia da bala. Enquanto elas estiver dentro de determinada area ou não atingir algum player
			gamestate = "player2" --se houve colisão com o player 2 automaticamente mudará o estado de jogo			
			shotnumber = shotnumber - 1 --limitação de efetuar um novo tiro enquanto um estiver na tela
			--delay.temp = delay.init --o delay de 30 segundo pŕa cada player volta a ter seu valor inicial ja que ao atirar o jogo muda de vez
			strength2 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.
			motionlimiter1 = 50 -- a limitação de deslocamento volta a ter seu valor inicial
			table.remove(bullets1, i) --bala é removida do jogo
			movimentflag1 = true -- como houve mudança de vez, a limitação de movimento após tiro volta a ter seu valor inicial
			if play then
				explosion1sound:play()
			end
		end
		
		-- DECRESCIMENTO DE VIDA --
		decrelife1 = 2*(strength1/100 + v.dy/100) 				
		if circlecolision(player2.x, player2.y, v.x, v.y, 25) then --Decrescimento de vida quando detectado colisão da bala com o player condierando a soma dos raios do player e da bala
			player2.life = player2.life - decrelife1
			damage1 = damage1 + decrelife1 -- variavel que guarda valor do dano a ser impresso
			printflag1 = true --flag para inicializar impressão de dano e animações
		end

		if circlecolision(player1.x, player1.y, v.x, v.y, 25)  then --Decrescimento de vida quando detectado colisão da bala com o player condierando a soma dos raios do player e da bala
			player1.life = player1.life - (decrelife1+10)/2
			selfdamage1 = selfdamage1 + (decrelife1+10)/2 -- variavel que guarda valor do dano a ser impresso
			printflagself1 = true	--flag para inicializar impressão de dano e animações		
		end
		-- DECRESCIMENTO DE VIDA --

		--REMOÇÃO BLOCO DE PISO --
		for k=-200, 950, 50 do
	    	for l = 300, 480, 30 do
	    		if squarecollision(v.x-5, v.y-5, 10, 10, k, l, w, h) and floor[k][l] ==1 then --verifica a colição entre a bala e cada bloco do chão
	    			 floor[k][l] = 0 -- caso acha colisão este bloco será desativado para futuros desenhos e toque
		        	gamestate = "player2" --ocorre mudança de vez de jogador						
					shotnumber = shotnumber - 1 --impossibilita o player de dar mais tiros enquanto houve bala na tela
					--delay.temp = delay.init -- o tempo de cada player  é zerado
					strength2 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.			
					motionlimiter1 = 50 -- o deslocamento do player 1 é zerado
					printfloorflag1 = true	--flag de ativação da animação e delay da mesma				
					table.remove(bullets1, i) -- remoção da bala
					movimentflag1 = true --flag de permição de deslocamento do player volta a ter seu valor original
					if play then
						explosion1sound:play()
					end		      		
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
	explosion1anim:update(dt)
end

function shot1_draw()
	love.graphics.setFont(gamefont)
	for i, v in ipairs(bullets1) do
		--impressão de cada bala 
		bullets1anim:draw(bullets1image,v.x, v.y, 0, 0.4, 0.4, bullets1image:getWidth()/16,bullets1image:getHeight()/16)
		--love.graphics.circle("line", v.x, v.y, 30)		
	end
		
	if printflag1 then --flag que permite a animação de explosão por alguns segudos ja que essa ativa o delay
		--explosion1anim:draw(explosion1image,player2.x, player2.y, 0, 0.8, 0.8, explosion1image:getWidth()/16,explosion1image:getHeight()/16)
		explosion1anim:draw(explosion1image,pontox1, pontoy1, 0, 0.8, 0.8, explosion1image:getWidth()/16,explosion1image:getHeight()/16)
	end
	if printflagself1 then --flag que permite a animação de explosão por alguns segudos ja que essa ativa o delay
		--explosion1anim:draw(explosion1image,player1.x, player1.y, 0, 0.8, 0.8, explosion1image:getWidth()/16,explosion1image:getHeight()/16)
		explosion1anim:draw(explosion1image,pontox1, pontoy1, 0, 0.8, 0.8, explosion1image:getWidth()/16,explosion1image:getHeight()/16)
	end
	if printfloorflag1 then--flag que permite a animação de explosão por alguns segudos ja que essa ativa o delay
		explosion1anim:draw(explosion1image,pontox1, pontoy1, 0, 0.8, 0.8, explosion1image:getWidth()/16,explosion1image:getHeight()/16)
	end
	
	-- BARRA DE VIDA --
	love.graphics.setColor(190, 0, 0) 
	love.graphics.rectangle("line", life1.x, life1.y, life1.w, life1.h)
	love.graphics.rectangle("fill", life1.x, life1.y, player1.life/2, life1.h)
	love.graphics.setColor(255,255,255)
	-- BARRA DE VIDA --

	-- DECRESCIMENTO DE VIDA --
	love.graphics.setColor(255,255,0)
	if printflag1 then	--flag que permite a impressão do dano por  alguns segudos ja que essa ativa o delay	
		love.graphics.print(math.floor(damage1).."0", player2.x + 15, player2.y - 65)
	end
	love.graphics.setColor(255,255,255)
	-- DECRESCIMENTO DE VIDA --

	-- DECRESCIMENTO DE VIDA --
	love.graphics.setColor(255,255,0)
	if printflagself1 then	--flag que permite a impressão do dano em si mesmo por  alguns segudos ja que essa ativa o delay		
		love.graphics.print(math.floor(selfdamage1).."0", player1.x -15, player1.y - 65)
	end
	love.graphics.setColor(255,255,255)
	-- DECRESCIMENTO DE VIDA --

	--MOSTRADOR DE ANGULO--
	love.graphics.print(math.ceil(math.deg(-angle1)).."º", x1, y1 - 30)
	--MOSTRADOR DE ANGULO--

	--DEBUGGING AND OLD CODE--
	--love.graphics.print(decrelife1, 0,0)	
	--love.graphics.print(angle2, 0, 60)
	--love.graphics.print(player1.life, player1.x - 30, player1.y - 40) -- impressão da quantidade de vida abaixo do jogador
	--DEBUGGING AND OLD CODE--


end

function shot1_keypressed(key)
	--mx = x
	--my = y
	--angle = math.atan2(x1-player1.y , y1 - player1.x )
	
	direction1x = (strength1 + ventohorizontal) * math.cos(angle1) -- simulação de direção, a direção será calculando usando a velocidade definida pela soma da força mais do vento multiplicado pelo cosceno angulo
	direction1y = (strength1+ ventohorizontal) * math.sin(angle1) -- simulação de direção, a direção será calculando usando a velocidade definida pela soma da força mais do vento multiplicado pelo seno angulo	

	if key == "space" and shotnumber ==0 and not printflag1 and not printflagself1 and not printfloorflag1 then -- limita a ativação do tiro quando não houver balas na tela, assim como impossibilda um novo tiro enquanto um antigo estiver explodindo
		table.insert (bullets1 , {x = x1, y = y1, dx = direction1x, dy = direction1y}) -- ao atirar serão inseridos dados como posição inicial e direção de deslocamento
		shotnumber = shotnumber + 1 --informa q há tiros na tela
		if play then
			shotsound:play()
		end
		movimentflag1 = false -- proibi o player de se movimentar apos tiro
		gameraflag1 = true --ativa a camera zoom
		--table.insert (bullets1 , {x = x1, y = y1, dx = direction1x - 5, dy = direction1y-20})
	end
end