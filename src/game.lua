gamefont = love.graphics.setNewFont("res/font/A-Space.otf", 13)
function game_load()
	cam = gamera.new(-3000,-600,6800,2000) --definição padrão da biblioteca gamera (ponto inicial de atualção x, ponto inicial de atuação y, deslocamento total no eixo x, deslocamento total no eixo y)
	cam:setScale(1.0)	--escala de aumento do zoom/ no caso esta padrão 1
	play = true	--som global ativado por padrão
	noise = true --som de fundo ativado por padrão
	volume = 0.5 -- volume inicial
	mx = 0 --coordenada do mouse no eixo x
	my = 0 --coordenada do mouse no eixo y
	gravity = 4 --gravidade inicial
	ui_load() --desenhos de tudo que não se move com a ativação da camera zoom
	moviments_load() -- função responsavel pelo movimento dos dois players
	delaytime_load() -- função responsavel pelo tempo destinado a cada player assim como tempo entre mudanças de vento
	aiming1_load() -- função quer permite mudar a posição da mira do jogador 1
	aiming2_load() -- função quer permite mudar a posição da mira do jogador 2
	player1_load() --informações de construção do jogador 1
	player2_load() --informações de construção do jogador 2
	shot1_load() -- função responsavel por toda mecanica do tipo e colisões do jogador 1
	shot2_load() -- função responsavel por toda mecanica do tipo e colisões do jogador 2
	floor_load() -- função responsavel por ciração do chão

	backgroud = love.graphics.newImage("res/img/background.jpg") --imagem de fundo
	speaker = love.graphics.newImage("res/img/speaker.png") -- imagem de ativação do som
	nospeaker = love.graphics.newImage("res/img/nospeaker.png") --imagem de desativação do som
	mainsound = love.audio.newSource("res/sound/mainsoundtrack.ogg") --som de fundo principal
	shotsound = love.audio.newSource("res/sound/shot1.ogg") -- som do tiro
	movimentsound = love.audio.newSource("res/sound/shipmoviment.ogg") --som de movimento
	loadingsound = love.audio.newSource("res/sound/loading.ogg") --som do carregamento da força de tiro
	aimsound = love.audio.newSource("res/sound/aimsound.ogg") -- som de mudança do angulo de tiro

	--delay para permanencia do volume da tela--
	delayvolume = 3 
	delayvolumeinit = 3
	volumeflag = false


	function love.keypressed(key)
		-- caso as condições sejam satisfeitas a função de tiro do jogado1 ou jogador será chamada.
		if gamestate == "player1" and state == "game" then
			shot1_keypressed(key)
		end
		if gamestate == "player2" and state == "game" then
			shot2_keypressed(key)
		end
		if key == "escape" then -- permite sair do jogo ao pressionar esc
			love.event.quit()
		end	
		if key == "m" then --tecla para ativa ou desativar o som global
			if play == false then
			play = true
			elseif play then
				play = false
			end
		end
		if key == "n" then -- tecla para ativar e desativar som de fundo
			if noise == false then
			noise = true
			elseif noise then
				noise = false
			end
		end
	end

	function love.mousepressed(x, y, button) -- chamada de função vazia para limitar o reconhecimento do toque do mouse.		
	end	
end

function game_update(dt)
	ui_update(dt)		
	moviments_update(dt)
	delaytime_update(dt)
	aiming1_update(dt)
	aiming2_update(dt)
	player1_update(dt)
	player2_update(dt)
	shot1_update(dt)
	shot2_update(dt)
	floor_update(dt)

--SOM DO JOGO--
	--delay de aparecimento do volume ao ser aumentado ou diminuido, quando for maior q zero este continuar a ser decrementado, ao chegar a 0 ou menor, o dely volta ao ser valor inicial e desativa o aparecimento do volume--
	if delayvolume > 0 then
		delayvolume =  delayvolume - dt
	elseif delayvolume <= 0  then 
		delayvolume = delayvolumeinit
		volumeflag = false
	end

	--enquanto a tecla k for pressionada o volume será aumentado, e a flag volumeflag permite a impressão do volume pelo tempo restante do dalyvolume
	if love.keyboard.isDown("k") then
		volumeflag = true
		volume = volume + 0.01
		if volume >= 1.0 then
			volume = 1.0
		end
	end

	--enquanto a tecla k for pressionada o volume será diminuido, e a flag volumeflag permite a impressão do volume pelo tempo restante do dalyvolume
	if love.keyboard.isDown("j") then
		volumeflag = true
		volume = volume - 0.01
		if volume <= 0.0 then
			volume = 0.0
		end
	end

	love.audio.setVolume(volume) -- volume do jogo

	if play and noise then -- se tanto o volume global quanod o volume de fundo estiverem ativador, o som de fundo será tocado
		mainsound:play()
	end
	if not play or not noise then --se ou o volume global ou de fundo estivem desativados, o som de fundo não será tocado.
		mainsound:pause()
	end
--SOM DO JOGO--


--CAMERA DO JOGO--
	--se não houve nenhuma bala na tela ou animação ocorrendo referente a jogada anterior, a camera terá como ponto de atuação o centro do jogo.
	if shotnumber == 0 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then 
		cam:setPosition(400, 300)
	end
	--se for a vez do jogador1, e este tiver feito algo tipo de movimento e não ouver nenhuma bala na tela, o ponto de atuação da camera será o jogador2, caso haja
	--bala na tela, o ponto de atuação será a bala.
	if gamestate == "player1" and  gameraflag1 and shotnumber == 0 then --love.keyboard.isDown("lshift")
		cam:setPosition(player1.x, player1.y)
	end
	--se for a vez do jogador2, e este tiver feito algo tipo de movimento e não ouver nenhuma bala na tela, o ponto de atuação da camera será o jogador2, caso haja
	--bala na tela, o ponto de atuação será a bala.
	if gamestate == "player2" and gameraflag2 and shotnumber == 0 then --love.keyboard.isDown("up")
		cam:setPosition(player2.x, player2.y)
	end
--CAMERA DO JOGO--
end

function game_draw()
	love.graphics.setFont(gamefont)	
	cam:draw(function() -- tudo que está dentro da função padrão cam:draw da biblioteca gamera, será possivel de fugir do foco da camera.
		love.graphics.setFont(gamefont)
		love.graphics.draw(backgroud,-3000, -600)			
		moviments_draw()
		delaytime_draw()
		aiming1_draw()
		aiming2_draw()
		floor_draw()
		player1_draw()
		player2_draw()	
		shot1_draw()
		shot2_draw()
	end)

	--[[função é colocada fora da função cam:draw para que os controles de cada player e informações principais do jogo permaneçam o tempo inteiro sendo exibidos
	independente da posição da camera]]	
	ui_draw()	

	if volumeflag then		
		love.graphics.rectangle("line", 50, 50, 10, 100) -- retangulo esterno de volume
		love.graphics.rectangle("fill", 50, 150,10, volume*-100) -- barra interna de volume subindo(coordenadas aumentando negativamente)
		love.graphics.print(math.ceil(volume*10), 30,48 ) --impressão do valor de volume multiplicado por 10
	end
	if volume <=0 or not play then -- se o volume for menor ou igual a zero ou som global desligado, será exibido o icone de desativação do som
		love.graphics.draw(nospeaker, 10, 0)
	end
end



