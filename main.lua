--https://stackoverflow.com/questions/21089959/detecting-collision-of-rectangle-with-circle
require "circlecolision"

function love.load()
	player = {}
	player.x =  350
	player.y = 50
	player.speed = 100
	player.r = 30
	
  	

  	circle ={}
  	circle.x = 300
  	circle.y= 300
  	circle.r = 10
  	speed2 = 0

  	  	   	
end

function love.update(dt)
	speed2 = 50
				
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

	if circlecolision(circle.x, circle.y, player.x, player.y, player.r + circle.r) then
		love.graphics.print("colisao", 100,200)
		if player.x < circle.x then	 -- colisão entre circulo e circulo			
			player.x = player.x -2
			player.y = player.y -1
		elseif player.x > circle.x then
			player.x = player.x +2
			player.y = player.y -1
	    end
	    if player.y < circle.y then
	    	speed = 0
			--player.y = player.y -2
	    elseif player.y > circle.y then
			player.y = player.y -2		
	    end
	end
	player.y = player.y + speed2 * dt		

end
	


function love.draw()
	love.graphics.circle("fill", player.x, player.y, player.r)
	love.graphics.circle("line", circle.x, circle.y, circle.r)
	if circlecolision(circle.x, circle.y, player.x, player.y, player.r + circle.r +2) then	 -- colisão entre circulo e quadrado
		love.graphics.print("colisao", 100,200)
	end	
end



