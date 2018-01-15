function instruction_load()
	menuback={ --coordenadas no botão voltar para menu
	x = 50,
  	y = 505,
  	w = 63,
  	h = 30
  	}

	start={ --coordenadas do botão para iniciar o jogo
  	x = 655,
  	y = 505,
  	w = 100,
  	h = 30
  	}
  	
	instructionfont = love.graphics.setNewFont("res/font/A-Space.otf", 16)	
	instructionfontb = love.graphics.setNewFont("res/font/MRROBOT.ttf", 24) 	
end

function instruction_update(dt)
	--função para detecção do ponto de click do mouse no botão de voltar e de iniciar
	function love.mousepressed(x, y, button)
		if button ==1 then
			mx = x
			my = y			
			if toqueretangulo(mx, my, menuback.x, menuback.y, menuback.w, menuback.h ) then
				menu()
			end
			if toqueretangulo(mx, my, start.x, start.y,start.w,start.h ) then
				game()
			end
		end
	end
end

function instruction_draw()
	love.graphics.setBackgroundColor(61, 61, 61, 50) -- cor de fundo

--CONTROLES DO JOGADOR 1 --
	love.graphics.setFont(instructionfontb) 
	love.graphics.printf("A , D", 50, 40, 100)	
	love.graphics.printf("W , S", 50, 70, 100)
	love.graphics.printf("LEFT SHIFT", 50, 100, 150)
	love.graphics.printf("SPACE", 50, 130, 200)
--CONTROLES DO JOGADOR 1 --

--CONTROLES DO JOGADOR 2 --
	love.graphics.printf("LEFT , RIGHT", 50, 160, 175)
	love.graphics.printf("UP , DOWN", 50, 190, 150)	
	love.graphics.printf("RIGHT SHIFT", 50, 220, 175)	
	love.graphics.printf("RIGHT CTRL", 50, 250, 400)
--CONTROLES DO JOGADOR 2 --

--CONTROLES DO JOGADOR 2 ALTERNATIVO --
	--[[love.graphics.printf("LEFT , RIGHT", 50, 160, 175)
	love.graphics.printf("UP , DOWN", 50, 190, 150)	
	love.graphics.printf("RIGHT SHIFT", 50, 220, 175)	
	love.graphics.printf("RIGHT CTRL", 50, 250, 400)]]
--CONTROLES DO JOGADOR 2 ALTERNATIVO --

--CONTROLES DE VOLUME--
	love.graphics.printf("M", 50, 280, 400)
	love.graphics.printf("N", 50, 310, 400)
	love.graphics.printf("K", 50, 340, 400)
	love.graphics.printf("J", 50, 370, 400)
--CONTROLES DE VOLUME--

--INSTRUÇÕES JOGADOR 1 --
	love.graphics.setFont(instructionfont)
	love.graphics.printf("Move o Jogador 1.", 123,45, 730)	
	love.graphics.printf("Move a mira do Jogador 1.", 123,75,730)	
	love.graphics.printf("Define a força de lançamento do Jogador 1. ", 217 ,105,750)
	love.graphics.printf("Lançamento do Jogador 1.",157,135,750)
--INSTRUÇÕES JOGADOR 1 --

--INSTRUÇÕES JOGADOR 2 --
	love.graphics.printf("Move o Jogador 2.", 225,165, 730)
	love.graphics.printf("Move a mira do Jogador 2.", 187,195,730)
	love.graphics.printf("Define a força de lançamento do Jogador 2. ", 225 ,225,750)	
	love.graphics.printf("Lançamento do Jogador 2.",217,255,750)
--INSTRUÇÕES JOGADOR 2 --

--INSTRUÇÕES JOGADOR 2 ALTERNATIVO--
	--[[love.graphics.printf("Move o Jogador 2.", 227,165, 730)
	love.graphics.printf("Move a mira do Jogador 2.", 192,195,730)
	love.graphics.printf("Define a força de lançamento do Jogador 2. ", 227 ,225,750)	
	love.graphics.printf("Lançamento do Jogador 2.",220,255,750)]]
--INSTRUÇÕES JOGADOR 2 ALTERNATIVO--

--INSTRUÇÕES GERAL--
	love.graphics.printf("Desliga e ligar o som.",90,285,750)
	love.graphics.printf("Desliga o som de fundo e de movimentos do Jogadores.",90,315,750)
	love.graphics.printf("Aumenta o volume",90,345,750)
	love.graphics.printf("Diminui o volume.",90,375,750)	
	love.graphics.printf("O objetivo do jogo é matar o adversário, calculando a força, variação do vento e  mira necessária para acerta-lo dentro de 30 segundos. Quanto maior a altitude alcançada maior será o dano.",50,415,710)
--INSTRUÇÕES GERAL--
		
--FONTE E BOTÃO--		
	love.graphics.setFont(fontmenu)
	love.graphics.printf("Menu", menuback.x,menuback.y,750)
	love.graphics.printf("Iniciar ", start.x, start.y,750)


--DEBBUG CODE--
	--love.graphics.rectangle("line", menuback.x-2, menuback.y, menuback.w, menuback.h)
	--love.graphics.rectangle("line", start.x-2, start.y, start.w, start.h)
end