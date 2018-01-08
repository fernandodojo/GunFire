--https://preview.tinyurl.com/fernando-gunfire
io.stdout:setvbuf("no") --permite fazer debbug do código pelo console interativo do sublime
io.stdout:setvbuf "no" --permite fazer debbug do código pelo console interativo do sublime

require "src/player1"
require "src/player2"
require "src/shot1"
require "src/shot2"
require "src/aiming1"
require "src/aiming2"
require "src/circlecolision"
require "src/squarecollision"
require "src/mouserectanglecollision"
require "src/moviments"
require "src/floor"
require "src/delaytime"
require "src/random"
require "src/menu"
require "src/game"
require "src/end"
require "src/instruction"
require "src/ui"
anim = require "libs/anim8"
gamera = require "libs/gamera"

math.randomseed(os.time()) --inicializador do gerador de numeros aleatórios

function love.keypressed(key)
	if key == "escape" then --permite fechar o jogo usando a tecla esc
		love.event.quit()
	end	
end

function love.load()
	--love.graphics.setDefaultFilter( 'nearest', 'nearest' )--Scale image with nearest neighbor interpolation.
	gamestate = "player1"-- define a vez começando pelo player 1
	state = "menu" -- flag para dizer parte do código devera carregar de acordo com a parte do jogo
	menu_load()	 -- como estado inicial carrega-se todos os arquivos do load pertencenter ao menu.lua
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



--[[a variável state é uma flag q limita a chamada de determinadas parte do código referente a parte do jogo.
No inicio do jogo esta é inicializada com valor "menu", indicando q está no menu do jogo, e dependendo da interação
com o usuário, este estado pode ser alterado para o jogo em sí, ou para as instruções e apenas quando detectado que
um dos jogadores perdeu, o estado é altomáticamente alterado para o final do jogo.]]
