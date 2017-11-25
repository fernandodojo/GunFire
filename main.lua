--https://stackoverflow.com/questions/21089959/detecting-collision-of-rectangle-with-circle
require "squarecolission"
require "circlecolision"

function love.load()
	player = {}
	player.x =  350
	player.y = 50
	player.speed = 100
	
  	

  	retangulo ={}
  	retangulo.x = 300
  	retangulo.y= 300

  	h = 25
  	w = 100


   	
end

function love.update(dt)
	local speed = 0
	local speed2 = player.speed
	if squarecolission(player.x, player.y, retangulo.x, retangulo.y, w, h ) then
		speed2 = 0
	end
			
	if love.keyboard.isDown("a") and player.x  > 0 then		
		player.x = player.x - speed2 * dt
	end
	if love.keyboard.isDown("d") and player.x  < 800  then
		player.x = player.x + player.speed * dt
	end
	if love.keyboard.isDown("w") and player.y > 0 then
		player.y = player.y - (player.speed + 200) * dt
	end
	if love.keyboard.isDown("s") and player.y < 600 then
		player.y = player.y + speed2 * dt			
	end
	

	b = (retangulo.x + w/2) - player.x
	c = (retangulo.y + h/2) - player.y
	if ( b < 10 + w/2 and b > (10 + w/2)*-1) and (c < 10 + h/2 and c > (10 + h/2)* -1) then
		player.x = player.x -2
	end
end

function love.draw()
	love.graphics.circle("fill", player.x, player.y, 10, 6)
	love.graphics.rectangle("line", retangulo.x, retangulo.y, w, h)
	love.graphics.print(b, 100, 100)
	if ( b < 10 + w/2 and b > (10 + w/2)*-1) and (c < 10 + h/2 and c > (10 + h/2)* -1) then	 -- colisão entre circulo e quadrado
		love.graphics.print("colisao", 100,200)
	end	
	if squarecolission(player.x, player.y, retangulo.x, retangulo.y, w, h ) then
		love.graphics.print("ok", 0, 50)
	end
end



--[[

require "squarecolission"

function love.load()
	player = {}
	player.x =  350
	player.y = 50
	player.speed = 100
	

  	h = 25
  	w = 100


  	terreno = {}
  	for i= 100, 400 do
  		terreno[i] = {}
  		for j = 300, 325 do
  			terreno[i][j] = 1
  		end
  	end 	
end

function love.update(dt)
	local speed = 0
	local speed2 = player.speed
	for i= 100, 400, 100 do
  		for j = 300, 400, 25 do
  			if terreno[i][j] == 1 then
  				if squarecolission(player.x, player.y, i, j, w, h ) then
					speed2 = 0
				end
			end  			
  		end
  	end

	if love.keyboard.isDown("a") and player.x  > 0 then		
		player.x = player.x - player.speed * dt
	end
	if love.keyboard.isDown("d") and player.x  < 800  then
		player.x = player.x + player.speed * dt
	end
	if love.keyboard.isDown("w") and player.y > 0 then
		player.y = player.y - (player.speed + 200) * dt
	end
	if love.keyboard.isDown("s") and player.y < 600 then
		player.y = player.y + speed2 * dt			
	end
end

function love.draw()
	love.graphics.circle("fill", player.x, player.y, 10)
	for i= 100, 400, 100 do
  		for j = 300, 325, 25 do
		    love.graphics.rectangle("line", i, j, w, h)
		    if squarecolission(player.x, player.y, i, j, w, h ) then
				love.graphics.print("ok", 0, 50)
			end
		end
	end
end
]]