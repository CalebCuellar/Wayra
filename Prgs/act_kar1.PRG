PARAMETERS pc_Code_Article,pc_Code_Store,pc_Number_Lot,pn_Number_Record,pl_Delete_Record
ln_Select_Current = SELECT()
*** Abriendo Tablas
ll_Used_Store = USED("stockart")
IF !ll_Used_Store
	USE stockart IN 0 AGAIN
ENDIF
***
*** Estableciendo Orden
SELECT ka2
lc_Order_Kardex = ORDER()
SET ORDER TO STOCKART

SELECT stockart
lc_Order_Store = ORDER()
SET ORDER TO codigo
***
SELECT ka2
IF RECNO() # pn_Number_Record
	GO pn_Number_Record
ENDIF
*** Obteniendo Saldo
STORE 0 TO _salcan,_salimpsol,_salimpdol,_preprosol,_preprodol
_salcon = 0
SELE ka2
SKIP -1
IF ka2.cod_articu = pc_Code_Article AND ka2.cod_alma = pc_Code_Store AND ka2.nro_lote = pc_Number_Lot AND !BOF()
	_salcan = ka2.cantidsld
	_salimpsol = ka2.impsolsld
	_salimpdol = ka2.impdolsld
	_preprosol = ka2.preprosol
	_preprodol = ka2.preprodol
ENDIF
IF RECNO() # pn_Number_Record
	GO pn_Number_Record
ENDIF
***
SCAN WHILE cod_articu + cod_alma + nro_lote = pc_Code_Article + pc_Code_Store + pc_Number_Lot
	*** Ignorando el registro a Eliminar
	IF pl_Delete_Record AND RECNO() = pn_Number_Record
		LOOP
	ENDIF
	***
	SELECT ka2
	*** Actualizando Saldo en Cantidad y Cono
	lnCantidad = (ka2.cantid_ing - ka2.cantid_sal)
	_salcon = EVALUATE("_salcon" + IIF(lnCantidad > 0,"+","-") + "ka2.cant_conos")
	_salcan = _salcan + lnCantidad
	REPLACE cantidsld WITH _salcan
	***
	IF ka2.rad_moti = "SAL"
		*** Precio Promedio del �ltimo Ingreso
		REPLACE preprosol WITH _preprosol
		REPLACE preprodol WITH _preprodol
		***
		REPLACE impsolsal WITH _preprosol * (ka2.cantid_ing + ka2.cantid_sal)
		REPLACE impdolsal WITH _preprodol * (ka2.cantid_ing + ka2.cantid_sal)
	ENDIF
	*** Actualizando Saldo en Soles y Dolares
	_salimpsol = _salimpsol + (ka2.impsol_ing - ka2.impsolsal)
	_salimpdol = _salimpdol + (ka2.impdol_ing - ka2.impdolsal)
	REPLACE impsolsld WITH _salimpsol
	REPLACE impdolsld WITH _salimpdol
	***
	*** Solo los Ingresos alteran el Precio Promedio
	IF ka2.rad_moti = "ING"
		*** Calculando Precio Promedio en Soles y Dolares
		_preprosol = IIF(_salcan != 0 AND _salimpsol != 0,ROUND(_salimpsol / _salcan,6),0)
		_preprodol = IIF(_salcan != 0 AND _salimpdol != 0,ROUND(_salimpdol / _salcan,6),0)
		***
		*** Actualizando Precio Promedio en Soles y Dolares
		&& CCP 30/04/2010 Esta correcion se hizo porque extra�amente en algunos casos aunque el monto es 0 lo
		&& considera como un valor 7.213232321E75+, pero si en el depurador lo igualamos a 0 da como .T. es por
		&& eso que cuando es 0 lo forzamos a que seo cero sin ningun decimal
		_preprosol = IIF(_preprosol # 0,_preprosol,0)
		_preprodol = IIF(_preprodol # 0,_preprodol,0)
		REPLACE preprosol WITH _preprosol
		REPLACE preprodol WITH _preprodol
		***
	ENDIF
	***
ENDSCAN
SELE ka2
IF RECNO() # pn_Number_Record
	GO pn_Number_Record
ENDIF
*** Actualizando Stock
SELE stockart
SEEK pc_Code_Article + pc_Code_Store + pc_Number_Lot
= BLOQUEAFILE()
IF !FOUND()
	IF _salcan > 0
		APPEND BLANK
		REPLACE tip_produc WITH "P"
		REPLACE cod_articu WITH pc_Code_Article
		REPLACE cod_alma WITH pc_Code_Store
		REPLACE nro_lote WITH pc_Number_Lot
	ENDIF
ELSE
	IF _salcan <= 0
		DELETE
	ENDIF
ENDIF
IF _salcan > 0
	REPLACE stock_arti WITH _salcan
	REPLACE stock_cono WITH _salcon
	REPLACE preprosol WITH _preprosol
	REPLACE preprodol WITH _preprodol
ENDIF
UNLOCK
***
*** Eliminando registro
IF pl_Delete_Record
	SELE ka2
	GO pn_Number_Record
	= BLOQUEARECORD()
	DELETE
	UNLOCK
ENDIF
***
*** Reestableciendo Orden
SELECT ka2
IF !EMPTY(lc_Order_Kardex)
	SET ORDER TO &lc_Order_Kardex.
ENDIF
SELECT stockart
IF !EMPTY(lc_Order_Store)
	SET ORDER TO &lc_Order_Store.
ENDIF
***
*** Cerrando Tablas
IF !ll_Used_Store
	USE IN stockart
ENDIF
***
SELECT(ln_Select_Current)
RETURN