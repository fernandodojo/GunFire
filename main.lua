require "squarecolission"

function love.load()
	player = {}
	player.x =  350
	player.y = 50
	player.speed = 100
	

	x= 300
	y = 300
  	h = 25
  	w = 100

  	speedw = player.speed
  	speeda = player.speed
  	speeds = player.speed
  	speedd = player.speed


 	
end

function love.update(dt)
	

	if love.keyboard.isDown("a") and player.x  > 0 then		
		player.x = player.x - speeda * dt
	end
	if love.keyboard.isDown("d") and player.x  < 800  then
		player.x = player.x + speedd * dt
	end
	if love.keyboard.isDown("w") and player.y > 0 then
		player.y = player.y - speedw * dt
	end
	if love.keyboard.isDown("s") and player.y < 600 then
		player.y = player.y + speeds * dt			
	end
end

function love.draw()
	love.graphics.circle("fill", player.x, player.y, 10)	
	love.graphics.rectangle("line", x, y, w, h)
	if squarecolission(player.x, player.y, 10, x, y, w, h ) then
		love.graphics.print("ok", 0, 50)
		if player.x< x and player.y> y then
			speedd = 0
			speedw = player.speed					
		end
		if player.x> x then
			speeda = 0
			speedw = player.speed
		end				
		if player.y< y then
			speeds = 0
			speeda = player.speed						
		end
		--if player.y> y then
			--speedw = 0
			-- = player.speed			
		--end
		
	else
		speedw = player.speed
	  	speeda = player.speed
	  	speeds = player.speed
	  	speedd = player.speed		
	end
end
