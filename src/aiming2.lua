function aiming2_load()			
	x2 = 0
	y2 =  0
	angle2 = 0	
	anglespeed2 = 1 -- change this to the angular speed you want
end

function aiming2_update(dt)
	--
	x2 = player2.x - math.cos(angle2) * 25
	y2 = player2.y - math.sin(angle2) * 25
	
	if love.keyboard.isDown("up") then
		angle2 = angle2 + anglespeed2 * dt
	end
	if love.keyboard.isDown("down") then
		angle2 = angle2 - anglespeed2 * dt
	end	
end
 
function aiming2_draw()
	love.graphics.circle("fill", x2, y2, 4)
	--love.graphics.print(angle2, 100,0)
	--love.graphics.print(x2, 100,25)
	--love.graphics.print(y2, 100,50)
end