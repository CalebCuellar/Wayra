CLOSE DATABASES ALL
SELECT 0
USE ordp1 ORDER ordp1 ALIAS op1
SELECT 0
USE ordp2 ORDER ordp2 ALIAS op2

SELECT 0
USE ordr1 ORDER ordr1 ALIAS orin1
SELECT 0
USE ordr2 ORDER seg_ordser ALIAS orin2
SELECT 0
USE notr1 ORDER notr1 ALIAS orpt1
SELECT 0
USE notr2 ORDER seg_ordser ALIAS orpt2

SELECT 0
USE guia1 ORDER guia1 ALIAS grin1
SELECT 0
USE guia2 ORDER docrel ALIAS grin2
SELECT 0
USE remi1 ORDER remi1 ALIAS grpt1
SELECT 0
USE remi2 ORDER docrel ALIAS grpt2

SELECT 0
USE ordpftpro ORDER codigo ALIAS ft1 EXCLUSIVE
DELETE ALL FOR ftpcoment = "*/*"
PACK
SELECT 0
USE ordpftpro3 ORDER codigo ALIAS ft3 EXCLUSIVE
DELETE ALL FOR torcion = "*/*"
PACK

SELECT 0
USE maestise ORDER codigo
SELECT 0
USE maesproc ORDER codigo

CREATE CURSOR cTabla(nombre C(4))
INSERT INTO cTabla VALUES("ORDS")
INSERT INTO cTabla VALUES("NOTS")
SELECT cTabla
SCAN
	lcTabla1 = cTabla.nombre + "1"
	lcTabla2 = cTabla.nombre + "2"
	SELECT 0
	USE (lcTabla1) ORDER (lcTabla1) ALIAS os1
	SELECT 0
	USE (lcTabla2) ORDER (lcTabla2) ALIAS os2
	SELECT * FROM os1 WHERE cod_moti = "004" AND !cod_anula AND !EMPTY(cod_tipser) ORDER BY cod_ordprd,fecha_reg INTO CURSOR cOs1
	SCAN
		SELECT maestise
		SEEK cOs1.cod_tipser
		IF !FOUND() OR EMPTY(maestise.procodigo)
			LOOP
		ENDIF
		lcOP_Serie = PADR(PADL(SUBSTR(cOs1.cod_ordprd,1,2),3,"0"),4," ")
		lcOP_Numero = PADL(SUBSTR(cOs1.cod_ordprd,4,5),10,"0")
		SELECT os2
		SEEK cOs1.serie + cOs1.nrodoc
		SCAN WHILE serie + nrodoc = cOs1.serie + cOs1.nrodoc
			IF EMPTY(os2.art_op)
				LOOP
			ENDIF
			*SUSP
			lcItem = ""
			lnItem = 0 && �ltimo Item
			*** Buscando Item del Proceso en la Ficha T�cnica
			SELECT ft1
			SEEK lcOP_Serie + lcOP_Numero + os2.art_op
			SCAN WHILE serie + nrodoc + codigo = lcOP_Serie + lcOP_Numero + os2.art_op
				lnItem = INT(VAL(ft1.item))
				IF ft1.procodigo = maestise.procodigo
					lcItem = ft1.item
					EXIT
				ENDIF
			ENDSCAN
			***
			IF EMPTY(lcItem)
				*** Registrando nuevo Proceso en la Ficha T�cnica
				lcItem = PADL(lnItem + 1,5,"0")
				SELECT maesproc
				SEEK maestise.procodigo
				SELECT ft1
				APPEND BLANK
				REPLACE serie WITH lcOP_Serie
				REPLACE nrodoc WITH lcOP_Numero
				REPLACE codigo WITH os2.art_op
				REPLACE item WITH lcItem
				REPLACE procodigo WITH maestise.procodigo
				REPLACE prodescri WITH maesproc.prodescri
				REPLACE ftputensi WITH ""
				REPLACE ftpmerma WITH 0
				REPLACE prvcodigo WITH cOs1.cod_auxi
				REPLACE ftpcoment WITH "*/*"
				***
			ENDIF
			*** Buscando Orden de Requerimiento (Insumos y Productos Terminados)
			lcOS_Tipo = IIF(cTabla.nombre = "ORDS","IN","PT")
			FOR I = 1 TO 2
				DO CASE
					CASE I = 1 && Insumo
						lcTipo = "IN"
						lcTipoOR = "ORDR"
						lcTablaOR1 = "orin1"
						lcTablaOR2 = "orin2"
						lcTablaGR1 = "grin1"
						lcTablaGR2 = "grin2"
					CASE I = 2 && Producto Terminado
						lcTipo = "PT"
						lcTipoOR = "NOTR"
						lcTablaOR1 = "orpt1"
						lcTablaOR2 = "orpt2"
						lcTablaGR1 = "grpt1"
						lcTablaGR2 = "grpt2"
				ENDCASE
				SELECT (lcTablaOR2)
				SEEK lcOS_Tipo + cOs1.serie + cOs1.nrodoc + os2.cod_articu
				SCAN WHILE tip_ordser + ser_ordser + nro_ordser + art_ordser = lcOS_Tipo + cOs1.serie + cOs1.nrodoc + os2.cod_articu
					SELECT (lcTablaOR1)
					SEEK &lcTablaOR2..serie + &lcTablaOR2..nrodoc
					IF !FOUND() &&OR &lcTablaOR1..cod_anula
						LOOP
					ENDIF
					LLSW = &lcTablaOR1..cod_anula
					IF LLSW
						LOOP
					ENDIF
					*** Buscando Gu�a de Remisi�n
					SELECT (lcTablaGR2)
					SEEK lcTipoOR + &lcTablaOR2..serie + &lcTablaOR2..nrodoc
					SCAN WHILE docrel_tip + docrel_ser + docrel_nro + cod_articu = lcTipoOR + &lcTablaOR2..serie + &lcTablaOR2..nrodoc + &lcTablaOR2..cod_articu
						SELECT (lcTablaGR1)
						SEEK &lcTablaGR2..serie + &lcTablaGR2..nrodoc
						IF !FOUND() OR &lcTablaGR1..cod_anula
							LOOP
						ENDIF
						*** Actualizando Ficha T�cnica de la O/P
						SELECT ft3
						SEEK lcOP_Serie + lcOP_Numero + os2.art_op + lcItem + lcTipo + &lcTablaGR2..cod_articu
						IF !FOUND()
							APPEND BLANK
							REPLACE serie WITH lcOP_Serie
							REPLACE nrodoc WITH lcOP_Numero
							REPLACE codigo WITH os2.art_op
							REPLACE item WITH lcItem
							REPLACE tipo WITH lcTipo
							REPLACE cod_articu WITH &lcTablaGR2..cod_articu
							REPLACE torcion WITH "*/*"
						ENDIF
						REPLACE cantidad1 WITH ft3.cantidad1 + &lcTablaGR2..cantidad
						REPLACE merma WITH 0
						REPLACE cantidad WITH ft3.cantidad1 + &lcTablaGR2..cantidad
						***
					ENDSCAN
					***
				ENDSCAN
			ENDFOR
			***
		ENDSCAN
	ENDSCAN
	USE
	USE IN os1
	USE IN os2
ENDSCAN
USE
USE IN op1
USE IN op2
USE IN orin1
USE IN orin2
USE IN orpt1
USE IN orpt2
USE IN grin1
USE IN grin2
USE IN grpt1
USE IN grpt2
USE IN ft1
USE IN ft3
USE IN maestise
USE IN maesproc