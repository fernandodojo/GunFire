function menu_load()
	mx = 0
	my = 0

	start={
	x = 355,
  	y = 400,
  	w= 100,
  	h = 50
  	}

  	instructions = {
	x = 357,
	y = 450,
	w = 100,
	h = 50
	}

  	exit={
  	x = 375,
  	y = 500,
  	w = 50,
  	h = 50
  	}  	
end

function menu_update()
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
	love.graphics.print("GUNFIRE", 365, 150)
	love.graphics.print("Iniciar Jogo", start.x, start.y)
	love.graphics.print("Instruções", instructions.x,instructions.y)
	love.graphics.print("Sair", exit.x, exit.y)
end

function game()
	state = "game"
	game_load()
end

function instruction()
	state = "instruction"
	instruction_load()
end