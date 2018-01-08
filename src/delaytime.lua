delayfont = love.graphics.setNewFont("res/font/A-Space.otf", 18)
function delaytime_load()
	--tempo pra cada jogador fazer a jogada--
	delay = {
	init = 31, -- o tempo inicial predefinido, sempre será 31.
	temp = 31, -- variavel q irá guardar o tempo que será de fato decrementado a cada segundo
	print1 = 30 --variável que sera começara imprimindo o valor 30 e irá decrementando a medida que o delay.temp decrementar
	}

	--tempo predefinido para chamada da função de mudança de vento
	delayrandom={
	init = 10,
	temp = 10
	}

	--tabela de varias do objeto estrela.
	star = {
	x = 400,
	y =100 ,
	speed = 10	 
	}

	--requisitos para animação da estrela central
	starimage = love.graphics.newImage("res/img/star2.png")
	staranimgrid = anim.newGrid(256,256,starimage:getWidth(), starimage:getHeight())
	staranim = anim.newAnimation(staranimgrid('1-17', 1),0.07)
end

function delaytime_update(dt)
	math.randomseed(os.time())-- gerador inicial do gerador de numeros aleatorios
	
	--[[basicamente verifica se a variavel de tempo temporario é maior q 0, se for ela será decrementada até chegar a zero. Quando esta chegar
	a zero, ela voltara a assumir seu valor inicial, assim como alterará a vez do jogador zerando sua ultima configuração de força e deslocamento]]
	if delay.temp >0 then
		delay.temp = delay.temp - dt
		if (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then
			delay.print1 = 30
		else
			delay.print1 = math.floor(delay.temp)
		end
	elseif delay.temp <=0 then
		delay.temp = delay.init
		if gamestate == "player1" then
			gamestate = "player2"
			strength2 = 0
			motionlimiter2 = 50
		elseif gamestate == "player2" then
			gamestate = "player1"
			strength1 = 0
			motionlimiter1 = 50
		end
	end

	--ira decrementar o tempo enquando for maior q zero, quando for menor ou igual a zero a função de mudança de ventos será chamada
	if delayrandom.temp > 0 then
		delayrandom.temp = delayrandom.temp - dt
	elseif delayrandom.temp<=0 then
		delayrandom.temp = delayrandom.init
		random()
	end

	--[[é feito a delimitação da área permitida a movimentação da estrela, esta irá acompanhar a velocidade e direção do vento. Tem como 
	finalidade ajudar o player a enteder o movimento do vento]]
	if star.x >= 50 and star.x <= 750 then 
		star.x = star.x +(7* ventohorizontal) * dt
		if star.x < 50 then
			star.x = 50
		elseif star.x > 750 then
			star.x = 750
		end
	end
	if star.y >= 65 and star.y <= 250 then 
		star.y = star.y +(7* ventovertical) * dt
		if star.y < 65 then
			star.y = 65
		elseif star.y > 250 then
			star.y = 250
		end
	end
	staranim:update(dt)
end

function delaytime_draw()
	--love.graphics.circle("line", star.x, star.y, 10)
	staranim:draw(starimage,star.x, star.y, 0, 0.5, 0.5, starimage:getWidth()/34,starimage:getHeight()/2)
end
