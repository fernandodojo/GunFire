function aiming1_load()			
	x1 = 0
	y1 =  0
	angle1 = - 0.785398
	anglespeed1 = 0.3-- change this to the angular speed you want
end

function aiming1_update(dt)
	x1 = player1.x + math.cos(angle1) * 25
	y1 = player1.y + math.sin(angle1) * 25
	
	if love.keyboard.isDown("w") and gamestate == "player1" then
		angle1 = angle1 - anglespeed1 * dt
	end
	if love.keyboard.isDown("s") and gamestate == "player1" then
		angle1 = angle1 + anglespeed1 * dt
	end	
end
 
function aiming1_draw()
	love.graphics.circle("fill", x1, y1, 4)
	--love.graphics.print(angle1, 0,0)
	--love.graphics.print(x1, 0,25)
	--love.graphics.print(y1, 0,50)
end