function player2_load()
	player2 = {
	x =725,
	y = 400,
	speed = 200,
	life = 100
	}
end

function player2_update(dt)
	local speed = 0
	local speed2 = 100
	   

	for i=0, 750, 50 do
		for j = 450, 490, 10 do
			if squarecolission(player2.x, player2.y + 20, i, j, w, h ) then
	     
	     		if floor[i][j] == 1 then
	          		speed2 = 0
	        	else
	          		speed2 = player2.speed
	        	end
	      	end
	      	--if squarecolission(bullets1.x, bullets1.y, i, j, w, h) then
	        --	floor[i][j] = 0
	      	--end
	    end
	end
	player2.y = player2.y + speed2 * dt
end

function player2_draw()
	love.graphics.circle("fill", player2.x, player2.y, 20)
end


