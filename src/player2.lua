function player2_load()
	player2 = {
	x =725,
	y = 400,
	speed = 200,
	life = 100,
	r = 20
	}
end

function player2_update(dt)
	
	for i= 10, 790, 20 do
	    for j = 300, 400, 20 do
		    if circlecolision(i, j, player2.x, player2.y, player2.r + circle.r) then
		        love.graphics.print("colisao", 100,200)
		        if floor[i][j] == 1 then
			        if player2.x < i then	 -- colisÃ£o entre circulo e circulo
			          	player2.x = player2.x -1.1
			          	player2.y = player2.y -1.1
			        elseif player2.x > i then
			          	player2.x = player2.x +1.1
			          	player2.y = player2.y -1.1
			        end
			        if player2.y < j then
			          	player2.y = player2.y -1.1
			        elseif player2.y > j then
			          	player2.y = player2.y -1.1
			        end
			    end
	      	end
	    end
	end
	player2.y = player2.y + player2.speed/10 * dt 
end

function player2_draw()
	love.graphics.circle("fill", player2.x, player2.y, 20)
end


