function player1_load()
	player1 = {
	x =75,
	y = 250,
	speed = 200,
	life = 100
	}
end

function player1_update(dt)
	grav = 250   

	for i=0, 750, 50 do
		for j = 300, 480, 30 do
			if floor[i][j] == 1 then
				if squarecolission(player1.x, player1.y, 15, i, j, w, h ) then
		     		if player1.x< i and player1.y> j and player1.y < j+ h then
						player1.x = player1.x - 5							
					end
					if player1.x > i + w and player1.y> j and player1.y < j+ h then
						player1.x = player1.x + 5
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
end

