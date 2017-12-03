function player1_load()
	player1 = {
	x =75,
	y = 350,
	speed = 200,
	life = 100,
	r = 20
	}
end

function player1_update(dt)
	speed2 = player1.speed
		  
	for i= 10, 810, 30 do
	    for j = 400, 500, 30 do
		    if circlecolision(i, j, player1.x, player1.y, player1.r + circle.r) and floor[i][j] == 1 then
		        love.graphics.print("colisao", 100,200)		       
		        if player1.x < i then	 -- colisÃ£o entre circulo e circulo
			       	player1.x = player1.x -2
			    elseif player1.x > i then
			       	player1.x = player1.x +2			       	
			    end
			    if player1.y < j  then
			        speed2 = 0
			        --player1.y = player1.y - 3.1		
			    elseif player1.y > j  then
			        player1.y = player1.y - 1.1		        		        
			    end
	      	end
	    end
	end
	player1.y = player1.y + speed2 * dt 
end

function player1_draw()
	love.graphics.circle("fill", player1.x, player1.y, player1.r)
end

