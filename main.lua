require "squarecolission"

function love.load()
	bullets1 = {}
	bullets1.x =  100
	bullets1.y =  100
	bullets1.speed = 150
	

  player1 = {}
  player1.x =  300
  player1.y = 50
  player1.speed = 100

  h = 20
  w = 50
  
  floor = {}
  for i=0, 750, 50 do
    floor[i] = {}
    for j = 450, 490, 20 do
      floor[i][j] = 1
    end
  end
  colisao = 0

end

function love.update(dt)
  local speed = 0
  local speed2 = 100
   

  for i=0, 750, 50 do
    for j = 450, 490, 20 do
      if squarecolission(player1.x, player1.y, i, j, w, h ) then
        colisao = 0
       
        if floor[i][j] == 1 then
          speed2 = 0
        else
          speed2 = player1.speed
        end
      end
      if squarecolission(bullets1.x, bullets1.y, i, j, w, h) then
        floor[i][j] = 0
      end
    end
  end
  player1.y = player1.y + speed2 * dt


  if love.keyboard.isDown("a") and player1.x  > 0 then   
    player1.x = player1.x - player1.speed * dt
  end
  if love.keyboard.isDown("d") and player1.x  < 800  then
    player1.x = player1.x + player1.speed * dt
  end
  if love.keyboard.isDown("w") and player1.y > 0 then
    player1.y = player1.y - (player1.speed + 300) * dt
  end
  if love.keyboard.isDown("s") and player1.y < 600 then
    player1.y = player1.y + player1.speed * dt     
  end

  

    

	if love.keyboard.isDown("left") and bullets1.x  > 0 then
		bullets1.x = bullets1.x - bullets1.speed * dt
	end
	if love.keyboard.isDown("right") and bullets1.x  < 800 then
		bullets1.x = bullets1.x + bullets1.speed * dt
	end
	if love.keyboard.isDown("up") and bullets1.y > 0 then
		bullets1.y = bullets1.y - bullets1.speed * dt
	end
	if love.keyboard.isDown("down") and bullets1.y < 600 then
		bullets1.y = bullets1.y + bullets1.speed * dt
	end
end

function love.draw()
	love.graphics.circle("fill", bullets1.x, bullets1.y, 10)
  love.graphics.circle("fill", player1.x, player1.y, 10)
  for i=0, 750, 50 do
    for j = 450, 490, 20 do
      if floor[i][j] == 1 then
        love.graphics.rectangle("line", i, j, w, h)
      end
      --[[if squarecolission(bullets1.x, bullets1.y, i, j, w, h) then        
        love.graphics.print("ok", 400 , 0)
      end      
      if squarecolission(player1.x, player1.y, i, j, w, h ) then
        love.graphics.print("ok", 0, 50)
      end]]
    end
  end  
end