require "squarecolission"

function love.load()
	player = {}
	player.x =  350
	player.y = 50
	player.speed = 100

	speedw = player.speed + 100
  	speeda = player.speed
  	speeds = player.speed
  	speedd = player.speed

  	bala = {
  	x = 200,
  	y = 200,
  	speed = 200
  	}
	

  	h = 20
  	w = 50


  	floor = {}
  	for i=100, 650, 50 do	    	
  		floor[i] = {}
  		for j = 400, 500, 20 do
  			floor[i][j] = 1
  		end
  	end 	
end

function love.update(dt)
	gravity = 100

	if love.keyboard.isDown("a") and player.x  > 0 then		
		player.x = player.x - speeda * dt
	end
	if love.keyboard.isDown("d") and player.x  < 800  then
		player.x = player.x + speedd * dt
	end
	if love.keyboard.isDown("w") and player.y > 0 then
		player.y = player.y - speedw * dt
	end

	if love.keyboard.isDown("left") and bala.x  > 0 then		
		bala.x = bala.x - speeda * dt
	end
	if love.keyboard.isDown("right") and bala.x  < 800  then
		bala.x = bala.x + speedd * dt
	end
	if love.keyboard.isDown("up") and bala.y > 0 then
		bala.y = bala.y - speedw * dt
	end
	if love.keyboard.isDown("down") and bala.y > 0 then
		bala.y = bala.y + speeds * dt
	end


	

	for i=100, 650, 50 do
	    for j = 400, 500, 20 do
  			if squarecolission(bala.x, bala.y, 5,i,j,w,h) and floor[i][j] == 0 then
  				floor[i][j] = 0
  			end
  			if floor[i][j] == 1 then
	  			if squarecolission(player.x, player.y, 10, i, j, w, h ) then
					love.graphics.print("ok", 0, 50)
					if player.x< i and player.y> j and player.y < j+ h then
						player.x = player.x - 2							
					end
					if player.x > i + w and player.y> j and player.y < j+ h then
						player.x = player.x + 2
					end				
					if player.y < j then
						gravity = 0					
					end					
				end
			end			
  		end
  	end
  	player.y = player.y + gravity * dt


end

function love.draw()
	love.graphics.circle("fill", player.x, player.y, 10)
	love.graphics.circle("fill", bala.x, bala.y, 5)
	for i=100, 650, 50 do
	    	for j = 400, 500, 20 do
		    love.graphics.rectangle("line", i, j, w, h)
		    if squarecolission(player.x, player.y, 10, i, j, w, h ) then
				love.graphics.print("ok", 0, 50)
			end
		end
	end
end
