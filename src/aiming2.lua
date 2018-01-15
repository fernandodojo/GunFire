--https://www.love2d.org/forums/viewtopic.php?f=4&t=35233#p104896
function aiming2_load()			
	x2 = 0 -- posição inicial no eixo x
	y2 =  0 -- posição inicial no eixo y
	angle2 = 0.785398 --angulo inicial em radianos, equivalente a 45°
	anglespeed2 = 0.3 -- change this to the angular speed you want
end

function aiming2_update(dt)
	--posição da bolinha de mira é definida pela coordenada do player + 25 * o coseno do angulo inicial dado--
	x2 = player2.x - math.cos(angle2) * 25
	y2 = player2.y - math.sin(angle2) * 25
	
	if love.keyboard.isDown("kp8") and gamestate == "player2" and movimentsflag2 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then --permite-se mudar o valor do angulo ao pressionar w caso seja a vez deste jogador
		angle2 = angle2 + anglespeed2 * dt
		if play and noise then --o som de movimento de angulo é ativado.
			aimsound:play()
		end
		gameraflag2 = true --apartir desta flag é possivel ativar a camera zoom para seguir o player 1 enquano não houve bala do mesmo na tela
	end
	if love.keyboard.isDown("kp5") and gamestate == "player2" and movimentsflag2 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then --permite-se mudar o valor do angulo ao pressionar w caso seja a vez deste jogador
		angle2 = angle2 - anglespeed2 * dt
		if play and noise then
			aimsound:play() --o som de movimento de angulo é ativado.
		end
		gameraflag2 = true --apartir desta flag é possivel ativar a camera zoom para seguir o player 1 enquano não houve bala do mesmo na tela	
	end	
end
 
function aiming2_draw()
	love.graphics.setColor(255, 63, 0)
	love.graphics.circle("fill", x2, y2, 4)
	love.graphics.setColor(255, 255, 255)
	--love.graphics.print(angle2, 100,0)
	--love.graphics.print(x2, 100,25)
	--love.graphics.print(y2, 100,50)
end