*function passw
para cadena
cad = ''
a  = 0
for x = 100 to 100 + 30
	a = a + 1
	if !empt (subs (cadena , a,1))
		cad = cad + chr ((asc (subs (cadena , a, 1))) +  x )
	else
		a= a - 1
	endif
endf
return cad