PARAMETERS pcProductType,pcCursorName
* pcCursorName: Nombre del Cursor que contiene los c�digos a imprimir. Debe tener los campos (codigo,descri,grupo,op,almacen,precio,cantidad)
ln_Select = SELECT()
SET PROCEDURE TO FoxBarcode,gpImage2 ADDITIVE
DO CASE
	CASE pcProductType = "IN"
		lcProductType = "1"
	CASE pcProductType = "PT"
		lcProductType = "2"
ENDCASE
CREATE CURSOR cLabel(codigo C(15),descri C(150),cod_intemp C(50),grupo C(15),op C(8),almacen C(3),almacen1 C(1),precio C(12),barra C(50),imagen G)
loFbc = CREATEOBJECT("FoxBarcode")
SELECT (pcCursorName)
lnX = 0
lnY = RECCOUNT()
SCAN
	lnX = lnX + 1
	WAIT WINDOW "Preparando Etiquetas... " + BARRA(lnX,lnY) NOWAIT
	FOR lnI = 1 TO &pcCursorName..cantidad
		SELE cLabel
		APPEND BLANK
		REPLACE codigo WITH &pcCursorName..codigo
		*REPLACE descri WITH ALLTRIM(&pcCursorName..cod_intemp) + CHR(13) + ALLTRIM(&pcCursorName..descri)
		REPLACE descri WITH ALLTRIM(&pcCursorName..cod_intemp) + CHR(13) + LEFT(ALLTRIM(&pcCursorName..descri),90)
		REPLACE cod_intemp WITH &pcCursorName..cod_intemp
		REPLACE grupo WITH &pcCursorName..grupo
		REPLACE op WITH &pcCursorName..op
		REPLACE almacen WITH &pcCursorName..almacen
		REPLACE almacen1 WITH &pcCursorName..almacen1
		lcNumOP = &pcCursorName..op
		IF lcNumOP = "00-OS-OP"
			lcNumOP = "0000000"
		ELSE
			lcNumOP = SUBSTR(cLabel.op,1,2) + SUBSTR(cLabel.op,4,5)
		ENDIF
		REPLACE precio WITH &pcCursorName..precio
		REPLACE barra WITH lcProductType + ALLTRIM(cLabel.codigo) + lcNumOP + ALLTRIM(cLabel.grupo) + cLabel.almacen
		APPEND GENERAL imagen FROM TIPO_DE_BARRA(4,ALLTRIM(cLabel.barra),ALLTRIM(cLabel.cod_intemp))
	ENDFOR
ENDSCAN
RELEASE loFbc
SET PROCEDURE TO LIBRARY
SELECT cLabel
GO TOP
WAIT WINDOW "Configurando Reporte... Espere un momento por favor." NOWAIT
DO CASE
	CASE pcProductType = "IN"
		lcReportName = "impcodbar1.lbx"
	CASE pcProductType = "PT"
		lcReportName = "impcodbar1.lbx"
ENDCASE
REPORT FORM &lcReportName. PREVIEW
REPORT FORM &lcReportName. NOCONSOLE TO PRINTER PROMPT
USE IN cLabel
SELECT(ln_Select)
RETURN

FUNCTION TIPO_DE_BARRA
PARAMETERS pnTypeBar,pcCode1,pcCode2
DO CASE
	CASE pnTypeBar = 1
		oImageBar = loFbc.BarcodeImage(pcCode1,,[cSet128 = "*",nBarcodeType = 110,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 2
		oImageBar = loFbc.BarcodeImage(pcCode1,,[cSet128 = "A",nBarcodeType = 110,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 3
		oImageBar = loFbc.BarcodeImage(pcCode1,,[cSet128 = "B",nBarcodeType = 110,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 4
		oImageBar = loFbc.BarcodeImage(pcCode1,,[cSet128 = "C",nBarcodeType = 110,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 5
		oImageBar = loFbc.BarcodeImage(pcCode1,,[nBarcodeType = 120,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 6
		oImageBar = loFbc.BarcodeImage(pcCode1,,[nBarcodeType = 121,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 7
		oImageBar = loFbc.BarcodeImage(pcCode1,,[nBarcodeType = 122,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 8
		oImageBar = loFbc.BarcodeImage(pcCode1,,[nBarcodeType = 123,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 9
		oImageBar = loFbc.BarcodeImage(pcCode1,,[nBarcodeType = 151,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 10
		oImageBar = loFbc.BarcodeImage(pcCode1,,[nBarcodeType = 161,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 11
		oImageBar = loFbc.BarcodeImage(pcCode1,,[nBarcodeType = 170,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 12
		oImageBar = loFbc.BarcodeImage(pcCode1,,[nBarcodeType = 173,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
	CASE pnTypeBar = 13
		oImageBar = loFbc.BarcodeImage(pcCode1,,[cImageType = "BMP",cSet128 = "C",nBarcodeType = 110,nBarsColor = 8404992,nFontColor = 8404992,nBackColor = 16777215,nImageHeight = 60, cHumanReadableTextWayra = pcCode2])
ENDCASE
RETURN oImageBar