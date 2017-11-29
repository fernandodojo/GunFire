--https://stackoverflow.com/questions/21089959/detecting-collision-of-rectangle-with-circle
require "circlecolision"

function love.load()
	player = {}
	player.x =  350
	player.y = 50
	player.speed = 100  
	player.r = 30
	
  	

  	circle ={}
  	--circle.x = 100
  	--circle.y= 100
  	circle.r = 10

  	floor = {}
  	for i= 10, 790 do
  		floor[i] = {}
  		for j = 300, 400 do
  			floor[i][j] = 1
  		end
  	end 

  	   	
end

function love.update(dt)
				
	if love.keyboard.isDown("a") and player.x  > 0 then		
		player.x = player.x - player.speed * dt
	end
	if love.keyboard.isDown("d") and player.x  < 800  then
		player.x = player.x + player.speed * dt
	end
	if love.keyboard.isDown("w") and player.y > 0 then
		player.y = player.y - player.speed * dt
	end
	if love.keyboard.isDown("s") and player.y < 600 then
		player.y = player.y + player.speed * dt			
	end
  
  for i= 10, 790, 20 do
    for j = 300, 400, 20 do
      if circlecolision(i, j, player.x, player.y, player.r + circle.r) then
        love.graphics.print("colisao", 100,200)
        if player.x < i then	 -- colisÃ£o entre circulo e circulo
          player.x = player.x -1.1
          player.y = player.y -1.1
        elseif player.x > i then
          player.x = player.x +1.1
          player.y = player.y -1.1
        end
        if player.y < j then
          player.y = player.y -1.1
        elseif player.y > j then
          player.y = player.y -1.1
        end
      end
    end
  end 
  
end
	

function love.draw()
	love.graphics.circle("fill", player.x, player.y, player.r)
	
	for i= 10, 790, 20 do
	    for j = 300, 400, 20 do
	  		love.graphics.circle("line", i, j,  circle.r, 6)
	  		if circlecolision(i, j, player.x, player.y, player.r + circle.r) then	 -- colisão entre circulo e quadrado
	        love.graphics.print("colisao", 300,0)
	      end
	    end
	end
end