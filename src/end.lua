local endfont = love.graphics.setNewFont("res/font/A-Space.otf", 20)
function end_load()
	playagain = {
	x = 285,
	y = 400,
	w = 100,
	h = 50
	}

	menuend = {
	x = 360,
	y = 450,
	w = 100,
	h = 50
	}

	exit = {
  	x = 370,
  	y = 500,
  	w = 50,
  	h = 50
  	}
 end

function end_update(dt)
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
	if player1dead then
		love.graphics.print("Jogador 2 Venceu", 285,75)
	elseif player2dead then
		love.graphics.print("Jogador 1 Venceu", 290,75)
	end

	love.graphics.print("Jogar Novamente", playagain.x, playagain.y)
	love.graphics.print("Menu", menuend.x,menuend.y)
	love.graphics.print("Sair", exit.x, exit.y)
	
end

function game()
	state = "game"
	game_load()
end

function menu()
	state = "menu"
	menu_load()
end