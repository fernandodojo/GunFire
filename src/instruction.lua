function instruction_load()

	menuback={
	x = 50,
  	y = 500,
  	w = 50,
  	h = 50
  	}

	start={
  	x = 675,
  	y = 500,
  	w = 50,
  	h = 50
  	}	

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
	love.graphics.print("Use as teclas A, D para mover o Jogador 1 e as setas ESQUERDA ou DIREITA para mover o Jogador 2.", 50,100)
	love.graphics.print("Use as teclas W, S para mover a mira do Jogador 1 e as setas  CIMA e BAIXO para mover a mira do Jogador 2.", 50,125)
	love.graphics.print("Use a tecla SPACE para carregar a força desejada para lançamento do projétil", 50 ,150)
	love.graphics.print("Use o mouse (CLICK 1) para realizar o lançamento.",50,175)

	love.graphics.print("O objetivo do jogo é matar o adversário, calculando intuitivamente a força e mira necessária para acerta-lo.",50,375)
	love.graphics.print("Considere a variação do vendo, gravidade e tempo antes de realizar o laçamento.",50,400)
	love.graphics.print("Tiros com grande altitude, força ou durante periodos de gravidade intensa podem causar até o dobro de dano.",50,425)

	love.graphics.print("Menu", menuback.x,menuback.y)
	love.graphics.print("Iniciar Jogo", start.x, start.y)
end