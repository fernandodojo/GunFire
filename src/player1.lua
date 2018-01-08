local player1image , player1anim

function player1_load()
	player1 = { --tabela referente ao player1
	x =math.random(-200,380), -- coordenada x é aleatoria
	y = -200, -- coordenada y elevada devido a dificultade de alguns computadores gerarem o player acima do chão
	speed = 25, -- velocidade do player
	life = 100, -- vida do player
	w = 30, -- largura do quadrado inscrito no plauer utilizado na colisão
	h = 30, -- alura do quadrado inscrito no plauer utilizado na colisão
	image = love.graphics.newImage("res/img/player1.png"),
	imagedamaged = love.graphics.newImage("res/img/player1_damage.png")
	}
	player1dead = false -- flag para indicar se o player está vivo ou morto


	player1image = love.graphics.newImage("res/img/ship1.png")
	player1animgrid = anim.newGrid(124,123,player1image:getWidth(), player1image:getHeight())
	player1anim = anim.newAnimation(player1animgrid('1-1', 1,'1-1', 2, '1-1', 3, '1-1', 4, '1-1', 5, '1-1', 6, '1-1', 7, '1-1', 8, '1-1', 9 ),0.04)
end

function player1_update(dt)
	grav = 250 --gravidade aplicada especificamente ao player para que este possa colar ao chão
	for i=-200, 950, 50 do
		for j = 300, 480, 30 do
			if floor[i][j] == 1 then
				--[[verifica colisão entre o canto esquerdo superior a 15 pixels do centro do player + altura e largura do mesmo, 
				juntamente com o ponto gerado pela tabela do chão, acrescidos de sua respectiva altura e largura]]
				if squarecollision(player1.x-15,player1.y-15, player1.w, player1.h, i,j,w,h) then --TODA E QUALQUER CONDIÇÃO ABAIXO SO É TESTADA QUANDO OCORRE COLISÃO-- evitando ativação de limitação quando o player não esta em contato com o chão.
					if player1.x< i and player1.y> j and player1.y < j+ h then -- condição q verifica se o player esta a esquer da um bloco assim como abaixo do ponto de inicio do mesmo
						player1.x = player1.x - 1	-- o player volta uma coordenada a esquerda.		
					end
					if player1.x > i + w and player1.y> j and player1.y < j+ h then --verifica se o player esta a direita de um bloco, assim como dentros dos limite de altura do mesmo
						player1.x = player1.x + 1 --o player volta uma coordenada a direita
					end				
					if player1.y < j then -- verifica se o player esta de fato acima do chão.
						grav = 0					
					end							
				end
			end			
  		end
  	end
  	player1.y = player1.y + grav * dt -- define q o player estara o tempo todo sob efeito da gravidade, 
  	player1anim:update(dt)

  	if player1.life <= 0 or player1.y > 600 then -- condição para vida do player assim como mudança de estado do jogo
		player1dead = true
		state = "end"
		end_load()
	end	
end

function player1_draw()
	--DEBUGGING AND OLD CODE--
	--love.graphics.setColor(16, 211, 140)
	--love.graphics.circle("line", player1.x, player1.y, 50)
	--love.graphics.rectangle("line",player1.x-15, player1.y-15, player1.w,player1.h)
	--love.graphics.setColor(255, 255, 255)
	--DEBUGGING AND OLD CODE--	
	
	player1anim:draw(player1image,player1.x, player1.y-4, 0, 0.27, 0.27, player1image:getWidth()/2,player1image:getHeight()/18) -- desenho do player
	--[[if player1.life <= 0 or player1.y > 600 then -- condição para vida do player
		player1dead = true
		state = "end"
		end_load()
	end	]]
end

