--https://stackoverflow.com/questions/21089959/detecting-collision-of-rectangle-with-circle
require "circlecolision"

function love.load()
	player = {}
	player.x =  350
	player.y = 50
	player.speed = 100
	player.r = 30
	
  	

  	circle ={}
  	circle.x = 100
  	circle.y= 100
  	circle.r = 10

  	terreno = {}
  	for i= 100, 700 do
  		terreno[i] = {}
  		for j = 300, 400 do
  			terreno[i][j] = 1
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
end
	

function love.draw()
	love.graphics.circle("fill", player.x, player.y, player.r)
	
	for i= 100, 700, 20 do
  		for j = 300, 400, 20 do
  			love.graphics.circle("line", i, j,  circle.r)
  			if circlecolision(i, j, player.x, player.y, player.r + circle.r) then	 -- colisão entre circulo e quadrado
				love.graphics.print("colisao", 300,0)
			end
		end
	end	
end