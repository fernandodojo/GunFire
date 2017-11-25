function squarecolission(xt, yt, x, y, width, height )
	return (xt >= x and xt <= x + width)  and  (yt >= y and yt <= y + height)
end
