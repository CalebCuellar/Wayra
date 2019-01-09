PARAMETERS pc_Code_Article,pc_Code_Quality,pn_Number_Record,pl_Delete_Record,pc_Name_Cursor_CP,pc_Code_Motive_CP
pc_Name_Cursor_CP = IIF(TYPE("pc_Name_Cursor_CP") = "C",pc_Name_Cursor_CP,"")
pc_Code_Motive_CP = IIF(TYPE("pc_Code_Motive_CP") = "C",pc_Code_Motive_CP,"")
* pc_Name_Cursor_CP: Nombre del Cursor de Costo de Producción
* pc_Code_Motive_CP: Código de Motivo de Producción
ln_Select_Current = SELECT()
*** Cursor de Saldos por Calidad
CREATE CURSOR cQuality(codigo C(1),saldo N(16,6))
INDEX ON codigo TAG codigo
***
*** Estableciendo Orden
SELECT ka2
lc_Order_Kardex = ORDER()
*SET ORDER TO kardex2
SET ORDER TO kardex3
***
SELECT ka2
IF RECNO() # pn_Number_Record
	GO pn_Number_Record
ENDIF
*** Obteniendo Saldos y Precio Promedio
STORE 0 TO _salcan, _salimpsol, _salimpdol, _preprosol, _preprodol
ll_Empty_Quality = EMPTY(pc_Code_Quality)
IF ll_Empty_Quality
	pc_Code_Quality = ka2.cod_calid
ENDIF
lcPreviousDocument = ""
*SELE ka2
*SKIP -1
*IF ka2.cod_articu = pc_Code_Article AND ka2.cod_calid = pc_Code_Quality AND !BOF()
*	_salcan = ka2.cantid_sld
*	_salimpsol = ka2.impsol_sld
*	_salimpdol = ka2.impdol_sld
*	_preprosol = ka2.prepro_sol
*	_preprodol = ka2.prepro_dol
*ENDIF
*IF ka2.cod_articu = pc_Code_Article AND !BOF()
*	_salimpsol = ka2.impsol_sld
*	_salimpdol = ka2.impdol_sld
*	_preprosol = ka2.prepro_sol
*	_preprodol = ka2.prepro_dol
*	lcPreviousDocument = ka2.tipdoc + ka2.serie + ka2.nrodoc
*	IF ka2.cod_calid = pc_Code_Quality
*		_salcan = ka2.cantid_sld
*	ENDIF
*ENDIF
&& Recorriendo registros anteriores
lnCount = 0
DO WHILE .T.
	lnCount = lnCount + 1
	SELECT ka2
	SKIP -1
	IF ka2.cod_articu = pc_Code_Article AND !BOF()
		IF lnCount = 1
			_salcan = ka2.cantidsld1 && Saldo x Producto
			_salimpsol = ka2.impsol_sld
			_salimpdol = ka2.impdol_sld
			_preprosol = ka2.prepro_sol
			_preprodol = ka2.prepro_dol
			lcPreviousDocument = ka2.tipdoc + ka2.serie + ka2.nrodoc
		ENDIF
		IF ka2.cod_calid = pc_Code_Quality
			&& Saldo x Producto y Calidad
			SELECT cQuality
			SEEK ka2.cod_calid
			IF !FOUND()
				APPEND BLANK
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
*SCAN WHILE cod_articu = pc_Code_Article AND cod_calid = pc_Code_Quality
SCAN WHILE cod_articu = pc_Code_Article
	*** Para actualizar Costo de Producción
	IF !EMPTY(pc_Name_Cursor_CP) AND !EMPTY(pc_Code_Motive_CP) AND ka2.rad_moti = "SAL" AND ka2.tipdoc = "NOTE" AND INLIST(ka2.docrel_tip,"PARI","NOTI") AND ka2.cod_moti = pc_Code_Motive_CP
		IF !SEEK(ka2.docrel_tip + ka2.docrel_ser + ka2.docrel_nro + ka2.docrel_itm,pc_Name_Cursor_CP)
			INSERT INTO (pc_Name_Cursor_CP) VALUES(ka2.docrel_tip,ka2.docrel_ser,ka2.docrel_nro,ka2.docrel_itm)
		ENDIF
	ENDIF
	***
	*** Ignorando el registro a Eliminar
	IF pl_Delete_Record AND RECNO() = pn_Number_Record
		LOOP
	ENDIF
	***
	*** Actualizando Cantidad
	SELECT cQuality
	SEEK ka2.cod_calid
	IF FOUND()
		REPLACE saldo WITH cQuality.saldo + (ka2.cantid_ing - ka2.cantid_sal)
	ELSE
		IF ll_Empty_Quality
			APPEND BLANK
			REPLACE codigo WITH ka2.cod_calid
			REPLACE saldo WITH (ka2.cantid_ing - ka2.cantid_sal)
		ENDIF
	ENDIF
	SELECT ka2
	IF !EOF("cQuality")
		REPLACE cantid_sld WITH cQuality.saldo && Saldo x Producto y Calidad
	ENDIF
	_salcan = _salcan + (ka2.cantid_ing - ka2.cantid_sal)
	REPLACE cantidsld1 WITH _salcan && Saldo x Producto
	***
	SELECT ka2
	DO CASE
		CASE ka2.rad_moti = "ING"
			IF !EMPTY(ka2.docori_tip) AND !EMPTY(ka2.docori_ser) AND !EMPTY(ka2.docori_nro) && El Precio SI depende de un Documento
				IF ka2.docori_tip + ka2.docori_ser + ka2.docori_nro = lcPreviousDocument && El Documento del registro Anterior debe ser el origen del Documento Actual
					*** Copiando Precios del Documento Anterior (Se asume que el Documento anterior es una Salida)
					REPLACE precom_sol WITH _preprosol
					REPLACE precom_dol WITH _preprodol
					REPLACE prepro_sol WITH _preprosol
					REPLACE prepro_dol WITH _preprodol
					REPLACE impsol_ing WITH _preprosol * (ka2.cantid_ing + ka2.cantid_sal)
					REPLACE impdol_ing WITH _preprodol * (ka2.cantid_ing + ka2.cantid_sal)
					***
				ENDI
			ENDIF
		CASE ka2.rad_moti = "SAL"
			*** Precio Promedio del último Ingreso
			REPLACE prepro_sol WITH _preprosol
			REPLACE prepro_dol WITH _preprodol
			***
			REPLACE impsol_sal WITH _preprosol * (ka2.cantid_ing + ka2.cantid_sal)
			REPLACE impdol_sal WITH _preprodol * (ka2.cantid_ing + ka2.cantid_sal)
	ENDCASE
	*** Actualizando Saldo en Soles y Dolares
	_salimpsol = _salimpsol + (ka2.impsol_ing - ka2.impsol_sal)
	_salimpdol = _salimpdol + (ka2.impdol_ing - ka2.impdol_sal)
	REPLACE impsol_sld WITH _salimpsol
	REPLACE impdol_sld WITH _salimpdol
	***
	*** Solo los Ingresos alteran el Precio Promedio
	IF ka2.rad_moti = "ING"
		IF !(!EMPTY(ka2.docori_tip) AND !EMPTY(ka2.docori_ser) AND !EMPTY(ka2.docori_nro)) && El Precio NO depende de ningún Documento
			*** Calculando Precio Promedio en Soles y Dolares
			_preprosol = IIF(_salcan != 0 AND _salimpsol != 0,ROUND(_salimpsol / _salcan,6),0)
			_preprodol = IIF(_salcan != 0 AND _salimpdol != 0,ROUND(_salimpdol / _salcan,6),0)
			***
			*** Actualizando Precio Promedio en Soles y Dolares
			&& CCP 30/04/2010 Esta correcion se hizo porque extrañamente en algunos casos aunque el monto es 0 lo
			&& considera como un valor 7.213232321E75+, pero si en el depurador lo igualamos a 0 da como .T. es por
			&& eso que cuando es 0 lo forzamos a que seo cero sin ningun decimal
			_preprosol = IIF(_preprosol # 0,_preprosol,0)
			_preprodol = IIF(_preprodol # 0,_preprodol,0)
			REPLACE prepro_sol WITH _preprosol
			REPLACE prepro_dol WITH _preprodol
			***
		ENDIF
	ENDIF
	***
	lcPreviousDocument = ka2.tipdoc + ka2.serie + ka2.nrodoc && ccp 10/03/18
ENDSCAN
SELE ka2
IF RECNO() # pn_Number_Record
	GO pn_Number_Record
ENDIF
*** Eliminando registro
IF pl_Delete_Record
	SELE ka2
	*GO pn_Number_Record
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
***
USE IN cQuality
SELECT(ln_Select_Current)
RETURN