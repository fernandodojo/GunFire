function instruction_load()
	menuback={
	x = 50,
  	y = 505,
  	w = 63,
  	h = 30
  	}

	start={
  	x = 655,
  	y = 505,
  	w = 100,
  	h = 30
  	}
  	
	instructionfont = love.graphics.setNewFont("res/font/A-Space.otf", 16)	
	instructionfontb = love.graphics.setNewFont("res/font/MRROBOT.ttf", 24) 	
end

function instruction_update(dt)
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
	love.graphics.setBackgroundColor(61, 61, 61, 50)

	love.graphics.setFont(instructionfontb) 
	love.graphics.printf("A  D", 50, 40, 100)
	love.graphics.printf("4  6", 50, 70, 100)
	love.graphics.printf("W  S", 50, 100, 100)
	love.graphics.printf("8  5", 50, 130, 100)
	love.graphics.printf("Left Shift", 50, 160, 150)
	love.graphics.printf("UP", 50, 190, 150)
	love.graphics.printf("SPACE", 50, 220, 200)
	love.graphics.printf("NUMPAD ENTER", 50, 250, 400)
	love.graphics.printf("M", 50, 280, 400)
	love.graphics.printf("N", 50, 310, 400)
	love.graphics.printf("O", 50, 340, 400)
	love.graphics.printf("L", 50, 370, 400)


	love.graphics.setFont(instructionfont)
	love.graphics.printf("Move o Jogador 1.", 115,45, 730)
	love.graphics.printf("Move o Jogador 2.", 115,75, 730)
	love.graphics.printf("Move a mira do Jogador 1.", 115,105,730)
	love.graphics.printf("Move a mira do Jogador 2.", 115,135,730)
	love.graphics.printf("Define a força de lançamento do Jogador 1. ", 215 ,165,750)
	love.graphics.printf("Define a força de lançamento do Jogador 2. ", 105 ,195,750)
	love.graphics.printf("Lançamento do Jogador 1.",160,225,750)
	love.graphics.printf("Lançamento do Jogador 2.",275,255,750)
	love.graphics.printf("Desliga e ligar o som.",90,285,750)
	love.graphics.printf("Desliga o som de fundo e de movimentos do Jogadores.",90,315,750)
	love.graphics.printf("Aumenta o volume",90,345,750)
	love.graphics.printf("Diminui o volume.",90,375,750)	
	love.graphics.printf("O objetivo do jogo é matar o adversário, calculando a força, variação do vento e  mira necessária para acerta-lo dentro de 30 segundos. Quanto maior a altitude alcançada maior será o dano.",50,415,710)
		
	love.graphics.setFont(fontmenu)
	love.graphics.printf("Menu", menuback.x,menuback.y,750)
	love.graphics.printf("Iniciar ", start.x, start.y,750)
	
	--love.graphics.rectangle("line", menuback.x-2, menuback.y, menuback.w, menuback.h)
	--love.graphics.rectangle("line", start.x-2, start.y, start.w, start.h)
end