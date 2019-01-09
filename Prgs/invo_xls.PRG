lnSelect = SELECT()
oExcel = ''
oExcel = CREATEOBJECT("Excel.Application")
lcFileName = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","PROFORMA_INVOICE_20")
IF ISNULL(lcFileName) OR EMPTY(lcFileName)
	lcFileName = "proforma_invoice_20.xlsx"
ENDIF
lcFileType = SUBSTR(lcFileName,RAT(".",lcFileName)+1)
lcFileSource = _rt_sis_ + "\plantillas\" + lcFileName
lcFileTarget = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","EXCEL_TARGET")
IF ISNULL(lcFileTarget) OR EMPTY(lcFileTarget)
	MESSAGEBOX("No se ha definido la ubicación destino" + CHR(13) + "del archivo en la configuración.",0+48,"Exportar Proforma")
	RETURN
ENDIF
lcFileTarget = "'" + lcFileTarget + "\proforma_invoice." + lcFileType + "'"
COPY FILE &lcFileSource. TO &lcFileTarget.
lnRow = 0
xUbica_File = lcFileTarget
oExcel.WORKBOOKS.OPEN(&xUbica_File.)
XLS = oExcel.ACTIVESHEET
*** Cabecera
lnRow = 2
XLS.Cells(lnRow,6).Value = ALLTRIM(NCIA) + " "
lnRow = 3
XLS.Cells(lnRow,6).Value = ALLTRIM("R.U.C. : " + rcia) + " "
lnRow = 7
XLS.Cells(lnRow,4).Value = ": " + ALLTRIM(m.con_auxi) + " " &&+ ALLTRIM(m.razon_com)
lnRow = 8
XLS.Cells(lnRow,4).Value = ": " + ALLTRIM(m.des_auxi) + " RAZÓN COMERCIAL: " + ALLTRIM(m.razon_com)
XLS.Cells(lnRow,23).Value = ALLTRIM(m.codigo_opc) + " "
XLS.Cells(lnRow,28).Value = ": " + ALLTRIM(m.codigo_op) + " "
lnRow = 9
XLS.Cells(lnRow,4).Value = ": " + ALLTRIM(m.direc) + " "
XLS.Cells(lnRow,28).Value = ": " + DTOC(m.fecha_reg) + " "

SELE cSelShipTo
SCAN
	lnRow = lnRow + 1
	IF RECNO() = 1
		XLS.Cells(lnRow,28).Value = ": " + DTOC(m.fecha_ent) + " "
	ELSE
		XLS.Rows(ALLTRIM(STR(lnRow))).Insert
	ENDIF
	XLS.Cells(lnRow,4).Value = ": " + ALLTRIM(cSelShipTo.descri) + " "
ENDSCAN
lnRow = lnRow + 1
XLS.Cells(lnRow,4).Value = ": " + ALLTRIM(m.direc_bill) + " "
XLS.Cells(lnRow,28).Value = ": " + ALLTRIM(m.telef01) + " "
lnRow = lnRow + 1
XLS.Cells(lnRow,4).Value = ": " + ALLTRIM(m.des_vend) + " "
XLS.Cells(lnRow,28).Value = ": " + ALLTRIM(m.telef02) + " "
lnRow = lnRow + 2
XLS.Cells(lnRow,27).Value = "PRICE " + IIF(m.cod_mone = "DOL",_Dol_Simb,_Sol_Simb)
XLS.Cells(lnRow,29).Value = "PRICE " + IIF(m.cod_mone = "DOL",_Dol_Simb,_Sol_Simb)
XLS.Cells(lnRow,30).Value = IIF(m.cod_mone = "DOL",_Dol_Simb,_Sol_Simb)
***
*** Preparando Cursor
SELECT detalles
AFIELDS(laStruc)
CREATE CURSOR cProforma FROM ARRAY laStruc
APPEND FROM DBF("detalles") FOR activo = 1
ALTER TABLE cProforma ADD COLUMN blanco L
GO TOP IN detalles
IF RECCOUNT("cProforma") <= 15
	FOR I = 1 TO 15
		IF I > RECCOUNT("cProforma")
			SELE cProforma
			APPEND BLANK
			REPLACE blanco WITH .T.
		ENDIF
	ENDFOR
ENDIF
***
*** Insertando filas adicionales
lcFila = ALLTRIM(STR(lnRow + 2))
IF RECCOUNT("cProforma") > 15
	FOR X = 1 TO 2
		XLS.Rows(lcFila).Insert
		XLS.Range("C" + lcFila + ":F" + lcFila).Merge
		XLS.Range("G" + lcFila + ":H" + lcFila).Merge
		XLS.Range("I" + lcFila + ":O" + lcFila).Merge
		XLS.Range("P" + lcFila + ":V" + lcFila).Merge
		XLS.Range("W" + lcFila + ":X" + lcFila).Merge
	ENDFOR
	FOR X = 16 TO RECCOUNT("cProforma")
		XLS.Rows(lcFila).Insert
		XLS.Range("C" + lcFila + ":F" + lcFila).Merge
		XLS.Range("G" + lcFila + ":H" + lcFila).Merge
		XLS.Range("I" + lcFila + ":O" + lcFila).Merge
		XLS.Range("P" + lcFila + ":V" + lcFila).Merge
		XLS.Range("W" + lcFila + ":X" + lcFila).Merge
	ENDFOR
ENDIF
***
*** Mostrando Detalle
SELECT cProforma
SCAN
	lnRow = lnRow + 1
	IF !cProforma.blanco
		XLS.Cells(lnRow,2).Value = "'" + ALLTRIM(cProforma.item) + " "
		XLS.Cells(lnRow,3).Value = ALLTRIM(cProforma.cod_intemp) + " "
		XLS.Cells(lnRow,7).Value = ALLTRIM(cProforma.cod_intcli) + " "
		XLS.Cells(lnRow,9).Value = ALLTRIM(cProforma.des_articu) + " "
		XLS.Cells(lnRow,16).Value = ALLTRIM(cProforma.des_artcli) + " "
		*IF m.i_exterior = 0
		*	XLS.Cells(lnRow,16).Value = ALLTRIM(prn_arti.descri) + " "
		*ELSE
		*	XLS.Cells(lnRow,16).Value = ALLTRIM(prn_arti.descri_ext) + " "
		*ENDIF
		XLS.Cells(lnRow,23).Value = ALLTRIM(cProforma.des_colcli) + " "
		XLS.Cells(lnRow,26).Value = cProforma.cantidad
		XLS.Cells(lnRow,27).Value = IIF(m.cod_mone = "SOL",cProforma.precio_1,cProforma.precio_2) &&cProforma.precio_1
		XLS.Cells(lnRow,28).Value = cProforma.val_extcha
		*XLS.Cells(lnRow,030).Value = (cProforma.precio_1 * cProforma.cantidad) + cProforma.val_extcha
		*** Formula de la sumatoria de los precios unitarios
		lcColumna = EXCEL_COLUMN(29) + ALLTRIM(STR(lnRow)) && "AC"
		XLS.Cells.Range(lcColumna).Select
		XLS.Cells.Range(lcColumna).FormulaR1C1 = "=+(RC[-2]+RC[-1])"
		*** Formula de la sumatoria de los precios unitario y unidades
		lcColumna = EXCEL_COLUMN(31) + ALLTRIM(STR(lnRow)) && "AE"
		XLS.Cells.Range(lcColumna).Select
		XLS.Cells.Range(lcColumna).FormulaR1C1 = "=+RC[-2]*RC[-5]"
		***
	ENDIF
ENDSCAN
USE
***
*** Pie de Página
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto01) + " "
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto02) + " "
XLS.Cells(lnRow,15).Value = ALLTRIM(m.bc_texto01) + " "
IF m.i_impuesto = 1
	XLS.Cells(lnRow,20).Value = 0.18
ELSE
	XLS.Cells(lnRow,20).Value = 0
ENDIF
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto03) + " "
XLS.Cells(lnRow,15).Value = ALLTRIM(m.bc_texto02) + " "
XLS.Cells(lnRow,31).Value = _totrece7
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto04) + " "
XLS.Cells(lnRow,15).Value = ALLTRIM(m.bc_texto03) + " "
XLS.Cells(lnRow,31).Value = _totrece8
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto05) + " "
XLS.Cells(lnRow,15).Value = ALLTRIM(m.bc_texto04) + " "
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto06) + " "
XLS.Cells(lnRow,15).Value = ALLTRIM(m.bc_texto05) + " "
XLS.Cells(lnRow,20).Value = _totrece4
XLS.Cells(lnRow,27).Value = STR(_totrece4,6,2)+" % Payment in Advance :"
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto07) + " "
XLS.Cells(lnRow,15).Value = ALLTRIM(m.bc_texto06) + " "
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto08) + " "
XLS.Cells(lnRow,15).Value = ALLTRIM(m.extra_char)+" "
XLS.Cells(lnRow,21).Value = ALLTRIM(m.con_auxi)+" "
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto09) + " "
XLS.Cells(lnRow,21).Value = ALLTRIM(m.des_auxi)+" "
lnRow = lnRow + 1
XLS.Cells(lnRow,2).Value = ALLTRIM(m.fp_texto10) + " "
****
XLS.Cells.Range("A1").Select
oExcel.Visible = .T.
RELEASE oExcel
SELECT(lnSelect)