function floor_load()
	floor = {}
	for i=0, 750, 50 do
		floor[i] = {}
		for j = 450, 490, 10 do
			floor[i][j] = 1
		end
	end
	w = 50
	h = 10

end

function floor_update(dt)

end

function floor_draw()
	for i=0, 750, 50 do
    	for j = 450, 490, 10 do
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
