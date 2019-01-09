PARAMETERS pfec01, pfec02, ptab01, ptab02, pSigDoc

USE IN 0 &ptab01. ORDER FECHA_REG ALIAS cabe_docu AGAIN		&& orden : DTOS(fecha_reg)
USE IN 0 &ptab02. ORDER &ptab02.  ALIAS deta_docu AGAIN		&& orden : serie + nrodoc

SELECT cabe_docu
ncampos = AFIELDS(matriz)
CREATE CURSOR c&ptab01. FROM ARRAY matriz

SELECT deta_docu
ncampos = AFIELDS(matriz)
CREATE CURSOR c&ptab02. FROM ARRAY matriz

FOR pfec00 = 0 TO (pfec02-pfec01)
	cfec00 = DTOS(pfec01 + pfec00)
	IF BETWEEN(cfec00, DTOS(pfec01), DTOS(pfec02))
		SELECT cabe_docu
		SET KEY TO cfec00
		GO TOP 
		SCAN
			***
			SCATTER MEMVAR 
			pkey_nrodoc = m.serie + m.nrodoc
			pkey_anula  = m.cod_anula
			***
			IF pkey_anula
				STORE 0 TO m.totvta, m.totigv, m.totnet
			ENDIF
			INSERT INTO c&ptab01. FROM MEMVAR 
			***
			SELECT deta_docu
			SET KEY TO pkey_nrodoc
			GO TOP 
			SCAN
				SCATTER memvar
				***
				m.cantidad = (m.cantidad * pSigDoc)
				***
				IF pkey_anula
					STORE 0 TO m.cantidad, m.precio_1, m.precio_2
				ENDIF 
				INSERT INTO c&ptab02. FROM MEMVAR 
				***
				SELECT deta_docu
			ENDSCAN 
			SELECT deta_docu
			SET KEY TO
			***
			SELECT cabe_docu
		ENDSCAN
		SELECT cabe_docu
		SET KEY TO 
	ENDIF 
ENDFOR

USE IN cabe_docu
USE IN deta_docu
RETURN
