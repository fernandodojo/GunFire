local player2image , player2anim

function player2_load()
	player2 = { --tabela referente ao player1
	x =math.random(420,990), -- coordenada x é aleatoria
	y = -200, -- coordenada y elevada devido a dificultade de alguns computadores gerarem o player acima do chão
	speed = 25, -- velocidade do player
	life = 100, -- vida do player
	w = 30, -- largura do quadrado inscrito no plauer utilizado na colisão
	h = 30, -- alura do quadrado inscrito no plauer utilizado na colisão
	image = love.graphics.newImage("res/img/player2.png"),
	imagedamaged = love.graphics.newImage("res/img/player2_damage.png")
	}

	player2dead = false -- flag para indicar se o player está vivo ou morto

	player2image = love.graphics.newImage("res/img/ship2.png")
	player2animgrid = anim.newGrid(124,127,player2image:getWidth(), player2image:getHeight())
	player2anim = anim.newAnimation(player2animgrid('1-1', 1,'1-1', 2, '1-1', 3, '1-1', 4, '1-1', 5, '1-1', 6, '1-1', 7, '1-1', 8, '1-1', 9 ),0.04)
end

function player2_update(dt)
	grav = 250 --gravidade aplicada especificamente ao player para que este possa colar ao chão
	for i=-200, 950, 50 do
		for j = 300, 480, 30 do
			if floor[i][j] == 1 then
				--[[verifica colisão entre o canto esquerdo superior a 15 pixels do centro do player + altura e largura do mesmo, 
				juntamente com o ponto gerado pela tabela do chão, acrescidos de sua respectiva altura e largura]]
				if squarecollision(player2.x-15,player2.y-15, player2.w, player2.h, i,j,w,h) then --TODA E QUALQUER CONDIÇÃO ABAIXO SO É TESTADA QUANDO OCORRE COLISÃO-- evitando ativação de limitação quando o player não esta em contato com o chão.
					if player2.x< i and player2.y> j and player2.y < j+ h then -- condição q verifica se o player esta a esquer da um bloco assim como abaixo do ponto de inicio do mesmo
						player2.x = player2.x - 1	-- o player volta uma coordenada a esquerda.		
					end
					if player2.x > i + w and player2.y> j and player2.y < j+ h then
						player2.x = player2.x + 1 --o player volta uma coordenada a direita
					end				
					if player2.y < j then
						grav = 0	-- verifica se o player esta de fato acima do chão.				
					end			
				end
			end			
  		end
  	end
  	player2.y = player2.y + grav * dt -- define q o player estara o tempo todo sob efeito da gravidade, 
  	player2anim:update(dt)

  	if player2.life <= 0 or player2.y > 600 then -- condição para vida do player assim como mudança de estado do jogo
		player2dead = true
		state = "end"
		end_load()
	end
end

function player2_draw()
	--DEBUGGING AND OLD CODE--
	--love.graphics.setColor(242, 94, 133)
	--love.graphics.circle("line", player2.x, player2.y, 70)
	--love.graphics.rectangle("line",player2.x-15, player2.y-15, player2.w,player2.h)
	--love.graphics.setColor(255, 255, 255)	
	--DEBUGGING AND OLD CODE--
	
	player2anim:draw(player2image,player2.x, player2.y-4, 0, 0.27, 0.27, player2image:getWidth()/2,player2image:getHeight()/18)
	--[[if player2.life <= 0 or player2.y > 600 then
		player2dead = true
		state = "end"
		end_load()
	end]]
end

