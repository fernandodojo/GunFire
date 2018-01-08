--ARQUIVO UTILIZADO PARA DESENHOS DE TODA E QUALQUER COISA DE OUTROS CÓDIGOS QUE NÃO DEVEM SER AFETADOS PELA MOVIMENTAÇÃO DA CAMERA--
function ui_load()
	
--VARIAÇÃO DE TODAS AS DIREÇÕES COM NIVEIS DE INTESIDADE DAS SETAS--
	arrows={
	left = love.graphics.newImage("res/img/left.png"),
	right = love.graphics.newImage("res/img/right.png"),
	up = love.graphics.newImage("res/img/up.png"),
	down = love.graphics.newImage("res/img/down.png"),
	downleft = love.graphics.newImage("res/img/downleft.png"),
	upleft = love.graphics.newImage("res/img/upleft.png"),
	downright = love.graphics.newImage("res/img/downright.png"),
	upright = love.graphics.newImage("res/img/upright.png"),
	fastleft = love.graphics.newImage("res/img/fastleft.png"),
	fastright = love.graphics.newImage("res/img/fastright.png"),
	fastdown = love.graphics.newImage("res/img/fastdown.png"),
	fastdownleft = love.graphics.newImage("res/img/fastdownleft.png"),
	fastupleft = love.graphics.newImage("res/img/fastupleft.png"),
	fastdownright = love.graphics.newImage("res/img/fastdownright.png"),
	fastupright = love.graphics.newImage("res/img/fastupright.png"),
	fastdowndownright = love.graphics.newImage("res/img/fastdowndownright.png"),
	fastdowndownleft = love.graphics.newImage("res/img/fastdowndownleft.png"),
	fastleftleftdown = love.graphics.newImage("res/img/fastleftleftdown.png"),
	fastrightrightdown = love.graphics.newImage("res/img/fastrightrightdown.png"),
	}
--VARIAÇÃO DE TODAS AS DIREÇÕES COM NIVEIS DE INTESIDADE DAS SETAS--

end

function ui_update(dt)

end

function ui_draw()
	love.graphics.setFont(delayfont) --fonte durante o jogo
	love.graphics.print(delay.print1, 395,25)
	if gamestate == "player1" then
		love.graphics.print("Player 1", 360, 0)
	elseif gamestate == "player2" then
		love.graphics.print("Player 2", 360, 0)
	end

	love.graphics.print("Vento", 580, 0)

	if ventovertical == -1 then
		if ventohorizontal == 0 then
			love.graphics.draw(arrows.up,605,25, 0, 0.3)
		elseif ventohorizontal == 1 then
			love.graphics.draw(arrows.upright,605,25, 0, 0.3)
		elseif ventohorizontal == -1 then
			love.graphics.draw(arrows.upleft,605,25, 0, 0.3)
		elseif ventohorizontal == 2 then
			love.graphics.draw(arrows.fastupright,605,25, 0, 0.3)
		elseif ventohorizontal == -2  then
			love.graphics.draw(arrows.fastupleft,605,25, 0, 0.3)
		end		
	elseif ventovertical == 0 then
		if ventohorizontal ==-1 then
			love.graphics.draw(arrows.left,605,25, 0, 0.3)
		elseif ventohorizontal == 1 then
			love.graphics.draw(arrows.right,605,25, 0, 0.3)
		elseif ventohorizontal == -2 then
			love.graphics.draw(arrows.fastleft,605,25, 0, 0.3)
		elseif ventohorizontal == 2 then
			love.graphics.draw(arrows.fastright,605,25, 0, 0.3)
		elseif ventohorizontal == 0 then
			love.graphics.print("0", 610, 25)
		end
	elseif ventovertical == 1 then
		if ventohorizontal == 0 then
			love.graphics.draw(arrows.down,605,25, 0, 0.3)
		elseif ventohorizontal ==1 then
			love.graphics.draw(arrows.downright,605,25, 0, 0.3)
		elseif ventohorizontal== -1 then
			love.graphics.draw(arrows.downleft,605,25, 0, 0.3)
		elseif ventohorizontal ==2 then
			love.graphics.draw(arrows.fastdownright,605,25, 0, 0.3)
		elseif ventohorizontal== -2 then
			love.graphics.draw(arrows.fastdownleft,605,25, 0, 0.3)
		end
	elseif ventovertical ==2 then
		if ventohorizontal == -1 then
			love.graphics.draw(arrows.fastleftleftdown,605,25, 0, 0.3)
		elseif ventohorizontal == 0 then
			love.graphics.draw(arrows.fastdown,605,25, 0, 0.3)
		elseif ventohorizontal == 1 then
			love.graphics.draw(arrows.fastrightrightdown,605,25, 0, 0.3)
		elseif ventohorizontal ==2  then
			love.graphics.draw(arrows.fastdowndownright,605,25, 0, 0.3)
		elseif ventohorizontal== -2 then
			love.graphics.draw(arrows.fastdowndownleft,605,25, 0, 0.3)
		end
	--elseif ventovertical==0 and ventohorizontal1 == 0 then
		--love.graphics.print("0", 615, 25)		
	end

	love.graphics.draw(player1.image, 10,525, 0, 0.45,0.45) --imagem do player1
	love.graphics.draw(player2.image, 400,525, 0, 0.45,0.45) --imagem do player2

	love.graphics.setFont(gamefont)
	--BARRA DE FORÇA PLAYER1--	
	love.graphics.print(strength1, (strength1 + 126)/1.66, 531)	
	love.graphics.setColor(216, 136, 32)
	love.graphics.rectangle("line", strengthline1.x, strengthline1.y, strengthline1.w, strengthline1.h)
	love.graphics.rectangle("fill", strengthline1.x, strengthline1.y, strength1/1.66, strengthline1.h)
	love.graphics.setColor(255,255,255)
	--BARRA DE FORÇA PLAYER1--	

	--BARRA DE FORÇA PLAYER2--
	love.graphics.print(strength2, (strength2 + 772)/1.66, 531) -- impressão da força de tiro
	love.graphics.setColor(216, 136, 32)
	love.graphics.rectangle("line", strengthline2.x, strengthline2.y, strengthline2.w, strengthline2.h)
	love.graphics.rectangle("fill", strengthline2.x, strengthline2.y, strength2/1.66, strengthline2.h)
	love.graphics.setColor(255,255,255)
	--BARRA DE FORÇA PLAYER2--

	--BARRA DE MOVIMENTO--
	love.graphics.setColor(32, 166, 216)
	love.graphics.rectangle("line", motion1.x, motion1.y, motion1.w, motion1.h)
	love.graphics.rectangle("fill", motion1.x, motion1.y, motionlimiter1*6, motion1.h)
	--BARRA DE MOVIMENTO--

	--BARRA DE FORÇA--
	love.graphics.rectangle("line", motion2.x, motion2.y, motion2.w, motion2.h)
	love.graphics.rectangle("fill", motion2.x, motion2.y, motionlimiter2*6, motion2.h)
	--BARRA DE FORÇA--
	love.graphics.setColor(255,255,255)
end