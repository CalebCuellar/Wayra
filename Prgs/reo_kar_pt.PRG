PARAMETERS pcYear,plAsk
pcYear = IIF(TYPE("pcYear") = "C",pcYear,PADL(YEAR(DATE()),4,"0"))
lcNameKardex = "KARPT" + pcYear
IF plAsk
	IF MESSAGEBOX("Desea iniciar la reorganización del Kardex?",4+32,"Confirmación") = 7
		RETURN
	ENDIF
ENDIF
ln_Select = SELECT()
STORE "" TO lcHorIni,lcHorFin
lcHorIni = TIME()
***** Tabla de Cierre
IF !FILE("cie_alm.dbf")
	lcNameTable = _rt_bas_ + "\cie_alm"
	CREATE CURSOR cCie_Alm(tipo C(2),ano C(4),mes C(2),tabsal C(10),tabkar C(10),ultusu C(3),ultfec D,ulthor C(8))
	INDEX ON tipo+ano+mes TAG cie_alm
	COPY TO &lcNameTable. WITH CDX
	USE
ENDIF
*****
***** Creando las Tablas de Almacen y Kardex
IF FILE("STRUKARDPT.DBF") AND !FILE(lcNameKardex + ".DBF")
	SELE 0
	USE strukardpt
	lcNameTable = _rt_bas_ + "\" + lcNameKardex
	COPY STRUC TO &lcNameTable. WITH CDX
	USE
ENDIF
IF FILE("STRUARTIPT.DBF") AND !FILE("STOCK_PT.DBF")
	SELE 0
	USE struartipt
	lcNameTable = _rt_bas_ + "\STOCK_PT"
	COPY STRUC TO &lcNameTable. WITH CDX
	USE
ENDIF
*****
***** Abriendo las Tablas de Almacen y Kardex
WAIT WINDOW "Procesando Kardex..." NOWAIT
SELE 0
USE (lcNameKardex) ORDER kardex2 ALIAS ka2 EXCLUSIVE
llExclusive_ka2 = USED("ka2")
IF !llExclusive_ka2
	SELE 0
	USE (lcNameKardex) ORDER kardex2 ALIAS ka2
ENDIF
SELECT 0
USE stock_pt ORDER codigo EXCLUSIVE
llExclusive_alm = USED("stock_pt")
IF !llExclusive_alm
	SELE 0
	USE stock_pt ORDER codigo
ENDIF
***
*** Cursor para actualizar Costo de Producción
lc_Cursor_Name = SYS(2015)
CREATE CURSOR (lc_Cursor_Name)(tipo C(4),serie C(4),nrodoc C(10),item C(4))
INDEX ON tipo + serie + nrodoc + item TAG codigo
lc_Mot_Prd = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","MOT_SAL_PRD")
lc_Mot_Prd = PADR(IIF(!ISNULL(lc_Mot_Prd),lc_Mot_Prd,""),3," ")
***
SELECT ka2
AFIELDS(laStruc)
CREATE CURSOR cKardex FROM ARRAY laStruc
ALTER TABLE cKardex ADD COLUMN vence		D
ALTER TABLE cKardex ADD COLUMN descri		C(150)
ALTER TABLE cKardex ADD COLUMN valtc		N(7,3)
INDEX ON cod_articu+cod_alma+cod_calid+DTOS(fecha_reg)+orden TAG codi2 && stock_pt
INDEX ON cod_articu+cod_calid+DTOS(fecha_reg)+orden TAG codi1 ADDITIVE && kardex2
SET ORDER TO
***** Rescatando los Saldos
SELE 0
USE maesmoti ORDER codigo
SELECT * FROM ka2 WHERE tipdoc + serie = "SALDINI " INTO CURSOR cTemp
SELE cTemp
SCAN
	SCATTER MEMVAR
	= SEEK(m.rad_moti + m.cod_moti,"maesmoti")
	m.orden = maesmoti.cod_orden1
	INSERT INTO cKardex FROM MEMVAR
ENDSCAN
USE
USE IN maesmoti
*****
***** Blanqueando Kardex
WAIT WINDOW "Eliminando Kardex..." NOWAIT
SELE ka2
DELETE ALL
IF llExclusive_ka2
	PACK
	REINDEX
ENDIF
SELE stock_pt
DELETE ALL
IF llExclusive_alm
	PACK
	REINDEX
ENDIF
*****
= KARDEX_DOCUMENTOS_PT("cKardex",CTOD("01/01/" + pcYear),CTOD("31/12/" + pcYear))
*****
IF USED("cKardex")
	SELECT ka2
	*SET ORDER TO kardex2
	SET ORDER TO kardex3
	WAIT WINDOW "Preparando Kardex... Espere un momento por favor." NOWAIT
	APPEND FROM DBF("cKardex")
	*** Reorganizando Nivel 1
	*SELECT cod_articu,cod_calid FROM cKardex GROUP BY cod_articu,cod_calid INTO CURSOR curTemp
	*SCAN
	*	WAIT WINDOW "Reorganizando Kardex... Nivel 1 " + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
	*	SELECT ka2
	*	SEEK curTemp.cod_articu + curTemp.cod_calid
	*	IF FOUND()
	*		ln_Record = RECNO("ka2")
	*		DO ACT_KAR_PT WITH ka2.cod_articu,ka2.cod_calid,ln_Record
	*	ENDIF
	*ENDSCAN
	*USE
	SELECT cod_articu FROM cKardex GROUP BY cod_articu INTO CURSOR curTemp
	SCAN
		WAIT WINDOW "Reorganizando Kardex... Nivel 1 " + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
		SELECT ka2
		SEEK curTemp.cod_articu
		IF FOUND()
			ln_Record = RECNO("ka2")
			*DO ACT_KAR_PT WITH ka2.cod_articu,"",ln_Record
			DO ACT_KAR_PT WITH ka2.cod_articu,"",ln_Record,.F.,lc_Cursor_Name,lc_Mot_Prd
		ENDIF
	ENDSCAN
	USE
	***
	*** Reorganizando Nivel 2
	*SELECT ka2
	*SET ORDER TO stockart
	*SELECT cod_articu,cod_alma,cod_calid FROM cKardex GROUP BY cod_articu,cod_alma,cod_calid INTO CURSOR curTemp
	*SCAN
	*	WAIT WINDOW "Reorganizando Kardex... Nivel 2 " + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
	*	SELECT ka2
	*	SEEK curTemp.cod_articu + curTemp.cod_alma + curTemp.cod_calid
	*	IF FOUND()
	*		ln_Record = RECNO("ka2")
	*		DO ACT_KAR_PT1 WITH ka2.cod_articu,ka2.cod_alma,ka2.cod_calid,ln_Record
	*	ENDIF
	*ENDSCAN
	*USE
	SELECT ka2
	SET ORDER TO stockart
	SELECT cod_articu,cod_alma FROM cKardex GROUP BY cod_articu,cod_alma INTO CURSOR curTemp
	SCAN
		WAIT WINDOW "Reorganizando Kardex... Nivel 2 " + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
		SELECT ka2
		SEEK curTemp.cod_articu + curTemp.cod_alma
		IF FOUND()
			ln_Record = RECNO("ka2")
			DO ACT_KAR_PT1 WITH ka2.cod_articu,ka2.cod_alma,"",ln_Record
		ENDIF
	ENDSCAN
	USE
	***
	*** Actualizando los Precios Promedios en el Detalle de los Documentos de Salida
	*** ... Esto ya no es necesario porque en la consulta del Precio Promedio (en los PI, PS o GR) se visualiza del Kardex 20/11/16
	*SELE ka2
	*SET ORDER TO documento
	*SELECT tipdoc,serie,nrodoc,item FROM cKardex WHERE rad_moti = "SAL" INTO CURSOR curTemp1
	*INDEX ON tipdoc TAG tipdoc
	*SELECT tipdoc,COUNT(*) AS total FROM cKardex GROUP BY tipdoc INTO CURSOR curTemp
	*SCAN
	*	*** Abriendo Tabla Detalle
	*	lcNameTable = curTemp.tipdoc + "2"
	*	SELE 0
	*	USE (lcNameTable) ORDER (lcNameTable) ALIAS tDetalle
	*	***
	*	I = 0
	*	SELE curTemp1
	*	SEEK curTemp.tipdoc
	*	SCAN WHILE tipdoc = curTemp.tipdoc
	*		I = I + 1
	*		WAIT WINDOW "Actualizando Precio Promedio en el Documento de Salida: " + curTemp.tipdoc + BARRA(I,curTemp.total) + "%" NOWAIT
	*		SELE ka2
	*		SEEK curTemp1.tipdoc + curTemp1.serie + curTemp1.nrodoc + curTemp1.item
	*		SELE tDetalle
	*		SEEK curTemp1.serie + curTemp1.nrodoc + PADR(curTemp1.item,4)
	*		IF FOUND()
	*			REPLACE precio_1 WITH ka2.prepro_sol
	*			REPLACE precio_2 WITH ka2.prepro_dol
	*		ENDIF
	*	ENDSCAN
	*	*** Cerrando Tabla Detalle
	*	USE IN tDetalle
	*	***
	*ENDSCAN
	*USE
	*USE IN curTemp1
	***
	*** Actualizar los saldos de GR facturadas
	SELECT guirem_ser,guirem_nro FROM cKardex WHERE INLIST(tipdoc,"FACT","BOLE") AND ;
		!EMPTY(guirem_tip) AND !EMPTY(guirem_ser) AND !EMPTY(guirem_nro) AND guirem_tip = "GUIA" ;
		GROUP BY guirem_ser,guirem_nro INTO CURSOR curTemp
	SCAN
		DO ACT_GUIA_PT WITH curTemp.guirem_ser,curTemp.guirem_nro
	ENDSCAN
	USE
	***
	USE IN cKardex
ENDIF
*****
USE IN ka2
USE IN stock_pt
*** Actualizando Costo de Producción
IF !EOF(lc_Cursor_Name)
	= COSTO_PRODUCCION(lc_Cursor_Name,.T.)
ENDIF
USE IN (lc_Cursor_Name)
***
WAIT WINDOW "Reorganización concluida..." NOWAIT
SELECT(ln_Select)
IF plAsk
	lcHorFin = TIME()
	MESSAGEBOX("El Proceso ha finalizado." + CHR(13) +;
		"Hora de Inicio: " + lcHorIni + CHR(13) +;
		"Hora de Termino: " + lcHorFin,0+48,"Reconstrucción del Kardex")
ENDIF
RETURN