PARAMETERS pcNumeroOrden,pcItemArticulo,pcCodigoArticulo
*** Abriendo Tablas
llUsedOrden1 = USED("orden1")
IF !llUsedOrden1
	SELECT 0
	USE ordp1 ALIAS orden1 AGAIN
ENDIF
SELECT orden1
lcOrderOrden1 = ORDER()
SET ORDER TO ordp1

llUsedOrden2 = USED("orden2")
IF !llUsedOrden2
	SELECT 0
	USE ordp2 ALIAS orden2 AGAIN
ENDIF
SELECT orden2
lcOrderOrden2 = ORDER()
SET ORDER TO ordp2

llUsedCliente = USED("cliente")
IF !llUsedCliente
	SELECT 0
	USE maesclie ALIAS cliente AGAIN
ENDIF
SELECT cliente
lcOrderCliente = ORDER()
SET ORDER TO codigo

llUsedVendedor = USED("vendedor")
IF !llUsedVendedor
	SELECT 0
	USE maesvend ALIAS vendedor AGAIN
ENDIF
SELECT vendedor
lcOrderVendedor = ORDER()
SET ORDER TO codigo

llUsedInsumo = USED("op_ft_ins")
IF !llUsedInsumo
	SELECT 0
	USE ordpftins ALIAS op_ft_ins AGAIN
ENDIF
SELECT op_ft_ins
lcOrderInsumo = ORDER()
SET ORDER TO codigo

llUsedEquivale = USED("op_ft_equ")
IF !llUsedEquivale
	SELECT 0
	USE ordpftequ ALIAS op_ft_equ AGAIN
ENDIF
SELECT op_ft_equ
lcOrderEquivale = ORDER()
SET ORDER TO codigo

llUsedProceso = USED("op_ft_pro")
IF !llUsedProceso
	SELECT 0
	USE ordpftpro ALIAS op_ft_pro AGAIN
ENDIF
SELECT op_ft_pro
lcOrderProceso = ORDER()
SET ORDER TO codigo

llUsedProceso1 = USED("op_ft_pro1")
IF !llUsedProceso1
	SELECT 0
	USE ordpftpro1 ALIAS op_ft_pro1 AGAIN
ENDIF
SELECT op_ft_pro1
lcOrderProceso1 = ORDER()
SET ORDER TO codigo

llUsedProceso2 = USED("op_ft_pro2")
IF !llUsedProceso2
	SELECT 0
	USE ordpftpro2 ALIAS op_ft_pro2 AGAIN
ENDIF
SELECT op_ft_pro2
lcOrderProceso2 = ORDER()
SET ORDER TO codigo

llUsedMedida = USED("op_ft_med")
IF !llUsedMedida
	SELECT 0
	USE ordpftmed ALIAS op_ft_med AGAIN
ENDIF
SELECT op_ft_med
lcOrderMedida = ORDER()
SET ORDER TO codigo

llUsedFoto = USED("op_ft_fot")
IF !llUsedFoto
	SELECT 0
	USE ordpftfot ALIAS op_ft_fot AGAIN
ENDIF
SELECT op_ft_fot
lcOrderFoto = ORDER()
SET ORDER TO codigo

llUsedArticle = USED("article")
IF !llUsedArticle
	SELECT 0
	USE maesarti ALIAS article AGAIN
ENDIF
SELECT article
lcOrderArticle = ORDER()
SET ORDER TO codigo

llUsedSupplie = USED("supplie")
IF !llUsedSupplie
	SELECT 0
	USE maesinsu ALIAS supplie AGAIN
ENDIF
SELECT supplie
lcOrderSupplie = ORDER()
SET ORDER TO codigo

llUsedProcess = USED("process")
IF !llUsedProcess
	SELECT 0
	USE maesproc ALIAS process AGAIN
ENDIF
SELECT process
lcOrderProcess = ORDER()
SET ORDER TO codigo

llUsedMeasure1 = USED("measure1")
IF !llUsedMeasure1
	SELECT 0
	USE maesunid ALIAS measure1 AGAIN
ENDIF
SELECT measure1
lcOrderMeasure1 = ORDER()
SET ORDER TO codigo

llUsedMeasure2 = USED("measure2")
IF !llUsedMeasure2
	SELECT 0
	USE maesfmed ALIAS measure2 AGAIN
ENDIF
SELECT measure2
lcOrderMeasure2 = ORDER()
SET ORDER TO codigo

llUsedProvider = USED("provider")
IF !llUsedProvider
	SELECT 0
	USE maesprov ALIAS provider AGAIN
ENDIF
SELECT provider
lcOrderProvider = ORDER()
SET ORDER TO codigo
***
*** Creando Cursores
SELE op_ft_ins
AFIELDS(laStruc)
CREATE CURSOR cFicha1 FROM ARRAY laStruc
INDEX ON prvcodigo TAG codigo

SELE op_ft_equ
AFIELDS(laStruc)
CREATE CURSOR cFicha2 FROM ARRAY laStruc
INDEX ON prvcodigo TAG codigo

SELE op_ft_pro
AFIELDS(laStruc)
CREATE CURSOR cFicha3 FROM ARRAY laStruc
INDEX ON prvcodigo TAG codigo

SELE op_ft_pro1
AFIELDS(laStruc)
CREATE CURSOR cFicha31 FROM ARRAY laStruc
INDEX ON item + prccodigo TAG codigo

SELE op_ft_pro2
AFIELDS(laStruc)
CREATE CURSOR cFicha32 FROM ARRAY laStruc
INDEX ON item + prccodigo + carcodigo TAG codigo

SELE op_ft_med
AFIELDS(laStruc)
CREATE CURSOR cFicha4 FROM ARRAY laStruc

SELE op_ft_fot
AFIELDS(laStruc)
CREATE CURSOR cFicha5 FROM ARRAY laStruc
***
*** Cargando Cursores
SELECT article
SEEK pcCodigoArticulo

SELE op_ft_ins
SEEK pcNumeroOrden + pcCodigoArticulo
SCAN WHILE serie + nrodoc + codigo = pcNumeroOrden + pcCodigoArticulo
	SCATTER MEMVAR
	INSERT INTO cFicha1 FROM MEMVAR
ENDSCAN

SELE op_ft_equ
SEEK pcNumeroOrden + pcCodigoArticulo
SCAN WHILE serie + nrodoc + codigo = pcNumeroOrden + pcCodigoArticulo
	SCATTER MEMVAR
	INSERT INTO cFicha2 FROM MEMVAR
ENDSCAN

SELE op_ft_pro
SEEK pcNumeroOrden + pcCodigoArticulo
SCAN WHILE serie + nrodoc + codigo = pcNumeroOrden + pcCodigoArticulo
	SCATTER MEMVAR
	INSERT INTO cFicha3 FROM MEMVAR
ENDSCAN

SELE op_ft_pro1
SEEK pcNumeroOrden + pcCodigoArticulo
SCAN WHILE serie + nrodoc + codigo = pcNumeroOrden + pcCodigoArticulo
	SCATTER MEMVAR
	INSERT INTO cFicha31 FROM MEMVAR
ENDSCAN

SELE op_ft_pro2
SEEK pcNumeroOrden + pcCodigoArticulo
SCAN WHILE serie + nrodoc + codigo = pcNumeroOrden + pcCodigoArticulo
	SCATTER MEMVAR
	INSERT INTO cFicha32 FROM MEMVAR
ENDSCAN

SELE op_ft_med
SEEK pcNumeroOrden + pcCodigoArticulo
SCAN WHILE serie + nrodoc + codigo = pcNumeroOrden + pcCodigoArticulo
	SCATTER MEMVAR
	INSERT INTO cFicha4 FROM MEMVAR
ENDSCAN

SELE op_ft_fot
SEEK pcNumeroOrden + pcCodigoArticulo
SCAN WHILE serie + nrodoc + codigo = pcNumeroOrden + pcCodigoArticulo
	SCATTER MEMVAR
	INSERT INTO cFicha5 FROM MEMVAR
ENDSCAN
***
oExcel = CREATEOBJECT("Excel.Application")
lcFileName = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","FICHA_TECNICA")
IF ISNULL(lcFileName) OR EMPTY(lcFileName)
	lcFileName = "ficha_tecnica.xls"
ENDIF
lcFileType = SUBSTR(lcFileName,RAT(".",lcFileName)+1)
lcFileSource = _rt_sis_ + "\plantillas\" + lcFileName
lcFileTarget = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","EXCEL_TARGET")
IF ISNULL(lcFileTarget) OR EMPTY(lcFileTarget)
	MESSAGEBOX("No se ha definido la ubicación destino" + CHR(13) + "del archivo en la configuración.",0+48,"Exportar Proforma")
	RETURN
ENDIF
lcFileTarget = "'" + lcFileTarget + "\FICHA_TECNICA." + lcFileType + "'"
WAIT WINDOW "Iniciando Excel..." NOWAIT
COPY FILE &lcFileSource. TO &lcFileTarget.
oExcel.WorkBooks.Open(&lcFileTarget.)
XLSheet = oExcel.ActiveSheet
lnRow = 1
*** CABECERA
SELECT orden1
SEEK pcNumeroOrden

SELECT orden2
SEEK pcNumeroOrden + pcItemArticulo

SELE cliente
SEEK orden1.cod_auxi

SELECT vendedor
SEEK ALLTRIM(orden1.cod_vend)

lnRow = lnRow + 1
XLSheet.Cells(lnRow,2).Value = orden1.fecha_reg

lnRow = lnRow + 1
XLSheet.Cells(lnRow,2).Value = SUBSTR(pcNumeroOrden,2,2) + "-" + SUBSTR(pcNumeroOrden,10,5)

lnRow = lnRow + 1
XLSheet.Cells(lnRow,2).Value = ALLTRIM(cliente.razon_com)

lnRow = lnRow + 1
XLSheet.Cells(lnRow,2).Value = ALLTRIM(vendedor.descri)

lnRow = lnRow + 1
XLSheet.Cells(lnRow,2).Value = ALLTRIM(IIF(!EMPTY(article.cod_intemp),article.cod_intemp,article.cod_wayra))

lnRow = lnRow + 1
XLSheet.Cells(lnRow,2).Value = ALLTRIM(orden2.des_artcli)

lnRow = lnRow + 1
XLSheet.Cells(lnRow,2).Value = ALLTRIM(article.descri)

lnRow = lnRow + 1
XLSheet.Cells(lnRow,2).Value = ALLTRIM(STR(orden2.peso,6,2)) + " KG."
***
lnRow = lnRow + 3
*** PROVEEDORES DE MATERIA PRIMA
SELECT prvcodigo FROM cFicha1 GROUP BY prvcodigo INTO CURSOR curTemp
SCAN
	XLSheet.Rows(lnRow+2).Insert
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT curTemp
SCAN
	lnRow = lnRow + 1
	SELE provider
	SEEK curTemp.prvcodigo
	XLSheet.Cells(lnRow,1).Value = ALLTRIM(provider.descri)
	lcInsumo = ""
	lcTorsion = ""
	lcComposicion = ""
	lcTitulo = ""
	lcColorCodigo = ""
	lcColorNombre = ""
	lcMedida = ""
	lcMerma = ""
	SELECT cFicha1
	SEEK curTemp.prvcodigo
	SCAN WHILE prvcodigo = curTemp.prvcodigo
		lcTorsion = lcTorsion + IIF(!EMPTY(lcTorsion),", ","") + ALLTRIM(cFicha1.ftihilo)
		lcMerma = lcMerma + IIF(!EMPTY(lcMerma),", ","") + ALLTRIM(STR(cFicha1.ftimerma,6,2)) + "%"
		SELECT supplie
		SEEK cFicha1.cod_articu
		IF FOUND()
			lcInsumo = lcInsumo + IIF(!EMPTY(lcInsumo),", ","") + ALLTRIM(supplie.cod_intemp)
			lcComposicion = lcComposicion + IIF(!EMPTY(lcComposicion),", ","") + ALLTRIM(supplie.des_comp)
			lcTitulo = lcTitulo + IIF(!EMPTY(lcTitulo),", ","") + ALLTRIM(supplie.des_titu)
			lcColorCodigo = lcColorCodigo + IIF(!EMPTY(lcColorCodigo),", ","") + ALLTRIM(supplie.cod_colpro)
			lcColorNombre = lcColorNombre + IIF(!EMPTY(lcColorNombre),", ","") + ALLTRIM(supplie.des_colo)
			lcMedida = lcMedida + IIF(!EMPTY(lcMedida),", ","") + ALLTRIM(supplie.des_med1)
		ENDIF
	ENDSCAN
	XLSheet.Cells(lnRow,2).Value = lcInsumo
	XLSheet.Cells(lnRow,3).Value = lcTorsion
	XLSheet.Cells(lnRow,4).Value = lcComposicion
ENDSCAN
***
lnRow = lnRow + 2
*** OTROS DATOS DE PROVEEDORES DE MATERIA PRIMA
SELECT curTemp
SCAN
	XLSheet.Rows(lnRow+2).Insert
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT curTemp
SCAN
	lnRow = lnRow + 1
	lcTitulo = ""
	lcColorCodigo = ""
	lcColorNombre = ""
	lcMedida = ""
	lcMerma = ""
	lcPeso = ""
	SELECT cFicha1
	SEEK curTemp.prvcodigo
	SCAN WHILE prvcodigo = curTemp.prvcodigo
		lcMerma = lcMerma + IIF(!EMPTY(lcMerma),", ","") + ALLTRIM(STR(cFicha1.ftimerma,6,2)) + "%"
		SELECT supplie
		SEEK cFicha1.cod_articu
		IF FOUND()
			lcTitulo = lcTitulo + IIF(!EMPTY(lcTitulo),", ","") + ALLTRIM(supplie.des_titu)
			lcColorCodigo = lcColorCodigo + IIF(!EMPTY(lcColorCodigo),", ","") + ALLTRIM(supplie.cod_colpro)
			lcColorNombre = lcColorNombre + IIF(!EMPTY(lcColorNombre),", ","") + ALLTRIM(supplie.des_colo)
			lcMedida = lcMedida + IIF(!EMPTY(lcMedida),", ","") + ALLTRIM(supplie.des_med1)
			IF supplie.cod_fami = "00001"
				lcPeso = lcPeso + IIF(!EMPTY(lcPeso),", ","") + ALLTRIM(STR(cFicha1.fticantid,8,2)) + " KG."
			ENDIF
		ENDIF
	ENDSCAN
	XLSheet.Cells(lnRow,1).Value = lcTitulo
	XLSheet.Cells(lnRow,2).Value = lcColorCodigo
	XLSheet.Cells(lnRow,3).Value = lcColorNombre
	XLSheet.Cells(lnRow,4).Value = lcMedida
	XLSheet.Cells(lnRow,5).Value = lcMerma
	XLSheet.Cells(lnRow,6).Value = lcPeso
ENDSCAN
***
lnRow = lnRow + 2
*** COLORES
SELE curTemp
SCAN
	SELECT cFicha1
	SEEK curTemp.prvcodigo
	SCAN WHILE prvcodigo = curTemp.prvcodigo
		XLSheet.Rows(lnRow+2).Insert
	ENDSCAN
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT curTemp
SCAN
	SELECT cFicha1
	SEEK curTemp.prvcodigo
	SCAN WHILE prvcodigo = curTemp.prvcodigo
		lnRow = lnRow + 1
		SELECT supplie
		SEEK cFicha1.cod_articu
		IF FOUND()
			XLSheet.Cells(lnRow,1).Value = ALLTRIM(supplie.cod_colpro)
			XLSheet.Cells(lnRow,2).Value = ALLTRIM(supplie.des_colo)
			IF supplie.cod_fami = "00001"
				XLSheet.Cells(lnRow,3).Value = ALLTRIM(STR(cFicha1.fticantid,8,2)) + " KG."
			ENDIF
		ENDIF
	ENDSCAN
ENDSCAN
USE
***
lnRow = lnRow + 3
*** DATOS DE PROVEEDORES DE EQUIVALENCIA
SELECT prvcodigo FROM cFicha2 GROUP BY prvcodigo INTO CURSOR curTemp
SCAN
	XLSheet.Rows(lnRow+2).Insert
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT curTemp
SCAN
	lnRow = lnRow + 1
	SELE provider
	SEEK curTemp.prvcodigo
	XLSheet.Cells(lnRow,1).Value = ALLTRIM(provider.descri)
	lcInsumo = ""
	lcComposicion = ""
	lcTitulo = ""
	lcColorCodigo = ""
	SELECT cFicha2
	SEEK curTemp.prvcodigo
	SCAN WHILE prvcodigo = curTemp.prvcodigo
		SELECT supplie
		SEEK cFicha2.cod_articu
		IF FOUND()
			lcInsumo = lcInsumo + IIF(!EMPTY(lcInsumo),", ","") + ALLTRIM(supplie.cod_intemp)
			lcComposicion = lcComposicion + IIF(!EMPTY(lcComposicion),", ","") + ALLTRIM(supplie.des_comp)
			lcTitulo = lcTitulo + IIF(!EMPTY(lcTitulo),", ","") + ALLTRIM(supplie.des_titu)
			lcColorCodigo = lcColorCodigo + IIF(!EMPTY(lcColorCodigo),", ","") + ALLTRIM(supplie.cod_colpro)
		ENDIF
	ENDSCAN
	XLSheet.Cells(lnRow,2).Value = lcInsumo
	XLSheet.Cells(lnRow,3).Value = lcComposicion
	XLSheet.Cells(lnRow,4).Value = lcTitulo
	XLSheet.Cells(lnRow,5).Value = lcColorCodigo
ENDSCAN
***
lnRow = lnRow + 2
*** OTROS DATOS DE PROVEEDORES DE EQUIVALENCIA
SELECT curTemp
SCAN
	XLSheet.Rows(lnRow+2).Insert
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT curTemp
SCAN
	lnRow = lnRow + 1
	lcColorNombre = ""
	lcMedida = ""
	lcMerma = ""
	SELECT cFicha2
	SEEK curTemp.prvcodigo
	SCAN WHILE prvcodigo = curTemp.prvcodigo
		lcMerma = lcMerma + IIF(!EMPTY(lcMerma),", ","") + ALLTRIM(STR(cFicha1.ftimerma,6,2)) + "%"
		SELECT supplie
		SEEK cFicha2.cod_articu
		IF FOUND()
			lcColorNombre = lcColorNombre + IIF(!EMPTY(lcColorNombre),", ","") + ALLTRIM(supplie.des_colo)
			lcMedida = lcMedida + IIF(!EMPTY(lcMedida),", ","") + ALLTRIM(supplie.des_med1)
		ENDIF
	ENDSCAN
	XLSheet.Cells(lnRow,1).Value = lcColorNombre
	XLSheet.Cells(lnRow,2).Value = lcMedida
	XLSheet.Cells(lnRow,3).Value = lcMerma
ENDSCAN
USE
***
lnRow = lnRow + 3
*** DATOS DE PROVEEDORES DE PROCESO
SELECT prvcodigo FROM cFicha3 GROUP BY prvcodigo INTO CURSOR curTemp
SCAN
	XLSheet.Rows(lnRow+2).Insert
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT curTemp
SCAN
	lnRow = lnRow + 1
	SELE provider
	SEEK curTemp.prvcodigo
	XLSheet.Cells(lnRow,1).Value = ALLTRIM(provider.descri)
	lcProceso = ""
	SELECT cFicha3
	SEEK curTemp.prvcodigo
	SCAN WHILE prvcodigo = curTemp.prvcodigo
		SELECT process
		SEEK cFicha3.procodigo
		IF FOUND()
			lcProceso = lcProceso + IIF(!EMPTY(lcProceso),", ","") + ALLTRIM(process.prodescri)
		ENDIF
	ENDSCAN
	XLSheet.Cells(lnRow,2).Value = lcProceso
ENDSCAN
***
lnRow = lnRow + 2
*** OTROS DATOS DE PROVEEDORES DE PROCESO
SELECT curTemp
SCAN
	XLSheet.Rows(lnRow+2).Insert
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT curTemp
SCAN
	lnRow = lnRow + 1
	lcUtensilio = ""
	lcComentario = ""
	SELECT cFicha3
	SEEK curTemp.prvcodigo
	SCAN WHILE prvcodigo = curTemp.prvcodigo
		lcUtensilio = lcUtensilio + IIF(!EMPTY(lcUtensilio),", ","") + ALLTRIM(cFicha3.ftputensi)
		lcComentario = lcComentario + IIF(!EMPTY(lcComentario),", ","") + ALLTRIM(cFicha3.ftpcoment)
	ENDSCAN
	XLSheet.Cells(lnRow,1).Value = lcUtensilio
	XLSheet.Cells(lnRow,2).Value = lcComentario
	XLSheet.Range(EXCEL_COLUMN(2) + ALLTRIM(STR(lnRow)) + ":" + EXCEL_COLUMN(5) + ALLTRIM(STR(lnRow))).Select
	XLSheet.Application.Selection.MergeCells = .T.
ENDSCAN
USE
***
lnRow = lnRow + 3
*** PROCESOS
SELECT cFicha3
SET ORDER TO
SCAN
	XLSheet.Rows(lnRow+2).Insert
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT cFicha3
SCAN
	lnRow = lnRow + 1
	XLSheet.Cells(lnRow,1).Value = ALLTRIM(cFicha3.prodescri)
	SELE provider
	SEEK cFicha3.prvcodigo
	XLSheet.Cells(lnRow,2).Value = ALLTRIM(provider.descri)
	XLSheet.Range(EXCEL_COLUMN(2) + ALLTRIM(STR(lnRow)) + ":" + EXCEL_COLUMN(5) + ALLTRIM(STR(lnRow))).Select
	XLSheet.Application.Selection.MergeCells = .T.
ENDSCAN
USE
***
lnRow = lnRow + 3
*** MEDIDAS
SELECT cFicha4
SCAN
	XLSheet.Rows(lnRow+2).Insert
ENDSCAN
&& Eliminando las dos filas que vienen de la Plantilla
XLSheet.Rows(lnRow+1).Delete
XLSheet.Rows(lnRow+1).Delete
&&
SELECT cFicha4
SCAN
	lnRow = lnRow + 1
	XLSheet.Cells(lnRow,1).Value = ALLTRIM(cFicha4.ftmcodigo)
	XLSheet.Cells(lnRow,2).Value = ALLTRIM(cFicha4.ftmdescri)
	XLSheet.Cells(lnRow,3).Value = ALLTRIM(cFicha4.ftmcantid) + " " + ALLTRIM(cFicha4.umedescri)
	*XLSheet.Cells(lnRow,4).Value = && PESO
ENDSCAN
USE
***
lnRow = lnRow + 2
*** FOTOS
SELECT cFicha5
SCAN
	llIsPair = (MOD(RECNO("cFicha5"),2) = 0)
	IF !llIsPair && IMPAR
		lnRow = lnRow + 1
		lnColumnStart = 1
		lnColumnEnd = 2
	ELSE && PAR
		lnColumnStart = 3
		lnColumnEnd = 6
	ENDIF
	XLSheet.Cells(lnRow,lnColumnStart).Value = ALLTRIM(cFicha5.ftfdescri)
	XLSheet.Range(EXCEL_COLUMN(lnColumnStart) + ALLTRIM(STR(lnRow)) + ":" + EXCEL_COLUMN(lnColumnEnd) + ALLTRIM(STR(lnRow))).Select
	XLSheet.Application.Selection.MergeCells = .T.
	XLSheet.Application.Selection.Font.Bold = .T.
	XLSheet.Application.Selection.Interior.Color = RGB(128,128,128)
	XLSheet.Application.Selection.Font.Color = RGB(255,255,255)
	XLSheet.Application.Selection.Borders(1).LineStyle = 1
	XLSheet.Application.Selection.Borders(2).LineStyle = 1
	XLSheet.Application.Selection.Borders(3).LineStyle = 1
	XLSheet.Application.Selection.Borders(4).LineStyle = 1
	XLSheet.Application.Selection.VerticalAlignment = 2
	lcArchivo = ""
	IF !EMPTY(_Carpeta_Foto) AND !EMPTY(cFicha5.ftftipo)
		lcArchivo = _Carpeta_Foto + "\OP" + PADL(ALLTRIM(SUBSTR(pcNumeroOrden,1,4)),4,"0") + SUBSTR(pcNumeroOrden,5) + cFicha5.codigo + cFicha5.ftfcodigo + "." + ALLTRIM(cFicha5.ftftipo)
		IF !FILE(lcArchivo)
			lcArchivo = ""
		ENDIF
	ENDIF
	IF !EMPTY(lcArchivo)
		XLSheet.Range(EXCEL_COLUMN(lnColumnStart) + ALLTRIM(STR(lnRow+1)) + ":" + EXCEL_COLUMN(lnColumnEnd) + ALLTRIM(STR(lnRow+1))).Select
		XLSheet.Pictures.Insert(lcArchivo)
		*XLSheet.Pictures.ShapeRange.ScaleWidth(0.70,0,0)
		*XLSheet.Pictures.ShapeRange.ScaleHeight(0.70,0,0)
		XLSheet.Pictures.ShapeRange.Height = 176
		lnRow = lnRow + IIF(llIsPair,13,0)
	ELSE
		XLSheet.Cells(lnRow+1,1).Value = "SIN FOTO"
		lnRow = lnRow + IIF(llIsPair,1,0)
	ENDIF
ENDSCAN
***
oExcel.Visible = .T.
RELEASE oExcel

*** Cerrando Tablas
SELECT orden1
IF !EMPTY(lcOrderOrden1)
	SET ORDER TO &lcOrderOrden1.
ENDIF
IF !llUsedOrden1
	USE
ENDIF

SELECT orden2
IF !EMPTY(lcOrderOrden2)
	SET ORDER TO &lcOrderOrden2.
ENDIF
IF !llUsedOrden2
	USE
ENDIF

SELECT cliente
IF !EMPTY(lcOrderCliente)
	SET ORDER TO &lcOrderCliente.
ENDIF
IF !llUsedCliente
	USE
ENDIF

SELECT vendedor
IF !EMPTY(lcOrderVendedor)
	SET ORDER TO &lcOrderVendedor.
ENDIF
IF !llUsedVendedor
	USE
ENDIF

SELECT op_ft_ins
IF !EMPTY(lcOrderInsumo)
	SET ORDER TO &lcOrderInsumo.
ENDIF
IF !llUsedInsumo
	USE
ENDIF

SELECT op_ft_equ
IF !EMPTY(lcOrderEquivale)
	SET ORDER TO &lcOrderEquivale.
ENDIF
IF !llUsedEquivale
	USE
ENDIF

SELECT op_ft_pro
IF !EMPTY(lcOrderProceso)
	SET ORDER TO &lcOrderProceso.
ENDIF
IF !llUsedProceso
	USE
ENDIF

SELECT op_ft_pro1
IF !EMPTY(lcOrderProceso1)
	SET ORDER TO &lcOrderProceso1.
ENDIF
IF !llUsedProceso1
	USE
ENDIF

SELECT op_ft_pro2
IF !EMPTY(lcOrderProceso2)
	SET ORDER TO &lcOrderProceso2.
ENDIF
IF !llUsedProceso2
	USE
ENDIF

SELECT op_ft_med
IF !EMPTY(lcOrderMedida)
	SET ORDER TO &lcOrderMedida.
ENDIF
IF !llUsedMedida
	USE
ENDIF

SELECT op_ft_fot
IF !EMPTY(lcOrderFoto)
	SET ORDER TO &lcOrderFoto.
ENDIF
IF !llUsedFoto
	USE
ENDIF

SELECT article
IF !EMPTY(lcOrderArticle)
	SET ORDER TO &lcOrderArticle.
ENDIF
IF !llUsedArticle
	USE
ENDIF

SELECT supplie
IF !EMPTY(lcOrderSupplie)
	SET ORDER TO &lcOrderSupplie.
ENDIF
IF !llUsedSupplie
	USE
ENDIF

SELECT process
IF !EMPTY(lcOrderProcess)
	SET ORDER TO &lcOrderProcess.
ENDIF
IF !llUsedProcess
	USE
ENDIF

SELECT measure1
IF !EMPTY(lcOrderMeasure1)
	SET ORDER TO &lcOrderMeasure1.
ENDIF
IF !llUsedMeasure1
	USE
ENDIF

SELECT measure2
IF !EMPTY(lcOrderMeasure2)
	SET ORDER TO &lcOrderMeasure2.
ENDIF
IF !llUsedMeasure2
	USE
ENDIF

SELECT provider
IF !EMPTY(lcOrderProvider)
	SET ORDER TO &lcOrderProvider.
ENDIF
IF !llUsedProvider
	USE
ENDIF

USE IN IIF(USED("cFicha1"),"cFicha1",0)
USE IN IIF(USED("cFicha2"),"cFicha2",0)
USE IN IIF(USED("cFicha3"),"cFicha3",0)
USE IN IIF(USED("cFicha31"),"cFicha31",0)
USE IN IIF(USED("cFicha32"),"cFicha32",0)
USE IN IIF(USED("cFicha4"),"cFicha4",0)
USE IN IIF(USED("cFicha5"),"cFicha5",0)
***
RETURN