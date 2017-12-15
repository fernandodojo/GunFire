--https://www.youtube.com/watch?v=rlU4dxD9Ak0
--https://www.youtube.com/watch?v=A1DQ-BbqOX8


require "src/moviments"
require "src/player1"
require "src/player2"
require "src/shot1"
require "src/shot2"
require "src/circlecolision"
require "src/floor"
require "src/squarecolission"
require "src/delaytime"

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.load()
	mx = 0
	my = 0
	gamestate = "player1"
	moviments_load()
	delaytime_load()
	player1_load()
	player2_load()
	shot1_load()
	shot2_load()
	floor_load()
end

function love.update(dt)

	moviments_update(dt)
	delaytime_update(dt)
	player1_update(dt)
	player2_update(dt)
	shot1_update(dt)
	shot2_update(dt)
	floor_update(dt)
end

function love.draw()

	moviments_draw()
	delaytime_draw()
	player1_draw()
	player2_draw()
	shot1_draw()
	shot2_draw()
	floor_draw()
end

function love.mousepressed(x, y, button)
	if gamestate == "player1" then
		shot1_mousepressed(x, y, button)
	end
	if gamestate == "player2" then
		shot2_mousepressed(x, y, button)
	end
end
