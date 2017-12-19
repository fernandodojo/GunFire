
function menu_load()
	mx = 0
	my = 0

	start={
	x = 355,
  	y = 450,
  	w= 100,
  	h = 30
  	}

  	instructions = {
	x = 158,
	y = 450,
	w = 147,
	h = 30
	}

  	exit={
  	x = 505,
  	y = 450,
  	w = 57,
  	h = 30
  	}

  	menuimage = love.graphics.newImage("res/img/bakchgroundmenu.png")
	fontetitle = love.graphics.setNewFont("res/font/Ailerons.otf", 100) 
	fontmenu = love.graphics.setNewFont("res/font/Ailerons.otf", 25) 	 	
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
	love.graphics.draw(menuimage, 0, 0)
	love.graphics.setFont(fontetitle)
	love.graphics.printf("GUNFIRE", 200, 137, 450)
	love.graphics.setColor(255,255,255)

	love.graphics.setFont(fontmenu)
	love.graphics.rectangle("line", start.x, start.y, start.w, start.h)
	love.graphics.printf("Iniciar", start.x, start.y, 250)

	love.graphics.rectangle("line", instructions.x, instructions.y, instructions.w, instructions.h)
	love.graphics.printf("Instruções", instructions.x,instructions.y, 250)

	love.graphics.rectangle("line", exit.x, exit.y, exit.w, exit.h)
	love.graphics.printf("Sair", exit.x, exit.y, 250)
end

function game()
	state = "game"
	game_load()
end

function instruction()
	state = "instruction"
	instruction_load()
end