IF !CARGAR_SALDOS_PT()
	RETURN
ENDIF
IF MESSAGEBOX("El archivo de Saldos se encuentra listo" + CHR(13) + "para ser cargado... Desea continuar?",4+32,"Confirmación") = 7
	USE IN cSaldos
	RETURN
ENDIF
*** Abrir Tablas
CREATE CURSOR cTabla(nombre C(10),nom_cursor C(10),descrip C(20),tipo C(4),dar_numero L)
INSERT INTO cTabla VALUES("noti1","cPari1","Parte de Ingreso (Cabecera)","NOTI",.T.)
INSERT INTO cTabla VALUES("noti2","cPari2","Parte de Ingreso (Detalle)","NOTI",.F.)
INSERT INTO cTabla VALUES("note1","cPars1","Parte de Salida (Cabecera)","NOTE",.T.)
INSERT INTO cTabla VALUES("note2","cPars2","Parte de Salida (Detalle)","NOTE",.F.)
INSERT INTO cTabla VALUES("remi1","cGuia1","Guia de Remisión (Cabecera)","REMI",.F.)
INSERT INTO cTabla VALUES("remi2","cGuia2","Guia de Remisión (Detalle)","REMI",.F.)
INSERT INTO cTabla VALUES("fact1","cFact1","Factura (Cabecera)","FACT",.F.)
INSERT INTO cTabla VALUES("fact2","cFact2","Factura (Detalle)","FACT",.F.)
INSERT INTO cTabla VALUES("bole1","cBole1","Boleta (Cabecera)","BOLE",.F.)
INSERT INTO cTabla VALUES("bole2","cBole2","Boleta (Detalle)","BOLE",.F.)
INSERT INTO cTabla VALUES("nocr1","cNocr1","Nota de Credito (Cabecera)","NOCR",.F.)
INSERT INTO cTabla VALUES("nocr2","cNocr2","Nota de Credito (Detalle)","NOCR",.F.)
INSERT INTO cTabla VALUES("node1","cNode1","Nota de Debito (Cabecera)","NODE",.F.)
INSERT INTO cTabla VALUES("node2","cNode2","Nota de Debito (Detalle)","NODE",.F.)
INSERT INTO cTabla VALUES("guis1","cGuis1","Proforma Interna (Cabecera)","GUIS",.F.)
INSERT INTO cTabla VALUES("guis2","cGuis2","Proforma Interna (Detalle)","GUIS",.F.)
CREATE CURSOR cMaesNume(tipdoc C(4),serie C(4),numero N(10))
INDEX ON tipdoc + serie TAG codigo
SELECT 0
USE maesarti
SELECT 0
USE maescali ORDER codigo
***
*** Cursor de Productos a ignorar
CREATE CURSOR cIgnorar(cod_intemp C(20),cod_articu C(13),tipdoc C(4),serie C(4),nrodoc C(10),cod_calid C(1))
*INSERT INTO cIgnorar VALUES("100HC2280I351","","GUIA","001","0000001733","5P8682")
*INSERT INTO cIgnorar VALUES("100HC2280K231","","GUIA","001","0000001733","5P6248")
*INSERT INTO cIgnorar VALUES("100HC2280N5","","GUIA","001","0000001727","S/L")
*INSERT INTO cIgnorar VALUES("100HC2280RJ2130","","PARS","001","0000000002","ggggg")
*INSERT INTO cIgnorar VALUES("ACRIL2280201","","GUIA","001","0000001733","S/L")
*INSERT INTO cIgnorar VALUES("ALA2280NE","","GUIA","001","0000001770","S/L")
*INSERT INTO cIgnorar VALUES("CORTPMG33390","","GUIA","001","0000001735","3460660")
*INSERT INTO cIgnorar VALUES("CORTPMG55664","","GUIA","001","0000001735","4350350")
*INSERT INTO cIgnorar VALUES("CORTPMG55884","","GUIA","001","0000001735","4450140")
*INSERT INTO cIgnorar VALUES("CORTPMG66450","","GUIA","001","0000001735","4150170")
*INSERT INTO cIgnorar VALUES("CORTPMG66713","","GUIA","001","0000001735","9062700")
*INSERT INTO cIgnorar VALUES("CORTPMG88998","","GUIA","001","0000001735","4450200")
INDEX ON tipdoc+serie+nrodoc+cod_articu+cod_calid TAG codigo
SELECT cIgnorar
SCAN
	SELECT maesarti
	LOCATE FOR cod_intemp = cIgnorar.cod_intemp
	IF FOUND()
		SELECT cIgnorar
		REPLACE cod_articu WITH maesarti.cod_fami + maesarti.codigo
	ENDIF
ENDSCAN
***
*** Abriendo Tablas y Recuperando registros en Cursores
SELECT cTabla
SCAN
	WAIT WINDOW "Recuperando información actual de Documentos... " + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
	lcTabla = ALLTRIM(cTabla.nombre)
	lcCursor = ALLTRIM(cTabla.nom_cursor)
	SELECT 0
	USE (lcTabla) EXCLUSIVE
	IF RIGHT(lcTabla,1) = "1"
		*** Cabecera
		lcWhereSQL = "!EMPTY(serie) AND !EMPTY(nrodoc)"
		DO CASE
			CASE lcTabla = "noti1"
				*lcWhereSQL = lcWhereSQL + " AND serie = '015 '"
				lcWhereSQL = lcWhereSQL + " AND serie = '015 ' AND LEFT(DTOS(fecha_reg),6)='201504'"
				*** Posibles Cabecera de PI generados por GR
				SELECT * FROM (lcTabla) A WHERE !EMPTY(serie) AND !EMPTY(nrodoc) AND serie # "015 " INTO CURSOR cGuiPI1
				INDEX ON serie + nrodoc TAG codigo
				***
			CASE lcTabla = "note1"
				*cWhereSQL = lcWhereSQL + " AND serie = '015 '"
				cWhereSQL = lcWhereSQL + " AND serie = '015 ' AND LEFT(DTOS(fecha_reg),6)='201504'"
			CASE lcTabla = "remi1"
				*lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015"
				lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015 AND MONTH(fecha_reg)=4"
			CASE lcTabla = "fact1"
				*lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015"
				lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015 AND MONTH(fecha_reg)=4"
			CASE lcTabla = "bole1"
				*lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015"
				lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015 AND MONTH(fecha_reg)=4"
			CASE lcTabla = "nocr1"
				*lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015"
				lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015 AND MONTH(fecha_reg)=4"
			CASE lcTabla = "node1"
				*lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015"
				lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015 AND MONTH(fecha_reg)=4"
			CASE lcTabla = "guis1"
				*lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015"
				lcWhereSQL = lcWhereSQL + " AND YEAR(fecha_reg)=2015 AND MONTH(fecha_reg)=4"
		ENDCASE
		SELECT * FROM (lcTabla) A WHERE &lcWhereSQL. ORDER BY serie,nrodoc INTO CURSOR curTemp
		***
	ELSE
		*** Detalle
		lcCursor0 = SUBSTR(lcCursor,1,LEN(lcCursor)-1) + "1"
		SELECT B.* FROM (lcCursor0) A,(lcTabla) B WHERE B.serie = A.serie AND B.nrodoc = A.nrodoc ORDER BY B.serie,B.nrodoc ;
			INTO CURSOR cTmp
		= AFIELDS(laStruc)
		&& Filtrando Productos a ignorar
		CREATE CURSOR curTemp FROM ARRAY laStruc
		SELECT cTmp
		SCAN
			SCATTER MEMVAR
			llSw = !SEEK(cTabla.tipo+m.serie+m.nrodoc+m.cod_articu+m.cod_calid,"cIgnorar")
			IF llSw
				llSw = (m.cod_articu # "XXXXXXXXXX")
			ENDIF
			IF llSw
				INSERT INTO curTemp FROM MEMVAR
			ENDIF
		ENDSCAN
		USE
		&&
		***
		*** Posibles Detalle de PI generados por GR
		IF lcTabla = "noti2" AND USED("cGuiPI1")
			SELECT B.* FROM cGuiPI1 A,(lcTabla) B WHERE B.serie = A.serie AND B.nrodoc = A.nrodoc INTO CURSOR cGuiPI2
			INDEX ON serie + nrodoc + item TAG codigo
		ENDIF
		***
	ENDIF
	SELECT curTemp
	= AFIELDS(laStruc)
	CREATE CURSOR (lcCursor) FROM ARRAY laStruc
	IF RIGHT(lcTabla,1) = "1"
		ALTER TABLE (lcCursor) ADD COLUMN numero N(10)
		INDEX ON serie + nrodoc TAG codigo
	ELSE
		INDEX ON serie + nrodoc + item TAG codigo
	ENDIF
	APPEND FROM DBF("curTemp")
	USE IN curTemp
ENDSCAN
***
USE IN cIgnorar
*** Recorriendo Documentos
SELECT cTabla
SCAN
	lcTabla1 = ALLTRIM(cTabla.nombre)
	lcTabla2 = SUBSTR(lcTabla1,1,LEN(lcTabla1)-1) + "2"
	lcCursor1 = ALLTRIM(cTabla.nom_cursor)
	lcCursor2 = SUBSTR(lcCursor1,1,LEN(lcCursor1)-1) + "2"
	*** Solo Cabecera
	IF RIGHT(lcTabla1,1) # "1"
		LOOP
	ENDIF
	***
	*** Blanqueando tablas física
	SELECT (lcTabla1)
	ZAP
	SELECT (lcTabla2)
	ZAP
	***
	*** Ingresando Saldo Inicial
	IF lcTabla1 = "noti1"
		*** Cabecera de Saldos
		m.serie = "015"
		&& Actualizando nueva numeración por Documento y Número de Serie
		SELECT cMaesNume
		SEEK cTabla.tipo + m.serie
		IF !FOUND()
			APPEND BLANK
			REPLACE tipdoc WITH cTabla.tipo
			REPLACE serie WITH m.serie
		ENDIF
		REPLACE numero WITH cMaesNume.numero + 1
		&&
		m.nrodoc = PADL(cMaesNume.numero,10,"0")
		*m.fecha_reg = CTOD("01/01/2015")
		m.fecha_reg = CTOD("01/04/2015")
		m.tipcam_cod = "V"
		m.tipcam_val = 0
		*m.cod_moti = "002"
		m.cod_moti = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","MOT_SLD_INI")
		m.cod_alma = "007" && "002"
		m.cod_mone = "SOL"
		m.cod_auxi = "50622029"
		m.cod_ordprd = ""
		m.des_ordprd = ""
		m.docrel_tip = "SIN"
		m.docrel_ser = ""
		m.docrel_nro = ""
		m.docrel_fec = CTOD("")
		m.ord_compra = ""
		m.doccom1tip = "SIN"
		m.doccom1ser = ""
		m.doccom1nro = ""
		m.doccom1fec = CTOD("")
		m.doccom2tip = "SIN"
		m.doccom2ser = ""
		m.doccom2nro = ""
		m.doccom2fec = CTOD("")
		m.cod_anula = .F.
		m.obs_docum = ""
		m.new_usu = _usuario
		m.new_fec = DATE()
		m.new_hor = TIME()
		m.mod_usu = ""
		m.mod_fec = CTOD("//")
		m.mod_hor = ""
		m.del_usu = ""
		m.del_fec = CTOD("")
		m.del_hor = ""
		INSERT INTO (lcTabla1) FROM MEMVAR
		***
		*** Detalle de Saldos
		lnItem = 0
		SELECT cSaldos
		SCAN
			SELECT maesarti
			LOCATE FOR cod_intemp = ALLTRIM(cSaldos.cod_intemp)
			lnItem = lnItem + 1
			m.item = PADL(lnItem,4,"0")
			m.cod_articu = maesarti.cod_grup + maesarti.cod_cate + maesarti.codigo
			m.des_articu = maesarti.descri
			m.cantidad = cSaldos.cantidad
			m.peso_bruto = 0
			m.precio_1 = cSaldos.precio_1
			m.precio_2 = 0
			m.obs_deta = ""
			m.cod_ordprd = ""
			m.des_ordprd = ""
			= SEEK(cSaldos.cod_calid,"maescali")
			m.cod_calid = cSaldos.cod_calid
			m.des_calid = maescali.descri
			m.tip_produc = "P"
			m.cod_intemp = maesarti.cod_intemp
			m.cod_wayra = maesarti.cod_wayra
			m.cod_tipmed = maesarti.cod_time
			m.des_tipmed = maesarti.des_time
			m.cod_medida = maesarti.cod_medi
			m.des_medida = maesarti.des_medi
			m.cod_color  = maesarti.cod_col1
			m.des_color  = maesarti.des_col1
			m.prv_color  = maesarti.cod_colpr1
			m.cod_unidad = maesarti.cod_unimed
			m.des_unidad = maesarti.des_unimed
			m.seg_ordcom = ""
			m.ubica1 = ""
			m.peso_prod = 0
			m.obs_deta = ""
			INSERT INTO (lcTabla2) FROM MEMVAR
		ENDSCAN
		USE
		***
	ENDIF
	***
	*** Ingresando Documento
	SELECT (lcCursor1)
	SCAN
		WAIT WINDOW "Actualizando " + ALLTRIM(cTabla.descrip) + "[" + ALLTRIM(STR(RECNO("cTabla"))) + " de " + ALLTRIM(STR(RECCOUNT("cTabla"))) + "]" + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
		*** Contabilizando cantidad de Detalle
		lnCantItem = 0
		SELECT (lcCursor2)
		SEEK &lcCursor1..serie + &lcCursor1..nrodoc
		SCAN WHILE serie + nrodoc = &lcCursor1..serie + &lcCursor1..nrodoc
			lnCantItem = lnCantItem + 1
		ENDSCAN
		&& Se ignoran los documentos sin detalle
		IF lnCantItem = 0
			LOOP
		ENDIF
		&&
		***
		*** Ingresando Cabecera
		SELECT (lcCursor1)
		SCATTER MEMVAR
		&& Actualizando nueva numeración por Documento y Número de Serie
		IF cTabla.dar_numero
			SELECT cMaesNume
			SEEK cTabla.tipo + m.serie
			IF !FOUND()
				APPEND BLANK
				REPLACE tipdoc WITH cTabla.tipo
				REPLACE serie WITH m.serie
			ENDIF
			REPLACE numero WITH cMaesNume.numero + 1
			SELECT (lcCursor1)
			REPLACE numero WITH cMaesNume.numero
			m.nrodoc = PADL(cMaesNume.numero,10,"0")
		ENDIF
		&&
		INSERT INTO (lcTabla1) FROM MEMVAR
		***
		*** Ingresando Detalle
		SELECT (lcCursor2)
		SEEK &lcCursor1..serie + &lcCursor1..nrodoc
		SCAN WHILE serie + nrodoc = &lcCursor1..serie + &lcCursor1..nrodoc
			SCATTER MEMVAR FIELDS EXCEPT serie,nrodoc
			INSERT INTO (lcTabla2) FROM MEMVAR
		ENDSCAN
		***
	ENDSCAN
	***
ENDSCAN
***
*** Actualizar numero del Documento Relacionado
SELECT cTabla
SCAN
	lcTabla = ALLTRIM(cTabla.nombre)
	*** Solo Cabecera
	IF RIGHT(lcTabla,1) # "1"
		LOOP
	ENDIF
	***
	SELE (lcTabla)
	SCAN FOR !EMPTY(docrel_tip) AND !EMPTY(docrel_ser) AND !EMPTY(docrel_nro)
		*** Determinando el nombre del Cursor del Documento relacionado
		lcTipoDR = &lcTabla..docrel_tip
		SELECT * FROM cTabla WHERE dar_numero AND tipo = lcTipoDR INTO CURSOR curTemp
		lcCursor = ALLTRIM(curTemp.nom_cursor)
		USE
		***
		*** Actualizando el número del Documento relacionado
		IF USED(lcCursor)
			lc_docrel_ser = &lcTabla..docrel_ser
			lc_docrel_nro = &lcTabla..docrel_nro
			SELECT (lcCursor)
			SEEK lc_docrel_ser + lc_docrel_nro
			IF FOUND()
				IF &lcCursor..numero > 0
					SELECT (lcTabla)
					REPLACE docrel_nro WITH PADL(&lcCursor..numero,10,"0")
				ENDIF
			ELSE
				*** GR que generaron PI
				IF cTabla.tipo = "REMI" AND lcTipoDR = "NOTI"
					IF USED("cGuiPI1") AND USED("cGuiPI2")
						SELECT cGuiPI1
						SEEK lc_docrel_ser + lc_docrel_nro
						IF FOUND()
							SCATTER MEMVAR
							*** Actualizando nueva numeración por Documento y Número de Serie
							SELECT cMaesNume
							SEEK lcTipoDR + lc_docrel_ser
							IF !FOUND()
								APPEND BLANK
								REPLACE tipdoc WITH lcTipoDR
								REPLACE serie WITH lc_docrel_ser
							ENDIF
							REPLACE numero WITH cMaesNume.numero + 1
							m.nrodoc = PADL(cMaesNume.numero,10,"0")
							***
							INSERT INTO noti1 FROM MEMVAR
							SELECT cGuiPI2
							SEEK lc_docrel_ser + lc_docrel_nro
							SCAN WHILE serie + nrodoc = lc_docrel_ser + lc_docrel_nro
								SCATTER MEMVAR FIELDS EXCEPT serie,nrodoc
								INSERT INTO noti2 FROM MEMVAR
							ENDSCAN
							SELE (lcTabla)
							REPLACE docrel_nro WITH m.nrodoc
						ENDIF
					ENDIF
				ENDIF
				***
			ENDIF
		ENDIF
		***
	ENDSCAN
ENDSCAN
***
*** Actualizando Maestra de Numeración
SELECT cMaesNume
SCAN FOR numero > 0
	= DOC_ACT_NUM("DOC" + cMaesNume.tipdoc,cMaesNume.serie,cMaesNume.numero)
ENDSCAN
***
*** Cerrar Tablas
USE IN maesarti
USE IN maescali
SELECT cTabla
SCAN
	lcTabla = ALLTRIM(cTabla.nombre)
	lcCursor = ALLTRIM(cTabla.nom_cursor)
	IF USED(lcTabla)
		USE IN (lcTabla)
	ENDIF
	IF USED(lcCursor)
		USE IN (lcCursor)
	ENDIF
ENDSCAN
USE
USE IN cMaesNume
USE IN IIF(USED("cGuiPI1"),"cGuiPI1",0)
USE IN IIF(USED("cGuiPI2"),"cGuiPI2",0)
***