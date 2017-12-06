function player2_load()
	player2 = {
	x =725,
	y = 250,
	speed = 200,
	life = 100
	}
end

function player2_update(dt)
	grav = 250   

	for i=0, 750, 50 do
		for j = 300, 480, 30 do
			if floor[i][j] == 1 then
				if squarecolission(player2.x, player2.y, 15, i, j, w, h ) then
		     		if player2.x< i and player2.y> j and player2.y < j+ h then
						player2.x = player2.x - 5							
					end
					if player2.x > i + w and player2.y> j and player2.y < j+ h then
						player2.x = player2.x + 5
					end				
					if player2.y < j then
						grav = 0					
					end					
				end
			end			
  		end
  	end
  	player2.y = player2.y + grav * dt
end

function player2_draw()
	love.graphics.circle("fill", player2.x, player2.y, 15)
end

