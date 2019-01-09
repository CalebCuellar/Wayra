PARAMETER pcModulo
SELECT 0
USE tabopc ORDER tabopc
SELECT 0
USE tabacc ORDER tabacc

SET SYSMENU TO
SET SYSMENU AUTOMATIC

SELECT * FROM tabopc WHERE subnivel = "00" and modulo = pcModulo ORDER BY modulo,nivel,subnivel INTO CURSOR cab
lnNivel1 = 0
SCAN
	lnNivel1 = lnNivel1 + 1
	*** Definiendo Menu
	lcCadena1 = "_menu" + PADL(lnNivel1,2,"0")
	lcCadena2 = "_mant" + PADL(lnNivel1,2,"0")
	DEFINE PAD &lcCadena1 OF _MSYSMENU PROMPT ALLTRIM(descrip) COLOR SCHEME 3
	ON PAD &lcCadena1 OF _MSYSMENU ACTIVATE POPUP &lcCadena2
	***
	*** Creando Menu
	DEFINE POPUP &lcCadena2 MARGIN RELATIVE SHADOW COLOR SCHEME 4
	lnNivel2 = 0
	SELECT tabopc
	SEEK cab.modulo + cab.nivel
	SCAN WHILE modulo + nivel = cab.modulo + cab.nivel
		llSw = (VAL(tabopc.subnivel)>0)
		IF llSw AND cab.modulo = "PL1"
			llSw = (ATC(ntippla+ntipmov,tabopc.observa)!=0)
		ENDIF
		IF !llSw
			LOOP
		ENDIF
		lnNivel2 = lnNivel2 + 1
		IF ALLTRIM(tabopc.descrip) = "\-"
			DEFINE BAR lnNivel2 OF &lcCadena2 PROMPT ALLTRIM(tabopc.descrip)
		ELSE	
			lcClave = PASSW(PADR(_usuario,3)) + PASSW(PADR(tabopc.modulo,3)) + PASSW(tabopc.nivel) + PASSW(tabopc.subnivel)
			IF SEEK(lcClave,"tabacc") OR _admin
				DEFINE BAR lnNivel2 OF &lcCadena2 PROMPT tabopc.nivel + tabopc.subnivel + "-" + ALLTRIM(tabopc.descrip)
			ELSE
				DEFINE BAR lnNivel2 OF &lcCadena2 PROMPT tabopc.nivel + tabopc.subnivel + "-" + ALLTRIM(tabopc.descrip) SKIP
			ENDIF
			ON SELECTION BAR lnNivel2 OF &lcCadena2 DO proc_opc IN LIBRARY
		ENDIF
	ENDSCAN
	***
ENDSCAN
USE
USE IN tabopc
USE IN tabacc
RETURN