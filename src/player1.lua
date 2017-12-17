function player1_load()
	player1 = {
	x =75,
	y = 250,
	speed = 25,
	life = 100,
	w = 15,
	h = 15
	}
	player1dead = false
end

function player1_update(dt)
	grav = 250 
	for i=0, 750, 50 do
		for j = 300, 480, 30 do
			if floor[i][j] == 1 then
				if squarecollision(player1.x-15,player1.y-15, 30, 30, i,j,w,h) then
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
end

function player1_draw()
	love.graphics.circle("fill", player1.x, player1.y, 15)
	--love.graphics.rectangle("line",player1.x-15, player1.y-15, 30,30)
	if player1.life <= 0 or player1.y > 600 then
		player1dead = true
		state = "end"
		end_load()
	end
end

