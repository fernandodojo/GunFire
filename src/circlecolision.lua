function circlecolision(centerx, centery, touchx, touchy, r)
	return (centerx - touchx )^2 + (centery - touchy)^2 < r^2
end

--função para detectar o toque de um ponto dentro de um circulo.--