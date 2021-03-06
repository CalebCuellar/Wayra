PARAMETERS pc_Code_Article,pc_Code_Store,pc_Code_Quality,pn_Number_Record,pl_Delete_Record
ln_Select_Current = SELECT()
*** Abriendo Tablas
ll_Used_Store = USED("stock_pt")
IF !ll_Used_Store
	USE stock_pt IN 0 AGAIN
ENDIF
***
*** Cursor de Saldos por Almacen y Calidad
CREATE CURSOR cQuality(almacen C(3),codigo C(1),saldo N(16,6),peso N(16,6))
INDEX ON almacen+codigo TAG codigo
***
*** Estableciendo Orden
SELECT ka2
lc_Order_Kardex = ORDER()
SET ORDER TO STOCKART

SELECT stock_pt
lc_Order_Store = ORDER()
SET ORDER TO codigo
***
SELECT ka2
IF RECNO() # pn_Number_Record
	GO pn_Number_Record
ENDIF
*** Obteniendo Saldo
STORE 0 TO _salcan,_salimpsol,_salimpdol,_preprosol,_preprodol
ll_Empty_Quality = EMPTY(pc_Code_Quality)
IF ll_Empty_Quality
	pc_Code_Quality = ka2.cod_calid
ENDIF
_salpes = 0
*SELE ka2
*SKIP -1
*IF ka2.cod_articu = pc_Code_Article AND ka2.cod_alma = pc_Code_Store AND ka2.cod_calid = pc_Code_Quality AND !BOF()
*	_salcan = ka2.cantidsld
*	_salimpsol = ka2.impsolsld
*	_salimpdol = ka2.impdolsld
*	_preprosol = ka2.preprosol
*	_preprodol = ka2.preprodol
*ENDIF
&&
*IF ka2.cod_articu = pc_Code_Article AND ka2.cod_alma = pc_Code_Store AND !BOF()
*	_salimpsol = ka2.impsolsld
*	_salimpdol = ka2.impdolsld
*	_preprosol = ka2.preprosol
*	_preprodol = ka2.preprodol
*	IF ka2.cod_calid = pc_Code_Quality
*		_salcan = ka2.cantidsld
*	ENDIF
*ENDIF
&&
&& Recorriendo registros anteriores
lnCount = 0
DO WHILE .T.
	lnCount = lnCount + 1
	SELECT ka2
	SKIP -1
	IF ka2.cod_articu = pc_Code_Article AND ka2.cod_alma = pc_Code_Store AND !BOF()
		IF lnCount = 1
			_salcan = ka2.cantidsld && Saldo x Producto y Almacen
			_salimpsol = ka2.impsolsld
			_salimpdol = ka2.impdolsld
			_preprosol = ka2.preprosol
			_preprodol = ka2.preprodol
		ENDIF
		IF ka2.cod_calid = pc_Code_Quality
			&& Saldo x Producto, Almacen y Calidad
			SELECT cQuality
			SEEK ka2.cod_alma + ka2.cod_calid
			IF !FOUND()
				APPEND BLANK
				REPLACE almacen WITH ka2.cod_alma
				REPLACE codigo WITH ka2.cod_calid
				REPLACE saldo WITH ka2.cantid_sld
			ENDIF
			EXIT
			&&
		ENDIF
	ELSE
		EXIT
	ENDIF
ENDDO
&&
SELECT ka2
IF RECNO() # pn_Number_Record
	GO pn_Number_Record
ENDIF
***
*SCAN WHILE cod_articu + cod_alma + cod_calid = pc_Code_Article + pc_Code_Store + pc_Code_Quality
SCAN WHILE cod_articu + cod_alma = pc_Code_Article + pc_Code_Store
	*** Ignorando el registro a Eliminar
	IF pl_Delete_Record AND RECNO() = pn_Number_Record
		LOOP
	ENDIF
	***
	*** Actualizando Cantidad
	lnCantidad = (ka2.cantid_ing - ka2.cantid_sal)
	SELECT cQuality
	SEEK ka2.cod_alma + ka2.cod_calid
	IF FOUND()
		REPLACE saldo WITH cQuality.saldo + lnCantidad
		REPLACE peso WITH EVALUATE("cQuality.peso" + IIF(lnCantidad > 0,"+","-") + "ka2.peso_prod")
	ELSE
		IF ll_Empty_Quality
			APPEND BLANK
			REPLACE almacen WITH ka2.cod_alma
			REPLACE codigo WITH ka2.cod_calid
			REPLACE saldo WITH lnCantidad
			REPLACE peso WITH ka2.peso_prod * IIF(lnCantidad >= 0,1,-1)
		ENDIF
	ENDIF
	SELECT ka2
	IF !EOF("cQuality")
		REPLACE cantidsld WITH cQuality.saldo && Saldo x Producto, Calidad y Almacen
	ENDIF
	_salcan = _salcan + (ka2.cantid_ing - ka2.cantid_sal)
	***
	
	SELECT ka2
	*** Actualizando Saldo en Cantidad y Peso
	*lnCantidad = (ka2.cantid_ing - ka2.cantid_sal)
	*_salpes = EVALUATE("_salpes" + IIF(lnCantidad > 0,"+","-") + "ka2.peso_prod")
	*_salcan = _salcan + lnCantidad
	*REPLACE cantidsld WITH _salcan
	&&
	*IF ka2.cod_calid = pc_Code_Quality
	*	lnCantidad = (ka2.cantid_ing - ka2.cantid_sal)
	*	_salpes = EVALUATE("_salpes" + IIF(lnCantidad > 0,"+","-") + "ka2.peso_prod")
	*	_salcan = _salcan + lnCantidad
	*	REPLACE cantidsld WITH _salcan
	*ENDIF
	&&
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
*SELE stock_pt
*SEEK pc_Code_Article + pc_Code_Store + pc_Code_Quality
*= BLOQUEAFILE()
*IF !FOUND()
*	IF _salcan > 0
*		APPEND BLANK
*		REPLACE tip_produc WITH "P"
*		REPLACE cod_articu WITH pc_Code_Article
*		REPLACE cod_alma WITH pc_Code_Store
*		REPLACE cod_calid WITH pc_Code_Quality
*	ENDIF
*ELSE
*	IF _salcan <= 0
*		DELETE
*	ENDIF
*ENDIF
*IF _salcan > 0
*	REPLACE stock_arti WITH _salcan
*	REPLACE stock_peso WITH _salpes
*	REPLACE preprosol WITH _preprosol
*	REPLACE preprodol WITH _preprodol
*ENDIF
*UNLOCK
SELE cQuality
SCAN
	SELE stock_pt
	SEEK pc_Code_Article + cQuality.almacen + cQuality.codigo
	= BLOQUEAFILE()
	IF !FOUND()
		IF cQuality.saldo > 0
			APPEND BLANK
			REPLACE tip_produc WITH "P"
			REPLACE cod_articu WITH pc_Code_Article
			REPLACE cod_alma WITH cQuality.almacen
			REPLACE cod_calid WITH cQuality.codigo
		ENDIF
	ELSE
		IF cQuality.saldo <= 0
			DELETE
		ENDIF
	ENDIF
	IF cQuality.saldo > 0
		REPLACE stock_arti WITH cQuality.saldo
		REPLACE stock_peso WITH cQuality.peso
		REPLACE preprosol WITH _preprosol
		REPLACE preprodol WITH _preprodol
	ENDIF
	UNLOCK
ENDSCAN
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
SELECT stock_pt
IF !EMPTY(lc_Order_Store)
	SET ORDER TO &lc_Order_Store.
ENDIF
***
*** Cerrando Tablas
IF !ll_Used_Store
	USE IN stock_pt
ENDIF
***
USE IN cQuality
SELECT(ln_Select_Current)
RETURN