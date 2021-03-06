local endfont = love.graphics.setNewFont("res/font/A-Space.otf", 20)
function end_load()
	playagain = { --botão para jogar novamento
	x = 285,
	y = 400,
	w = 225,
	h = 25
	}

	menuend = { --botao para voltar para o menu 
	x = 355, 
	y = 450,
	w = 75,
	h = 25
	}

	exit = { --botão para sair do jogo
  	x = 370,
  	y = 500,
  	w = 50,
  	h = 25
  	}
  	play = false
 end

function end_update(dt)
	--[[esta função detecta o toque do ponto de click do mouse dentro dos retangulos e cada botão, caso seja detectado , 
	será chamado a função responsavel por fazer a mudança de estado de jogo assim como o carregamento da respectiva função de estado]]
	function love.mousepressed(x, y, button) 
		if button ==1 then
			mx = x
			my = y
			
			if toqueretangulo(mx, my, playagain.x, playagain.y,playagain.w,playagain.h ) then
				game()
			end
			if toqueretangulo(mx, my, menuend.x, menuend.y, menuend.w, menuend.h ) then
				menu()
			end
			if toqueretangulo(mx, my, exit.x, exit.y, exit.w, exit.h ) then		
				love.event.push("quit")
			end
		end
	end
end

function end_draw()
	love.graphics.setFont(endfont)
	love.graphics.setBackgroundColor(61, 61, 61, 50)

	--desenho e impressão dependendo de qual player perdeu
	if player1dead then 
		love.graphics.print("Jogador 2 Venceu", 285,75)
		love.graphics.draw(player1.imagedamaged, 175,230, 0, 1,1)
		love.graphics.draw(player2.image, 501,175, 0, 1,1)
	elseif player2dead then
		love.graphics.print("Jogador 1 Venceu", 290,75)
		love.graphics.draw(player1.image, 175,175, 0, 1,1)
		love.graphics.draw(player2.imagedamaged, 501,230, 0, 1,1)
	end

	love.graphics.print("Jogar Novamente", playagain.x, playagain.y)
	love.graphics.print("Menu", menuend.x,menuend.y)
	love.graphics.print("Sair", exit.x, exit.y)

	--DEBUGGING AND OLD CODE--
	--love.graphics.rectangle("line", playagain.x, playagain.y, playagain.w, playagain.h)
	--love.graphics.rectangle("line", menuend.x, menuend.y, menuend.w, menuend.h)
	--love.graphics.rectangle("line", exit.x, exit.y, exit.w, exit.h)
	--DEBUGGING AND OLD CODE--	
end

--função de mudança de estado de jogo e carregamento do respectivo load
function game()
	state = "game"
	game_load()
end

function menu()
	state = "menu"
	menu_load()
end