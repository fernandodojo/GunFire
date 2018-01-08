
function menu_load()
	mx = 0
	my = 0

	start={ --botão iniciar
	x = 365,
  	y = 450,
  	w= 100,
  	h = 30
  	}

  	instructions = { --botão instruções
	x = 158,
	y = 450,
	w = 147,
	h = 30
	}

  	exit={ --botão sair
  	x = 525,
  	y = 450,
  	w = 57,
  	h = 30
  	}

  	menuimage = love.graphics.newImage("res/img/bakchgroundmenu.png")
	fontetitle = love.graphics.setNewFont("res/font/MRROBOT.ttf", 110) 
	fontmenu = love.graphics.setNewFont("res/font/Ailerons.otf", 25)	 	 	
end

function menu_update()
	--função de detecção de toque do ponto de click nos botões iniciar, instruções e sair.	Caso seja detectado o toque, função de mudança de estado de jogo podem ser chamadas.
	function love.mousepressed(x, y, button)
		if button ==1 then
			mx = x
			my = y			
			if toqueretangulo(mx, my, start.x, start.y,start.w,start.h ) then
				game()
			end
			if toqueretangulo(mx, my, instructions.x, instructions.y,instructions.w,instructions.h) then
				instruction()
			end
			if toqueretangulo(mx, my, exit.x, exit.y, exit.w, exit.h ) then
				love.event.push("quit")
			end
		end
	end	
end

function menu_draw()
	love.graphics.draw(menuimage, 0, 0) -- imagem do menu
	love.graphics.setFont(fontetitle) --definição de fonte
	love.graphics.printf("GUNFIRE", 140, 137, 600) -- impressão do titulo do jogo
	love.graphics.setColor(255,255,255) -- cor das letras

	love.graphics.setFont(fontmenu)	--definição de outra fonte
	love.graphics.printf("Iniciar", start.x, start.y, 250)	-- impressão dos respectivos botoões
	love.graphics.printf("Instruções", instructions.x,instructions.y, 250)
	love.graphics.printf("Sair", exit.x, exit.y, 250)		
		
	--love.graphics.rectangle("line", start.x, start.y, start.w, start.h)
	--love.graphics.rectangle("line", instructions.x, instructions.y, instructions.w, instructions.h)
	--love.graphics.rectangle("line", exit.x, exit.y, exit.w, exit.h)
end

--função de mudança de estado de jogo assim como carregamento de load do respectivo estado.
function game()
	state = "game"
	game_load()
end

function instruction()
	state = "instruction"
	instruction_load()
end