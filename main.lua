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
end
	

function love.draw()
	love.graphics.circle("fill", player.x, player.y, player.r)
	love.graphics.circle("line", circle.x, circle.y, circle.r)
	if circlecolision(circle.x, circle.y, player.x, player.y, player.r + circle.r) then	 -- colisão entre circulo e quadrado
		love.graphics.print("colisao", 100,200)
	end	
end



