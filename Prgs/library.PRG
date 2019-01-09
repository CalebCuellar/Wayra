PROCEDURE INICIO
Do x_path
Do x_seteos
Do x_path
Do creafile WITH 'ALL_FILE'
Do x_DBFS
SET PROCEDURE TO LIBRARY
SET CLASSLIB TO bsc
ON KEY LABEL CTRL+S SUSPEND
tmp = nombre('®¨¼')
= CREATE_FILE_USER()
RETURN

Procedure x_DBFs
if !file('MaesVari.DBF')
	create cursor tempo (Radical c(3), Codigo c(10), Descri c(50), ;
		ValVar_01 c(10)  , ValVar_02 c(10)  , ValVar_03 c(10), ;
		ValNum_01 n(12,2), ValNum_02 n(12,2), ValNum_03 n(12,2), ;
		new_usu c(3), new_fec d(8), new_hor c(9), ;
		mod_usu c(3), mod_fec d(8), mod_hor c(9), ;
		del_usu c(3), del_fec d(8), del_hor c(9))
	Index on Radical + Codigo Tag Codigo
	Index on Radical + Descri Tag Descri
	Select tempo
	Copy To &_rt_bas_.\MaesVari With CDX Type fox2x
	use in tempo
endif
use in 0 MaesVari Order Codigo Alias aMaesVari
*** Carga los meses del año 01-->12
Do Crg_DBFs with 'MES', '01', 'ENERO'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '02', 'FEBRERO'    , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '03', 'MARZO'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '04', 'ABRIL'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '05', 'MAYO'       , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '06', 'JUNIO'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '07', 'JULIO'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '08', 'AGOSTO'     , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '09', 'SETIEMBRE'  , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '10', 'OCTUBRE'    , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '11', 'NOVIEMBRE'  , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MES', '12', 'DICIEMBRE'  , '', '', '', 0, 0, 0


Do Crg_DBFs with 'MON', 'SOL', 'NUEVOS SOLES'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MON', 'DOL', 'DOLARES AMERICANOS', '', '', '', 0, 0, 0

Do Crg_DBFs with 'IMP', 'IGV ', 'IMPUESTO GENERAL A LAS VENTAS', '', '', '', 19, 1.19, 0.19

Do Crg_DBFs with 'TCA', 'C', 'COMPRA'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'TCA', 'V', 'VENTA'       , '', '', '', 0, 0, 0
Do Crg_DBFs with 'TCA', 'O', 'OTROS'       , '', '', '', 0, 0, 0

*Do Crg_DBFs with 'DRE', 'SIN', 'SIN DOCUMENTO'      , '', '', '', 0, 0, 0
*Do Crg_DBFs with 'DRE', 'FACT', 'FACTURA'      , '', '', '', 0, 0, 0
*Do Crg_DBFs with 'DRE', 'BOLE', 'BOLETA DE VENTA'      , '', '', '', 0, 0, 0
*Do Crg_DBFs with 'DRE', 'CRED', 'NOTA DE CREDITO'      , '', '', '', 0, 0, 0
*Do Crg_DBFs with 'DRE', 'DEBI', 'NOTA DE DEBITO'      , '', '', '', 0, 0, 0
*Do Crg_DBFs with 'DRE', 'GUIS', 'PROFORMA INTERNA'      , '', '', '', 0, 0, 0
*Do Crg_DBFs with 'DRE', 'PARI', 'PARTE DE INGRESO INTERNO'      , '', '', '', 0, 0, 0
*Do Crg_DBFs with 'DRE', 'PARS', 'PARTE DE SALIDA INTERNO'      , '', '', '', 0, 0, 0
*Do Crg_DBFs with 'DRE', 'GUIA', 'GUIA DE REMISION'      , '', '', '', 0, 0, 0

*** Relacion de Maestros de Productos (Artículo, Concepto, Servicio)
Do Crg_DBFs with 'MTP', 'P', 'Artículos'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MTP', 'C', 'Conceptos'      , '', '', '', 0, 0, 0
Do Crg_DBFs with 'MTP', 'S', 'Servicios'      , '', '', '', 0, 0, 0
***
***
*** Quiebres del reporte de ventas configurables
DO  Crg_DBFs WITH 'QRV', '01', 'Tipos de Documentos', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '02', 'Emisores de Documentos', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '03', 'Documento', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '04', 'Fechas', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '05', 'Periodo Mensual', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '06', 'Periodo Anual', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '07', 'Motivos de Venta', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '08', 'Local de Salida', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '09', 'Cliente', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '10', 'Forma de Pago', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '11', 'Vendedor', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '12', 'Familia de Artículo', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '13', 'Sub-Familia de Artículo', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '14', 'Tipo de Artículo', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '15', 'Artículo o Producto', '', '', '', 0, 0, 0
* quiebres adicionales 24-09-2010
DO  Crg_DBFs WITH 'QRV', '16', 'Relación de Conceptos', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '17', 'Relación de Servicios', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '18', 'Todos los Productos', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRV', '19', 'Tipo de Productos', '', '', '', 0, 0, 0
***
***
*** Quiebres del reporte de Movimiento de kardex configurables
DO  Crg_DBFs WITH 'QRK', '01', 'Tipos de Documentos', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '02', 'Emisores de Documentos', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '03', 'Documento', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '04', 'Fechas', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '05', 'Periodo Mensual', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '06', 'Periodo Anual', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '07', 'Motivos u Operaciones', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '08', 'Local', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '09', 'Familia de Artículo', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '10', 'Sub-Familia de Artículo', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '11', 'Tipo de Artículo', '', '', '', 0, 0, 0
DO  Crg_DBFs WITH 'QRK', '12', 'Artículo o Producto', '', '', '', 0, 0, 0
use in aMaesVari

if !file('StockArt.DBF')
	create cursor tempo (tip_produc c(1), cod_articu c(13), cod_alma c(3), Stock_Arti n(16,6))
	
	SELECT tempo
	Index on cod_articu + cod_alma Tag Codigo
	Index on cod_alma + cod_articu Tag Almacen
	
	Select tempo
	Copy To &_rt_bas_.\StockArt With CDX Type fox2x
	use in tempo
endif

if !file('kardex2.dbf')
	Create Cursor tempo (;
		tip_produc c(1), COD_ARTICU C(13), COD_AUXI C(15), COD_ALMA C(3), COD_ALMA1 C(3), ;
		TIPDOC C(4), SERIE C(4), NRODOC C(10), ITEM C(5), FECHA_REG D(8), ;
		RAD_MOTI C(3), COD_MOTI C(3), COD_MONE C(3), ;
		TIPCAM_COD C(1), TIPCAM_VAL N(16,6), ;
		PRECOM_SOL N(16,6), PRECOM_DOL N(16,6), PREPRO_SOL N(16,6), PREPRO_DOL N(16,6), ;
		CANTID_ING N(16,6), CANTID_SAL N(16,6), CANTID_SLD N(16,6), ;
		IMPSOL_ING N(16,6), IMPSOL_SAL N(16,6), IMPSOL_SLD N(16,6), ;
		IMPDOL_ING N(16,6), IMPDOL_SAL N(16,6), IMPDOL_SLD N(16,6), ;
		ORDEN C(2), ;
		DOCREL_TIP C(4), DOCREL_SER C(4), DOCREL_NRO C(10), ;
		DOCCOM1TIP C(4), DOCCOM1SER C(4), DOCCOM1NRO C(10), DOCCOM1FEC D(8), ;
		DOCCOM2TIP C(4), DOCCOM2SER C(4), DOCCOM2NRO C(10), DOCCOM2FEC D(8) )
		
	SELECT tempo	
	index on cod_articu+DTOS(fecha_reg)+orden tag kardex2
	index on tipdoc + serie + nrodoc + item tag documento
	
	Select tempo
	Copy To &_rt_bas_.\kardex2 With CDX Type fox2x
	use in tempo
endif
return


Procedure Crg_DBFs
Parame xxxRadical, xxxCodigo, xDescri, xValVar_01, xValVar_02, xValVar_03, xValNum_01, xValNum_02, xValNum_03

Select aMaesVari
Locate For Radical + Codigo = xxxRadical + xxxCodigo
If EOF()
	Do While !FLock()
		Wait Windows 'Espere un Momento ..........' Time 3
	EndDo
	Select aMaesVari
	Append Blank
	Replace Radical   with xxxRadical
	Replace Codigo    with xxxCodigo
	Replace Descri    with xDescri
	Replace ValVar_01 with xValVar_01
	Replace ValVar_02 with xValVar_02
	Replace ValVar_03 with xValVar_03
	Replace ValNum_01 with xValNum_01
	Replace ValNum_02 with xValNum_02
	Replace ValNum_03 with xValNum_03
	Replace new_usu   with _usuario
	Replace new_fec   with date()
	Replace new_hor   with time()
	Unlock
Endif
Select aMaesVari
Set Key To
Return


FUNCTION CODIFICA
PARAMETER LCCODI
LCCODI = ALLTRIM(LCCODI)
LCCODE = ""
FOR I = 1 TO LEN(LCCODI)
	LCCHAR = SUBSTR(LCCODI, I, 1)
	LCASC = ASC(LCCHAR)+ASC("=")
	LCCODE = LCCODE+CHR(LCASC)
ENDFOR
RETURN LCCODE
ENDFUNC
**
FUNCTION DECODIFICA
PARAMETER LCCODE
LCCODE = ALLTRIM(LCCODE)
LCCODI = ""
FOR I = 1 TO LEN(LCCODE)
	LCCHAR = SUBSTR(LCCODE, I, 1)
	LNASC = ASC(LCCHAR)-ASC("=")
	LCCODI = LCCODI+CHR(LNASC)
ENDFOR
RETURN LCCODI
ENDFUNC

PROCEDURE PROC_OPC
lcCodigo = LEFT(PROMPT(),4)
*** Abriendo Tablas
SELE 0
USE tabopc ORDER tabopc
***
SELECT tabopc
SEEK _modulo + lcCodigo
lcPrograma = ALLTRIM(tabopc.programa)
*** Cerrando Tablas
USE IN tabopc
***
DO ejecuta WITH lcPrograma
RETURN

PROCEDURE EJECUTA
PARAMETERS pcNombreArchivo
SET SYSMENU OFF
ON KEY LABEL ESC
lcNombreArchivo = "" && SUBSTR(pcNombreArchivo,1,12)
FOR I = 1 TO LEN(ALLTRIM(pcNombreArchivo))
	lcCaracter = SUBSTR(pcNombreArchivo,I,1)
	IF !EMPTY(lcCaracter)
		lcNombreArchivo = lcNombreArchivo + lcCaracter
	ELSE
		EXIT
	ENDIF
ENDFOR
IF FILE(lcNombreArchivo)
	CLOSE DATABASE
	lcComando = "DO " + ALLTRIM(pcNombreArchivo)
	&lcComando.
ELSE
	IF FILE("\BSC\VFPE\" + lcNombreArchivo)
		CLOSE DATABASE
		DO \BSC\VFPE\&pcNombreArchivo.
	ELSE
		WAIT WINDOW "Archivo Seleccionado, No encontrado ... " + pcNombreArchivo TIMEOUT 2
	ENDIF
ENDIF
ON KEY LABEL ESC = 0
SET SYSMENU ON
RETURN

FUNCTION CREATE_FILE_INIT
IF !FILE(SYS(5) + CURDIR() + "CONFIG.INI")
	= WriteFileIni(SYS(5) + CURDIR() + "CONFIG.INI","BSC","DB_PATH","D:\Sistemas\Sistem01\CIBY")
	= WriteFileIni(SYS(5) + CURDIR() + "CONFIG.INI","BSC","EXCEL_TARGET","c:\exportar\")
	= WriteFileIni(SYS(5) + CURDIR() + "CONFIG.INI","BSC","CONTABILIDAD_PATH","\\192.168.1.2\SisBSC2011\")
ENDIF
RETURN

*----------------------------------------------------
FUNCTION WriteFileIni(tcFileName,tcSection,tcEntry,tcValue)
*----------------------------------------------------
* Escribe un valor de un archivo INI.
* Si no existe el archivo, la sección o la entrada, la crea.
* Retorna .T. si tuvo éxito
* PARAMETROS:
*  tcFileName = Nombre y ruta completa del archivo.INI
*  tcSection = Sección del archivo.INI
*  tcEntry = Entrada del archivo.INI
*  tcValue = Valor de la entrada
* USO: WriteFileIni("C:MiArchivo.ini","Default","Port","2")
* RETORNO: Logico
*----------------------------------------------------
DECLARE INTEGER WritePrivateProfileString ;
	IN WIN32API ;
	STRING cSection,STRING cEntry,STRING cEntry,;
	STRING cFileName

RETURN IIF(WritePrivateProfileString(tcSection,tcEntry,tcValue,tcFileName)=1, .T., .F.)
ENDFUNC

*----------------------------------------------------
FUNCTION ReadFileIni(tcFileName,tcSection,tcEntry)
*----------------------------------------------------
* Lee un valor de un archivo INI.
* Si no existe el archivo, la sección o la entrada, retorna .NULL.
* PARAMETROS:
*  tcFileName = Nombre y ruta completa del archivo.INI
*  tcSection = Sección del archivo.INI
*  tcEntry = Entrada del archivo.INI
* USO: ReadFileIni("C:MiArchivo.ini","Default","Port")
* RETORNO: Caracter
*----------------------------------------------------
LOCAL lcIniValue, lnResult, lnBufferSize
DECLARE INTEGER GetPrivateProfileString ;
   IN WIN32API ;
   STRING cSection,;
   STRING cEntry,;
   STRING cDefault,;
   STRING @cRetVal,;
   INTEGER nSize,;
   STRING cFileName
lnBufferSize = 255
lcIniValue = spac(lnBufferSize)
lnResult=GetPrivateProfileString(tcSection,tcEntry,"*NULL*",;
   @lcIniValue,lnBufferSize,tcFileName)
lcIniValue=SUBSTR(lcIniValue,1,lnResult)
IF lcIniValue="*NULL*"
   lcIniValue=.NULL.
ENDIF
RETURN lcIniValue
ENDFUNC

FUNCTION DOC_ACT_NUM
PARAMETERS pcDocument,pcNumSerie,pnNumDocu
ln_Select = SELECT()
*** Abriendo Tabla
ll_Used_Maesnume = USED("amaesnume")
IF !ll_Used_Maesnume
	SELECT 0
	USE maesnume ALIAS amaesnume AGAIN
ENDIF
SELECT amaesnume
lc_Order_Maesnume = ORDER()
SET ORDER TO tipdoc
***
SELE amaesnume
SEEK pcDocument + pcNumSerie
IF !FOUND()
	DO WHILE !BLOQUEAFILE()
	ENDDO
	APPEND BLANK
	REPLACE nume_radi WITH SUBSTR(pcDocument,1,3)
	REPLACE nume_tipo WITH SUBSTR(pcDocument,4,4)
	REPLACE nume_indi WITH 0
	REPLACE nume_serie WITH pcNumSerie
	REPLACE nume_ini WITH 1
	REPLACE nume_fin WITH 9999999
	REPLACE nume_fecha WITH DATE()+30
	REPLACE new_usu WITH _usuario
	REPLACE new_fec WITH DATE()
	REPLACE new_hor WITH TIME()
ELSE
	DO WHILE !BLOQUEARECORD()
	ENDDO
ENDIF
*IF pnNumDocu > amaesnume.nume_docu
	REPLACE nume_docu WITH pnNumDocu
*ENDIF
REPLACE mod_usu WITH _usuario
REPLACE mod_fec WITH DATE()
REPLACE mod_hor WITH TIME()
UNLOCK
*** Cerrando Tabla
SELECT amaesnume
IF !EMPTY(lc_Order_Maesnume)
	SET ORDER TO &lc_Order_Maesnume.
ENDIF
IF !ll_Used_Maesnume
	USE
ENDIF
***
SELECT(ln_Select)
RETURN

FUNCTION DOC_VER_NUM
PARAMETERS pcNameTable,pcNameVarSerie,pcNameVarNumber,pcNameCursor,pcNameField
ln_Select = SELECT()
SELE (pcNameTable)
SEEK &pcNameVarSerie. + &pcNameVarNumber.
IF FOUND()
	MESSAGEBOX("Este número de documento ya existe en la base de datos" + CHR(13) +;
		"Estableciendo búsqueda para un nuevo número de documento" + CHR(13) +;
		"Presione una tecla para continuar", 64, "Atención",10000)
	= BLOQUEAFILE()
	*** Buscando Nuevo Correlativo
	DO WHILE .T.
		SELE (pcNameTable)
		SEEK &pcNameVarSerie. + &pcNameVarNumber.
		IF !FOUND()
			MESSAGEBOX("Nuevo Número de Documento" + CHR(13) + "Documento : " + &pcNameVarSerie. + " - " + &pcNameVarNumber.,64,"Atención",5000)
			EXIT
		ELSE
			&pcNameVarNumber. = TRANSFORM(VAL(&pcNameVarNumber.) + 1,"@l 9999999999")
		ENDIF
	ENDDO
	***
	*** Actualizando Cursor Detalle del Documento
	IF !EMPTY(pcNameCursor) AND !EMPTY(pcNameField) AND USED(pcNameCursor)
		SELE (pcNameCursor)
		REPLACE ALL &pcNameField. WITH &pcNameVarNumber. FOR ALIAS() = pcNameCursor
	ENDIF
	***
	SELE (pcNameTable)
	UNLOCK
ENDIF
SELECT(ln_Select)
RETURN

FUNCTION DOC_OBT_NUM
PARAMETERS pcDocument,pcNumSerie,plUpdate,pcTypeReturn,pnLongReturn
pcTypeReturn = IIF(TYPE("pcTypeReturn")="C" AND pcTypeReturn="C","C","N")
pnLongReturn = IIF(TYPE("pnLongReturn") = "N",pnLongReturn,0)
ln_Select = SELECT()
ll_Used_Maesnume = USED("maesnume")
IF !ll_Used_Maesnume
	USE maesnume IN 0 AGAIN
ENDIF
SELECT maesnume
lc_Order_Maesnume = ORDER()
SET ORDER TO tipdoc
SEEK pcDocument + pcNumSerie
lnValueReturn = maesnume.nume_docu + 1
IF !FOUND()
	= BLOQUEAFILE()
	APPEND BLANK
	REPLACE nume_radi WITH SUBSTR(pcDocument,1,3)
	REPLACE nume_tipo WITH SUBSTR(pcDocument,4,4)
	REPLACE nume_indi WITH 0
	REPLACE nume_serie WITH pcNumSerie
	REPLACE nume_ini WITH 1
	REPLACE nume_fin WITH 9999999
	REPLACE nume_fecha WITH DATE()+30
	REPLACE new_usu WITH _usuario
	REPLACE new_fec WITH DATE()
	REPLACE new_hor WITH TIME()
	UNLOCK
ENDIF
IF plUpdate
	REPLACE nume_docu WITH lnValueReturn
	REPLACE mod_usu WITH _usuario
	REPLACE mod_fec WITH DATE()
	REPLACE mod_hor WITH TIME()
ENDIF
IF !EMPTY(lc_Order_Maesnume)
	SET ORDER TO &lc_Order_Maesnume.
ENDIF
IF !ll_Used_Maesnume
	USE
ENDIF
SELECT(ln_Select)
IF pcTypeReturn = "C"
	IF pnLongReturn > 0
		lnValueReturn = PADL(lnValueReturn,pnLongReturn,"0")
	ELSE
		lnValueReturn = ALLTRIM(STR(lnValueReturn))
	ENDIF
ENDIF
RETURN lnValueReturn

FUNCTION DOC_OBT_ACT
PARAMETERS pcDocument
ln_Select = SELECT()
ll_Used_Maesnume = USED("maesnume")
IF !ll_Used_Maesnume
	USE maesnume IN 0 AGAIN
ENDIF
SELECT maesnume
lc_Order_Maesnume = ORDER()
SET ORDER TO numera
SEEK pcDocument + "1"
IF !FOUND()
	SET ORDER TO tipdoc
	SEEK pcDocument
	IF !FOUND()
		APPEND BLANK
		REPLACE nume_radi WITH SUBSTR(pcDocument,1,3)
		REPLACE nume_tipo WITH SUBSTR(pcDocument,4,4)
		REPLACE nume_indi WITH 1
		REPLACE nume_serie WITH "001"
		REPLACE nume_docu WITH 0
		REPLACE nume_ini WITH 1
		REPLACE nume_fin WITH 999999
		REPLACE nume_fecha WITH DATE()+30
		REPLACE new_usu WITH _usuario
		REPLACE new_fec WITH DATE()
		REPLACE new_hor WITH TIME()
		UNLOCK
	ENDIF
ENDIF
IF TYPE("xnume_serie") != "U"
	xnume_serie = maesnume.nume_serie
ENDIF
IF TYPE("xnume_docu") != "U"
	xnume_docu = maesnume.nume_docu
ENDIF
IF TYPE("xnume_ini") != "U"
	xnume_ini = maesnume.nume_ini
ENDIF
IF TYPE("xnume_fin") != "U"
	xnume_fin = maesnume.nume_fin
ENDIF
IF TYPE("xnume_fecha") != "U"
	xnume_fecha = maesnume.nume_fecha
ENDIF
lcValueReturn = maesnume.nume_serie + STR(maesnume.nume_docu,10) + STR(maesnume.nume_ini,10) + STR(maesnume.nume_fin,10) + DTOC(maesnume.nume_fecha)
SELECT maesnume
IF !EMPTY(lc_Order_Maesnume)
	SET ORDER TO &lc_Order_Maesnume.
ENDIF
IF !ll_Used_Maesnume
	USE
ENDIF
SELECT(ln_Select)
RETURN lcValueReturn

FUNCTION BLOQUEARECORD
PARAMETERS lcNameTable,lnNumberRecord
lcNameTable = IIF(TYPE("lcNameTable")="C" AND USED(lcNameTable),lcNameTable,ALIAS())
llLock = .F.
IF !EMPTY(lcNameTable)
	lcNumberRecord = ALLTRIM(STR(IIF(TYPE("lnNumberRecord")="N",lnNumberRecord,RECNO(lcNameTable))))
	llLock = RLOCK(lcNumberRecord,lcNameTable)
	DO WHILE !llLock
		WAIT WINDOW "Intentando bloquear Registro Nº" + lcNumberRecord + " " + lcNameTable + "... ESC=Cancelar" NOWAIT
		llLock = RLOCK(lcNumberRecord,lcNameTable)
		IF INKEY("H") = 27
			EXIT
		ENDIF
	ENDDO
ENDIF
RETURN llLock

FUNCTION BLOQUEAFILE
PARAMETERS lcNameTable
lcNameTable = IIF(TYPE("lcNameTable")="C" AND USED(lcNameTable),lcNameTable,ALIAS())
llLock = .F.
IF !EMPTY(lcNameTable)
	llLock = FLOCK(lcNameTable)
	DO WHILE !llLock
		WAIT WINDOW "Intentando bloquear Tabla " + lcNameTable + "... ESC=Cancelar" NOWAIT
		llLock = FLOCK(lcNameTable)
		IF INKEY("H") = 27
			EXIT
		ENDIF
	ENDDO
ENDIF
RETURN llLock

FUNCTION BORRAR
*CLOSE DATABASES ALL
ln_Select = SELECT()
SELECT 0
*USE maesnume ORDER tipdoc
USE maesnume ORDER numera
CREATE CURSOR cTablas(nombre C(15),radical C(7),serie C(3))
* Orden de Pedido/Producción
INSERT INTO cTablas VALUES("ordp1","DOCORDP","014")
INSERT INTO cTablas VALUES("ordp2","","")
INSERT INTO cTablas VALUES("maes_op","","")
* Orden de Compra
INSERT INTO cTablas VALUES("ordc1","DOCORDC","014")
INSERT INTO cTablas VALUES("ordc2","","")
* Orden de Servicio
INSERT INTO cTablas VALUES("ords1","DOCORDS","014")
INSERT INTO cTablas VALUES("ords2","","")
* Orden de Requerimiento
INSERT INTO cTablas VALUES("ordr1","DOCORDR","014")
INSERT INTO cTablas VALUES("ordr2","","")
* Parte de Ingreso
INSERT INTO cTablas VALUES("pari1","DOCPARI","014")
INSERT INTO cTablas VALUES("pari2","","")
* Parte de Salida
INSERT INTO cTablas VALUES("pars1","DOCPARS","014")
INSERT INTO cTablas VALUES("pars2","","")
* Guia de Remisión
INSERT INTO cTablas VALUES("guia1","DOCGUIA","014")
INSERT INTO cTablas VALUES("guia2","","")
SELECT cTablas
SCAN
	lcTabla = ALLTRIM(cTablas.nombre)
	lcRadical = ALLTRIM(cTablas.radical)
	lcSerie = ALLTRIM(cTablas.serie)
	SELECT 0
	USE (lcTabla) EXCLUSIVE
	ZAP
	USE
	IF !EMPTY(lcRadical) AND !EMPTY(lcSerie)
		SELECT maesnume
		*SEEK lcRadical + lcSerie + "1"
		SEEK lcRadical + "1"
		IF FOUND()
			REPLACE nume_docu WITH 0
		ENDIF
	ENDIF
ENDSCAN
USE
USE IN maesnume

SELECT 0
USE stockart EXCLUSIVE
ZAP
SELECT 0
USE kardex2 EXCLUSIVE
ZAP
USE

SELECT(ln_Select)
RETURN

FUNCTION SALDO_ARTICULO
PARAMETERS pc_Code_Store,pc_Code_Article,pc_Number_Lot,pd_Date,pc_Var_Sld_Can,pc_Var_Sld_Sol,pc_Var_Sld_Dol,pc_Var_PPS,pc_Var_PPD
*PARAMETERS pc_Code_Article,pc_Number_Lot,pd_Date,pc_Var_Sld_Can,pc_Var_Sld_Sol,pc_Var_Sld_Dol,pc_Var_PPS,pc_Var_PPD
* pc_Var_Sld_Can = Nombre de Variable que almacena el Saldo en Cantidad
* pc_Var_Sld_Sol = Nombre de Variable que almacena el Saldo en Soles
* pc_Var_Sld_Dol = Nombre de Variable que almacena el Saldo en Dolares
* pc_Var_PPS = Nombre de Variable que almacena el Precio Promedio en Soles
* pc_Var_PPD = Nombre de Variable que almacena el Precio Promedio en Dolares
ln_Select_Current = SELECT()
pc_Code_Store = PADR(IIF(TYPE("pc_Code_Store") = "C",pc_Code_Store,""),3)
pc_Code_Article = PADR(IIF(TYPE("pc_Code_Article") = "C",pc_Code_Article,""),10)
pc_Number_Lot = PADR(IIF(TYPE("pc_Number_Lot") = "C",pc_Number_Lot,""),15)
IF !EMPTY(pc_Code_Article) AND !EMPTY(pc_Number_Lot) AND !EMPTY(pd_Date)
	*** Abriendo Tablas
	ll_Used_kardex2 = USED("StockKard")
	IF !ll_Used_kardex2
		lcNameFile = "KAR" + "IN" + LEFT(DTOS(pd_Date),4)
		IF FILE(lcNameFile + ".DBF")
			SELECT 0
			USE (lcNameFile) ALIAS StockKard AGAIN
		ENDIF
	ENDIF
	***
	IF USED("StockKard")
		***
		IF EMPTY(pc_Code_Store)
			lcLabelOrder = "kardex2"
			lcLabelField = "cod_articu + nro_lote"
			lcLabelString1 = pc_Code_Article + pc_Number_Lot + DTOS(pd_Date)
			lcLabelString2 = pc_Code_Article + pc_Number_Lot
		ELSE
			lcLabelOrder = "stockart"
			lcLabelField = "cod_articu + cod_alma + nro_lote"
			lcLabelString1 = pc_Code_Article + pc_Code_Store + pc_Number_Lot + DTOS(pd_Date)
			lcLabelString2 = pc_Code_Article + pc_Code_Store + pc_Number_Lot
		ENDIF
		***
		*** Estableciendo Orden
		SELECT StockKard
		lc_Order_kardex2 = ORDER()
		SET ORDER TO &lcLabelOrder. DESCENDING
		***
		SET NEAR ON
		*** Obteniendo Saldo
		SELECT StockKard
		SEEK lcLabelString1
		IF &lcLabelField. = lcLabelString2
			SCAN WHILE &lcLabelField. = lcLabelString2
				*IF StockKard.fecha_reg < pd_Date
				IF StockKard.fecha_reg <= pd_Date
					IF TYPE("pc_Var_Sld_Can") = "C" AND TYPE(pc_Var_Sld_Can) # "U"
						&pc_Var_Sld_Can. = IIF(EMPTY(pc_Code_Store),StockKard.cantid_sld,StockKard.cantidsld)
					ENDIF
					IF TYPE("pc_Var_Sld_Sol") = "C" AND TYPE(pc_Var_Sld_Sol) # "U"
						&pc_Var_Sld_Sol. = IIF(EMPTY(pc_Code_Store),StockKard.impsol_sld,StockKard.impsolsld)
					ENDIF
					IF TYPE("pc_Var_Sld_Dol") = "C" AND TYPE(pc_Var_Sld_Dol) # "U"
						&pc_Var_Sld_Dol. = IIF(EMPTY(pc_Code_Store),StockKard.impdol_sld,StockKard.impdolsld)
					ENDIF
					IF TYPE("pc_Var_PPS") = "C" AND TYPE(pc_Var_PPS) # "U"
						&pc_Var_PPS. = IIF(EMPTY(pc_Code_Store),StockKard.prepro_sol,StockKard.preprosol)
					ENDIF
					IF TYPE("pc_Var_PPD") = "C" AND TYPE(pc_Var_PPD) # "U"
						&pc_Var_PPD. = IIF(EMPTY(pc_Code_Store),StockKard.prepro_dol,StockKard.preprodol)
					ENDIF
					EXIT
				ENDIF
			ENDSCAN
		ENDIF
		***
		SET NEAR OFF
		*** Reestableciendo Orden
		SELECT StockKard
		IF !EMPTY(lc_Order_kardex2)
			SET ORDER TO &lc_Order_kardex2.
		ENDIF
		***
		*** Cerrando Tablas
		SELECT StockKard
		IF !ll_Used_kardex2
			USE
		ENDIF
		***
	ENDIF
ENDIF
SELECT(ln_Select_Current)
RETURN

FUNCTION SALDO_ARTICULO_PT
PARAMETERS pc_Code_Store,pc_Code_Article,pc_Code_Cal,pd_Date,pc_Var_Sld_Can,pc_Var_Sld_Sol,pc_Var_Sld_Dol,pc_Var_PPS,pc_Var_PPD
*PARAMETERS pc_Code_Article,pc_Code_Cal,pd_Date,pc_Var_Sld_Can,pc_Var_Sld_Sol,pc_Var_Sld_Dol,pc_Var_PPS,pc_Var_PPD
* pc_Var_Sld_Can = Nombre de Variable que almacena el Saldo en Cantidad
* pc_Var_Sld_Sol = Nombre de Variable que almacena el Saldo en Soles
* pc_Var_Sld_Dol = Nombre de Variable que almacena el Saldo en Dolares
* pc_Var_PPS = Nombre de Variable que almacena el Precio Promedio en Soles
* pc_Var_PPD = Nombre de Variable que almacena el Precio Promedio en Dolares
ln_Select_Current = SELECT()
pc_Code_Store = PADR(IIF(TYPE("pc_Code_Store") = "C",pc_Code_Store,""),3)
pc_Code_Article = PADR(IIF(TYPE("pc_Code_Article") = "C",pc_Code_Article,""),15)
pc_Code_Cal = PADR(IIF(TYPE("pc_Code_Cal") = "C",pc_Code_Cal,""),1)
IF !EMPTY(pc_Code_Article) AND !EMPTY(pc_Code_Cal) AND !EMPTY(pd_Date)
	*** Abriendo Tablas
	ll_Used_kardex2 = USED("StockKard")
	IF !ll_Used_kardex2
		lcNameFile = "KAR" + "PT" + LEFT(DTOS(pd_Date),4)
		IF FILE(lcNameFile + ".DBF")
			SELECT 0
			USE (lcNameFile) ALIAS StockKard AGAIN
		ENDIF
	ENDIF
	***
	IF USED("StockKard")
		***
		IF EMPTY(pc_Code_Store)
			lcLabelOrder = "kardex2"
			lcLabelField = "cod_articu + cod_calid"
			lcLabelString1 = pc_Code_Article + pc_Code_Cal + DTOS(pd_Date)
			lcLabelString2 = pc_Code_Article + pc_Code_Cal
		ELSE
			lcLabelOrder = "stockart"
			lcLabelField = "cod_articu + cod_alma + cod_calid"
			lcLabelString1 = pc_Code_Article + pc_Code_Store + pc_Code_Cal + DTOS(pd_Date)
			lcLabelString2 = pc_Code_Article + pc_Code_Store + pc_Code_Cal
		ENDIF
		***
		*** Estableciendo Orden
		SELECT StockKard
		lc_Order_kardex2 = ORDER()
		SET ORDER TO &lcLabelOrder. DESCENDING
		***
		SET NEAR ON
		*** Obteniendo Saldo
		SELECT StockKard
		SEEK lcLabelString1
		IF &lcLabelField. = lcLabelString2
			SCAN WHILE &lcLabelField. = lcLabelString2
				*IF StockKard.fecha_reg < pd_Date
				IF StockKard.fecha_reg <= pd_Date
					IF TYPE("pc_Var_Sld_Can") = "C" AND TYPE(pc_Var_Sld_Can) # "U"
						&pc_Var_Sld_Can. = IIF(EMPTY(pc_Code_Store),StockKard.cantid_sld,StockKard.cantidsld)
					ENDIF
					IF TYPE("pc_Var_Sld_Sol") = "C" AND TYPE(pc_Var_Sld_Sol) # "U"
						&pc_Var_Sld_Sol. = IIF(EMPTY(pc_Code_Store),StockKard.impsol_sld,StockKard.impsolsld)
					ENDIF
					IF TYPE("pc_Var_Sld_Dol") = "C" AND TYPE(pc_Var_Sld_Dol) # "U"
						&pc_Var_Sld_Dol. = IIF(EMPTY(pc_Code_Store),StockKard.impdol_sld,StockKard.impdolsld)
					ENDIF
					IF TYPE("pc_Var_PPS") = "C" AND TYPE(pc_Var_PPS) # "U"
						&pc_Var_PPS. = IIF(EMPTY(pc_Code_Store),StockKard.prepro_sol,StockKard.preprosol)
					ENDIF
					IF TYPE("pc_Var_PPD") = "C" AND TYPE(pc_Var_PPD) # "U"
						&pc_Var_PPD. = IIF(EMPTY(pc_Code_Store),StockKard.prepro_dol,StockKard.preprodol)
					ENDIF
					EXIT
				ENDIF
			ENDSCAN
		ENDIF
		***
		SET NEAR OFF
		*** Reestableciendo Orden
		SELECT StockKard
		IF !EMPTY(lc_Order_kardex2)
			SET ORDER TO &lc_Order_kardex2.
		ENDIF
		***
		*** Cerrando Tablas
		SELECT StockKard
		IF !ll_Used_kardex2
			USE
		ENDIF
		***
	ENDIF
ENDIF
SELECT(ln_Select_Current)
RETURN

FUNCTION SALDO_ARTICULO_PT1
PARAMETERS pc_Code_Store,pc_Code_Article,pd_Date,pc_Var_Sld_Can,pc_Var_Sld_Sol,pc_Var_Sld_Dol,pc_Var_PPS,pc_Var_PPD
* CALCULO DE SALDO SIN CALIDAD
* pc_Var_Sld_Can = Nombre de Variable que almacena el Saldo en Cantidad
* pc_Var_Sld_Sol = Nombre de Variable que almacena el Saldo en Soles
* pc_Var_Sld_Dol = Nombre de Variable que almacena el Saldo en Dolares
* pc_Var_PPS = Nombre de Variable que almacena el Precio Promedio en Soles
* pc_Var_PPD = Nombre de Variable que almacena el Precio Promedio en Dolares
ln_Select_Current = SELECT()
pc_Code_Store = PADR(IIF(TYPE("pc_Code_Store") = "C",pc_Code_Store,""),3)
pc_Code_Article = PADR(IIF(TYPE("pc_Code_Article") = "C",pc_Code_Article,""),15)
IF !EMPTY(pc_Code_Article) AND !EMPTY(pd_Date)
	*** Abriendo Tablas
	ll_Used_kardex2 = USED("StockKard")
	IF !ll_Used_kardex2
		lcNameFile = "KAR" + "PT" + LEFT(DTOS(pd_Date),4)
		IF FILE(lcNameFile + ".DBF")
			SELECT 0
			USE (lcNameFile) ALIAS StockKard AGAIN
		ENDIF
	ENDIF
	***
	IF USED("StockKard")
		IF EMPTY(pc_Code_Store)
			*lcLabelOrder = "kardex2"
			lcLabelOrder = "kardex3"
			SELECT * FROM StockKard ;
				WHERE cod_articu = pc_Code_Article AND fecha_reg <= pd_Date INTO CURSOR cTemp
		ELSE
			lcLabelOrder = "stockart"
			SELECT * FROM StockKard ;
				WHERE cod_articu = pc_Code_Article AND cod_alma = pc_Code_Store AND fecha_reg <= pd_Date INTO CURSOR cTemp
		ENDIF
		SELE StockKard
		lc_Order_kardex2 = ORDER()
		SET ORDER TO &lcLabelOrder.
		lcKey = KEY()
		SELE cTemp
		*INDEX ON (lcKey) TAG codigo DESCENDING
		INDEX ON &lcKey. TAG codigo DESCENDING
		GO TOP
		IF TYPE("pc_Var_Sld_Can") = "C" AND TYPE(pc_Var_Sld_Can) # "U"
			&pc_Var_Sld_Can. = IIF(EMPTY(pc_Code_Store),cTemp.cantidsld1,cTemp.cantidsld)
		ENDIF
		IF TYPE("pc_Var_Sld_Sol") = "C" AND TYPE(pc_Var_Sld_Sol) # "U"
			&pc_Var_Sld_Sol. = IIF(EMPTY(pc_Code_Store),cTemp.impsol_sld,cTemp.impsolsld) && cTemp.sld_sol
		ENDIF
		IF TYPE("pc_Var_Sld_Dol") = "C" AND TYPE(pc_Var_Sld_Dol) # "U"
			&pc_Var_Sld_Dol. = IIF(EMPTY(pc_Code_Store),cTemp.impdol_sld,cTemp.impdolsld) && cTemp.sld_dol
		ENDIF
		IF TYPE("pc_Var_PPS") = "C" AND TYPE(pc_Var_PPS) # "U"
			&pc_Var_PPS. = IIF(EMPTY(pc_Code_Store),cTemp.prepro_sol,cTemp.preprosol) && cTemp.pp_sol
		ENDIF
		IF TYPE("pc_Var_PPD") = "C" AND TYPE(pc_Var_PPD) # "U"
			&pc_Var_PPD. = IIF(EMPTY(pc_Code_Store),cTemp.prepro_dol,cTemp.preprodol) && cTemp.pp_dol
		ENDIF
		USE IN cTemp
		***
		*** Reestableciendo Orden
		SELECT StockKard
		IF !EMPTY(lc_Order_kardex2)
			SET ORDER TO &lc_Order_kardex2.
		ENDIF
		***
		*** Cerrando Tablas
		SELECT StockKard
		IF !ll_Used_kardex2
			USE
		ENDIF
		***
	ENDIF
ENDIF
SELECT(ln_Select_Current)
RETURN

FUNCTION BARRA
PARAMETERS lnReg,lnTot
lcBarra = PADR(LEFT("",((lnReg*100)/lnTot)/5),20) + STR((lnReg*100)/lnTot,3)
RETURN lcBarra

FUNCTION CARGAR_SALDOS
ln_Select = SELECT()
SELECT 0
USE maevar ORDER radcod
SEEK "PXCPXC"
lnPesoCono = maevar.varfac
USE
CREATE CURSOR cSaldos(cod_intemp C(50),nro_lote C(15),cant_conos N(16,6),cantidad N(16,6),precio_1 N(16,6),ubica C(5),existe L)
lcNombreArchivo = GETFILE("XLS", "Archivo:", "Seleccionar",0,"")
CREATE CURSOR cErrores(cod_intemp C(20),nro_lote C(15),observ C(100))
IF EMPTY(lcNombreArchivo)
	RETURN
ENDIF
oExcel = ""
oExcel = CREATEOBJECT("Excel.Application")
lnFila = 1
oExcel.WORKBOOKS.OPEN(lcNombreArchivo)
XLS = oExcel.ACTIVESHEET
DO WHILE .T.
	WAIT WINDOW "Fila: " + ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
	IF ISNULL(XLS.CELLS(lnFila,1).VALUE) OR EMPTY(XLS.CELLS(lnFila,1).VALUE)
		EXIT
	ELSE
		m.cod_intemp = XLS.CELLS(lnFila,1).VALUE
		m.nro_lote = XLS.CELLS(lnFila,8).VALUE
		m.cant_conos = XLS.CELLS(lnFila,12).VALUE
		m.cantidad = XLS.CELLS(lnFila,13).VALUE
		m.precio_1 = XLS.CELLS(lnFila,14).VALUE
		m.ubica = XLS.CELLS(lnFila,15).VALUE
		
		IF TYPE("m.nro_lote") = "N"
			m.nro_lote = ALLTRIM(STR(m.nro_lote))
		ELSE
			IF TYPE("m.nro_lote") = "C"
				m.nro_lote = ALLTRIM(m.nro_lote)
			ELSE
				m.nro_lote = ""
			ENDIF
		ENDIF
		IF TYPE("m.cant_conos") = "N"
			m.cant_conos = ROUND(m.cant_conos,6)
		ELSE
			m.cant_conos = 0
		ENDIF
		IF TYPE("m.cantidad") = "N"
			m.cantidad = ROUND(m.cantidad,6)
		ELSE
			m.cantidad = 0
		ENDIF
		IF TYPE("m.precio_1") = "N"
			m.precio_1 = ROUND(m.precio_1,6)
		ELSE
			m.precio_1 = 0
		ENDIF
		IF TYPE("m.ubica") = "N"
			m.ubica = ALLTRIM(STR(m.ubica))
		ELSE
			IF TYPE("m.ubica") = "C"
				m.ubica = ALLTRIM(m.ubica)
			ELSE
				m.ubica = ""
			ENDIF
		ENDIF
		INSERT INTO cSaldos FROM MEMVAR
	ENDIF
ENDDO
*oExcel.WORKBOOKS.Close()
RELEASE oExcel
*** Verificando duplicidad de Codigo + Lote
SELECT cod_intemp,nro_lote,COUNT(*) AS total FROM cSaldos GROUP BY cod_intemp,nro_lote HAVING total > 1 INTO CURSOR cTemp
SCAN
	INSERT INTO cErrores VALUES(cTemp.cod_intemp,cTemp.nro_lote,"Articulo y Lote Repetido!")
ENDSCAN
USE
***
*** Verificando Lote en Blanco
SELECT cod_intemp,RECNO() AS registro FROM cSaldos WHERE EMPTY(nro_lote) INTO CURSOR cTemp
SCAN
	INSERT INTO cErrores VALUES(cTemp.cod_intemp,"","Articulo SIN Lote!")
ENDSCAN
USE
***
*** Verificando Cantidad y Precio
SELECT cod_intemp,nro_lote,cant_conos,cantidad,precio_1 FROM cSaldos WHERE cantidad<=0 OR precio_1<=0 INTO CURSOR cTemp
SCAN
	IF cTemp.cantidad <= 0
		lcTitle = "Falta Cantidad!"
		INSERT INTO cErrores VALUES(cTemp.cod_intemp,cTemp.nro_lote,"Falta Cantidad!")
	ELSE
		IF cTemp.precio_1 <= 0
			lcTitle = "Falta Precio!"
			INSERT INTO cErrores VALUES(cTemp.cod_intemp,cTemp.nro_lote,"Falta Precio!")
		ENDIF
	ENDIF
ENDSCAN
USE
***
*** Verificando existencia de Código
SELECT 0
USE maesinsu
SELECT cSaldos
SCAN
	SELECT maesinsu
	*LOCATE FOR cod_intemp = ALLTRIM(cSaldos.cod_intemp)
	LOCATE FOR cod_intemp = cSaldos.cod_intemp
	llSw = FOUND()
	***
	IF llSw
		I = 0
		*SCAN WHILE cod_intemp = cSaldos.cod_intemp
		SCAN FOR cod_intemp = cSaldos.cod_intemp
			I = I + 1
		ENDSCAN
		IF I > 1
			INSERT INTO cErrores VALUES(cSaldos.cod_intemp,"","El código existe " + ALLTRIM(STR(I)) + " veces en la Maestra de Productos.")
		ENDIF
	ENDIF
	***
	SELECT cSaldos
	REPLACE existe WITH llSw
ENDSCAN
USE IN maesinsu
***
SELECT cod_intemp FROM cSaldos WHERE !existe INTO CURSOR cTemp
SCAN
	INSERT INTO cErrores VALUES(cTemp.cod_intemp,"","Código No Existe!")
ENDSCAN
USE
SELECT cErrores
llSw = EOF()
IF !llSw
	COPY TO errores TYPE XLS
	MESSAGEBOX("Existe errores en el sistema... Revise el archivo:" + CHR(13) + LOCFILE("errores.xls"),0+48,"Error en carga de Saldos!")
ENDIF
USE
SELECT(ln_Select)
RETURN llSw

FUNCTION CARGAR_SALDOS_PT
ln_Select = SELECT()
CREATE CURSOR cSaldos(cod_intemp C(50),cod_calid C(1),cantidad N(16,6),precio_1 N(16,6),ubica C(5),existe_art L,existe_cal L)
lcNombreArchivo = GETFILE("XLS", "Archivo:", "Seleccionar",0,"")
CREATE CURSOR cErrores(cod_intemp C(20),cod_calid C(1),observ C(100))
IF EMPTY(lcNombreArchivo)
	RETURN
ENDIF
oExcel = ""
oExcel = CREATEOBJECT("Excel.Application")
lnFila = 1
oExcel.WORKBOOKS.OPEN(lcNombreArchivo)
XLS = oExcel.ACTIVESHEET
DO WHILE .T.
	WAIT WINDOW "Fila: " + ALLTRIM(STR(lnFila)) NOWAIT
	lnFila = lnFila + 1
	IF ISNULL(XLS.CELLS(lnFila,1).VALUE) OR EMPTY(XLS.CELLS(lnFila,1).VALUE)
		EXIT
	ELSE
		m.cod_intemp = XLS.CELLS(lnFila,1).VALUE
		m.cod_calid = XLS.CELLS(lnFila,28).VALUE
		m.cantidad = XLS.CELLS(lnFila,30).VALUE
		m.precio_1 = XLS.CELLS(lnFila,29).VALUE
		m.ubica = XLS.CELLS(lnFila,30).VALUE
		
		IF TYPE("m.cod_calid") = "N"
			m.cod_calid = ALLTRIM(STR(m.cod_calid))
		ELSE
			IF TYPE("m.cod_calid") = "C"
				m.cod_calid = ALLTRIM(m.cod_calid)
			ELSE
				m.cod_calid = ""
			ENDIF
		ENDIF
		IF TYPE("m.cantidad") = "N"
			m.cantidad = ROUND(m.cantidad,6)
		ELSE
			m.cantidad = 0
		ENDIF
		IF TYPE("m.precio_1") = "N"
			m.precio_1 = ROUND(m.precio_1,6)
		ELSE
			m.precio_1 = 0
		ENDIF
		IF TYPE("m.ubica") = "N"
			m.ubica = ALLTRIM(STR(m.ubica))
		ELSE
			IF TYPE("m.ubica") = "C"
				m.ubica = ALLTRIM(m.ubica)
			ELSE
				m.ubica = ""
			ENDIF
		ENDIF
		INSERT INTO cSaldos FROM MEMVAR
	ENDIF
ENDDO
*oExcel.WORKBOOKS.Close()
RELEASE oExcel
*** Verificando duplicidad de Codigo + Calidad
SELECT cod_intemp,cod_calid,COUNT(*) AS total FROM cSaldos GROUP BY cod_intemp,cod_calid HAVING total > 1 INTO CURSOR cTemp
SCAN
	INSERT INTO cErrores VALUES(cTemp.cod_intemp,cTemp.cod_calid,"Articulo y Calidad Repetido!")
ENDSCAN
USE
***
*** Verificando Calidad en Blanco
SELECT cod_intemp,RECNO() AS registro FROM cSaldos WHERE EMPTY(cod_calid) INTO CURSOR cTemp
SCAN
	INSERT INTO cErrores VALUES(cTemp.cod_intemp,"","Articulo SIN Calidad!")
ENDSCAN
USE
***
*** Verificando Cantidad y Precio
SELECT cod_intemp,cod_calid,cantidad,precio_1 FROM cSaldos WHERE cantidad<=0 OR precio_1<=0 INTO CURSOR cTemp
SCAN
	IF cTemp.cantidad <= 0
		lcTitle = "Falta Cantidad!"
		INSERT INTO cErrores VALUES(cTemp.cod_intemp,cTemp.cod_calid,"Falta Cantidad!")
	ELSE
		IF cTemp.precio_1 <= 0
			lcTitle = "Falta Precio!"
			INSERT INTO cErrores VALUES(cTemp.cod_intemp,cTemp.cod_calid,"Falta Precio!")
		ENDIF
	ENDIF
ENDSCAN
USE
***
*** Verificando existencia de Código
SELECT 0
USE maesarti
SELECT 0
USE maescali ORDER codigo
SELECT cSaldos
SCAN
	SELECT maesarti
	*LOCATE FOR cod_intemp = ALLTRIM(cSaldos.cod_intemp)
	LOCATE FOR cod_intemp = cSaldos.cod_intemp
	llSw = FOUND()
	***
	IF llSw
		I = 0
		SCAN FOR cod_intemp = cSaldos.cod_intemp
			I = I + 1
		ENDSCAN
		IF I > 1
			INSERT INTO cErrores VALUES(cSaldos.cod_intemp,"","El código existe " + ALLTRIM(STR(I)) + " veces en la Maestra de Productos.")
		ENDIF
	ENDIF
	***
	SELECT cSaldos
	REPLACE existe_art WITH llSw
	
	SELECT maescali
	SEEK cSaldos.cod_calid
	llSw = FOUND()
	SELECT cSaldos
	REPLACE existe_cal WITH llSw
ENDSCAN
USE IN maesarti
USE IN maescali
***
SELECT cod_intemp FROM cSaldos WHERE !existe_art INTO CURSOR cTemp
SCAN
	INSERT INTO cErrores VALUES(cTemp.cod_intemp,"","Código No Existe!")
ENDSCAN
USE
SELECT cod_intemp,cod_calid FROM cSaldos WHERE !existe_cal INTO CURSOR cTemp
SCAN
	INSERT INTO cErrores VALUES(cTemp.cod_intemp,cod_calid,"Calidad No Existe!")
ENDSCAN
USE
SELECT cErrores
llSw = EOF()
IF !llSw
	COPY TO errores TYPE XLS
	MESSAGEBOX("Existe errores en el sistema... Revise el archivo:" + CHR(13) + LOCFILE("errores.xls"),0+48,"Error en carga de Saldos!")
ENDIF
USE
SELECT(ln_Select)
RETURN llSw

FUNCTION KARDEX_DOCUMENTOS
PARAMETERS pcTableKardex,pdDateBegin,pdDateEnd
ln_Select_ = SELECT()
***** Abriendo otras tablas
SELE 0
USE maesmoti ORDER codigo
*****
***** Creando contenedor del Kardex
IF !USED(pcTableKardex)
	&& Copiando Estructura
	SELE 0
	USE strukardin
	AFIELDS(laStruc)
	USE
	&&
	CREATE CURSOR (pcTableKardex) FROM ARRAY laStruc
	ALTER TABLE (pcTableKardex) ADD COLUMN vence D
	ALTER TABLE (pcTableKardex) ADD COLUMN descri C(150)
	ALTER TABLE (pcTableKardex) ADD COLUMN valtc N(7,3)
	INDEX ON cod_articu+cod_alma+nro_lote+DTOS(fecha_reg)+orden TAG codi2 && stockart
	INDEX ON cod_articu+nro_lote+DTOS(fecha_reg)+orden TAG codi1 ADDITIVE && kardex2
	SET ORDER TO
ENDIF
*****
***** Documentos del Kardex
CREATE CURSOR cDocument(codigo C(4),descrip C(20),tabla C(10),tipo C(3))
INSERT INTO cDocument VALUES("PARI","GUIA DE INGRESO","pari","ING")
INSERT INTO cDocument VALUES("PARS","GUIA DE SALIDA","pars","SAL")
INSERT INTO cDocument VALUES("GUIA","GUIA DE REMISION","guia","SAL")
SCAN
	lcTableHeader = ALLTRIM(cDocument.tabla) + "1"
	lcTableDetail = ALLTRIM(cDocument.tabla) + "2"
	***** Abriendo Tablas del Documento
	SELE 0
	USE (lcTableHeader) ORDER (lcTableHeader)
	SELE 0
	USE (lcTableDetail) ORDER (lcTableDetail)
	*****
	WAIT WINDOW "Consultando " + ALLTRIM(cDocument.descrip) + "..." NOWAIT
	SELECT * FROM (lcTableHeader) WHERE !cod_anula AND BETWEEN(fecha_reg,pdDateBegin,pdDateEnd) INTO CURSOR curTemp
	SCAN
		WAIT WINDOW "Consultando " + ALLTRIM(cDocument.descrip) + "..." + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
		SCATTER MEMVAR
		&& Salvando variables de memoria(Cabecera)
		DIMENSION laMemvar[1]
		= MEMVAR_BACKUP(@laMemvar)
		&&
		***** Motivo
		lcOrden = ""
		SELECT maesmoti
		SEEK cDocument.tipo + m.cod_moti
		lcOrden = maesmoti.cod_orden
		lcProce = maesmoti.indi_proc
		*****
		***** Actualizando el Tipo de Cambio en Cabecera de Documento
		IF cDocument.tipo = "ING"
			= TIPO_CAMBIO_ACTUALIZAR("m.tipcam_cod","m.tipcam_val",m.cod_moti,m.doccom2fec,m.doccom1fec,m.docrel_fec)
			&& Si Contabilidad NO tiene el TC se jala de Almacen
			IF m.tipcam_val = 0
				= TIPO_CAMBIO_ACTUALIZAR("m.tipcam_cod","m.tipcam_val",m.cod_moti,m.fecha_reg)
			ENDIF
			&&
		ELSE
			IF m.tipcam_cod != "O"
				m.tipcam_val = TIPOCAMBIO(m.fecha_reg,m.tipcam_cod)
			ENDIF
		ENDIF
		SELE (lcTableHeader)
		SEEK m.serie + m.nrodoc
		REPLACE tipcam_cod WITH m.tipcam_cod
		REPLACE tipcam_val WITH m.tipcam_val
		IF m.tipcam_val <= 0
			MESSAGEBOX("Documento NO registra Tipo de Cambio.",0+48,ALLTRIM(cDocument.descrip) + ":" + ALLTRIM(m.serie) + "-" + ALLTRIM(m.nrodoc))
		ENDIF
		*****
		*****
		DO CASE
			CASE cDocument.codigo = "PARI" && GUIA DE INGRESO
				
			CASE cDocument.codigo = "PARS" && GUIA DE SALIDA
				
			CASE cDocument.codigo = "GUIA" && GUIA DE REMISION
				
		ENDCASE
		*****
		***** Detalle
		SELE (lcTableDetail)
		SEEK m.serie + m.nrodoc
		SCAN WHILE serie + nrodoc = m.serie + m.nrodoc
			SELE (pcTableKardex)
			SCATTER MEMVAR BLANK
			&& Restaurando variables(Cabecera)
			= MEMVAR_RESTORE(@laMemvar)
			&&
			SELE (lcTableDetail)
			SCATTER MEMVAR
			llSw = (m.tip_produc = "P")
			IF llSw
				DO CASE
					CASE cDocument.codigo = "PARI" && GUIA DE INGRESO
						
					CASE cDocument.codigo = "PARS" && GUIA DE SALIDA
						
					CASE cDocument.codigo = "GUIA" && GUIA DE REMISION
						
				ENDCASE
			ENDIF
			IF llSw
				m.orden	= lcOrden
				m.orden1 = ""
				IF !EMPTY(m.rad_moti1) AND !EMPTY(m.cod_moti1)
					SELECT maesmoti
					SEEK m.rad_moti1 + m.cod_moti1
					m.orden1 = maesmoti.cod_orden
				ENDIF
				m.tipdoc = cDocument.codigo
				lc_serie = m.serie
				lc_nrodoc = m.nrodoc
				DO CASE
					CASE cDocument.codigo = "PARI"
						IF lcProce = "05" AND m.docrel_tip = "ORDS"
							*** Se respeta su Costo de Producción en Soles y Dolares y se recalcula el TC
							m.tipcam_cod = "O"
							m.tipcam_val = (m.cantidad * m.precom_sol) / (m.cantidad * m.precom_dol)
							***
						ELSE
							*** Actualizando el Precio de Compra en el Detalle del Documento
							SELE (lcTableDetail)
							DO CASE
								CASE m.cod_mone = "SOL"
									m.precio_2 = IIF(m.tipcam_val > 0,ROUND(m.precio_1 / m.tipcam_val,6),0)
								CASE m.cod_mone = "DOL"
									m.precio_1 = IIF(m.tipcam_val > 0,ROUND(m.precio_2 * m.tipcam_val,6),0)
							ENDCASE
							GATHER MEMVAR FIELDS precio_1,precio_2
							***
						ENDIF
						m.cantid_ing = m.cantidad
						m.precom_sol = m.precio_1
						m.precom_dol = m.precio_2
						m.impsol_ing = m.cantidad * m.precom_sol
						m.impdol_ing = m.cantidad * m.precom_dol
					CASE cDocument.codigo = "PARS"
						***** Guia de Salida
						m.cantid_sal = m.cantidad
						*****
					CASE cDocument.codigo = "GUIA"
						***** Guia de Remisión
						m.cantid_sal = m.cantidad
						*****
				ENDCASE
				m.rad_moti = cDocument.tipo
				INSERT INTO (pcTableKardex) FROM MEMVAR
				*****
				*****
				SELE (pcTableKardex)
				REPLACE serie	WITH lc_serie
				REPLACE nrodoc	WITH lc_nrodoc
				*****
			ENDIF
		ENDSCAN
		*****
	ENDSCAN
	USE
	***** Cerrando Tablas del Documento
	USE IN (lcTableHeader)
	USE IN (lcTableDetail)
	*****
	WAIT CLEAR
ENDSCAN
USE
*****
***** Cerrando Tablas
USE IN maesmoti
*****
SELECT(ln_Select_)
RETURN

FUNCTION KARDEX_DOCUMENTOS_PT
PARAMETERS pcTableKardex,pdDateBegin,pdDateEnd
ln_Select_ = SELECT()
***** Abriendo otras tablas
SELE 0
USE maesmoti ORDER codigo
*****
***** Creando contenedor del Kardex
IF !USED(pcTableKardex)
	&& Copiando Estructura
	SELE 0
	USE strukardpt
	AFIELDS(laStruc)
	USE
	&&
	CREATE CURSOR (pcTableKardex) FROM ARRAY laStruc
	ALTER TABLE (pcTableKardex) ADD COLUMN vence D
	ALTER TABLE (pcTableKardex) ADD COLUMN descri C(150)
	ALTER TABLE (pcTableKardex) ADD COLUMN valtc N(7,3)
	INDEX ON cod_articu+cod_alma+cod_calid+DTOS(fecha_reg)+orden TAG codi2 && stockart
	INDEX ON cod_articu+cod_calid+DTOS(fecha_reg)+orden TAG codi1 ADDITIVE && kardex2
	SET ORDER TO
ENDIF
*****
***** Documentos del Kardex
CREATE CURSOR cDocument(codigo C(4),descrip C(20),tabla C(10),tipo C(3))
INSERT INTO cDocument VALUES("NOTI","GUIA DE INGRESO","noti","ING")
INSERT INTO cDocument VALUES("NOTE","GUIA DE SALIDA","note","SAL")
INSERT INTO cDocument VALUES("REMI","GUIA DE REMISION","remi","SAL")
INSERT INTO cDocument VALUES("FACT","FACTURA","fact","SAL")
INSERT INTO cDocument VALUES("BOLE","BOLETA","bole","SAL")
INSERT INTO cDocument VALUES("CRED","NOTA DE CREDITO","nocr","SAL")
INSERT INTO cDocument VALUES("DEBI","NOTA DE DEBITO","node","SAL")
INSERT INTO cDocument VALUES("GUIS","PROFORMA INTERNA","guis","SAL")
SCAN
	lcTableHeader = ALLTRIM(cDocument.tabla) + "1"
	lcTableDetail = ALLTRIM(cDocument.tabla) + "2"
	***** Abriendo Tablas del Documento
	SELE 0
	USE (lcTableHeader) ORDER (lcTableHeader)
	SELE 0
	USE (lcTableDetail) ORDER (lcTableDetail)
	*****
	WAIT WINDOW "Consultando " + ALLTRIM(cDocument.descrip) + "..." NOWAIT
	SELECT * FROM (lcTableHeader) WHERE !cod_anula AND BETWEEN(fecha_reg,pdDateBegin,pdDateEnd) INTO CURSOR curTemp
	SCAN
		WAIT WINDOW "Consultando " + ALLTRIM(cDocument.descrip) + "..." + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
		SCATTER MEMVAR
		&& Salvando variables de memoria(Cabecera)
		DIMENSION laMemvar[1]
		= MEMVAR_BACKUP(@laMemvar)
		&&
		***** Motivo
		lcOrden = ""
		SELECT maesmoti
		SEEK cDocument.tipo + m.cod_moti
		lcOrden = maesmoti.cod_orden1
		lcProce = maesmoti.indi_proc
		*****
		***** Actualizando el Tipo de Cambio en Cabecera de Documento
		IF cDocument.tipo = "ING"
			= TIPO_CAMBIO_ACTUALIZAR("m.tipcam_cod","m.tipcam_val",m.cod_moti,m.doccom2fec,m.doccom1fec,m.docrel_fec)
			&& Si Contabilidad NO tiene el TC se jala de Almacen
			if m.tipcam_val = 0
				= TIPO_CAMBIO_ACTUALIZAR("m.tipcam_cod","m.tipcam_val",m.cod_moti,m.fecha_reg)
			ENDIF
			&&
		ELSE
			IF m.tipcam_cod != "O"
				m.tipcam_val = TIPOCAMBIO(m.fecha_reg,m.tipcam_cod)
			ENDIF
		ENDIF
		SELE (lcTableHeader)
		SEEK m.serie + m.nrodoc
		REPLACE tipcam_cod WITH m.tipcam_cod
		REPLACE tipcam_val WITH m.tipcam_val
		IF m.tipcam_val <= 0
			MESSAGEBOX("Documento NO registra Tipo de Cambio.",0+48,ALLTRIM(cDocument.descrip) + ":" + ALLTRIM(m.serie) + "-" + ALLTRIM(m.nrodoc))
		ENDIF
		*****
		*****
		DO CASE
			CASE cDocument.codigo = "NOTI" && GUIA DE INGRESO
				
			CASE cDocument.codigo = "NOTE" && GUIA DE SALIDA
				
			CASE cDocument.codigo = "REMI" && GUIA DE REMISION
				
			CASE cDocument.codigo = "FACT" && FACTURA
				
			CASE cDocument.codigo = "BOLE" && BOLETA DE VENTA
				
			CASE cDocument.codigo = "CRED" && NOTA DE CREDITO
				
			CASE cDocument.codigo = "DEBI" && NOTA DE DEBITO
				
			CASE cDocument.codigo = "GUIS" && PROFORMA INTERNA
				
		ENDCASE
		*****
		***** Detalle
		SELE (lcTableDetail)
		SEEK m.serie + m.nrodoc
		SCAN WHILE serie + nrodoc = m.serie + m.nrodoc
			SELE (pcTableKardex)
			SCATTER MEMVAR BLANK
			&& Restaurando variables(Cabecera)
			= MEMVAR_RESTORE(@laMemvar)
			&&
			SELE (lcTableDetail)
			SCATTER MEMVAR
			llSw = (m.tip_produc = "P")
			IF llSw
				DO CASE
					CASE cDocument.codigo = "NOTI" && GUIA DE INGRESO
					
					CASE cDocument.codigo = "NOTE" && GUIA DE SALIDA
					
					CASE cDocument.codigo = "REMI" && GUIA DE REMISION
						
					CASE cDocument.codigo = "FACT" && FACTURA
						*** Ignorar Factura con GR
						llSw = !(!EMPTY(m.guirem_tip) AND !EMPTY(m.guirem_ser) AND !EMPTY(m.guirem_nro))
						***
					CASE cDocument.codigo = "BOLE" && BOLETA DE VENTA
						*** Ignorar Boleta con GR
						llSw = !(!EMPTY(m.guirem_tip) AND !EMPTY(m.guirem_ser) AND !EMPTY(m.guirem_nro))
						***
					CASE cDocument.codigo = "CRED" && NOTA DE CREDITO
						
					CASE cDocument.codigo = "DEBI" && NOTA DE DEBITO
						
					CASE cDocument.codigo = "GUIS" && PROFORMA INTERNA
						
				ENDCASE
			ENDIF
			IF llSw
				m.orden	= lcOrden
				m.orden1 = ""
				IF !EMPTY(m.rad_moti1) AND !EMPTY(m.cod_moti1)
					SELECT maesmoti
					SEEK m.rad_moti1 + m.cod_moti1
					m.orden1 = maesmoti.cod_orden1
				ENDIF
				m.tipdoc = cDocument.codigo
				lc_serie = m.serie
				lc_nrodoc = m.nrodoc
				DO CASE
					CASE cDocument.codigo = "NOTI"
						IF lcProce = "05" AND m.docrel_tip = "NOTS"
							*** Se respeta su Costo de Producción en Soles y Dolares y se recalcula el TC
							m.tipcam_cod = "O"
							m.tipcam_val = (m.cantidad * m.precom_sol) / (m.cantidad * m.precom_dol)
							***
						ELSE
							*** Actualizando el Precio de Compra en el Detalle del Documento
							SELE (lcTableDetail)
							DO CASE
								CASE m.cod_mone = "SOL"
									m.precio_2 = IIF(m.tipcam_val > 0,ROUND(m.precio_1 / m.tipcam_val,6),0)
								CASE m.cod_mone = "DOL"
									m.precio_1 = IIF(m.tipcam_val > 0,ROUND(m.precio_2 * m.tipcam_val,6),0)
							ENDCASE
							GATHER MEMVAR FIELDS precio_1,precio_2
							***
						ENDIF
						m.cantid_ing = m.cantidad
						m.precom_sol = m.precio_1
						m.precom_dol = m.precio_2
						m.impsol_ing = m.cantidad * m.precom_sol
						m.impdol_ing = m.cantidad * m.precom_dol
					CASE cDocument.codigo = "NOTE"
						***** Guia de Salida
						m.cantid_sal = m.cantidad
						*****
					CASE cDocument.codigo = "REMI"
						***** Guia de Remisión
						m.cantid_sal = m.cantidad
						*****
					CASE cDocument.codigo = "FACT"
						***** Factura de Venta
						m.cantid_sal = m.cantidad
						*****
					CASE cDocument.codigo = "BOLE"
						***** Boleta de Venta
						m.cantid_sal = m.cantidad
						*****
					CASE cDocument.codigo = "CRED"
						***** Nota de Crédito
						m.cantid_sal = m.cantidad * -1
						*****
					CASE cDocument.codigo = "DEBI"
						***** Nota de Débito
						m.cantid_sal = m.cantidad
						*****
					CASE cDocument.codigo = "GUIS"
						***** Proforma Interna
						m.cantid_sal = m.cantidad
						*****
				ENDCASE
				m.rad_moti = cDocument.tipo
				INSERT INTO (pcTableKardex) FROM MEMVAR
				*****
				*****
				SELE (pcTableKardex)
				REPLACE serie	WITH lc_serie
				REPLACE nrodoc	WITH lc_nrodoc
				*****
			ENDIF
		ENDSCAN
		*****
	ENDSCAN
	USE
	***** Cerrando Tablas del Documento
	USE IN (lcTableHeader)
	USE IN (lcTableDetail)
	*****
	WAIT CLEAR
ENDSCAN
USE
*****
***** Cerrando Tablas
USE IN maesmoti
*****
SELECT(ln_Select_)
RETURN

FUNCTION CREATE_FILE_KARDEX
PARAMETERS pcTypeModule,pdDateFile
*pcTypeModule = Tipo de Modulo (IN = Insumos, PT = Productos Terminados)
ln_Select_ = SELECT()
***** Verificando existencia del archivo de Kardex Anual
lcNameFile = "KAR" + pcTypeModule + LEFT(DTOS(pdDateFile),4)
*lcPathFile = SYS(5) + CURDIR() + "DATA\ALMA\" + lcNameFile + ".DBF"
lcPathFile = _rt_bas_ + "\" + lcNameFile + ".DBF"
IF !FILE(lcPathFile)
	&& Abriendo archivo de estructura del kardex
	lcNameFile = "strukard" + pcTypeModule
	SELE 0
	USE (lcNameFile)
	&&
	COPY TO &lcPathFile. WITH CDX
	USE
ENDIF
*****
SELECT(ln_Select_)
RETURN lcPathFile

FUNCTION EXIST_FILE_KARDEX
PARAMETERS pcTypeModule,pdDateFile
*pcTypeModule = Tipo de Modulo (IN = Insumos, PT = Productos Terminados)
lcNameFile = "KAR" + pcTypeModule + LEFT(DTOS(pdDateFile),4)
*lcPathFile = SYS(5) + CURDIR() + "DATA\ALMA\" + lcNameFile + ".DBF"
lcPathFile = _rt_bas_ + "\" + lcNameFile + ".DBF"
IF !FILE(lcPathFile)
	lcPathFile = ""
ENDIF
RETURN lcPathFile

FUNCTION CIERRE_DIARIO
PARAMETERS pdDate,pcType
pcType = IIF(TYPE("pcType")="C" AND INLIST(pcType,"IN","PT"),pcType,"IN")
ln_Select_ = SELECT()
llSw = .F.
IF !EMPTY(pdDate)
	ll_Used = USED("cie_alm")
	SELECT mes FROM cie_alm WHERE tipo + ano + mes = pcType + LEFT(DTOS(pdDate),6) INTO CURSOR cTemp
	llSw = !EOF()
	USE
	USE IN IIF(USED("cie_alm") AND !ll_Used,"cie_alm",0)
ENDIF
SELECT(ln_Select_)
RETURN llSw

FUNCTION NAME_MONTH
PARAMETERS lnNumberMonth
lnNumberMonth = IIF(TYPE("lnNumberMonth") = "C",INT(VAL(lnNumberMonth)),lnNumberMonth)
***** Determinando el nombre del mes en español
lcNameMonth = ""
DO CASE
	CASE lnNumberMonth = 1
		lcNameMonth = "ENERO"
	CASE lnNumberMonth = 2
		lcNameMonth = "FEBRERO"
	CASE lnNumberMonth = 3
		lcNameMonth = "MARZO"
	CASE lnNumberMonth = 4
		lcNameMonth = "ABRIL"
	CASE lnNumberMonth = 5
		lcNameMonth = "MAYO"
	CASE lnNumberMonth = 6
		lcNameMonth = "JUNIO"
	CASE lnNumberMonth = 7
		lcNameMonth = "JULIO"
	CASE lnNumberMonth = 8
		lcNameMonth = "AGOSTO"
	CASE lnNumberMonth = 9
		lcNameMonth = "SETIEMBRE"
	CASE lnNumberMonth = 10
		lcNameMonth = "OCTUBRE"
	CASE lnNumberMonth = 11
		lcNameMonth = "NOVIEMBRE"
	CASE lnNumberMonth = 12
		lcNameMonth = "DICIEMBRE"
ENDCASE
RETURN lcNameMonth

FUNCTION TIPO_CAMBIO
PARAMETERS pdDate1,pcTypePrice,plEnter,pdDate2
pdDate1 = IIF(TYPE("pdDate1")="D",pdDate1,DATE())
pcTypePrice = IIF(TYPE("pcTypePrice")="C",pcTypePrice,"C")
pdDate2 = IIF(TYPE("pdDate2")="D",pdDate2,pdDate1)
ln_Select = SELECT()
llOpen = USED("maestica")
SELECT AVG(compra) AS compra,AVG(venta) AS venta,AVG(promed) AS promedio FROM maestica ;
	WHERE BETWEEN(fecha,pdDate1,pdDate2) INTO CURSOR cTemp
USE IN IIF(USED("maestica") AND !llOpen,"maestica",0)
IF !EMPTY(pdDate1) AND EOF() AND plEnter
	*USE
	*DO FORM g_cotica WITH pdDate1
	*llOpen = USED("tabtc")
	*SELECT AVG(compra) AS compra,AVG(venta) AS venta FROM maestica ;
		WHERE BETWEEN(fecha,pdDate1,pdDate2) INTO CURSOR cTemp
	*USE IN IIF(USED("maestica") AND !llOpen,"maestica",0)
ENDIF
lnPrice = 0
DO CASE
	CASE pcTypePrice = "C" && Precio de Compra
		IF !ISNULL(cTemp.compra)
			lnPrice = cTemp.compra
		ENDIF
	CASE pcTypePrice = "V" && Precio de Venta
		IF !ISNULL(cTemp.compra)
			lnPrice = cTemp.venta
		ENDIF
	CASE pcTypePrice = "P" && Precio Promedio
		IF !ISNULL(cTemp.promedio)
			lnPrice = cTemp.promedio
		ENDIF
ENDCASE
USE
SELECT(ln_Select)
RETURN ROUND(lnPrice,3)

FUNCTION STOCK_ACTUAL
PARAMETERS pcCodeStore,pcCodeArticle,pcNumberLot,pcVarStock,pcVarSeparado
* pcCodeStore		= Código de Almacen
* pcCodeArticle		= Código de Articulo
* pcNumberLot		= Numero de Lote
* pcVarStock		= Nombre de variable donde se almacena el stock
* pnVarSeparado		= Nombre de variable donde se almacena la separacion
ln_Select_Number = SELECT()
ll_Return = .T.
***** Abriendo Tabla de Almacen
ll_Store_Used = USED("stockart")
IF !ll_Store_Used
	USE stockart IN 0 AGAIN
ENDIF
SELE stockart
lc_Store_Order = ORDER()
SET ORDER TO almacen
*****
STORE 0 TO pnStock,pnSeparado
IF !EMPTY(pcCodeStore) AND !EMPTY(pcCodeArticle) AND !EMPTY(pcNumberLot)
	SELE stockart
	*SEEK pcCodeStore + pcCodeArticle + pcNumberLot
	SEEK PADR(pcCodeStore,3) + PADR(pcCodeArticle,10) + PADR(pcNumberLot,15)
	ll_Return = FOUND()
	IF TYPE("pcVarStock") = "C"
		&pcVarStock. = stockart.stock_arti
	ENDIF
	IF TYPE("pcVarSeparado") = "C"
		*&pcVarSeparado. = stockart.cantid_sepa
	ENDIF
ENDIF
***** Regresando Tabla Almacen a su estado anterior
SELE stockart
IF !EMPTY(lc_Store_Order)
	SET ORDER TO &lc_Store_Order.
ENDIF
USE IN IIF(USED("stockart") AND !ll_Store_Used,"stockart",0)
*****
RETURN ll_Return

FUNCTION STOCK_ACTUAL_PT
PARAMETERS pcCodeStore,pcCodeArticle,pcCodeQuality,pcVarStock,pcVarSeparado
* pcCodeStore		= Código de Almacen
* pcCodeArticle		= Código de Articulo
* pcCodeQuality		= Código de Calidad
* pcVarStock		= Nombre de variable donde se almacena el stock
* pnVarSeparado		= Nombre de variable donde se almacena la separacion
ln_Select_Number = SELECT()
ll_Return = .T.
***** Abriendo Tabla de Almacen
ll_Store_Used = USED("stock_pt")
IF !ll_Store_Used
	USE stock_pt IN 0 AGAIN
ENDIF
SELE stock_pt
lc_Store_Order = ORDER()
SET ORDER TO almacen
*****
STORE 0 TO pnStock,pnSeparado
IF !EMPTY(pcCodeStore) AND !EMPTY(pcCodeArticle) AND !EMPTY(pcCodeQuality)
	SELE stock_pt
	*SEEK pcCodeStore + pcCodeArticle + pcCodeQuality
	SEEK PADR(pcCodeStore,3) + PADR(pcCodeArticle,15) + PADR(pcCodeQuality,1)
	ll_Return = FOUND()
	IF TYPE("pcVarStock") = "C"
		&pcVarStock. = stock_pt.stock_arti
	ENDIF
	IF TYPE("pcVarSeparado") = "C"
		*&pcVarSeparado. = stock_pt.cantid_sepa
	ENDIF
ENDIF
***** Regresando Tabla Almacen a su estado anterior
SELE stock_pt
IF !EMPTY(lc_Store_Order)
	SET ORDER TO &lc_Store_Order.
ENDIF
USE IN IIF(USED("stock_pt") AND !ll_Store_Used,"stock_pt",0)
*****
RETURN ll_Return

FUNCTION DBF_TO_TEXTO
USE D:\CORREO\sunat
= AFIELDS(laStruc)
CREATE CURSOR TodoString FROM ARRAY laStruc
*** Transformando otros tipos a caracter
ALTER TABLE TodoString ALTER COLUMN autovaluo C(15)
SELECT sunat
SCAN
	SCATTER MEMVAR
	WAIT WINDOW "Formateando Tabla (DBF)..." + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
	m.autovaluo = STR(m.autovaluo,15,2)
	INSERT INTO TodoString FROM MEMVAR
ENDSCAN
***
USE
SELECT TodoString
lnTotalCampos = AFIELDS(laStruc)
*** Incrementando en 1 el tamaño del campo para poner el palote
FOR I = 1 TO lnTotalCampos
	IF I < lnTotalCampos
		laStruc(I,3) = laStruc(I,3) + 1
	ENDIF
ENDFOR
***
CREATE CURSOR Exportar FROM ARRAY laStruc
SELECT TodoString
SCAN
	SCATTER MEMVAR
	WAIT WINDOW "Preparando Tabla (DBF)..." + BARRA(RECNO(),RECCOUNT()) + "%" NOWAIT
	FOR I = 1 TO FCOUNT()
		lcCampo = "m." + FIELD(I)
		&lcCampo. = &lcCampo. + IIF(I < FCOUNT(),"|","")
	ENDFOR
	INSERT INTO Exportar FROM MEMVAR
ENDSCAN
USE
WAIT WINDOW "Exportando Archivo... Espere un momento por favor." NOWAIT
SELECT Exportar
COPY TO D:\EXPORTAR TYPE SDF
USE
WAIT CLEAR
RETURN

FUNCTION TIPOCAMBIO
PARAMETERS pdDate1,pcTypePrice,plEnter,pdDate2
pdDate1 = IIF(TYPE("pdDate1")="D" AND !EMPTY(pdDate1),pdDate1,DATE())
pcTypePrice = IIF(TYPE("pcTypePrice")="C",pcTypePrice,"V")
pdDate2 = IIF(TYPE("pdDate2")="D",pdDate2,pdDate1)
ln_Select = SELECT()
***
lnPrice = 0
lcRuta = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","CONTABILIDAD_PATH")
IF !EMPTY(lcRuta)
	lcRuta = lcRuta + "WP01\CONF\"
ENDIF
IF FILE(lcRuta + "TABTC.DBF")
	SELECT 0
	USE &lcRuta.tabtc ORDER fecha ALIAS tTipCam AGAIN
	IF USED("tTipCam")
		SELECT AVG(compra) AS compra,AVG(venta) AS venta FROM tTipCam ;
			WHERE BETWEEN(fecha,pdDate1,pdDate2) INTO CURSOR cTemp
		*IF (ISNULL(cTemp.compra) OR ISNULL(cTemp.venta)) AND plEnter
		*	USE
		*	DO FORM tipcam WITH pdDate1
		*	SELECT AVG(compra) AS compra,AVG(venta) AS venta FROM tTipCam ;
		*		WHERE BETWEEN(fecha,pdDate1,pdDate2) INTO CURSOR cTemp
		*ENDIF
		USE IN tTipCam
		lnPrice = cTemp.compra - cTemp.compra
		DO CASE
			CASE pcTypePrice = "C" && Precio de Compra
				lnPrice = IIF(!ISNULL(cTemp.compra),cTemp.compra,0.0000)
			CASE pcTypePrice = "V" && Precio de Venta
				lnPrice = IIF(!ISNULL(cTemp.venta),cTemp.venta,0.0000)
		ENDCASE
		USE
	ENDIF
ENDIF
IF lnPrice = 0
	llUsed = USED("maestica")
	SELECT AVG(compra) AS compra,AVG(venta) AS venta FROM maestica ;
		WHERE BETWEEN(fecha,pdDate1,pdDate2) INTO CURSOR cTemp
	USE IN IIF(USED("maestica") AND !llUsed,"maestica",0)
	lnPrice = cTemp.compra - cTemp.compra
	DO CASE
		CASE pcTypePrice = "C" && Precio de Compra
			lnPrice = IIF(!ISNULL(cTemp.compra),cTemp.compra,0.0000)
		CASE pcTypePrice = "V" && Precio de Venta
			lnPrice = IIF(!ISNULL(cTemp.venta),cTemp.venta,0.0000)
	ENDCASE
	USE
ENDIF
***
SELECT(ln_Select)
RETURN ROUND(lnPrice,4)

FUNCTION ERROR_FOCUS
PARAMETERS pnNumberError,pcNameVar
IF pnNumberError = 2012
	IF !EMPTY(pcNameVar)
		&pcNameVar. = .T.
	ENDIF
ENDIF
RETURN

FUNCTION EXCEL_COLUMN
LPARAMETERS pnNumberColumn
I = INT(pnNumberColumn/27)
lcCharBegin = IIF(I > 0,CHR(64 + I),"")
lcColumn = lcCharBegin + CHR(64 + IIF(MOD(pnNumberColumn,26)=0,26,MOD(pnNumberColumn,26)))
RETURN lcColumn

FUNCTION MAESVARI
PARAMETERS pcCodeTable,pcCodeRegister,pcNameField
ln_Select = SELECT()
SELECT 0
USE maesvari ORDER codigo ALIAS tMaevar AGAIN
SEEK pcCodeTable + pcCodeRegister
lc_Desc = ""
IF !EMPTY(pcNameField)
	*lc_Desc = ALLTRIM(EVALUATE(pcNameField))
	lc_Desc = EVALUATE(pcNameField)
	IF TYPE("lc_Desc") = "C"
		lc_Desc = ALLTRIM(lc_Desc)
	ENDIF
ENDIF
USE
SELECT(ln_Select)
RETURN lc_Desc

FUNCTION LAST_DAY
PARAMETERS pcYearMonth
pcYearMonth = IIF(TYPE("pcYearMonth")="C",pcYearMonth,LEFT(DTOS(DATE()),6))
***** Ultimo Dia del Mes
lnMonth = INT(VAL(RIGHT(pcYearMonth,2)))
lnYear = INT(VAL(LEFT(pcYearMonth,4)))
lnYear = lnYear + IIF(lnMonth = 12,1,0)
lnMonth = IIF(lnMonth < 12,lnMonth + 1,1)
ldLastDay = CTOD("01/" + PADL(lnMonth,2,"0") + "/" + PADL(lnYear,4,"0")) - 1
*****
RETURN ldLastDay

FUNCTION MENSAJE
PARAMETERS pcDescription,pcTitle,pcObjectFocus
IF !USED("cMessage")
	CREATE CURSOR cMessage(numero N(3),descrip M,objeto C(100))
ENDIF
lcMensaje = ""
IF TYPE("pcTitle") = "C" AND !EMPTY(pcTitle)
	lcMensaje = UPPER(pcTitle) + CHR(13)
ENDIF
lcMensaje = lcMensaje + pcDescription
INSERT INTO cMessage VALUES(RECCOUNT("cMessage") + 1,lcMensaje,IIF(TYPE("pcObjectFocus") = "C" AND !EMPTY(pcObjectFocus),pcObjectFocus,""))
RETURN

FUNCTION STOCK_INSUMO
PARAMETERS pcCodeArticle,pcVarStock
* pcCodeArticle		= Código de Articulo
* pcVarStock		= Nombre de variable donde se almacena el stock
ln_Select_Number = SELECT()
ll_Return = .T.
***** Abriendo Tabla de Almacen
ll_Store_Used = USED("stockart")
IF !ll_Store_Used
	USE stockart IN 0 AGAIN
ENDIF
SELE stockart
lc_Store_Order = ORDER()
SET ORDER TO codigo
*****
IF !EMPTY(pcCodeArticle)
	SELE stockart
	SEEK PADR(pcCodeArticle,10)
	ll_Return = FOUND()
	SCAN WHILE cod_articu = PADR(pcCodeArticle,10)
		IF TYPE("pcVarStock") = "C"
			&pcVarStock. = &pcVarStock. + stockart.stock_arti
		ENDIF
	ENDSCAN
ENDIF
***** Regresando Tabla Almacen a su estado anterior
SELE stockart
IF !EMPTY(lc_Store_Order)
	SET ORDER TO &lc_Store_Order.
ENDIF
USE IN IIF(USED("stockart") AND !ll_Store_Used,"stockart",0)
*****
RETURN ll_Return

FUNCTION STOCK_PT
PARAMETERS pcCodeArticle,pcVarStock
* pcCodeArticle		= Código de Articulo
* pcVarStock		= Nombre de variable donde se almacena el stock
ln_Select_Number = SELECT()
ll_Return = .T.
***** Abriendo Tabla de Almacen
ll_Store_Used = USED("stock_pt")
IF !ll_Store_Used
	USE stock_pt IN 0 AGAIN
ENDIF
SELE stock_pt
lc_Store_Order = ORDER()
SET ORDER TO codigo
*****
IF !EMPTY(pcCodeArticle)
	SELE stock_pt
	SEEK PADR(pcCodeArticle,15)
	ll_Return = FOUND()
	SCAN WHILE cod_articu = PADR(pcCodeArticle,15)
		IF TYPE("pcVarStock") = "C"
			&pcVarStock. = &pcVarStock. + stock_pt.stock_arti
		ENDIF
	ENDSCAN
ENDIF
***** Regresando Tabla Almacen a su estado anterior
SELE stock_pt
IF !EMPTY(lc_Store_Order)
	SET ORDER TO &lc_Store_Order.
ENDIF
USE IN IIF(USED("stock_pt") AND !ll_Store_Used,"stock_pt",0)
*****
RETURN ll_Return

FUNCTION ACTUALIZAR_PRODUCTO
PARAMETERS pcTipo,pcCodigo1,pcCodigo2,pcDescEspanol,pcDescIngles
lnSelect = SELECT()
CREATE CURSOR cTable(nombre C(10),indice C(10),campo1 C(10),campo2 C(10))
DO CASE
	CASE pcTipo = "IN" && Insumos
		*pari2	cod_intemp	COD_ARTICU	tip_produc+cod_articu+serie+nrodoc+item
		*pars2	cod_intemp	COD_ARTICU	tip_produc+cod_articu+serie+nrodoc+item
		*ordc2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*ords2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*ordr2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*guia2	cod_intemp	COD_ARTICU	tip_produc+cod_articu+serie+nrodoc+item
		INSERT INTO cTable VALUES("PARI2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("PARS2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("ORDC2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("ORDS2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("ORDR2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("GUIA2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		*des_articu
	CASE pcTipo = "PT" && Productos Terminados
		*noti2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*note2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*notc2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*nots2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*notr2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*remi2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*ordp2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		INSERT INTO cTable VALUES("NOTI2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("NOTE2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("NOTC2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("NOTS2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("NOTR2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("REMI2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
		INSERT INTO cTable VALUES("ORDP2","COD_ARTICU","COD_INTEMP","DES_ARTICU")
ENDCASE
*WAIT WINDOW "Actualizando cambio de Código... Espere un momento por favor." NOWAIT
SELECT cTable
SCAN
	lcTabla = ALLTRIM(cTable.nombre)
	lcIndice = ALLTRIM(cTable.indice)
	lcField1 = ALLTRIM(cTable.campo1)
	lcField2 = ALLTRIM(cTable.campo2)
	DO CASE
		CASE lcTabla = "PARI2"
			lcCampo = "tip_produc+cod_articu"
			lcCodigo = "P" + pcCodigo1
		CASE lcTabla = "PARS2"
			lcCampo = "tip_produc+cod_articu"
			lcCodigo = "P" + pcCodigo1
		CASE lcTabla = "GUIA2"
			lcCampo = "tip_produc+cod_articu"
			lcCodigo = "P" + pcCodigo1
		OTHERWISE
			lcCampo = "cod_articu"
			lcCodigo = pcCodigo1
	ENDCASE
	IF lcTabla = "ORDP2"
		SELECT 0
		USE ordp1 ORDER ordp1 ALIAS documento1 AGAIN
	ENDIF
	SELECT 0
	USE (lcTabla) ORDER (lcIndice) ALIAS documento2 AGAIN
	SEEK lcCodigo
	IF FOUND()
		= BLOQUEAFILE()
		SCAN WHILE &lcCampo. = lcCodigo
			REPLACE &lcField1. WITH pcCodigo2
			REPLACE &lcField2. WITH pcDescEspanol
			*** Orden de Pedido
			IF lcTabla = "ORDP2"
				SELECT documento1
				SEEK documento2.serie + documento2.nrodoc
				llExterior = (documento1.i_exterior = 1)
				SELECT documento2
				IF llExterior AND !EMPTY(pcDescIngles)
					REPLACE des_artcli WITH pcDescIngles && Descripcion en Ingles
				ELSE
					REPLACE des_artcli WITH pcDescEspanol
				ENDIF
			ENDIF
			***
		ENDSCAN
		UNLOCK
	ENDIF
	USE
	IF USED("documento1")
		USE IN documento1
	ENDIF
ENDSCAN
USE
WAIT CLEAR
SELECT(lnSelect)
RETURN

FUNCTION VERIFICAR_PRODUCTO
PARAMETERS pcTipo,pcCodigo
lnSelect = SELECT()
CREATE CURSOR cTable(nombre C(10),indice C(10))
DO CASE
	CASE pcTipo = "IN" && Insumos
		*pari2	cod_intemp	COD_ARTICU	tip_produc+cod_articu+serie+nrodoc+item
		*pars2	cod_intemp	COD_ARTICU	tip_produc+cod_articu+serie+nrodoc+item
		*ordc2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*ords2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*ordr2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*guia2	cod_intemp	COD_ARTICU	tip_produc+cod_articu+serie+nrodoc+item
		INSERT INTO cTable VALUES("PARI2","COD_ARTICU")
		INSERT INTO cTable VALUES("PARS2","COD_ARTICU")
		INSERT INTO cTable VALUES("ORDC2","COD_ARTICU")
		INSERT INTO cTable VALUES("ORDS2","COD_ARTICU")
		INSERT INTO cTable VALUES("ORDR2","COD_ARTICU")
		INSERT INTO cTable VALUES("GUIA2","COD_ARTICU")
	CASE pcTipo = "PT" && Productos Terminados
		*noti2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*note2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*notc2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*nots2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*notr2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*remi2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		*ordp2	cod_intemp	COD_ARTICU	cod_articu+serie+nrodoc+item
		INSERT INTO cTable VALUES("NOTI2","COD_ARTICU")
		INSERT INTO cTable VALUES("NOTE2","COD_ARTICU")
		INSERT INTO cTable VALUES("NOTC2","COD_ARTICU")
		INSERT INTO cTable VALUES("NOTS2","COD_ARTICU")
		INSERT INTO cTable VALUES("NOTR2","COD_ARTICU")
		INSERT INTO cTable VALUES("REMI2","COD_ARTICU")
		INSERT INTO cTable VALUES("ORDP2","COD_ARTICU")
ENDCASE
llEnUso = .F.
WAIT WINDOW "Verificando existencia de Código... Espere un momento por favor." NOWAIT
SELECT cTable
SCAN
	lcTabla = ALLTRIM(cTable.nombre)
	lcIndice = ALLTRIM(cTable.indice)
	DO CASE
		CASE lcTabla = "PARI2"
			lcCodigo = "P" + pcCodigo
		CASE lcTabla = "PARS2"
			lcCodigo = "P" + pcCodigo
		CASE lcTabla = "GUIA2"
			lcCodigo = "P" + pcCodigo
		OTHERWISE
			lcCodigo = pcCodigo
	ENDCASE
	SELECT 0
	USE (lcTabla) ORDER (lcIndice) ALIAS documento AGAIN
	SEEK lcCodigo
	llEnUso = FOUND()
	USE
	IF llEnUso
		EXIT	
	ENDIF
ENDSCAN
USE
WAIT CLEAR
SELECT(lnSelect)
RETURN llEnUso

FUNCTION VERIFICAR_ORDEN_SERVICIO
PARAMETERS pcType,pcCursorDetail,pcNumber,pcMessage
lnSelect = SELECT()
*** Abriendo Tablas
SELECT 0
USE ordr1 ORDER ordr1 ALIAS orin1 AGAIN
SELECT 0
USE ordr2 ORDER seg_ordser ALIAS orin2 AGAIN
SELECT 0
USE notr1 ORDER notr1 ALIAS orpt1 AGAIN
SELECT 0
USE notr2 ORDER seg_ordser ALIAS orpt2 AGAIN
***
llSw = .F.
*** Verificando si existe articulos en uso
SELECT item,des_articu,cod_intemp FROM (pcCursorDetail) INTO CURSOR curTemp
SCAN
	FOR lnI = 1 TO 2
		lcTableName1 = "OR" + IIF(lnI = 1,"IN","PT") + "1"
		lcTableName2 = "OR" + IIF(lnI = 1,"IN","PT") + "2"
		*** Orden de Requerimiento de Insumos
		SELECT (lcTableName2)
		SEEK pcType + pcNumber + curTemp.item
		SCAN WHILE tip_ordser + ser_ordser + nro_ordser + itm_ordser = pcType + pcNumber + curTemp.item
			SELECT (lcTableName1)
			SEEK &lcTableName2..serie + &lcTableName2..nrodoc
			llSw = (FOUND() AND !&lcTableName1..cod_anula)
			IF llSw
				MESSAGEBOX("El Item " + curTemp.item + " se encuentra referenciado en la Orden de Requerimiento de " + IIF(lnI = 1,"Insumo","PT") + " " + ALLTRIM(&lcTableName1..serie) + "-" + ALLTRIM(&lcTableName1..nrodoc) + ".",0+48,pcMessage)
				EXIT
			ENDIF
		ENDSCAN
		***
		IF llSw
			EXIT
		ENDIF
	ENDFOR
	IF llSw
		EXIT
	ENDIF
ENDSCAN
USE
*** Cerrando Tablas
USE IN orin1
USE IN orin2
USE IN orpt1
USE IN orpt2
***
SELECT(lnSelect)
RETURN llSw

FUNCTION VERIFICAR_ORDEN_SERVICIO_ITEM
PARAMETERS pcType,pcNumber,pcItem,pcMessage
lnSelect = SELECT()
llSw = .F.
FOR lnX = 1 TO 2
	*** Abriendo Tablas
	DO CASE
		CASE lnX = 1
			lcTable = "ORDR"
		CASE lnX = 2
			lcTable = "NOTR"
	ENDCASE
	SELECT 0
	lcTableName = lcTable + "1"
	USE (lcTableName) ORDER (lcTableName) ALIAS or1 AGAIN
	SELECT 0
	lcTableName = lcTable + "2"
	USE (lcTableName) ORDER seg_ordser ALIAS or2 AGAIN
	***
	SELECT or2
	SEEK pcType + pcNumber + pcItem
	SCAN WHILE tip_ordser + ser_ordser + nro_ordser + itm_ordser = pcType + pcNumber + pcItem
		SELECT or1
		SEEK or2.serie + or2.nrodoc
		llSw = (FOUND() AND !or1.cod_anula)
		IF llSw
			MESSAGEBOX("El Item esta referenciado en la Orden de Requerimiento de " + IIF(lnX = 1,"Insumo","PT") + " " + ALLTRIM(or1.serie) + "-" + ALLTRIM(or1.nrodoc) + ".",0+48,pcMessage)
			EXIT
		ENDIF
	ENDSCAN
	*** Cerrando Tablas
	USE IN or1
	USE IN or2
	***
	IF llSw
		EXIT
	ENDIF
ENDFOR
SELECT(lnSelect)
RETURN llSw

FUNCTION VERIFICAR_ORDEN_COMPRA
PARAMETERS pcType,pcCursorDetail,pcNumber,pcMensaje
lnSelect = SELECT()
*** Abriendo Tablas
DO CASE
	CASE pcType = "IN"
		SELECT 0
		USE pari1 ORDER pari1 ALIAS pi1 AGAIN
		SELECT 0
		USE pari2 ORDER seg_ordcom ALIAS pi2 AGAIN
	CASE pcType = "PT"
		SELECT 0
		USE noti1 ORDER noti1 ALIAS pi1 AGAIN
		SELECT 0
		USE noti2 ORDER seg_ordcom ALIAS pi2 AGAIN
ENDCASE
***
llSw = .F.
*** Verificando si existe articulos en uso
SELECT cod_articu,des_articu,cod_intemp FROM (pcCursorDetail) INTO CURSOR curTemp
SCAN
	SELECT pi2
	SEEK pcNumber + curTemp.cod_articu
	SCAN WHILE seg_ordcom + cod_articu = pcNumber + curTemp.cod_articu
		SELECT pi1
		SEEK pi2.serie + pi2.nrodoc
		llSw = (FOUND() AND !pi1.cod_anula)
		IF llSw
			MESSAGEBOX("El " + IIF(pcType = "IN","Insumo","Producto") + ": " + CHR(13) + ALLTRIM(curTemp.cod_intemp) + " - " + ALLTRIM(curTemp.des_articu) + CHR(13) +;
				"se encuentra referenciado en el Parte de Ingreso " + ALLTRIM(pi1.serie) + "-" + ALLTRIM(pi1.nrodoc) + ".",0+48,pcMensaje)
			EXIT
		ENDIF
	ENDSCAN
	IF llSw
		EXIT
	ENDIF
ENDSCAN
USE
*** Cerrando Tablas
USE IN pi1
USE IN pi2
***
SELECT(lnSelect)
RETURN llSw

FUNCTION VERIFICAR_ORDEN_COMPRA_ITEM
PARAMETERS pcType,pcNumber,pcArticulo,pcMessage
lnSelect = SELECT()
*** Abriendo Tablas
DO CASE
	CASE pcType = "IN"
		SELECT 0
		USE pari1 ORDER pari1 ALIAS pi1 AGAIN
		SELECT 0
		USE pari2 ORDER seg_ordcom ALIAS pi2 AGAIN
	CASE pcType = "PT"
		SELECT 0
		USE noti1 ORDER noti1 ALIAS pi1 AGAIN
		SELECT 0
		USE noti2 ORDER seg_ordcom ALIAS pi2 AGAIN
ENDCASE
***
llSw = .F.
SELECT pi2
SEEK pcNumber + pcArticulo
SCAN WHILE seg_ordcom + cod_articu = pcNumber + pcArticulo
	SELECT pi1
	SEEK pi2.serie + pi2.nrodoc
	llSw = (FOUND() AND !pi1.cod_anula)
	IF llSw
		MESSAGEBOX("El " + IIF(pcType = "IN","Insumo","Producto") + " esta referenciado en el Parte de Ingreso " + ALLTRIM(pi1.serie) + "-" + ALLTRIM(pi1.nrodoc) + ".",0+48,pcMessage)
		EXIT
	ENDIF
ENDSCAN
*** Cerrando Tablas
USE IN pi1
USE IN pi2
***
SELECT(lnSelect)
RETURN llSw

FUNCTION VERIFICAR_ORDEN_REQUERIMIENTO
PARAMETERS pcType,pcCursorDetail,pcNumber,pcMessage
lnSelect = SELECT()
*** Abriendo Tablas
lcTable = IIF(pcType = "ORDR","GUIA","REMI")
SELECT 0
lcTableName = lcTable + "1"
USE (lcTableName) ORDER (lcTableName) ALIAS gr1 AGAIN
SELECT 0
lcTableName = lcTable + "2"
USE (lcTableName) ORDER docrel ALIAS gr2 AGAIN
***
llSw = .F.
*** Verificando si existe articulos en uso
SELECT item,des_articu,cod_intemp FROM (pcCursorDetail) INTO CURSOR curTemp
SCAN
	*** Guia de Remisión
	SELECT gr2
	SEEK pcType + pcNumber + curTemp.item
	SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = pcType + pcNumber + curTemp.item
		SELECT gr1
		SEEK gr2.serie + gr2.nrodoc
		llSw = (FOUND() AND !gr1.cod_anula)
		IF llSw
			MESSAGEBOX("El Item " + ALLTRIM(curTemp.item) + " se encuentra referenciado en la Guía de Remisión " + ALLTRIM(gr1.serie) + "-" + ALLTRIM(gr1.nrodoc) + ".",0+48,pcMessage)
			EXIT
		ENDIF
	ENDSCAN
	***
	IF llSw
		EXIT
	ENDIF
ENDSCAN
USE
*** Cerrando Tablas
USE IN gr1
USE IN gr2
***
SELECT(lnSelect)
RETURN llSw

FUNCTION VERIFICAR_ORDEN_REQUERIMIENTO_ITEM
PARAMETERS pcType,pcNumber,pcItem,pcMessage
lnSelect = SELECT()
llSw = .F.
*** Abriendo Tablas
lcTable = IIF(pcType = "ORDR","GUIA","REMI")
SELECT 0
lcTableName = lcTable + "1"
USE (lcTableName) ORDER (lcTableName) ALIAS gr1 AGAIN
SELECT 0
lcTableName = lcTable + "2"
USE (lcTableName) ORDER docrel ALIAS gr2 AGAIN
***
SELECT gr2
SEEK pcType + pcNumber + pcItem
SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = pcType + pcNumber + pcItem
	SELECT gr1
	SEEK gr2.serie + gr2.nrodoc
	llSw = (FOUND() AND !gr1.cod_anula)
	IF llSw
		MESSAGEBOX("El Item esta referenciado en la Guía de Remisión de " + IIF(pcType = "ORDR","Insumo","PT") + " " + ALLTRIM(gr1.serie) + "-" + ALLTRIM(gr1.nrodoc) + ".",0+48,pcMessage)
		EXIT
	ENDIF
ENDSCAN
*** Cerrando Tablas
USE IN gr1
USE IN gr2
***
SELECT(lnSelect)
RETURN llSw

FUNCTION VERIFICAR_PROVEEDOR
PARAMETERS pcCodigo
lnSelect = SELECT()
CREATE CURSOR cTable(nombre C(10),campo C(10),longitud N(2))
INSERT INTO cTable VALUES("MAESCOLO","COD_CODPRO",8)
INSERT INTO cTable VALUES("PARI1","COD_AUXI",15)
INSERT INTO cTable VALUES("PARS1","COD_PROV",15)
INSERT INTO cTable VALUES("GUIA1","COD_PROV",15)
INSERT INTO cTable VALUES("ORDC1","COD_AUXI",15)
INSERT INTO cTable VALUES("ORDS1","COD_AUXI",15)
INSERT INTO cTable VALUES("ORDR1","COD_AUXI",15)
INSERT INTO cTable VALUES("NOTI1","COD_AUXI",15)
INSERT INTO cTable VALUES("NOTE1","COD_PROV",15)
INSERT INTO cTable VALUES("REMI1","COD_PROV",15)
INSERT INTO cTable VALUES("NOTC1","COD_AUXI",15)
INSERT INTO cTable VALUES("NOTS1","COD_AUXI",15)
INSERT INTO cTable VALUES("NOTR1","COD_AUXI",15)
llEnUso = .F.
WAIT WINDOW "Verificando existencia de Código... Espere un momento por favor." NOWAIT
SELECT cTable
SCAN
	lcNameTable = ALLTRIM(cTable.nombre)
	lcNameField = ALLTRIM(cTable.campo)
	SELECT 0
	USE (lcNameTable) ALIAS documento AGAIN
	LOCATE FOR &lcNameField. = PADR(pcCodigo,cTable.longitud)
	llEnUso = FOUND()
	USE
	IF llEnUso
		EXIT	
	ENDIF
ENDSCAN
USE
WAIT CLEAR
SELECT(lnSelect)
RETURN llEnUso

FUNCTION VERIFICAR_CLIENTE
PARAMETERS pcCodigo
lnSelect = SELECT()
CREATE CURSOR cTable(nombre C(10),campo C(10),longitud N(2))
INSERT INTO cTable VALUES("PARS1","COD_AUXI",15)
INSERT INTO cTable VALUES("NOTE1","COD_AUXI",15)
INSERT INTO cTable VALUES("REMI1","COD_AUXI",15)
llEnUso = .F.
WAIT WINDOW "Verificando existencia de Código... Espere un momento por favor." NOWAIT
SELECT cTable
SCAN
	lcNameTable = ALLTRIM(cTable.nombre)
	lcNameField = ALLTRIM(cTable.campo)
	SELECT 0
	USE (lcNameTable) ALIAS documento AGAIN
	LOCATE FOR &lcNameField. = PADR(pcCodigo,cTable.longitud)
	llEnUso = FOUND()
	USE
	IF llEnUso
		EXIT	
	ENDIF
ENDSCAN
USE
WAIT CLEAR
SELECT(lnSelect)
RETURN llEnUso

FUNCTION IMPUESTO
PARAMETERS pcCodeTaxes,pcNameField
pcCodeTaxes = IIF(EMPTY(pcCodeTaxes),"IGV",pcCodeTaxes)
pcNameField = IIF(TYPE("pcNameField") = "C" AND !EMPTY(pcNameField),UPPER(pcNameField),"VALNUM_01")
ln_Select = SELECT()
ll_Used = !USED("maesvari")
*RADICAL = IMP 3
*CODIGO = IGV 10
SELECT * FROM maesvari ;
	WHERE radical + codigo = "IMP" + pcCodeTaxes INTO CURSOR curTemp
lnPercent = curTemp.&pcNameField.
USE
USE IN IIF(USED("maesvari") AND ll_Used,"maesvari",0)
SELECT(ln_Select)
RETURN lnPercent

FUNCTION TIPO_CAMBIO_ACTUALIZAR
PARAMETERS pcVarCodTC,pcVarValTC,pcCodMoti,pdFecha1,pdFecha2,pdFecha3
pcCodMoti = PADR(IIF(TYPE("pcCodMoti") = "C",pcCodMoti,""),3)
pdFecha1 = IIF(TYPE("pdFecha1") = "D",pdFecha1,CTOD(""))
pdFecha2 = IIF(TYPE("pdFecha2") = "D",pdFecha2,CTOD(""))
pdFecha3 = IIF(TYPE("pdFecha3") = "D",pdFecha3,CTOD(""))
IF !FLAG_MOTIVO_APERTURA(pcCodMoti)
	lc_tipcam_cod = ""
	ln_tipcam_val = 0
	IF !EMPTY(pdFecha1)
		lc_tipcam_cod = "O"
		ln_tipcam_val = TIPOCAMBIO(pdFecha1,"V") && Siempre debe jalar el Tipo de Cambio venta
	ELSE
		IF !EMPTY(pdFecha2)
			lc_tipcam_cod = "O"
			ln_tipcam_val = TIPOCAMBIO(pdFecha2,"V") && Siempre debe jalar el Tipo de Cambio venta
		ELSE
			IF !EMPTY(pdFecha3)
				lc_tipcam_cod = "O"
				ln_tipcam_val = TIPOCAMBIO(pdFecha3,"V") && Siempre debe jalar el Tipo de Cambio venta
			ENDIF
		ENDIF
	ENDIF
	IF !EMPTY(pdFecha1) OR !EMPTY(pdFecha2) OR !EMPTY(pdFecha3)
		IF TYPE("pcVarCodTC") = "C" AND !EMPTY(pcVarCodTC)
			&pcVarCodTC. = lc_tipcam_cod
		ENDIF
		IF TYPE("pcVarValTC") = "C" AND !EMPTY(pcVarValTC)
			&pcVarValTC. = ln_tipcam_val
		ENDIF
	ENDIF
ENDIF
RETURN

FUNCTION FLAG_MOTIVO_APERTURA
PARAMETERS pcCodigoMotivo,pcAliasTablaMotivo
pcCodigoMotivo = PADR(pcCodigoMotivo,3)
pcAliasTablaMotivo = IIF(TYPE("pcAliasTablaMotivo")="C" AND !EMPTY(pcAliasTablaMotivo),pcAliasTablaMotivo,"tMotivo")
ln_Select = SELECT()
ll_Used_Motivo = USED(pcAliasTablaMotivo)
IF !ll_Used_Motivo
	SELE 0
	USE maesmoti ALIAS (pcAliasTablaMotivo) AGAIN
ENDIF
SELECT (pcAliasTablaMotivo)
lc_Order_Motivo = ORDER()
ln_Recno = IIF(!EOF(),RECNO(),0)
SET ORDER TO codigo
SEEK "ING" + pcCodigoMotivo
ll_Sw = (FOUND() AND &pcAliasTablaMotivo..indi_proc = "03")
IF !EMPTY(lc_Order_Motivo)
	SET ORDER TO &lc_Order_Motivo.
ELSE
	SET ORDER TO
ENDIF
IF ln_Recno > 0
	GO ln_Recno
ENDIF
IF !ll_Used_Motivo
	USE IN (pcAliasTablaMotivo)
ENDIF
SELECT(ln_Select)
RETURN ll_Sw

FUNCTION PRECIO_PROMEDIO_KARDEX
PARAMETERS pcAlmTipo,pdDocFecha,pcDocTipo,pcDocSerie,pcDocNumero,pcDocItem,pcVarPrecio1,pcVarPrecio2
ln_Select_ = SELECT()
IF !EMPTY(pdDocFecha)
	lcArchivoKardex = EXIST_FILE_KARDEX(pcAlmTipo,pdDocFecha)
	IF !EMPTY(lcArchivoKardex)
		SELE 0
		USE (lcArchivoKardex) ORDER documento ALIAS kardex AGAIN
		SEEK pcDocTipo + pcDocSerie + pcDocNumero + pcDocItem
		IF FOUND()
			*** Precio Promedio por Almacén
			pcVarPrecio1 = kardex.prepro_sol && kardex.preprosol
			pcVarPrecio2 = kardex.prepro_dol && kardex.preprodol
			***
		ENDIF
		USE
	ENDIF
ENDIF
SELECT(ln_Select_)
RETURN

FUNCTION SALDO_ARTICULO_OP
PARAMETERS pc_Type_Store,pc_Code_Store,pc_Code_Article,pc_Code_Group,pc_Number_OP,pd_Date,pc_Document,pd_Date1
*pc_Document: Tipo + Serie + Numero
ln_Select_Current = SELECT()
pc_Type_Store = PADR(IIF(TYPE("pc_Type_Store") = "C",pc_Type_Store,"IN"),2)
pc_Code_Store = PADR(IIF(TYPE("pc_Code_Store") = "C",pc_Code_Store,""),3)
*pc_Code_Article = PADR(IIF(TYPE("pc_Code_Article") = "C",pc_Code_Article,""),IIF(pc_Type_Store = "IN",13,15))
pc_Code_Article = PADR(IIF(TYPE("pc_Code_Article") = "C",pc_Code_Article,""),IIF(pc_Type_Store = "IN",10,15))
*pc_Code_Group = PADR(IIF(TYPE("pc_Code_Group") = "C",pc_Code_Group,""),15)
pc_Code_Group = PADR(IIF(TYPE("pc_Code_Group") = "C",pc_Code_Group,""),IIF(pc_Type_Store = "IN",15,1))
pc_Number_OP = PADR(IIF(TYPE("pc_Number_OP") = "C",pc_Number_OP,""),8)
pd_Date = IIF(TYPE("pd_Date") = "D",pd_Date,DATE())
*pd_Date1 = Ignorar consumo de producción de esta fecha
ln_Stock = 0
*IF !EMPTY(pc_Type_Store) AND !EMPTY(pc_Code_Store) AND !EMPTY(pc_Code_Article) AND !EMPTY(pc_Code_Group) AND !EMPTY(pc_Number_OP) AND !EMPTY(pd_Date)
IF !EMPTY(pc_Type_Store) AND !EMPTY(pc_Code_Store) AND !EMPTY(pc_Code_Article) AND !EMPTY(pc_Number_OP) AND !EMPTY(pd_Date)
	*lc_SQL_Select = "SELECT SUM(cantid_ing-cantid_sal) AS stock FROM tKardex WHERE cod_alma='" + pc_Code_Store + "' AND cod_articu='" +;
		pc_Code_Article + "' AND " + IIF(pc_Type_Store = "IN","nro_lote","cod_calid") + "='" + pc_Code_Group + "' AND cod_ordprd='" +;
		pc_Number_OP + "' AND fecha_reg <= pd_Date"
	lc_SQL_Select = "SELECT SUM(cantid_ing-cantid_sal) AS stock FROM tKardex WHERE cod_alma='" + pc_Code_Store + "' AND cod_articu='" +;
		pc_Code_Article + "'" +;
		IIF(!EMPTY(pc_Code_Group)," AND " + IIF(pc_Type_Store = "IN","nro_lote","cod_calid") + "='" + pc_Code_Group + "'","") +;
		" AND cod_ordprd='" + pc_Number_OP + "' AND fecha_reg <= pd_Date"
	lnAnoIni = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","AÑO_APERTURA")
	lnAnoIni = IIF(TYPE("lnAnoIni") != "U",INT(VAL(lnAnoIni)),YEAR(pd_Date))
	lnAnoFin = YEAR(pd_Date)
	*FOR Y = lnAnoFin TO lnAnoIni STEP -1
		*** Abriendo Tabla
		*lcNameFile = "KAR" + pc_Type_Store + PADL(Y,4,"0")
		lcNameFile = "KAR" + pc_Type_Store + PADL(YEAR(pd_Date),4,"0")
		IF FILE(lcNameFile + ".DBF")
			SELECT 0
			USE (lcNameFile) ALIAS tKardex AGAIN
		ENDIF
		***
		*ll_Sw = .F.
		IF USED("tKardex")
			*** Stock Actual 
			lc_SQL_Exec = lc_SQL_Select
			&& Ignorando Documento Actual
			IF !EMPTY(pc_Document)
				lc_SQL_Exec = lc_SQL_Exec + " AND tipdoc+serie+nrodoc!='" + pc_Document + "'"
			ENDIF
			&&
			&& Ignorando Consumo de Producción de una fecha determinada
			IF !EMPTY(pd_Date1)
				lc_cod_moti = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","MOT_SAL_PRD")
				lc_cod_moti = IIF(!ISNULL(lc_cod_moti),lc_cod_moti,"")
				lc_SQL_Exec = lc_SQL_Exec + " AND !(rad_moti = 'SAL' AND tipdoc='" + IIF(pc_Type_Store = "IN","PARS","NOTE") +;
					"' AND cod_moti='" + lc_cod_moti + "' AND fecha_reg = pd_Date1)"
			ENDIF
			&&
			lc_SQL_Exec = lc_SQL_Exec + " INTO CURSOR c_Temp"
			&lc_SQL_Exec.
			*ll_Sw = !EOF("c_Temp")
			IF !ISNULL(c_Temp.stock)
				ln_Stock = ln_Stock + c_Temp.stock
			ENDIF
			USE IN c_Temp
			***
			*** Cerrando Tabla
			USE IN tKardex
			***
		ENDIF
		*IF !ll_Sw
		*	EXIT
		*ENDIF
	*ENDFOR
ENDIF
SELECT(ln_Select_Current)
RETURN ln_Stock

PROCEDURE MEMVAR_BACKUP
PARAMETERS pc_NameArray,pc_NameAlias
pc_NameAlias = IIF(EMPTY(pc_NameAlias),ALIAS(),pc_NameAlias)
ln_Select_ = SELECT()
IF !EMPTY(pc_NameAlias)
	ln_A = 0
	SELECT (pc_NameAlias)
	FOR ln_I = 1 TO FCOUNT()
		lcNameField1 = "m." + FIELD(ln_I)
		lcNameField2 = "m_" + FIELD(ln_I)
		IF TYPE(lcNameField1) != "U"
			ln_A = ln_A + 1
			DIMENSION pc_NameArray(ln_A,2)
			pc_NameArray(ln_A,1) = lcNameField2
			pc_NameArray(ln_A,2) = &lcNameField1.
		ENDIF
	ENDFOR
ENDIF
SELECT (ln_Select_)
RETURN

PROCEDURE MEMVAR_RESTORE
PARAMETERS pc_NameArray
IF ALEN(pc_NameArray,2) = 0
	RETURN
ENDIF
FOR ln_I = 1 TO ALEN(pc_NameArray,1)
	lcNameField1 = ALLTRIM(pc_NameArray(ln_I,1))
	lcNameField1 = "m." + SUBSTR(lcNameField1,3)
	&lcNameField1. = pc_NameArray(ln_I,2)
ENDFOR
RETURN

FUNCTION CREATE_FILE_USER
lcNameDirectory = GETENV("TEMP")
IF !EMPTY(lcNameDirectory) AND RIGHT(lcNameDirectory,1) != "\"
	lcNameDirectory = lcNameDirectory + "\"
ENDIF
IF DIRECTORY(lcNameDirectory) AND !FILE(lcNameDirectory + "USER.INI")
	= WriteFileIni(lcNameDirectory + "USER.INI","WAYRA","CODE","")
	= WriteFileIni(lcNameDirectory + "USER.INI","WAYRA","PATH_PDF",lcNameDirectory)
ENDIF
RETURN

FUNCTION READ_FILE_USER
PARAMETERS pcSection,pcEntry
lcNameDirectory = GETENV("TEMP")
IF !EMPTY(lcNameDirectory) AND RIGHT(lcNameDirectory,1) != "\"
	lcNameDirectory = lcNameDirectory + "\"
ENDIF
lcReturnValue = ""
IF DIRECTORY(lcNameDirectory)
	lcReturnValue = ReadFileIni(lcNameDirectory + "USER.INI",pcSection,pcEntry)
ENDIF
RETURN lcReturnValue

FUNCTION WRITE_FILE_USER
PARAMETERS pcSection,pcEntry,pcValue
lcNameDirectory = GETENV("TEMP")
IF !EMPTY(lcNameDirectory) AND RIGHT(lcNameDirectory,1) != "\"
	lcNameDirectory = lcNameDirectory + "\"
ENDIF
IF DIRECTORY(lcNameDirectory)
	= WriteFileIni(lcNameDirectory + "USER.INI",pcSection,pcEntry,pcValue)
ENDIF
RETURN

*!*	FUNCTION COSTO_PRODUCCION
*!*	PARAMETERS pcPI_Type,pcPI_Serie,pcPI_Number,pcPI_Item,pnPI_Quantity,pcOS_Type,pcOS_Serie,pcOS_Number,pcOS_Item,pcCursorName,pnVarPrice1,pnVarPrice2
*!*	pcCursorName = IIF(TYPE("pcCursorName") = "C",pcCursorName,"")
*!*	ln_Select = SELECT()
*!*	pcOS_Type = IIF(TYPE("pcOS_Type") = "C",pcOS_Type,"")
*!*	pcOS_Serie = IIF(TYPE("pcOS_Serie") = "C",pcOS_Serie,"")
*!*	pcOS_Number = IIF(TYPE("pcOS_Number") = "C",pcOS_Number,"")
*!*	pcOS_Item = IIF(TYPE("pcOS_Item") = "C",pcOS_Item,"")
*!*	CREATE CURSOR cCost(tipo C(4),serie C(4),nrodoc C(10),item C(4),codigo C(50),descri C(150),grptipo C(10),grpvalor C(15),cantidad N(16,6),precio1 N(16,6),precio2 N(16,6),total1 N(16,6),total2 N(16,6))
*!*	*** Costo de Servicio
*!*	IF !EMPTY(pcOS_Type) AND !EMPTY(pcOS_Serie) AND !EMPTY(pcOS_Number) AND !EMPTY(pcOS_Item)
*!*		&& Abriendo Tablas
*!*		SELECT 0
*!*		lcTableName = pcOS_Type + "1"
*!*		USE (lcTableName) ORDER (lcTableName) ALIAS tOS1 AGAIN
*!*		SELECT 0
*!*		lcTableName = pcOS_Type + "2"
*!*		USE (lcTableName) ORDER (lcTableName) ALIAS tOS2 AGAIN
*!*		&&
*!*		SELECT tOS1
*!*		SEEK pcOS_Serie + pcOS_Number
*!*		IF FOUND() AND !tOS1.cod_anula
*!*			SELECT tOS2
*!*			SEEK pcOS_Serie + pcOS_Number + pcOS_Item
*!*			IF FOUND()
*!*				SELECT cCost
*!*				APPEND BLANK
*!*				REPLACE tipo WITH pcOS_Type
*!*				REPLACE serie WITH pcOS_Serie
*!*				REPLACE nrodoc WITH pcOS_Number
*!*				REPLACE item WITH pcOS_Item
*!*				REPLACE codigo WITH tOS1.cod_tipser
*!*				REPLACE descri WITH tOS1.des_tipser
*!*				REPLACE cantidad WITH 1
*!*				REPLACE precio1 WITH tOS2.precio_1
*!*				REPLACE precio2 WITH tOS2.precio_2
*!*				REPLACE total1 WITH cCost.cantidad * cCost.precio1
*!*				REPLACE total2 WITH cCost.cantidad * cCost.precio2
*!*			ENDIF
*!*		ENDIF
*!*		&& Cerrando Tablas
*!*		USE IN tOS1
*!*		USE IN tOS2
*!*		&&
*!*	ENDIF
*!*	***
*!*	*** Costo de Insumos
*!*	FOR lnI = 1 TO 2
*!*		&& Abriendo Tablas
*!*		DO CASE
*!*			CASE lnI = 1
*!*				lcTableSigla = "PARS"
*!*				lcFieldGroup = "nro_lote"
*!*			CASE lnI = 2
*!*				lcTableSigla = "NOTE"
*!*				lcFieldGroup = "cod_calid"
*!*		ENDCASE
*!*		SELECT 0
*!*		lcTableName = lcTableSigla + "1"
*!*		USE (lcTableName) ORDER docrel ALIAS tPS1 AGAIN
*!*		SELECT 0
*!*		lcTableName = lcTableSigla + "2"
*!*		USE (lcTableName) ORDER (lcTableName) ALIAS tPS2 AGAIN
*!*		&&
*!*		SELECT tPS1
*!*		SEEK pcPI_Type + pcPI_Serie + pcPI_Number
*!*		IF FOUND() AND tPS1.docrel_aut
*!*			SELECT tPS2
*!*			SEEK tPS1.serie + tPS1.nrodoc
*!*			SCAN WHILE serie + nrodoc = tPS1.serie + tPS1.nrodoc
*!*				IF tPS2.docrel_tip + tPS2.docrel_ser + tPS2.docrel_nro + tPS2.docrel_itm = pcPI_Type + pcPI_Serie + pcPI_Number + pcPI_Item
*!*					STORE 0 TO lnPrice1,lnPrice2
*!*					= PRECIO_PROMEDIO_KARDEX(IIF(lnI = 1,"IN","PT"),tPS1.fecha_reg,lcTableSigla,tPS1.serie,tPS1.nrodoc,tPS2.item,@lnPrice1,@lnPrice2)
*!*					SELECT cCost
*!*					APPEND BLANK
*!*					REPLACE tipo WITH lcTableSigla
*!*					REPLACE serie WITH tPS1.serie
*!*					REPLACE nrodoc WITH tPS1.nrodoc
*!*					REPLACE item WITH tPS2.item
*!*					REPLACE codigo WITH tPS2.cod_intemp
*!*					REPLACE descri WITH tPS2.des_articu
*!*					REPLACE grptipo WITH IIF(lnI = 1,"LOTE","CALIDAD")
*!*					REPLACE grpvalor WITH tPS2.&lcFieldGroup.
*!*					REPLACE cantidad WITH tPS2.cantidad/pnPI_Quantity
*!*					REPLACE precio1 WITH lnPrice1
*!*					REPLACE precio2 WITH lnPrice2
*!*					REPLACE total1 WITH cCost.cantidad * cCost.precio1
*!*					REPLACE total2 WITH cCost.cantidad * cCost.precio2
*!*				ENDIF
*!*			ENDSCAN
*!*		ENDIF
*!*		&& Cerrando Tablas
*!*		USE IN tPS1
*!*		USE IN tPS2
*!*		&&
*!*	ENDFOR
*!*	***
*!*	SELECT SUM(total1) AS costo1,SUM(total2) AS costo2 FROM cCost INTO CURSOR cTemp
*!*	pnVarPrice1 = cTemp.costo1
*!*	pnVarPrice2 = cTemp.costo2
*!*	USE
*!*	IF !EMPTY(pcCursorName)
*!*		SELECT * FROM cCost INTO CURSOR (pcCursorName)
*!*	ENDIF
*!*	USE IN cCost
*!*	SELECT(ln_Select)
*!*	RETURN

FUNCTION COSTO_PRODUCCION
PARAMETERS pcCursorName1,plUpdateCost,pcCursorName2
* Estructura de Cursor pcCursorName1 (Campos Obligatorios): tipo C(4),serie C(4),nrodoc C(10),item C(4)
* Estructura de Cursor pcCursorName1 (Campos Opcionales): precio1 N(16,6),precio2 N(16,6)
* pcCursorName2: Cursor donde se devuelve el detalle del Costo de Producción
pcCursorName2 = IIF(TYPE("pcCursorName2") = "C",pcCursorName2,"")
ln_Select = SELECT()
*** Abriendo Tablas
&& Parte de Ingreso
SELECT 0
USE pari1 ORDER pari1 ALIAS tpari1 AGAIN
SELECT 0
USE pari2 ORDER pari2 ALIAS tpari2 AGAIN
SELECT 0
USE noti1 ORDER noti1 ALIAS tnoti1 AGAIN
SELECT 0
USE noti2 ORDER noti2 ALIAS tnoti2 AGAIN
&&
&& Orden de Servicio
SELECT 0
USE ords1 ORDER ords1 ALIAS tords1 AGAIN
SELECT 0
USE ords2 ORDER ords2 ALIAS tords2 AGAIN
SELECT 0
USE nots1 ORDER nots1 ALIAS tnots1 AGAIN
SELECT 0
USE nots2 ORDER nots2 ALIAS tnots2 AGAIN
&&
&& Parte de Salida
SELECT 0
USE pars1 ORDER docrel ALIAS tpars1 AGAIN
SELECT 0
USE pars2 ORDER pars2 ALIAS tpars2 AGAIN
SELECT 0
USE note1 ORDER docrel ALIAS tnote1 AGAIN
SELECT 0
USE note2 ORDER note2 ALIAS tnote2 AGAIN
&&
CREATE CURSOR cCost(tipo C(4),serie C(4),nrodoc C(10),item C(4),codigo C(50),descri C(150),grptipo C(10),grpvalor C(15),cantidad N(16,6),precio1 N(16,6),precio2 N(16,6),total1 N(16,6),total2 N(16,6))
***
SELECT (pcCursorName1)
ln_Recno = RECNO()
SCAN
	lcTableNameParteIngreso1 = "t" + &pcCursorName1..tipo + "1"
	lcTableNameParteIngreso2 = "t" + &pcCursorName1..tipo + "2"
	SELECT (lcTableNameParteIngreso2)
	SEEK &pcCursorName1..serie + &pcCursorName1..nrodoc + &pcCursorName1..item
	IF FOUND() AND IIF(&pcCursorName1..tipo = "PARI",(&lcTableNameParteIngreso2..docrel_tip = "ORDS"),(&lcTableNameParteIngreso2..docrel_tip = "NOTS")) AND ;
		!EMPTY(&lcTableNameParteIngreso2..docrel_ser) AND !EMPTY(&lcTableNameParteIngreso2..docrel_nro) AND !EMPTY(&lcTableNameParteIngreso2..docrel_itm)
		ZAP IN cCost
		*** Costo de Servicio
		lcTableNameOrdenServicio1 = "t" + &lcTableNameParteIngreso2..docrel_tip + "1"
		lcTableNameOrdenServicio2 = "t" + &lcTableNameParteIngreso2..docrel_tip + "2"
		SELECT (lcTableNameOrdenServicio1)
		SEEK &lcTableNameParteIngreso2..docrel_ser + &lcTableNameParteIngreso2..docrel_nro
		IF FOUND() AND !&lcTableNameOrdenServicio1..cod_anula
			SELECT (lcTableNameOrdenServicio2)
			SEEK &lcTableNameParteIngreso2..docrel_ser + &lcTableNameParteIngreso2..docrel_nro + &lcTableNameParteIngreso2..docrel_itm
			IF FOUND()
				SELECT cCost
				APPEND BLANK
				REPLACE tipo WITH &lcTableNameParteIngreso2..docrel_tip
				REPLACE serie WITH &lcTableNameParteIngreso2..docrel_ser
				REPLACE nrodoc WITH &lcTableNameParteIngreso2..docrel_nro
				REPLACE item WITH &lcTableNameParteIngreso2..docrel_itm
				REPLACE codigo WITH &lcTableNameOrdenServicio1..cod_tipser
				REPLACE descri WITH &lcTableNameOrdenServicio1..des_tipser
				REPLACE cantidad WITH 1
				REPLACE precio1 WITH &lcTableNameOrdenServicio2..precio_1
				REPLACE precio2 WITH &lcTableNameOrdenServicio2..precio_2
				REPLACE total1 WITH cCost.cantidad * cCost.precio1
				REPLACE total2 WITH cCost.cantidad * cCost.precio2
			ENDIF
		ENDIF
		***
		*** Costo de Insumos
		FOR lnI = 1 TO 2
			DO CASE
				CASE lnI = 1
					lcTableSigla = "PARS"
					lcFieldGroup = "nro_lote"
				CASE lnI = 2
					lcTableSigla = "NOTE"
					lcFieldGroup = "cod_calid"
			ENDCASE
			lcTableNameParteSalida1 = "t" + lcTableSigla + "1"
			lcTableNameParteSalida2 = "t" + lcTableSigla + "2"
			SELECT (lcTableNameParteSalida1)
			SEEK &pcCursorName1..tipo + &pcCursorName1..serie + &pcCursorName1..nrodoc
			IF FOUND() AND &lcTableNameParteSalida1..docrel_aut
				SELECT (lcTableNameParteSalida2)
				SEEK &lcTableNameParteSalida1..serie + &lcTableNameParteSalida1..nrodoc
				SCAN WHILE serie + nrodoc = &lcTableNameParteSalida1..serie + &lcTableNameParteSalida1..nrodoc
					IF &lcTableNameParteSalida2..docrel_tip + &lcTableNameParteSalida2..docrel_ser + &lcTableNameParteSalida2..docrel_nro + &lcTableNameParteSalida2..docrel_itm = &pcCursorName1..tipo + &pcCursorName1..serie + &pcCursorName1..nrodoc + &pcCursorName1..item
						STORE 0 TO lnPrice1,lnPrice2
						= PRECIO_PROMEDIO_KARDEX(IIF(lnI = 1,"IN","PT"),&lcTableNameParteSalida1..fecha_reg,lcTableSigla,&lcTableNameParteSalida1..serie,&lcTableNameParteSalida1..nrodoc,&lcTableNameParteSalida2..item,@lnPrice1,@lnPrice2)
						SELECT cCost
						APPEND BLANK
						REPLACE tipo WITH lcTableSigla
						REPLACE serie WITH &lcTableNameParteSalida1..serie
						REPLACE nrodoc WITH &lcTableNameParteSalida1..nrodoc
						REPLACE item WITH &lcTableNameParteSalida2..item
						REPLACE codigo WITH &lcTableNameParteSalida2..cod_intemp
						REPLACE descri WITH &lcTableNameParteSalida2..des_articu
						REPLACE grptipo WITH IIF(lnI = 1,"LOTE","CALIDAD")
						REPLACE grpvalor WITH &lcTableNameParteSalida2..&lcFieldGroup.
						REPLACE cantidad WITH &lcTableNameParteSalida2..cantidad/&lcTableNameParteIngreso2..cantidad
						REPLACE precio1 WITH lnPrice1
						REPLACE precio2 WITH lnPrice2
						REPLACE total1 WITH cCost.cantidad * cCost.precio1
						REPLACE total2 WITH cCost.cantidad * cCost.precio2
					ENDIF
				ENDSCAN
			ENDIF
		ENDFOR
		***
		SELECT SUM(total1) AS costo1,SUM(total2) AS costo2 FROM cCost INTO CURSOR cTemp
		lnPrice_1 = cTemp.costo1
		lnPrice_2 = cTemp.costo2
		USE
		*** Devolver Costo de Producción
		IF TYPE(pcCursorName1 + ".precio1") != "U" OR TYPE(pcCursorName1 + ".precio2") != "U"
			SELECT (pcCursorName1)
			IF TYPE(pcCursorName1 + ".precio1") != "U"
				REPLACE precio1 WITH lnPrice_1
			ENDIF
			IF TYPE(pcCursorName1 + ".precio2") != "U"
				REPLACE precio2 WITH lnPrice_2
			ENDIF
		ENDIF
		*** Actualizar Costo de Producción
		IF plUpdateCost
			SELECT (lcTableNameParteIngreso1)
			SEEK &pcCursorName1..serie + &pcCursorName1..nrodoc
			IF !FOUND() OR &lcTableNameParteIngreso1..cod_anula OR !&lcTableNameParteIngreso1..ps_gene
				LOOP
			ENDIF
			*** Actualizando Costo de Producción en el Parte de Ingreso
			SELECT (lcTableNameParteIngreso2)
			= BLOQUEARECORD()
			REPLACE precio_1 WITH lnPrice_1
			REPLACE precio_2 WITH lnPrice_2
			UNLOCK
			***
			*** Abriendo Tabla de Kardex
			lcTableNameKardex = EXIST_FILE_KARDEX(IIF(&pcCursorName1..tipo = "PARI","IN","PT"),&lcTableNameParteIngreso1..fecha_reg)
			IF !EMPTY(lcTableNameKardex)
				SELECT 0
				USE (lcTableNameKardex) ORDER documento ALIAS ka2 AGAIN
			ENDIF
			***
			IF USED("ka2")
				*** Actualizando Costo de Producción en el Kardex
				SELECT ka2
				SEEK &pcCursorName1..tipo + &pcCursorName1..serie + &pcCursorName1..nrodoc + &pcCursorName1..item
				IF FOUND()
					= BLOQUEARECORD()
					REPLACE precom_sol WITH lnPrice_1
					REPLACE precom_dol WITH lnPrice_2
					REPLACE impsol_ing WITH ka2.cantid_ing * lnPrice_1
					REPLACE impdol_ing WITH ka2.cantid_ing * lnPrice_2
					&& Actualizando el Tipo de Cambio (El TC de la Cabecera del Documento es referencial)
					REPLACE tipcam_cod WITH "O"
					REPLACE tipcam_val WITH (ka2.impsol_ing / ka2.impdol_ing)
					&&
					UNLOCK
					ln_Record = RECNO("ka2")
					DO CASE
						CASE &pcCursorName1..tipo = "PARI"
							DO ACT_KAR WITH ka2.cod_articu,ka2.nro_lote,ln_Record
							DO ACT_KAR1 WITH ka2.cod_articu,ka2.cod_alma,ka2.nro_lote,ln_Record
						CASE &pcCursorName1..tipo = "NOTI"
							DO ACT_KAR_PT WITH ka2.cod_articu,ka2.cod_calid,ln_Record
							DO ACT_KAR_PT1 WITH ka2.cod_articu,ka2.cod_alma,ka2.cod_calid,ln_Record
					ENDCASE
				ENDIF
				***
			ENDIF
			*** Cerrando Tabla de Kardex
			USE IN IIF(USED("ka2"),SELECT("ka2"),0)
			***
		ENDIF
		***
	ENDIF
ENDSCAN
IF ln_Recno > 0
	GO ln_Recno
ENDIF
IF !EMPTY(pcCursorName2)
	SELECT * FROM cCost INTO CURSOR (pcCursorName2)
ENDIF
*** Cerrando Tablas
&& Parte de Ingreso
USE IN tpari1
USE IN tpari2
USE IN tnoti1
USE IN tnoti2
&&
&& Orden de Servicio
USE IN tords1
USE IN tords2
USE IN tnots1
USE IN tnots2
&&
&& Parte de Salida
USE IN tpars1
USE IN tpars2
USE IN tnote1
USE IN tnote2
&&
USE IN cCost
***
SELECT(ln_Select)
RETURN

FUNCTION OP_ITEM_INGRESO
PARAMETERS pcOP_Serie,pcOP_Number,pcOP_Item,pcCursorName
ln_Select_ = SELECT()
*** Abriendo Tablas
SELECT 0
USE ordp2 ORDER ordp2 ALIAS tOP2 AGAIN
SELECT 0
USE ordpftpro ORDER codigo ALIAS tOP_Pro AGAIN
SELECT 0
USE ordpftpro3 ORDER codigo ALIAS tOP_Pro3 AGAIN
SELECT 0
USE nots1 ORDER nots1 ALIAS tOS1 AGAIN
SELECT 0
USE nots2 ORDER seg_op ALIAS tOS2 AGAIN
SELECT 0
USE nots3 ORDER nots3 ALIAS tOS3 AGAIN
SELECT 0
USE noti1 ORDER noti1 ALIAS tPI1 AGAIN
SELECT 0
USE noti2 ORDER docrel ALIAS tPI2 AGAIN
CREATE CURSOR cOS2(serie C(4),nrodoc C(10),item C(4),cod_articu C(10),des_articu C(150),cod_intemp C(50),;
	cantsoli N(16,6),cantentr N(16,6),precio_1 N(16,6),precio_2 N(16,6))
CREATE CURSOR cOS2A(serie C(4),nrodoc C(10),item C(4),pi_serie C(4),pi_nrodoc C(10),pi_fecha D,pi_cantid N(16,6))
INDEX ON serie+nrodoc+item TAG codigo
***
*** Obteniendo último Proceso
&& El ultimo proceso debe tener como salida el Producto Terminado según O/P
lcProcess = ""
SELECT tOP2
SEEK pcOP_Serie + pcOP_Number + pcOP_Item
IF FOUND()
	SELECT tOP_Pro
	SEEK pcOP_Serie + pcOP_Number + tOP2.cod_articu
	SCAN WHILE serie + nrodoc + codigo = pcOP_Serie + pcOP_Number + tOP2.cod_articu
		SELECT tOP_Pro3
		SEEK pcOP_Serie + pcOP_Number + tOP2.cod_articu + tOP_Pro.item
		IF FOUND()
			lcProcess = tOP_Pro.item
		ENDIF
	ENDSCAN
ENDIF
***
*** Ordenes de Servicio del último Proceso
&& Las O/S del último proceso debe ser de tipo PT y ésta debe atender el Producto Terminado de la O/P, es decir, si en la O/P
&& dice 5 UND de Mantas, las O/S del último proceso debería arrojar 5 UND de Mantas
IF !EMPTY(lcProcess)
	SELECT tOS2
	SEEK pcOP_Serie + pcOP_Number + pcOP_Item
	SCAN WHILE ser_op + nro_op + itm_op = pcOP_Serie + pcOP_Number + pcOP_Item
		IF tOS2.tip_produc != "P"
			LOOP
		ENDIF
		SELECT tOS1
		SEEK tOS2.serie + tOS2.nrodoc
		IF !FOUND() OR tOS1.cod_anula
			LOOP
		ENDIF
		SELECT tOS3
		SEEK tOS2.serie + tOS2.nrodoc + tOS2.item + pcOP_Item + lcProcess
		IF FOUND()
			SELECT cOS2
			APPEND BLANK
			REPLACE serie WITH tOS2.serie
			REPLACE nrodoc WITH tOS2.nrodoc
			REPLACE item WITH tOS2.item
			REPLACE cod_articu WITH tOS2.cod_articu
			REPLACE des_articu WITH tOS2.des_articu
			REPLACE cod_intemp WITH tOS2.cod_intemp
			REPLACE cantsoli WITH tOS2.cantidad
			REPLACE precio_1 WITH tOS2.precio_1
			REPLACE precio_2 WITH tOS2.precio_2
		ENDIF
	ENDSCAN
ENDIF
***
*** Partes de Ingreso x Ordenes de Servicio
SELECT cOS2
SCAN
	SELECT tPI2
	SEEK "NOTS" + cOS2.serie + cOS2.nrodoc + cOS2.item
	SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = "NOTS" + cOS2.serie + cOS2.nrodoc + cOS2.item
		IF tPI2.tip_produc != "P"
			LOOP
		ENDIF
		SELECT tPI1
		SEEK tPI2.serie + tPI2.nrodoc
		IF !FOUND() OR tPI1.cod_anula
			LOOP
		ENDIF
		SELECT cOS2
		REPLACE cantentr WITH cOS2.cantentr + tPI2.cantidad
		***
		SELECT cOS2A
		APPEND BLANK
		REPLACE serie WITH cOS2.serie
		REPLACE nrodoc WITH cOS2.nrodoc
		REPLACE item WITH cOS2.item
		REPLACE pi_serie WITH tPI2.serie
		REPLACE pi_nrodoc WITH tPI2.nrodoc
		REPLACE pi_fecha WITH tPI1.fecha_reg
		REPLACE pi_cantid WITH tPI2.cantidad
		***
	ENDSCAN
ENDSCAN
***
SELECT cOS2
SUM cantentr TO lnReturnValue
IF TYPE("pcCursorName") = "C" AND !EMPTY(pcCursorName)
	SELECT * FROM cOS2A INTO CURSOR (pcCursorName)
ENDIF
*** Cerrando Tablas
USE IN tOP2
USE IN tOP_Pro
USE IN tOP_Pro3
USE IN tOS1
USE IN tOS2
USE IN tOS3
USE IN tPI1
USE IN tPI2
USE IN cOS2
USE IN cOS2A
***
SELECT(ln_Select_)
RETURN lnReturnValue

*!*	FUNCTION OP_ITEM_INGRESO
*!*	PARAMETERS pcOP_Serie,pcOP_Number,pcOP_Item,pcOP_Proceso,pcCursorName
*!*	ln_Select_ = SELECT()
*!*	*** Abriendo Tablas
*!*	SELECT 0
*!*	USE nots1 ORDER nots1 ALIAS tOS1 AGAIN
*!*	SELECT 0
*!*	USE nots2 ORDER seg_op ALIAS tOS2 AGAIN
*!*	SELECT 0
*!*	USE nots3 ORDER nots3 ALIAS tOS3 AGAIN
*!*	SELECT 0
*!*	USE noti1 ORDER noti1 ALIAS tPI1 AGAIN
*!*	SELECT 0
*!*	USE noti2 ORDER docrel ALIAS tPI2 AGAIN
*!*	CREATE CURSOR cOS2(serie C(4),nrodoc C(10),item C(4),cod_articu C(10),des_articu C(150),cod_intemp C(50),;
*!*		cantsoli N(16,6),cantentr N(16,6),precio_1 N(16,6),precio_2 N(16,6))
*!*	CREATE CURSOR cOS2A(serie C(4),nrodoc C(10),item C(4),pi_serie C(4),pi_nrodoc C(10),pi_fecha D,pi_cantid N(16,6))
*!*	INDEX ON serie+nrodoc+item TAG codigo
*!*	***
*!*	*** Ordenes de Servicio del Proceso
*!*	SELECT tOS2
*!*	SEEK pcOP_Serie + pcOP_Number + pcOP_Item
*!*	SCAN WHILE ser_op + nro_op + itm_op = pcOP_Serie + pcOP_Number + pcOP_Item
*!*		IF tOS2.tip_produc != "P"
*!*			LOOP
*!*		ENDIF
*!*		SELECT tOS1
*!*		SEEK tOS2.serie + tOS2.nrodoc
*!*		IF !FOUND() OR tOS1.cod_anula
*!*			LOOP
*!*		ENDIF
*!*		SELECT tOS3
*!*		SEEK tOS2.serie + tOS2.nrodoc + tOS2.item + pcOP_Item + pcOP_Proceso
*!*		IF FOUND()
*!*			SELECT cOS2
*!*			APPEND BLANK
*!*			REPLACE serie WITH tOS2.serie
*!*			REPLACE nrodoc WITH tOS2.nrodoc
*!*			REPLACE item WITH tOS2.item
*!*			REPLACE cod_articu WITH tOS2.cod_articu
*!*			REPLACE des_articu WITH tOS2.des_articu
*!*			REPLACE cod_intemp WITH tOS2.cod_intemp
*!*			REPLACE cantsoli WITH tOS2.cantidad
*!*			REPLACE precio_1 WITH tOS2.precio_1
*!*			REPLACE precio_2 WITH tOS2.precio_2
*!*		ENDIF
*!*	ENDSCAN
*!*	***
*!*	*** Partes de Ingreso x Ordenes de Servicio
*!*	SELECT cOS2
*!*	SCAN
*!*		SELECT tPI2
*!*		SEEK "NOTS" + cOS2.serie + cOS2.nrodoc + cOS2.item
*!*		SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = "NOTS" + cOS2.serie + cOS2.nrodoc + cOS2.item
*!*			IF tPI2.tip_produc != "P"
*!*				LOOP
*!*			ENDIF
*!*			SELECT tPI1
*!*			SEEK tPI2.serie + tPI2.nrodoc
*!*			IF !FOUND() OR tPI1.cod_anula
*!*				LOOP
*!*			ENDIF
*!*			SELECT cOS2
*!*			REPLACE cantentr WITH cOS2.cantentr + tPI2.cantidad
*!*			***
*!*			SELECT cOS2A
*!*			APPEND BLANK
*!*			REPLACE serie WITH cOS2.serie
*!*			REPLACE nrodoc WITH cOS2.nrodoc
*!*			REPLACE item WITH cOS2.item
*!*			REPLACE pi_serie WITH tPI2.serie
*!*			REPLACE pi_nrodoc WITH tPI2.nrodoc
*!*			REPLACE pi_fecha WITH tPI1.fecha_reg
*!*			REPLACE pi_cantid WITH tPI2.cantidad
*!*			***
*!*		ENDSCAN
*!*	ENDSCAN
*!*	***
*!*	SELECT cOS2
*!*	SUM cantentr TO lnReturnValue
*!*	IF TYPE("pcCursorName") = "C" AND !EMPTY(pcCursorName)
*!*		SELECT * FROM cOS2A INTO CURSOR (pcCursorName)
*!*	ENDIF
*!*	*** Cerrando Tablas
*!*	USE IN tOS1
*!*	USE IN tOS2
*!*	USE IN tOS3
*!*	USE IN tPI1
*!*	USE IN tPI2
*!*	USE IN cOS2
*!*	USE IN cOS2A
*!*	***
*!*	SELECT(ln_Select_)
*!*	RETURN lnReturnValue

FUNCTION OS_ITEM_INGRESO
PARAMETERS pcOS_Type,pcOS_Serie,pcOS_Number,pcOS_Item
ln_Select_ = SELECT()
*** Abriendo Tablas
lcTableNamePI = IIF(pcOS_Type = "ORDS","PARI","NOTI")
SELECT 0
lcTableName = lcTableNamePI + "1"
USE (lcTableName) ORDER (lcTableName) ALIAS tPI1 AGAIN
SELECT 0
lcTableName = lcTableNamePI + "2"
USE (lcTableName) ORDER docrel ALIAS tPI2 AGAIN
***
lnReturnValue = 0
*** Partes de Ingreso
SELECT tPI2
SEEK pcOS_Type + pcOS_Serie + pcOS_Number + pcOS_Item
SCAN WHILE docrel_tip+docrel_ser+docrel_nro+docrel_itm = pcOS_Type + pcOS_Serie + pcOS_Number + pcOS_Item
	SELECT tPI1
	SEEK tPI2.serie + tPI2.nrodoc
	IF !FOUND() OR tPI1.cod_anula
		LOOP
	ENDIF
	lnReturnValue = lnReturnValue + tPI2.cantidad
ENDSCAN
***
*** Cerrando Tablas
USE IN tPI1
USE IN tPI2
***
SELECT(ln_Select_)
RETURN lnReturnValue

*!*	FUNCTION CODIGO_DE_BARRA
*!*	PARAMETERS pcProductType,pcAliasName,pcFieldCodeProduct1,pcFieldCodeLotQuality,pcFieldCodeProduct2,pcFieldPrice
*!*	ln_Select = SELECT()
*!*	SET PROCEDURE TO FoxBarcode,gpImage2 ADDITIVE
*!*	DO CASE
*!*		CASE pcProductType = "IN"
*!*			lcProductType = "1"
*!*			lcTableProduct = "maesinsu"
*!*		CASE pcProductType = "PT"
*!*			lcProductType = "2"
*!*			lcTableProduct = "maesarti"
*!*	ENDCASE
*!*	SELECT 0
*!*	USE (lcTableProduct) ORDER codigo ALIAS article AGAIN	
*!*	CREATE CURSOR cLabel(descri C(150),precio C(12),imagen G)
*!*	loFbc = CREATEOBJECT("FoxBarcode")
*!*	SELECT (pcAliasName)
*!*	lnX = 0
*!*	lnY = RECCOUNT()
*!*	SCAN
*!*		lnX = lnX + 1
*!*		WAIT WINDOW "Preparando Etiquetas... " + BARRA(lnX,lnY) NOWAIT
*!*		= SEEK(ALLTRIM(EVALUATE(pcAliasName + "." + pcFieldCodeProduct1)),"article")
*!*		SELE cLabel
*!*		APPEND BLANK
*!*		lcCode1 = lcProductType + ALLTRIM(EVALUATE(pcAliasName + "." + pcFieldCodeProduct1)) + ALLTRIM(EVALUATE(pcAliasName + "." + pcFieldCodeLotQuality))
*!*		lcCode2 = ALLTRIM(EVALUATE(pcAliasName + "." + pcFieldCodeProduct2))
*!*		REPLACE descri WITH article.descri
*!*		REPLACE precio WITH EVALUATE(pcAliasName+ "." + pcFieldPrice)
*!*		APPEND GENERAL imagen FROM TIPO_DE_BARRA(2,lcCode1,lcCode2)
*!*	ENDSCAN
*!*	RELEASE loFbc
*!*	SET PROCEDURE TO LIBRARY
*!*	SELECT cLabel
*!*	GO TOP
*!*	WAIT WINDOW "Configurando Reporte... Espere un momento por favor." NOWAIT
*!*	DO CASE
*!*		CASE pcProductType = "IN"
*!*			lcReportName = "impcodbar"
*!*		CASE pcProductType = "PT"
*!*			lcReportName = "impcodbar"
*!*	ENDCASE
*!*	REPORT FORM &lcReportName. PREVIEW
*!*	REPORT FORM &lcReportName. NOCONSOLE TO PRINTER PROMPT
*!*	USE IN cLabel
*!*	USE IN article
*!*	SELECT(ln_Select)
*!*	RETURN

FUNCTION STOCK_DETALLE
PARAMETERS pc_Type_Article,pc_Code_Article,pc_Code_Store,pc_Code_OP,pd_Date,pc_Name_Cursor
ln_Select_Current = SELECT()
pc_Code_Article = IIF(TYPE("pc_Code_Article") = "C",pc_Code_Article,"")
pc_Code_Store = IIF(TYPE("pc_Code_Store") = "C",pc_Code_Store,"")
CREATE CURSOR cGrpStk(codigo C(15),saldo N(16,6))
INDEX ON codigo TAG codigo
IF !EMPTY(pc_Code_Article) AND !EMPTY(pd_Date)
	*** Abriendo Tablas
	ll_Used_kardex2 = USED("StockKard")
	IF !ll_Used_kardex2
		lcNameFile = "KAR" + pc_Type_Article + LEFT(DTOS(pd_Date),4)
		IF FILE(lcNameFile + ".DBF")
			SELECT 0
			USE (lcNameFile) ALIAS StockKard AGAIN
		ENDIF
	ENDIF
	***
	IF USED("StockKard")
		***
		IF EMPTY(pc_Code_Store)
			lcLabelOrder = "kardex2"
			lcLabelField = "cod_articu"
			lcLabelString1 = pc_Code_Article
			lcLabelString2 = pc_Code_Article
		ELSE
			lcLabelOrder = "stockart"
			lcLabelField = "cod_articu + cod_alma"
			lcLabelString1 = pc_Code_Article + pc_Code_Store
			lcLabelString2 = pc_Code_Article + pc_Code_Store
		ENDIF
		***
		*** Estableciendo Orden
		SELECT StockKard
		lc_Order_kardex2 = ORDER()
		SET ORDER TO &lcLabelOrder.
		***
		*** Obteniendo Saldo
		SELECT StockKard
		SEEK lcLabelString1
		SCAN WHILE &lcLabelField. = lcLabelString2
			IF StockKard.fecha_reg <= pd_Date
				ll_Sw = IIF(EMPTY(pc_Code_OP),.T.,(StockKard.cod_ordprd = pc_Code_OP))
				IF ll_Sw
					lcCode_Group = IIF(pc_Type_Article = "IN",StockKard.nro_lote,StockKard.cod_calid)
					lnQuantity = (StockKard.cantid_ing - StockKard.cantid_sal)
					SELE cGrpStk
					SEEK lcCode_Group
					IF !FOUND()
						INSERT INTO cGrpStk VALUES(lcCode_Group,lnQuantity)
					ELSE
						REPLACE saldo WITH cGrpStk.saldo + lnQuantity
					ENDIF
				ENDIF
			ENDIF
		ENDSCAN
		***
		*** Reestableciendo Orden
		SELECT StockKard
		IF !EMPTY(lc_Order_kardex2)
			SET ORDER TO &lc_Order_kardex2.
		ENDIF
		***
		*** Cerrando Tablas
		SELECT StockKard
		IF !ll_Used_kardex2
			USE
		ENDIF
		***
	ENDIF
ENDIF
IF !EMPTY(pc_Name_Cursor)
	SELECT * FROM cGrpStk WHERE saldo > 0 INTO CURSOR (pc_Name_Cursor)
ENDIF
USE IN cGrpStk
SELECT(ln_Select_Current)
RETURN

FUNCTION VERIFICAR_ORDEN_PEDIDO
PARAMETERS pcCursorDetail,pcNumber,pcMessage
lnSelect = SELECT()
*** Abriendo Tablas
SELECT 0
USE ords1 ORDER ords1 ALIAS osin1 AGAIN
SELECT 0
USE ords2 ORDER seg_op ALIAS osin2 AGAIN
SELECT 0
USE nots1 ORDER nots1 ALIAS ospt1 AGAIN
SELECT 0
USE nots2 ORDER seg_op ALIAS ospt2 AGAIN
***
llSw = .F.
*** Verificando si existe articulos en uso
SELECT item,des_articu,cod_intemp FROM (pcCursorDetail) INTO CURSOR curTemp
SCAN
	FOR lnI = 1 TO 2
		lcTableName1 = "OS" + IIF(lnI = 1,"IN","PT") + "1"
		lcTableName2 = "OS" + IIF(lnI = 1,"IN","PT") + "2"
		*** Orden de Requerimiento de Insumos
		SELECT (lcTableName2)
		SEEK pcNumber + curTemp.item
		SCAN WHILE ser_op + nro_op + itm_op = pcNumber + curTemp.item
			SELECT (lcTableName1)
			SEEK &lcTableName2..serie + &lcTableName2..nrodoc
			llSw = (FOUND() AND !&lcTableName1..cod_anula)
			IF llSw
				MESSAGEBOX("El Item " + curTemp.item + " se encuentra referenciado en la Orden de Servicio de " + IIF(lnI = 1,"Insumo","PT") + " " + ALLTRIM(&lcTableName1..serie) + "-" + ALLTRIM(&lcTableName1..nrodoc) + ".",0+48,pcMessage)
				EXIT
			ENDIF
		ENDSCAN
		***
		IF llSw
			EXIT
		ENDIF
	ENDFOR
	IF llSw
		EXIT
	ENDIF
ENDSCAN
USE
*** Cerrando Tablas
USE IN osin1
USE IN osin2
USE IN ospt1
USE IN ospt2
***
SELECT(lnSelect)
RETURN llSw

FUNCTION VERIFICAR_ORDEN_PEDIDO_ITEM
PARAMETERS pcNumber,pcItem,pcMessage
lnSelect = SELECT()
llSw = .F.
FOR lnX = 1 TO 2
	*** Abriendo Tablas
	DO CASE
		CASE lnX = 1
			lcTable = "ORDS"
		CASE lnX = 2
			lcTable = "NOTS"
	ENDCASE
	SELECT 0
	lcTableName = lcTable + "1"
	USE (lcTableName) ORDER (lcTableName) ALIAS os1 AGAIN
	SELECT 0
	lcTableName = lcTable + "2"
	USE (lcTableName) ORDER seg_op ALIAS os2 AGAIN
	***
	SELECT os2
	SEEK pcNumber + pcItem
	SCAN WHILE ser_op + nro_op + itm_op = pcNumber + pcItem
		SELECT os1
		SEEK os2.serie + os2.nrodoc
		llSw = (FOUND() AND !os1.cod_anula)
		IF llSw
			MESSAGEBOX("El Item esta referenciado en la Orden de Servicio de " + IIF(lnX = 1,"Insumo","PT") + " " + ALLTRIM(os1.serie) + "-" + ALLTRIM(os1.nrodoc) + ".",0+48,pcMessage)
			EXIT
		ENDIF
	ENDSCAN
	*** Cerrando Tablas
	USE IN os1
	USE IN os2
	***
	IF llSw
		EXIT
	ENDIF
ENDFOR
SELECT(lnSelect)
RETURN llSw

FUNCTION VERIFICAR_ORDEN_PEDIDO_FT
PARAMETERS pcNumOP
IF pcNumOP = "00-OS-OP"
	RETURN .T.
ENDIF
ln_Select = SELECT()
lcOP_Serie = PADR(PADL(SUBSTR(pcNumOP,1,2),3,"0"),4)
lcOP_Numero = PADL(SUBSTR(pcNumOP,4,5),10,"0")
*** Abriendo Tablas
SELECT 0
USE ordp1 ORDER ordp1 ALIAS tOp1 AGAIN
SELECT 0
USE ordp2 ORDER ordp2 ALIAS tOp2 AGAIN
SELECT 0
USE ordpftins ORDER codigo ALIAS tOp2Ins AGAIN
SELECT 0
USE ordpftpro ORDER codigo ALIAS tOp2Pro AGAIN
SELECT 0
USE ordpftpro3 ORDER codigo ALIAS tOp2Pro1 AGAIN
***
SELECT tOp1
SEEK lcOP_Serie + lcOP_Numero
llSw = FOUND()
IF tOp1.tipo_orden = 2 && Producción
	*SELECT tOp2
	*SEEK lcOP_Serie + lcOP_Numero
	*SCAN WHILE serie + nrodoc = lcOP_Serie + lcOP_Numero
	*	*** Ignorando el item anulado
	*	IF tOp2.activo = 0
	*		LOOP
	*	ENDIF
	*	***
	*	*** Validando que el Item tenga al menos 1 Insumo
	*	SELECT tOp2Ins
	*	SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu
	*	IF !FOUND()
	*		llSw = .F.
	*		EXIT
	*	ENDIF
	*	***
	*	*** Validando que el Item tenga un Proceso con Insumo
	*	SELECT tOp2Pro
	*	SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu
	*	IF FOUND()
	*		llSw1 = .F.
	*		SCAN WHILE serie + nrodoc + codigo = lcOP_Serie + lcOP_Numero + tOp2.cod_articu
	*			SELECT tOp2Pro1
	*			SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu + tOp2Pro.item
	*			IF FOUND()
	*				llSw1 = .T.
	*				EXIT
	*			ENDIF
	*		ENDSCAN
	*		llSw = llSw1
	*	ELSE
	*		llSw = .F.
	*	ENDIF
	*	IF !llSw
	*		EXIT
	*	ENDIF
	*	***
	*ENDSCAN
	
	llSw1 = .F.
	SELECT tOp2
	SEEK lcOP_Serie + lcOP_Numero
	SCAN WHILE serie + nrodoc = lcOP_Serie + lcOP_Numero
		*** Ignorando el item anulado
		IF tOp2.activo = 0
			LOOP
		ENDIF
		***
		*** Validando que el Item tenga al menos 1 Insumo
		SELECT tOp2Ins
		SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu
		llSw1 = FOUND()
		***
		IF llSw1
			*** Validando que el Item tenga un Proceso con Insumo
			SELECT tOp2Pro
			SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu
			llSw1 = FOUND()
			IF llSw1
				llSw1 = .F.
				SCAN WHILE serie + nrodoc + codigo = lcOP_Serie + lcOP_Numero + tOp2.cod_articu
					SELECT tOp2Pro1
					SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu + tOp2Pro.item
					llSw1 = FOUND()
					IF llSw1
						EXIT
					ENDIF
				ENDSCAN
			ENDIF
			***
		ENDIF
		IF llSw1
			EXIT
		ENDIF
	ENDSCAN
	llSw = llSw1
	
ENDIF
*** Cerrando Tablas
USE IN tOp1
USE IN tOp2
USE IN tOp2Ins
USE IN tOp2Pro
USE IN tOp2Pro1
***
SELECT(ln_Select)
RETURN llSw

FUNCTION VERIFICAR_ORDEN_PEDIDO_FT_ITEM
PARAMETERS pcNameCursor
lcValueReturn = ""
IF !USED(pcNameCursor) OR TYPE(pcNameCursor + ".numero") != "C" OR TYPE(pcNameCursor + ".item") != "C"
	RETURN lcValueReturn
ENDIF
ln_Select = SELECT()
*** Abriendo Tablas
SELECT 0
USE ordp1 ORDER ordp1 ALIAS tOp1 AGAIN
SELECT 0
USE ordp2 ORDER ordp2 ALIAS tOp2 AGAIN
SELECT 0
USE ordpftins ORDER codigo ALIAS tOp2Ins AGAIN
SELECT 0
USE ordpftpro ORDER codigo ALIAS tOp2Pro AGAIN
SELECT 0
USE ordpftpro3 ORDER codigo ALIAS tOp2Pro1 AGAIN
***
SELECT (pcNameCursor)
SCAN
	lcNumber = EVALUATE(pcNameCursor + ".numero")
	IF lcNumber = "00-OS-OP"
		LOOP
	ENDIF
	lcOP_Serie = PADR(PADL(SUBSTR(lcNumber,1,2),3,"0"),4)
	lcOP_Numero = PADL(SUBSTR(lcNumber,4,5),10,"0")
	lcOP_Item = EVALUATE(pcNameCursor + ".item")
	SELECT tOp1
	SEEK lcOP_Serie + lcOP_Numero
	IF tOp1.tipo_orden = 1 && Ignorando los que son de Muestra
		LOOP
	ENDIF
	SELECT tOp2
	SEEK lcOP_Serie + lcOP_Numero + lcOP_Item
	IF !FOUND()
		lcValueReturn = lcNumber + lcOP_Item && El Item No Existe
	ELSE
		IF tOp2.activo = 0
			lcValueReturn = lcNumber + lcOP_Item && El Item se encuentra Inactivo
		ELSE
			SELECT tOp2Ins
			SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu
			IF !FOUND()
				lcValueReturn = lcNumber + lcOP_Item && El Item NO tiene al menos 1 Insumo
			ELSE
				SELECT tOp2Pro
				SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu
				IF !FOUND()
					lcValueReturn = lcNumber + lcOP_Item && El Item NO tiene al menos 1 Proceso
				ELSE
					llSw = .F.
					SCAN WHILE serie + nrodoc + codigo = lcOP_Serie + lcOP_Numero + tOp2.cod_articu
						SELECT tOp2Pro1
						SEEK lcOP_Serie + lcOP_Numero + tOp2.cod_articu + tOp2Pro.item
						llSw = FOUND()
						IF llSw
							EXIT
						ENDIF
					ENDSCAN
					IF !llSw
						lcValueReturn = lcNumber + lcOP_Item && NO existe Proceso que al menos tenga 1 Insumo
					ENDIF
				ENDIF

			ENDIF
		ENDIF
	ENDIF
	IF !EMPTY(lcValueReturn)
		EXIT
	ENDIF
ENDSCAN
*** Cerrando Tablas
USE IN tOp1
USE IN tOp2
USE IN tOp2Ins
USE IN tOp2Pro
USE IN tOp2Pro1
***
SELECT(ln_Select)
RETURN lcValueReturn

FUNCTION ACTUALIZAR_ORDEN_COMPRA
PARAMETERS pcOC_Type,pcOC_Serie,pcOC_Number,pcOC_CursorName
* pcOC_Type = Tipo de Documento ("ORDC" o "NOTC")
* pcOC_Serie = Serie de Documento
* pcOC_Number = Número de Documento
* pcOC_CursorName = Nombre del Cursor que contiene el detalle del Documento a actualizar. Campos Obligatorios: item,precio_1,precio_2
ln_Select_Current = SELECT()
*** Abriendo Tablas
SELECT 0
lcOC_TableName = pcOC_Type + "1"
USE (lcOC_TableName) ORDER (lcOC_TableName) ALIAS tOC1 AGAIN
lcPI_Type = IIF(pcOC_Type = "ORDC","PARI","NOTI")
SELECT 0
lcPI_TableName = lcPI_Type + "1"
USE (lcPI_TableName) ORDER (lcPI_TableName) ALIAS tPI1 AGAIN
SELECT 0
lcPI_TableName = lcPI_Type + "2"
USE (lcPI_TableName) ORDER docrel ALIAS tPI2 AGAIN
***
*** Cursor para la actualización de Costos de Producción
lcCursorNameCP = SYS(2015)
CREATE CURSOR (lcCursorNameCP)(tipo C(4),serie C(4),nrodoc C(10),item C(4))
***
***
SELECT tOC1
SEEK pcOC_Serie + pcOC_Number
IF FOUND() AND !tOC1.cod_anula
	SELECT (pcOC_CursorName)
	SCAN
		SELECT tPI2
		SEEK pcOC_Type + pcOC_Serie + pcOC_Number + &pcOC_CursorName..item
		SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = pcOC_Type + pcOC_Serie + pcOC_Number + &pcOC_CursorName..item
			SELECT tPI1
			SEEK tPI2.serie + tPI2.nrodoc
			IF !FOUND() OR tPI1.cod_anula
				LOOP
			ENDIF
			= BLOQUEARECORD()
			REPLACE docrel_fec WITH tOC1.fecha_reg
			UNLOCK
			*** Tipo de Cambio
			lnTC_Code = tPI1.tipcam_cod
			lnTC_Value = 0
			= TIPO_CAMBIO_ACTUALIZAR("lnTC_Code","lnTC_Value",tPI1.cod_moti,tPI1.doccom2fec,tPI1.doccom1fec,tPI1.docrel_fec)
			&& Si Contabilidad NO tiene el TC se jala de Almacen
			IF lnTC_Value = 0
				= TIPO_CAMBIO_ACTUALIZAR("lnTC_Code","lnTC_Value",tPI1.cod_moti,tOC1.fecha_reg)
			ENDIF
			***
			lnPrice_1 = &pcOC_CursorName..precio_1
			lnPrice_2 = &pcOC_CursorName..precio_2
			DO CASE
				CASE tOC1.cod_mone = "SOL"
					lnPrice_2 = IIF(lnTC_Value > 0,ROUND(lnPrice_1/lnTC_Value,6),0)
				CASE tOC1.cod_mone = "DOL"
					lnPrice_1 = ROUND(lnPrice_2 * lnTC_Value,6)
			ENDCASE
			IF tPI2.precio_1 != lnPrice_1 OR tPI2.precio_2 != lnPrice_2
				SELECT tPI2
				= BLOQUEARECORD()
				REPLACE precio_1 WITH lnPrice_1
				REPLACE precio_2 WITH lnPrice_2
				UNLOCK
				INSERT INTO (lcCursorNameCP) VALUES(lcPI_Type,tPI2.serie,tPI2.nrodoc,tPI2.item)
			ENDIF
		ENDSCAN
	ENDSCAN
ENDIF
***
IF !EOF(lcCursorNameCP)
	= COSTO_PRODUCCION(lcCursorNameCP,.T.)
ENDIF
USE IN (lcCursorNameCP)
*** Cerrando Tablas
USE IN tOC1
USE IN tPI1
USE IN tPI2
***
SELECT(ln_Select_Current)
RETURN

FUNCTION ACTUALIZAR_ORDEN_SERVICIO
PARAMETERS pcOS_Type,pcOS_Serie,pcOS_Number,pcOS_CursorName
* pcOS_Type = Tipo de Documento ("ORDS" o "NOTS")
* pcOS_Serie = Serie de Documento
* pcOS_Number = Número de Documento
* pcOS_CursorName = Nombre del Cursor que contiene el detalle del Documento a actualizar. Campos Obligatorios: item,precio_1,precio_2
ln_Select_Current = SELECT()
*** Abriendo Tablas
SELECT 0
lcOC_TableName = pcOS_Type + "1"
USE (lcOC_TableName) ORDER (lcOC_TableName) ALIAS tOS1 AGAIN
lcPI_Type = IIF(pcOS_Type = "ORDS","PARI","NOTI")
SELECT 0
lcPI_TableName = lcPI_Type + "1"
USE (lcPI_TableName) ORDER (lcPI_TableName) ALIAS tPI1 AGAIN
SELECT 0
lcPI_TableName = lcPI_Type + "2"
USE (lcPI_TableName) ORDER docrel ALIAS tPI2 AGAIN
***
*** Cursor para la actualización de Costos de Producción
lcCursorNameCP = SYS(2015)
CREATE CURSOR (lcCursorNameCP)(tipo C(4),serie C(4),nrodoc C(10),item C(4))
***
***
SELECT tOS1
SEEK pcOS_Serie + pcOS_Number
IF FOUND() AND !tOS1.cod_anula
	SELECT (pcOS_CursorName)
	SCAN
		SELECT tPI2
		SEEK pcOS_Type + pcOS_Serie + pcOS_Number + &pcOS_CursorName..item
		SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = pcOS_Type + pcOS_Serie + pcOS_Number + &pcOS_CursorName..item
			SELECT tPI1
			SEEK tPI2.serie + tPI2.nrodoc
			IF !FOUND() OR tPI1.cod_anula
				LOOP
			ENDIF
			= BLOQUEARECORD()
			REPLACE docrel_fec WITH tOS1.fecha_reg
			UNLOCK
			*** Tipo de Cambio
			lnTC_Code = tPI1.tipcam_cod
			lnTC_Value = 0
			= TIPO_CAMBIO_ACTUALIZAR("lnTC_Code","lnTC_Value",tPI1.cod_moti,tPI1.doccom2fec,tPI1.doccom1fec,tPI1.docrel_fec)
			&& Si Contabilidad NO tiene el TC se jala de Almacen
			IF lnTC_Value = 0
				= TIPO_CAMBIO_ACTUALIZAR("lnTC_Code","lnTC_Value",tPI1.cod_moti,tOS1.fecha_reg)
			ENDIF
			***
			lnPrice_1 = &pcOS_CursorName..precio_1
			lnPrice_2 = &pcOS_CursorName..precio_2
			DO CASE
				CASE tOS1.cod_mone = "SOL"
					lnPrice_2 = IIF(lnTC_Value > 0,ROUND(lnPrice_1/lnTC_Value,6),0)
				CASE tOS1.cod_mone = "DOL"
					lnPrice_1 = ROUND(lnPrice_2 * lnTC_Value,6)
			ENDCASE
			*IF tPI2.precio_1 != lnPrice_1 OR tPI2.precio_2 != lnPrice_2
			*	SELECT tPI2
			*	= BLOQUEARECORD()
			*	REPLACE precio_1 WITH lnPrice_1
			*	REPLACE precio_2 WITH lnPrice_2
			*	UNLOCK
				INSERT INTO (lcCursorNameCP) VALUES(lcPI_Type,tPI2.serie,tPI2.nrodoc,tPI2.item)
			*ENDIF
		ENDSCAN
	ENDSCAN
ENDIF
***
IF !EOF(lcCursorNameCP)
	= COSTO_PRODUCCION(lcCursorNameCP,.T.)
ENDIF
USE IN (lcCursorNameCP)
*** Cerrando Tablas
USE IN tOS1
USE IN tPI1
USE IN tPI2
***
SELECT(ln_Select_Current)
RETURN

FUNCTION ACTUALIZAR_FT_ITEM
PARAMETERS pcOp_Serie,pcOp_Number,pcOp_Item
ln_Select = SELECT()
*** Abriendo Tabla
ll_Used = USED("tOp2")
IF !ll_Used
	SELECT 0
	USE ordp2 ORDER ordp2 ALIAS tOp2 AGAIN
ENDIF
***
SELECT tOp2
SEEK pcOp_Serie + pcOp_Number + pcOp_Item
IF FOUND()
	= BLOQUEARECORD()
	IF EMPTY(tOp2.ft_new_usu)
		REPLACE ft_new_usu WITH _Usuario
		REPLACE ft_new_fec WITH DATE()
		REPLACE ft_new_hor WITH TIME()
	ELSE
		REPLACE ft_mod_usu WITH _Usuario
		REPLACE ft_mod_fec WITH DATE()
		REPLACE ft_mod_hor WITH TIME()
	ENDIF
	UNLOCK
ENDIF
*** Cerrando Tabla
USE IN IIF(USED("tOp2") AND !ll_Used,SELECT("tOp2"),0)
***
SELECT(ln_Select)
RETURN

*FUNCTION EVALUAR
*PARAMETERS pnFilaActual
*lcMessage = ""
*FOR X = 1 TO 100
*	lnHeight = XLSheet.Rows(X).Height
*	IF lnHeight >= 1535
*		lcMessage = lcMessage + IIF(!EMPTY(lcMessage),CHR(13),"") + "FILA " + ALLTRIM(STR(X)) + ", ALTURA " + ALLTRIM(STR(lnHeight))
*	ENDIF
*ENDFOR
*IF !EMPTY(lcMessage)
*	WAIT WINDOW "FILA " + ALLTRIM(STR(pnFilaActual)) + " " + lcMessage
*ENDIF
*RETURN lcMessage

FUNCTION ESTADO_DOCUMENTO
PARAMETERS pcDocumentType,pcStateCode,pcOptionCode
ln_Select = SELECT()
*** Abriendo Tablas
SELECT 0
USE usuario ORDER prefij ALIAS user AGAIN
SELECT 0
USE maesesta ORDER codigo ALIAS state AGAIN
***
SELECT user
SEEK _usuario
*ll_Sw = (FOUND() AND !EMPTY(user.cargo))
ll_Sw = (FOUND() AND (_admin OR !EMPTY(user.cargo)))
IF ll_Sw
	SELECT state
	SEEK pcDocumentType + pcStateCode
	ll_Sw = (FOUND() AND (_admin OR !EMPTY(state.cargo)))
	IF ll_Sw
		*** Verificado si el Cargo del Usuario se encuentra Autorizado. Si el usuario es Administrador se ignora la validación
		ll_Sw = _admin
		IF !ll_Sw AND !EMPTY(state.cargo)
			lcPositionCode = ""
			FOR lnI = 1 TO LEN(ALLTRIM(state.cargo))
				lcPositionCode = lcPositionCode + SUBSTR(state.cargo,lnI,1)
				IF MOD(lnI,3) = 0
					ll_Sw = (lcPositionCode = user.cargo)
					lcPositionCode = ""
					IF ll_Sw
						EXIT
					ENDIF
				ENDIF
			ENDFOR
		ENDIF
		***
		IF ll_Sw
			*** Verificado si la Opción esta Habilitado
			lcOptionCode = ""
			ll_Sw = !EMPTY(state.opcion)
			IF ll_Sw
				FOR lnI = 1 TO LEN(ALLTRIM(state.opcion))
					lcOptionCode = lcOptionCode + SUBSTR(state.opcion,lnI,1)
					IF MOD(lnI,3) = 0
						ll_Sw = (lcOptionCode = pcOptionCode)
						lcOptionCode = ""
						IF ll_Sw
							EXIT
						ENDIF
					ENDIF
				ENDFOR
			ENDIF
			***
		ENDIF
	ENDIF
ENDIF
*** Cerrando Tablas
USE IN user
USE IN state
***
IF !ll_Sw
	MESSAGEBOX("El Estado del Documento NO permite esta operación.",0+16,"Acceso Denegado")
ENDIF
SELECT(ln_Select)
RETURN ll_Sw

FUNCTION ESTADO_DESCRIPCION
PARAMETERS pcDocumentType,pcStateCode
ln_Select_Current = SELECT()
lcStateName = ""
IF !EMPTY(pcDocumentType) AND !EMPTY(pcStateCode)
	SELECT 0
	USE maesesta ORDER codigo ALIAS state AGAIN
	SEEK pcDocumentType + pcStateCode
	lcStateName = ALLTRIM(state.descri)
	USE IN state
ENDIF
SELECT(ln_Select_Current)
RETURN lcStateName

FUNCTION ESTADO_CODIGO
PARAMETERS pcDocumentType
ln_Select_Current = SELECT()
lcStateCode = ""
IF !EMPTY(pcDocumentType)
	SELECT 0
	USE maesesta ORDER orden ALIAS state AGAIN
	SEEK pcDocumentType
	lcStateCode = ALLTRIM(state.codigo)
	USE IN state
ENDIF
SELECT(ln_Select_Current)
RETURN lcStateCode

FUNCTION MEMVAR_SET
PARAMETERS pl_Switch_On,pc_Alias_Name
ln_Select_Current = SELECT()
pc_Alias_Name = IIF(TYPE("pc_Alias_Name") = "C" AND !EMPTY(pc_Alias_Name),pc_Alias_Name,ALIAS())
IF !EMPTY(pc_Alias_Name)
	lnFieldCount = AFIELDS(lc_Array_Name,pc_Alias_Name)
	FOR ln_A = 1 TO lnFieldCount
		lc_Field_Name = "m." + lc_Array_Name(ln_A,1)
		IF TYPE(lc_Field_Name) != "U"
			RELEASE &lc_Field_Name.
		ENDIF
		IF pl_Switch_On && Establecer variable como Pública
			PUBLIC &lc_Field_Name.
		ENDIF
	ENDFOR
ENDIF
SELECT(ln_Select_Current)
RETURN

FUNCTION REPORTE_OC
PARAMETERS pcOC_Type,pcOC_Serie,pcOC_Number,pnPrint_Type,pcOC_State
pnPrint_Type = IIF(TYPE("pnPrint_Type") = "N",pnPrint_Type,1)
* pnPrint_Type: 1 = Vista previa, 2 = Impresión PDF
ln_Select = SELECT()
*** Abriendo Tablas
SELECT 0
lcTableName = pcOC_Type + "1"
USE (lcTableName) ORDER (lcTableName) ALIAS tDocu1 AGAIN
SELECT 0
lcTableName = pcOC_Type + "2"
USE (lcTableName) ORDER (lcTableName) ALIAS tDocu2 AGAIN
SELECT 0
USE usuario ORDER prefij ALIAS user AGAIN
SELECT 0
USE maesvari ORDER codigo ALIAS several AGAIN
SELECT 0
USE maesmoti ORDER codigo ALIAS motive AGAIN
SELECT 0
USE maesprov ORDER codigo ALIAS supplier AGAIN
SELECT 0
USE maesdist ORDER codigo ALIAS district AGAIN
***
lcReportCursor = SYS(2015)
SELECT tDocu1
AFIELDS(laStruc)
CREATE CURSOR (lcReportCursor) FROM ARRAY laStruc
*** Campos de Cabecera
ALTER TABLE (lcReportCursor) ADD COLUMN tipo C(4)
ALTER TABLE (lcReportCursor) ADD COLUMN des_mone C(10)
ALTER TABLE (lcReportCursor) ADD COLUMN des_moti C(100)

ALTER TABLE (lcReportCursor) ADD COLUMN des_auxi C(100)
ALTER TABLE (lcReportCursor) ADD COLUMN cod_ruc C(15)
ALTER TABLE (lcReportCursor) ADD COLUMN direc C(150)
ALTER TABLE (lcReportCursor) ADD COLUMN des_aten01 C(100)
ALTER TABLE (lcReportCursor) ADD COLUMN telef01 C(15)
ALTER TABLE (lcReportCursor) ADD COLUMN telef02 C(15)
ALTER TABLE (lcReportCursor) ADD COLUMN telef03 C(15)
ALTER TABLE (lcReportCursor) ADD COLUMN telef04 C(15)
ALTER TABLE (lcReportCursor) ADD COLUMN telef05 C(15)
ALTER TABLE (lcReportCursor) ADD COLUMN telef06 C(15)
ALTER TABLE (lcReportCursor) ADD COLUMN correo C(50)

ALTER TABLE (lcReportCursor) ADD COLUMN igv_porc N(12,4)
ALTER TABLE (lcReportCursor) ADD COLUMN subtotal1 N(12,4)
ALTER TABLE (lcReportCursor) ADD COLUMN subtotal2 N(12,4)
ALTER TABLE (lcReportCursor) ADD COLUMN impuesto1 N(12,4)
ALTER TABLE (lcReportCursor) ADD COLUMN impuesto2 N(12,4)
ALTER TABLE (lcReportCursor) ADD COLUMN total1 N(12,4)
ALTER TABLE (lcReportCursor) ADD COLUMN total2 N(12,4)

ALTER TABLE (lcReportCursor) ADD COLUMN son_letras C(200)
ALTER TABLE (lcReportCursor) ADD COLUMN usu_nombre C(30)
***
*** Campos de Detalle
ALTER TABLE (lcReportCursor) ADD COLUMN item C(4)
ALTER TABLE (lcReportCursor) ADD COLUMN cod_articu C(10)
ALTER TABLE (lcReportCursor) ADD COLUMN des_articu C(150)
ALTER TABLE (lcReportCursor) ADD COLUMN cod_intemp C(50)
ALTER TABLE (lcReportCursor) ADD COLUMN des_unimed C(50)
ALTER TABLE (lcReportCursor) ADD COLUMN cantidad N(16,6)
ALTER TABLE (lcReportCursor) ADD COLUMN precio_1 N(16,6)
ALTER TABLE (lcReportCursor) ADD COLUMN precio_2 N(16,6)
***
*** Preparando datos de la Cabecera
SELECT tDocu1
SEEK pcOC_Serie + pcOC_Number
SELECT user
SEEK tDocu1.new_usu
lcUserName = IIF(!EMPTY(user.nombre),DECODIFICA(user.nombre),"")
SELECT several
SEEK "MON" + tDocu1.cod_mone
SELE motive
SEEK "ING" + tDocu1.cod_moti
SELECT supplier
SEEK tDocu1.cod_auxi
SELECT district
SEEK supplier.distri
***
*** Detalle
STORE 0 TO lnTotal_1,lnTotal_2
SELECT tDocu2
SEEK pcOC_Serie + pcOC_Number
SCAN WHILE serie + nrodoc = pcOC_Serie + pcOC_Number
	SELECT (lcReportCursor)
	APPEND BLANK
	*** Información de Cabecera
	FOR lnI = 1 TO FCOUNT("tDocu1")
		lcFieldName = FIELD(lnI,"tDocu1")
		REPLACE &lcFieldName. WITH EVALUATE("tDocu1." + lcFieldName)
	ENDFOR
	REPLACE tipo WITH pcOC_Type
	REPLACE des_mone WITH ALLTRIM(several.descri)
	REPLACE des_moti WITH ALLTRIM(motive.descri)
	
	REPLACE des_auxi WITH supplier.descri
	REPLACE cod_ruc WITH supplier.cod_ruc
	REPLACE direc WITH supplier.direc + " " + ALLTRIM(district.descri)
	REPLACE des_aten01 WITH supplier.des_aten01
	REPLACE telef01 WITH supplier.telef01
	REPLACE telef02 WITH supplier.telef02
	REPLACE telef03 WITH supplier.telef03
	REPLACE telef04 WITH supplier.telef04
	REPLACE telef05 WITH supplier.telef05
	REPLACE telef06 WITH supplier.telef06
	REPLACE correo WITH supplier.correo

	REPLACE usu_nombre WITH lcUserName
	***
	*** Información de Detalle
	REPLACE item WITH tDocu2.item
	REPLACE cod_articu WITH tDocu2.cod_articu
	REPLACE des_articu WITH tDocu2.des_articu
	REPLACE cod_intemp WITH tDocu2.cod_intemp
	REPLACE des_unimed WITH tDocu2.des_unimed
	REPLACE cantidad WITH tDocu2.cantidad
	REPLACE precio_1 WITH tDocu2.precio_1
	REPLACE precio_2 WITH tDocu2.precio_2
	lnTotal_1 = lnTotal_1 + (tDocu2.cantidad * tDocu2.precio_1)
	lnTotal_2 = lnTotal_2 + (tDocu2.cantidad * tDocu2.precio_2)
	***
ENDSCAN
***
lnImpuesto_1 = IIF(tDocu1.inc_igv,lnTotal_1*(tDocu1.por_igv/100),0)
lnImpuesto_2 = IIF(tDocu1.inc_igv,lnTotal_2*(tDocu1.por_igv/100),0)
lcImporteLetras = UPPER(ALLTRIM(_letras(IIF(tDocu1.cod_mone = "SOL",lnTotal_1+lnImpuesto_1,lnTotal_2+lnImpuesto_2)))) + " " + ALLTRIM(several.descri)
SELECT (lcReportCursor)
REPLACE ALL subtotal1 WITH lnTotal_1
REPLACE ALL subtotal2 WITH lnTotal_2
REPLACE ALL impuesto1 WITH lnImpuesto_1
REPLACE ALL impuesto2 WITH lnImpuesto_2
REPLACE ALL total1 WITH lnTotal_1 + lnImpuesto_1
REPLACE ALL total2 WITH lnTotal_2 + lnImpuesto_2
REPLACE ALL son_letras WITH lcImporteLetras
GO TOP
DO CASE
	CASE pcOC_Type = "ORDC"
		lcReportName = "rf_oc_01"
	CASE pcOC_Type = "NOTC"
		lcReportName = "rf_nc_01"
ENDCASE
DO CASE
	CASE pnPrint_Type = 1 && Vista Previa
		REPORT FORM (lcReportName) PREVIEW
	CASE pnPrint_Type = 2 && PDF
		*oShell = CREATEOBJECT("WScript.Shell")
		*myDesktop = DIRECTORIO_PDF(oShell.SpecialFolders("Desktop"))
		lcPathPDF = READ_FILE_USER("WAYRA","PATH_PDF")
		IF !EMPTY(lcPathPDF)
			lcFilePDF = lcPathPDF + pcOC_Type + "-" + ALLTRIM(pcOC_Serie) + "-" + RIGHT(pcOC_Number,5) + ".pdf"
		ELSE
			lcFilePDF = PUTFILE("Archivo:",pcOC_Type + "-" + ALLTRIM(pcOC_Serie) + "-" + RIGHT(pcOC_Number,5),"PDF")
		ENDIF		
		IF !EMPTY(lcFilePDF)
		*	TRY
		*		DO reportpdf.app WITH "rf_oc_01.frx",myDesktop + "\OC-IN-" + ALLTRIM(m.serie) + "-" + RIGHT(m.nrodoc,5) + ".pdf",.F.,.T.,.T.,[]
				DO reportpdf.app WITH lcReportName,lcFilePDF,.F.,.T.,.T.,[]
		*		CATCH TO loError
		*		lcErr = [Error: ] + STR(loError.ERRORNO) + CHR(13) + [Linea: ] + STR(loError.LINENO) + CHR(13) + [Mensaje: ] + loError.MESSAGE
		*		FINALLY
		*		MESSAGEBOX("Fichero PDF Creado Correctamente en el Escritorio.")
		*	ENDTRY
			SET EXAC OFF
			SET DATE TO DMY
			*** Actualizar Estado el la cabecera del Documento
			SELECT tDocu1
			IF !EOF()
				lcOC_Estado = PADL(INT(VAL(tDocu1.estado)) + 1,3,"0")
				= BLOQUEARECORD()
				REPLACE estado WITH lcOC_Estado
				UNLOCK
				IF TYPE("pcOC_State") = "C"
					pcOC_State = lcOC_Estado
				ENDIF
			ENDIF
			***
		ENDIF
		*RELEASE oShell
ENDCASE
USE IN (lcReportCursor)
*** Cerrando Tablas
USE IN tDocu1
USE IN tDocu2
USE IN user
USE IN several
USE IN motive
USE IN supplier
USE IN district
***
SELECT(ln_Select)
RETURN

FUNCTION ESTADO_ACTUALIZAR
PARAMETERS pcDocumentType,pcDocumentSerie,pcDocumentNumber,pcStateCode,pcStateDescription
pcStateDescription = IIF(TYPE("pcStateDescription") = "C" AND !EMPTY(pcStateDescription),pcStateDescription,"")
ln_Select = SELECT()
*** Abriendo Tablas
SELECT 0
USE estado ALIAS state ORDER codigo DESC AGAIN
SELECT 0
lcTableName = pcDocumentType + "1"
USE (lcTableName) ORDER (lcTableName) ALIAS docu1 AGAIN
***
*** Obteniendo Código correlativo
SELECT state
SEEK pcDocumentType + pcDocumentSerie + pcDocumentNumber
lcNewCode = PADL(INT(VAL(state.codigo)) + 1,3,"0")
***
*** Actualizando Cabecera del Documento
SELECT docu1
SEEK pcDocumentSerie + pcDocumentNumber
IF FOUND()
	= BLOQUEARECORD()
	REPLACE estado WITH pcStateCode
	UNLOCK
	*** Registrando Estado
	SELECT state
	= BLOQUEAFILE()
	APPEND BLANK
	REPLACE tipo WITH pcDocumentType
	REPLACE serie WITH pcDocumentSerie
	REPLACE numero WITH pcDocumentNumber
	REPLACE codigo WITH lcNewCode
	REPLACE estado WITH pcStateCode
	REPLACE comentario WITH pcStateDescription
	REPLACE usuario WITH _usuario
	REPLACE fecha WITH DATE()
	REPLACE hora WITH TIME()
	UNLOCK
	***
ENDIF
***
*** Cerrando Tablas
USE IN state
USE IN docu1
***
SELECT(ln_Select)
RETURN