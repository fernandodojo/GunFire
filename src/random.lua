vento = 0
vento2 =0
gerador = 0
function random()
	math.randomseed(os.time())
	gerador = math.random(-1,1)
	if gerador < 0 then
		vento = math.random(-2,2)
		vento2 = math.random(-1,2)		
	elseif gerador >= 0 then
		vento = 0
		vento2 = 0
	end	
end