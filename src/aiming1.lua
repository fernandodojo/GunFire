--https://www.love2d.org/forums/viewtopic.php?f=4&t=35233#p104896
function aiming1_load()			
	x1 = 0 -- posição inicial no eixo x
	y1 =  0 -- posição inicial no eixo y
	angle1 = - 0.785398 --angulo inicial em radianos, equivalente a 45°
	anglespeed1 = 0.3 -- velocidade com o qual o angulo será alterado ao pressionar determinadas teclas
end

function aiming1_update(dt)
	--posição da bolinha de mira é definida pela coordenada do player + 25 * o coseno do angulo inicial dado--
	x1 = player1.x + math.cos(angle1) * 25 
	y1 = player1.y + math.sin(angle1) * 25
	

	if love.keyboard.isDown("w") and gamestate == "player1" and movimentflag1 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then --permite-se mudar o valor do angulo ao pressionar w caso seja a vez deste jogador
		angle1 = angle1 - anglespeed1 * dt 
		if play and noise then --o som de movimento de angulo é ativado.
			aimsound:play()
		end
		gameraflag1 = true --apartir desta flag é possivel ativar a camera zoom para seguir o player 1 enquano não houve bala do mesmo na tela
	end
	if love.keyboard.isDown("s") and gamestate == "player1" and movimentflag1 and not (printflag1 or  printflagself1 or printfloorflag1 or printflag2 or printflagself2 or printfloorflag2) then --permite-se mudar o valor do angulo ao pressionar w caso seja a vez deste jogador
		angle1 = angle1 + anglespeed1 * dt 
		if play and noise then --o som de movimento de angulo é ativado.
			aimsound:play()
		end
		gameraflag1 = true	--apartir desta flag é possivel ativar a camera zoom para seguir o player 1 enquano não houve bala do mesmo na tela	
	end		
end
 
function aiming1_draw()
	love.graphics.setColor(255, 63, 0)
	love.graphics.circle("fill", x1, y1, 4)
	love.graphics.setColor(255, 255, 255)	
	--love.graphics.print(angle1, 0,0)
	--love.graphics.print(x1, 0,25)
	--love.graphics.print(y1, 0,50)
end