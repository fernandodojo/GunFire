function squarecolission(xt, yt,raio, x, y, width, height )
	return  (xt + raio >= x and xt + raio <= x + width)  and  (yt + raio >= y and yt + raio <= y + height) or (xt - raio >= x and xt - raio <= x + width)  and  (yt - raio >= y and yt - raio <= y + height) or (xt + raio >= x and xt + raio <= x + width)  and  (yt - raio >= y and yt - raio <= y + height) or (xt - raio >= x and xt - raio <= x + width)  and  (yt + raio >= y and yt + raio <= y + height)
end
