local player1image , player1anim

function player1_load()
	player1 = {
	x =math.random(20,380),
	y = 0,
	speed = 25,
	life = 100,
	w = 30,
	h = 30,
	image = love.graphics.newImage("res/img/player1.png"),
	imagedamaged = love.graphics.newImage("res/img/player1_damage.png")
	}
	player1dead = false


	player1image = love.graphics.newImage("res/img/ship1.png")
	player1animgrid = anim.newGrid(124,123,player1image:getWidth(), player1image:getHeight())
	player1anim = anim.newAnimation(player1animgrid('1-1', 1,'1-1', 2, '1-1', 3, '1-1', 4, '1-1', 5, '1-1', 6, '1-1', 7, '1-1', 8, '1-1', 9 ),0.04)
end

function player1_update(dt)
	grav = 250 
	for i=0, 750, 50 do
		for j = 300, 480, 30 do
			if floor[i][j] == 1 then
				if squarecollision(player1.x-15,player1.y-15, player1.w, player1.h, i,j,w,h) then
					if player1.x< i and player1.y> j and player1.y < j+ h then
						player1.x = player1.x - 1			
					end
					if player1.x > i + w and player1.y> j and player1.y < j+ h then
						player1.x = player1.x + 1
					end				
					if player1.y < j then
						grav = 0					
					end							
				end
			end			
  		end
  	end
  	player1.y = player1.y + grav * dt
  	player1anim:update(dt)
end

function player1_draw()
	--DEBUGGING AND OLD CODE--
	--love.graphics.setColor(16, 211, 140)
	--love.graphics.circle("line", player1.x, player1.y, 50)
	--love.graphics.rectangle("line",player1.x-15, player1.y-15, player1.w,player1.h)
	--love.graphics.setColor(255, 255, 255)
	--DEBUGGING AND OLD CODE--	
	
	player1anim:draw(player1image,player1.x, player1.y-4, 0, 0.27, 0.27, player1image:getWidth()/2,player1image:getHeight()/18)
	--love.graphics.draw(player1.image, 10,525, 0, 0.45,0.45)
	if player1.life <= 0 or player1.y > 600 then
		player1dead = true
		state = "end"
		end_load()
	end	
end

