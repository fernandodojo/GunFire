

function instruction_load()

	menuback={
	x = 50,
  	y = 500,
  	w = 65,
  	h = 18
  	}

	start={
  	x = 675,
  	y = 500,
  	w = 63,
  	h = 18
  	}
  	
  	--instructionsimage = love.graphics.newImage("res/img/backgroundinstructions.png")
	instructionfont = love.graphics.setNewFont("res/font/A-Space.otf", 16)	
	instructionfontb = love.graphics.setNewFont("res/font/A-Space.otf", 24)

	leftarrow = love.graphics.newImage("res/img/leftarrow.png")
	rightarrow = love.graphics.newImage("res/img/rightarrow.png")
	uparrow = love.graphics.newImage("res/img/uparrow.png")
	downarrow = love.graphics.newImage("res/img/downarrow.png") 	
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
	love.graphics.printf("A  D", 180, 73, 100)
	love.graphics.printf("4  6", 515, 73, 100)
	love.graphics.printf("W  S", 180, 118, 100)
	love.graphics.printf("8  5", 610, 118, 100)
	love.graphics.printf("Left Shift", 157, 168, 150)
	love.graphics.printf("UP", 157, 188, 150)
	love.graphics.printf("SPACE", 157, 218, 200)
	love.graphics.printf("NUMPAD ENTER", 157, 248, 400)


	love.graphics.setFont(instructionfont)
	love.graphics.printf("Use as teclas,             , para mover o Jogador 1 e,              ,para mover o Jogador 2.", 35,80, 730)
	love.graphics.printf("Use as teclas,               , para mover a mira do Jogador 1 e,              ,para mover a mira do Jogador 2.", 35,125,730)
	love.graphics.printf("Use a tecla,                               , para definir a força de lançamento do Jogador 1 e,           , para definir a força do Jogador 2. ", 35 ,175,750)
	love.graphics.printf("Use a tecla,                        , para realizar o lançamento do Jogador 1.",35,225,750)
	love.graphics.printf("Use a tecla,                                                     , para realizar o lançamento do Jogador 2.",35,255,750)

	love.graphics.printf("O objetivo do jogo é matar o adversário, calculando a força e mira necessária para acerta-lo dentro de 30 segundos.",35,325,730)
	love.graphics.printf("Considere a variação do vento e da gravidade antes de realizar o laçamento.",35,365,750)
	love.graphics.printf("Tiros com grande altitude, força causam danos proporcionais.",35,405,730)

	love.graphics.printf("Menu", menuback.x,menuback.y,750)
	love.graphics.printf("Iniciar ", start.x, start.y,750)
	
	--love.graphics.rectangle("line", menuback.x-3, menuback.y, menuback.w, menuback.h)
	--love.graphics.rectangle("line", start.x-3, start.y, start.w, start.h)
end