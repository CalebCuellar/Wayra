CLOSE DATABASES

nfiles = ADIR(matriz,"\sistem01\data02\*.dbf")

=ASORT(matriz)

FOR x=1 TO nfiles
	xbase = matriz(x,1)
	SELECT 0
	USE &xbase. EXCLUSIVE
	PACK
	
ENDFOR 