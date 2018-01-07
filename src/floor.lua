function floor_load()
  floor = {} --tabela que acomoda a geração de cada ponto esquerdo superior de cada bloco do chão
  for i=-200, 950, 50 do -- cada variação do indice i, indica o ponto de origem de cada bloco no eixo x.
    floor[i] = {}
    for j = 300, 480, 30 do -- cada variação do indice j indica o ponto de origem de cada bloco no eixo y.
      floor[i][j] = 1 --cada indice [i][j] da tabela recebe o valor 1 que funciona como uma flag para posterior desenho e detecção de toque.
    end
  end
  w = 50 --comprimento de cada bloco
  h = 30 --altura de cada bloco
  moonfloor = love.graphics.newImage("res/img/moonfloor.png") --imagem de cada bloco
end

function floor_update(dt)

end

function floor_draw()
  for i=-200, 950, 50 do
    for j = 300, 480, 30 do
      if floor[i][j] == 1 then
        love.graphics.draw(moonfloor, i, j)
        --love.graphics.rectangle("line", i, j, w, h)
        --love.graphics.circle("line", i, j, 3)
      end         
    end
  end
end
