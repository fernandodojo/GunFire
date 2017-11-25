function player1_load()
	player1 = {
	x =75,
	y = 400,
	speed = 200,
	life = 100
	}
end

function player1_update(dt)
	local speed = 0
	local speed2 = 100
	   

	for i=0, 750, 50 do
		for j = 450, 490, 10 do
			if squarecolission(player1.x, player1.y + 20, i, j, w, h ) then
	     
	     		if floor[i][j] == 1 then
	          		speed2 = 0
	        	else
	          		speed2 = player1.speed
	        	end
	      	end
	      	--if squarecolission(bullets1.x, bullets1.y, i, j, w, h) then
	        --	floor[i][j] = 0
	      	--end
	    end
	end
	player1.y = player1.y + speed2 * dt
end

function player1_draw()
	love.graphics.circle("fill", player1.x, player1.y, 20)
end

