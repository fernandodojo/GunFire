--https://www.love2d.org/forums/viewtopic.php?f=4&t=35233#p104896
local bullets2image, bullets2anim

function shot2_load()
	bullets2 = {}-- tabela de balas
	shotnumber = 0 -- declaração de variável para guardar numero de tiros na tela
	strength2 = 0 -- declaração de variável para guardar força(velocidade) de lançamento da bala
	
	strengthline2 = { --coordenadas da barra de força
	x = 465,
	y = 530,
	w = 300,
	h = 14
	}

	life2 = { --coordenadas da barra de vida 
	x = nil,
	y = nil,
	w = 50,
	h = 5
	}

	pontox2 = 0 -- ultima localização no eixo x da bala
	pontoy2 = 0 --ultima localização no eixo y da bala

	decrelife2 = 0 -- variavel q guarda quanto deve ser decrescido de vida do player
	damage2 = 0 -- variavel responsavel por receber o valor do dano final para exclusivamente ser impresso respeitando o daley de sua impressão.
	selfdamage2 = 0  -- variavel responsavel por receber o valor do dano final em si mesmo para exclusivamente ser impresso respeitando o daley de sua impressão.

	movimentsflag2 = true -- flag responsavel por limitar o movimento do player quando após o mesmo atirar.
	gameraflag2 = false --flag responsavel por ativar  um delay para q a camera zoom mantenha o foco na jogada do respectivo player

	--delay de impressão
	delayprintinit2 = 2
	delayprinttemp2 = 2
	printflag2 = false
	--delay de impressão

	--delay de impressão
	delayprintinitself2 = 2
	delayprinttempself2 = 2
	printflagself2 = false		
	--delay de impressão

	--delay de impressão de dano no piso
	delayfloorflag2 = 2
	delayfloorflaginit2 = 2
	printfloorflag2 = false		
	--delay de impressão de dano no piso

	bullets2image = love.graphics.newImage("/res/img/bullets2.png")
	local bullets2animgrid = anim.newGrid(256,256,bullets2image:getWidth(), bullets2image:getHeight())
	bullets2anim = anim.newAnimation(bullets2animgrid('1-8',1, '1-8', 2), 0.03)

	explosion2image = love.graphics.newImage("/res/img/bullets2.png")
	local explosion2animgrid = anim.newGrid(256,256,explosion2image:getWidth(), explosion2image:getHeight())
	explosion2anim = anim.newAnimation(explosion2animgrid('1-8',3,'1-8',4, '1-8', 5, '1-8',6, '1-8', 7, '1-8',8), 0.03)

	explosion2sound = love.audio.newSource("res/sound/explosion2.ogg")
end

function shot2_update(dt)
--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--
	--verifica se a flag de impressão foi ativada após dano.. se isso for verdade e o delay definido for maior q zero, então o dano continuará a ser impresso.
	--se o delay for menor ou igual a zero, ele voltara a ter seu valor inicial, assim como as flags de impressão de dano, de ativação de camera e a variavel q guardo a quantidade de dano
	if printflag2 == true  and delayprinttemp2 > 0 then
		delayprinttemp2 = delayprinttemp2 - dt
	elseif 	delayprinttemp2 <= 0 then
		delayprinttemp2 = delayprintinit2
		delay.temp = delay.init
		printflag2 = false
		gameraflag2 = false
		damage2 = 0
	end
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO--

--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO EM SI MESMO--
	--verifica se a flag de impressão foi ativada após dano.. se isso for verdade e o delay definido for maior q zero, então o dano continuará a ser impresso.
	--se o delay for menor ou igual a zero, ele voltara a ter seu valor inicial, assim como as flags de impressão de dano, de ativação de camera e a variavel q guardo a quantidade de dano
	if printflagself2 == true and delayprinttempself2 > 0 then
		delayprinttempself2 = delayprinttempself2 - dt
	elseif 	delayprinttempself2 <= 0 then
		delayprinttempself2 = delayprintinitself2
		delay.temp = delay.init
		printflagself2 = false
		gameraflag2 = false
		selfdamage2 = 0	
	end
	--FLAG DE DELAY DE IMPRESSAO DA VIDA APÓS O DANO EM SI MESMO--

	--FLAG DE DELAY DE ANIMAÇÃO APÓS DANO NO PISO--
	if printfloorflag2 == true and delayfloorflag2 > 0 then
		delayfloorflag2 = delayfloorflag2 - dt
	elseif 	delayfloorflag2 <= 0 then
		delayfloorflag2 = delayfloorflaginit2
		delay.temp = delay.init
		printfloorflag2 = false
		gameraflag2 = false
	end
	--FLAG DE DELAY DE ANIMAÇÃO APÓS DANO NO PISO--
	
	--condição para que regula quando vai haver incremento da força do tiro ao pressionar tecla "space", apenas quando for a vez de determinado jogador, impedindo o incremento da força do outro mesmo utilizando a mesma tecla
	if gamestate == "player2" then
		if love.keyboard.isDown("up") then
			gameraflag2 = true
			if strength2 >=500 then
				strength2 = 500
			else
				strength2 = strength2 + 3
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

	for i, v in ipairs (bullets2) do
		v.x = v.x + v.dx * dt --+ (ventohorizontal) --modificação de posição da bala atirando em direção ao angulo da mira no eixo x
		v.y = v.y + v.dy * dt --modificação de posição da bala atirando em direção angulo da mira no eixo y
		v.dy = v.dy + gravity + ventovertical-- implementação da gravidade + atuação do vento
		v.dx = v.dx + ventohorizontal --implementação da atuação do vento na horizontal			

		pontox2 = v.x --a ultima posição da bala recebera a posição enquanto a bala não for removida
		pontoy2 = v.y --a ultima posição da bala recebera a posição enquanto a bala não for removida

		cam:setPosition(v.x, v.y) -- a camera seguira a bala sempre que houver bala na tela

		if v.y > 600 then
			printfloorflag2 = true --se a bala alcançar a coordenada 600 no eixo y, a mesma ativará uma flag para impressão da animação
		end

		if v.x> 3800 or v.x < -3000 or v.y > 600 or circlecolision(player1.x, player1.y, v.x, v.y, 25) or circlecolision(player2.x, player2.y, v.x, v.y, 25) then
			--limitação de existencia da bala. Enquanto elas estiver dentro de determinada area ou não atingir algum player
			gamestate = "player1" --se houve colisão com o player 2 automaticamente mudará o estado de jogo
			--delay.temp = delay.init --o delay de 30 segundo pŕa cada player volta a ter seu valor inicial ja que ao atirar o jogo muda de vez
			shotnumber = shotnumber - 1 --limitação de efetuar um novo tiro enquanto um estiver na tela
			strength1 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.
			motionlimiter2 = 50 -- a limitação de deslocamento volta a ter seu valor inicial
			table.remove(bullets2, i) --bala é removida do jogo
			movimentsflag2 = true -- como houve mudança de vez, a limitação de movimento após tiro volta a ter seu valor inicial
			if play then
				explosion2sound:play()
			end
		end

		-- DECRESCIMENTO DE VIDA --		
		decrelife2 = 2*(strength2/100 + v.dy/100) 		 
		if circlecolision(player1.x, player1.y, v.x, v.y, 25) then --Decrescimento de vida quando detectado colisão da bala com o player condierando a soma dos raios do player e da bala
		  	player1.life = player1.life - decrelife2
			printflag2 = true --flag para inicializar impressão de dano e animações
			damage2 = damage2 + decrelife2 -- variavel que guarda valor do dano a ser impresso
		end
		if circlecolision(player2.x, player2.y, v.x, v.y, 25) then --Decrescimento de vida quando detectado colisão da bala com o player
			player2.life = player2.life - (decrelife2+10)/2
			printflagself2 = true --flag para inicializar impressão de dano e animações
			selfdamage2 = selfdamage2 + (decrelife2+10)/2  -- variavel que guarda valor do dano a ser impresso
		end
		-- DECRESCIMENTO DE VIDA --

		--REMOÇÃO BLOCO DE PISO --
		for k=-200, 950, 50 do
	    	for l = 300, 480, 30 do
	    		if squarecollision(v.x-5, v.y-5,10, 10, k, l, w, h) and floor[k][l] ==1 then --verifica a colição entre a bala e cada bloco do chão
	        		floor[k][l] = 0 -- caso acha colisão este bloco será desativado para futuros desenhos e toque
	        		gamestate = "player1" --ocorre mudança de vez de jogador	        		
	        		shotnumber = shotnumber - 1 --impossibilita o player de dar mais tiros enquanto houve bala na tela
	        		--delay.temp = delay.init -- o tempo de cada player  é zerado
					strength1 = 0 -- mantem na tela a força utiliza pelo jogador que não esta jogando até o atual terminar a jogada, permitindo zerar a força apenas quando o da vez estiver jogando.					
					printfloorflag2 = true --flag de ativação da animação e delay da mesma	
					motionlimiter2 = 50 -- o deslocamento do player 1 é zerado
					table.remove(bullets2, i) -- remoção da bala
					movimentsflag2 = true --flag de permição de deslocamento do player volta a ter seu valor original
					if play then
						explosion2sound:play()
					end					
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
		--impressão de cada bala 
		bullets2anim:draw(bullets2image,v.x, v.y, 0, 0.4, 0.4, bullets2image:getWidth()/16,bullets2image:getHeight()/16)
		--love.graphics.circle("line", v.x, v.y, 30)
	end

	if printflag2 then --flag que permite a animação de explosão por alguns segudos ja que essa ativa o delay
		--explosion2anim:draw(explosion2image,player1.x, player1.y, 0, 0.8, 0.8, explosion2image:getWidth()/16,explosion2image:getHeight()/16)
		explosion2anim:draw(explosion2image,pontox2, pontoy2, 0, 0.8, 0.8, explosion2image:getWidth()/16,explosion2image:getHeight()/16)
	end
	if printflagself2 then --flag que permite a animação de explosão por alguns segudos ja que essa ativa o delay
		--explosion2anim:draw(explosion2image,player2.x, player2.y, 0, 0.8, 0.8, explosion2image:getWidth()/16,explosion2image:getHeight()/16)
		explosion2anim:draw(explosion2image,pontox2, pontoy2, 0, 0.8, 0.8, explosion2image:getWidth()/16,explosion2image:getHeight()/16)
	end
	if printfloorflag2 then --flag que permite a animação de explosão por alguns segudos ja que essa ativa o delay
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
	if printflag2 == true then --flag que permite a impressão do dano por  alguns segudos ja que essa ativa o delay		
		love.graphics.print(math.floor(damage2).."0", player1.x - 15, player1.y - 65)
	end	
	love.graphics.setColor(255,255,255)
	-- DECRESCIMENTO DE VIDA --

	-- DECRESCIMENTO DE VIDA --
	love.graphics.setColor(255,255,0)
	if printflagself2 == true then	--flag que permite a impressão do dano em si mesmo por  alguns segudos ja que essa ativa o delay			
		love.graphics.print(math.floor(selfdamage2).."0", player2.x + 15, player2.y - 65)
	end	
	love.graphics.setColor(255,255,255)
	-- DECRESCIMENTO DE VIDA --

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

	direction2x = (strength2 - ventohorizontal) * -math.cos(angle2) -- simulação de direção, a direção será calculando usando a velocidade definida pela soma da força mais do vento multiplicado pelo cosceno angulo
	direction2y = (strength2 - ventohorizontal) * -math.sin(angle2) -- simulação de direção, a direção será calculando usando a velocidade definida pela soma da força mais do vento multiplicado pelo seno angulo	

	if key == "kpenter" and shotnumber == 0  and not printflag2 and not printflagself2 and not printfloorflag2 then	-- limita a ativação do tiro quando não houver balas na tela, assim como impossibilda um novo tiro enquanto um antigo estiver explodindo
		table.insert(bullets2, {x = x2, y = y2 , dx = direction2x, dy = direction2y}) -- ao atirar serão inseridos dados como posição inicial e direção de deslocamento
		shotnumber = shotnumber + 1 --informa q há tiros na tela
		if play then
			shotsound:play() 
		end
		movimentsflag2 = false -- proibi o player de se movimentar apos tiro
		gameraflag2 = true --ativa a camera zoom
		--table.insert(bullets2, {x = x2, y = y2, dx = direction2x + 5, dy = direction2y-20})
	end
end