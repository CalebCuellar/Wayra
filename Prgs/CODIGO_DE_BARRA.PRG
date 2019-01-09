PARAMETERS pcProductType,pcCursorName,plShowPrice,pcCurrencyCode
* pcCursorName: Nombre del Cursor que contiene los códigos a imprimir. Debe tener los campos (codigo,grupo,op,cantidad)
pcCurrencyCode = IIF(TYPE("pcCurrencyCode") = "C" AND INLIST(pcCurrencyCode,"SOL","DOL"),pcCurrencyCode,"")
ln_Select = SELECT()
SET PROCEDURE TO FoxBarcode,gpImage2 ADDITIVE
DO CASE
	CASE pcProductType = "IN"
		lcProductType = "1"
		lcTableProduct = "maesinsu"
	CASE pcProductType = "PT"
		lcProductType = "2"
		lcTableProduct = "maesarti"
ENDCASE
SELECT 0
USE (lcTableProduct) ORDER codigo ALIAS article AGAIN
*** Moneda
lcCurencySymbol = ""
IF plShowPrice AND !EMPTY(pcCurrencyCode)
	ll_Used = USED("maesvari")
	SELECT valvar_01 FROM maesvari WHERE radical + codigo = "MON" + pcCurrencyCode INTO CURSOR cTemp
	lcCurencySymbol = ALLTRIM(cTemp.valvar_01)
	USE
	USE IN IIF(USED("maesvari") AND !ll_Used,SELECT("maesvari"),0)
ENDIF
***
CREATE CURSOR cLabel(codigo C(15),descri C(150),cod_intemp C(50),grupo C(15),op C(8),precio C(12),barra C(50),imagen G)
loFbc = CREATEOBJECT("FoxBarcode")
SELECT (pcCursorName)
lnX = 0
lnY = RECCOUNT()
SCAN
	lnX = lnX + 1
	WAIT WINDOW "Preparando Etiquetas... " + BARRA(lnX,lnY) NOWAIT
	= SEEK(ALLTRIM(EVALUATE(pcCursorName + ".codigo")),"article")
	FOR lnI = 1 TO &pcCursorName..cantidad
		SELE cLabel
		APPEND BLANK
		REPLACE codigo WITH &pcCursorName..codigo
		REPLACE descri WITH ALLTRIM(article.cod_intemp) + CHR(13) + ALLTRIM(article.descri)
		REPLACE cod_intemp WITH article.cod_intemp
		REPLACE grupo WITH &pcCursorName..grupo
		REPLACE op WITH &pcCursorName..op
		lcNumOP = &pcCursorName..op
		IF lcNumOP = "00-OS-OP"
			lcNumOP = "0000000"
		ELSE
			lcNumOP = SUBSTR(cLabel.op,1,2) + SUBSTR(cLabel.op,4,5)
		ENDIF
		lcPrice = ""
		IF plShowPrice
			DO CASE
				CASE pcCurrencyCode = "SOL"
					*lcPrice = STR(article.)
				CASE pcCurrencyCode = "DOL"
					*lcPrice = STR(article.)
			ENDCASE
		ENDIF
		REPLACE precio WITH lcCurencySymbol + " " + lcPrice
		*REPLACE barra WITH lcProductType + ALLTRIM(cLabel.codigo) + SUBSTR(cLabel.op,1,2) + SUBSTR(cLabel.op,4,5) + ALLTRIM(cLabel.grupo)
		REPLACE barra WITH lcProductType + ALLTRIM(cLabel.codigo) + lcNumOP + ALLTRIM(cLabel.grupo)
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
		lcReportName = "impcodbar.lbx"
	CASE pcProductType = "PT"
		lcReportName = "impcodbar.lbx"
ENDCASE
REPORT FORM &lcReportName. PREVIEW
REPORT FORM &lcReportName. NOCONSOLE TO PRINTER PROMPT
USE IN cLabel
USE IN article
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