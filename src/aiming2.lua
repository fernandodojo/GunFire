function aiming2_load()			
	x2 = 0
	y2 =  0
	angle2 = 0.785398
	anglespeed2 = 0.3 -- change this to the angular speed you want
end

function aiming2_update(dt)
	x2 = player2.x - math.cos(angle2) * 25
	y2 = player2.y - math.sin(angle2) * 25
	
	if love.keyboard.isDown("kp8") and gamestate == "player2" then
		angle2 = angle2 + anglespeed2 * dt
		if play then
			aimsound:play()
		end
	end
	if love.keyboard.isDown("kp5") and gamestate == "player2"then
		angle2 = angle2 - anglespeed2 * dt
		if play then
			aimsound:play()
		end
	end	
end
 
function aiming2_draw()
	love.graphics.setColor(255, 63, 0)
	love.graphics.circle("fill", x2, y2, 4)
	love.graphics.setColor(255, 255, 255)
	--love.graphics.print(angle2, 100,0)
	--love.graphics.print(x2, 100,25)
	--love.graphics.print(y2, 100,50)
end