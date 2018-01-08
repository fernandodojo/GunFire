ventohorizontal = 0 
ventovertical = 0
gerador = 0
function random() --função que é chamada toda vez q o randomdelay acaba
	math.randomseed(os.time())
	gerador = math.random(-1,1) -- aqui é gerado outra sequencia pra dizer se o vento irá de fato mudar ou não, existindo duas vezes mais possibiladades de não haver mudança
	if gerador < 0 then
		ventohorizontal = math.random(-2,2) --variação do vento
		ventovertical = math.random(-1,2)		
	elseif gerador >= 0 then
		ventohorizontal = 0 -- permanencia do vento
		ventovertical = 0
	end	
end