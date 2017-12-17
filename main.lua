io.stdout:setvbuf("no")
io.stdout:setvbuf "no"

require "src/player1"
require "src/player2"
require "src/shot1"
require "src/shot2"
require "src/aiming1"
require "src/aiming2"
require "src/circlecolision"
require "src/squarecollision"
require "src/mousecirclecollision"
require "src/mouserectanglecollision"
require "src/moviments"
require "src/floor"
require "src/delaytime"
require "src/random"
require "src/menu"
require "src/game"
require "src/end"
require "src/instruction"

anim = require "libs/anim8"

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.load()
	gamestate = "player1"
	state = "menu"
	menu_load()
end

function love.update(dt)
	if state == "menu" then
		menu_update(dt)
	elseif state == "instruction" then
		instruction_update(dt)
	elseif state == "game" then
		game_update(dt)
	elseif state == "end" then
		end_update(dt)
	end
end

function love.draw()
	if state == "menu" then
		menu_draw(dt)
	elseif state == "instruction" then
		instruction_draw()
	elseif state == "game" then
		game_draw()
	elseif state == "end" then
		end_draw()
	end
end


