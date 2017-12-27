function floor_load()
  floor = {}
  for i=0, 750, 50 do
    floor[i] = {}
    for j = 300, 480, 30 do
      floor[i][j] = 1
    end
  end
  w = 50
  h = 30
  moonfloor = love.graphics.newImage("res/img/moonfloor.png")

end

function floor_update(dt)

end

function floor_draw()
  for i=0, 750, 50 do
    for j = 300, 480, 30 do
      if floor[i][j] == 1 then
        love.graphics.draw(moonfloor, i, j)
      end         
    end
  end
end
