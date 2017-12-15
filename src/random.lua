vento = 0
gerador = 0
gravity = 3
function random()
	math.randomseed(os.time())
	gerador = math.random(-5,10)
	if gerador < 0 then
		vento = math.random(-2,2)
		gravity = math.random(1,5)
	elseif gerador > 0 then
		vento = 0
		gravity = 3
	end
end