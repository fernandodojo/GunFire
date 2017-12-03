function floor_load()
  circle ={}
    --circle.x = 100
    --circle.y= 100
    circle.r = 15

    floor = {}
    for i= 10, 810 do
      floor[i] = {}
      for j = 400, 500 do
        floor[i][j] = 1
      end
    end 

end

function floor_update(dt)

end

function floor_draw()
  for i= 10, 810, 30 do
      for j = 400, 500, 30 do
          if floor[i][j] == 1 then
            love.graphics.circle("line", i, j,  circle.r, 8)
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
