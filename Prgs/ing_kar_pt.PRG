PARAMETERS p_g, t_t, ppp_serie, ppp_nrodoc, ppp_cod_alma, ppp_cod_alma1, ppp_fecha_reg, ppp_tipcam_cod, ppp_tipcam_val, ppp_detalle, ppp_cod_mone, ppp_cod_auxi
* p_g = Tipo de Documento
* t_t = Motivo
* ppp_serie = Serie de Documento
* ppp_nrodoc = Número de Documento
* ppp_cod_alma = Almacen Origen
* ppp_cod_alma1 = Almacen Destno
* ppp_fecha_reg = Fecha de Documento
* ppp_tipcam_cod = Código de Tipo de Cambio
* ppp_tipcam_val = Valor de Tipo de Cambio
* ppp_detalle = Cursor Detalle
* ppp_cod_mone = Tipo de Moneda
* ppp_cod_auxi = Código de Proveedor
ln_Select = SELECT()
*** GUARDANDO VALORES DE VARIABLE: m.serie y m.nrodoc 29/04/2016
*IF TYPE("m.serie") != "U"
*	lc_serie = m.serie
*ENDIF
*IF TYPE("m.nrodoc") != "U"
*	lc_nrodoc = m.nrodoc
*ENDIF
***
*** Abriendo Tablas
ll_Used_ka2 = USED("ka2")
IF !ll_Used_ka2
	SELECT 0
	lcNameFile = CREATE_FILE_KARDEX("PT",ppp_fecha_reg)
	USE (lcNameFile) ALIAS ka2 AGAIN
ENDIF
SELECT ka2
DIMENSION laVarKardex[1] && ccp 11-05-17
= MEMVAR_BACKUP(@laVarKardex) && ccp 11-05-17
lc_Order_ka2 = ORDER()
SET ORDER TO kardex2

ll_Used = USED("maesmoti")
SELECT indi_proc,cod_orden1 FROM maesmoti WHERE radical+codigo = "ING" + t_t INTO CURSOR cTemp
lc_Ord_Mot = cTemp.cod_orden1
USE
USE IN IIF(USED("maesmoti") AND !ll_Used,"maesmoti",0)
***
*** Cursor para actualizar Costo de Producción
lc_Cursor_Name = SYS(2015)
CREATE CURSOR (lc_Cursor_Name)(tipo C(4),serie C(4),nrodoc C(10),item C(4))
INDEX ON tipo + serie + nrodoc + item TAG codigo
lc_Mot_Prd = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","MOT_SAL_PRD")
lc_Mot_Prd = PADR(IIF(!ISNULL(lc_Mot_Prd),lc_Mot_Prd,""),3," ")
***
*** Ingresando Detalle
SELE &ppp_detalle.
DIMENSION laVarDetalle[1] && ccp 11-05-17
= MEMVAR_BACKUP(@laVarDetalle) && ccp 11-05-17
ln_Recno = IIF(!EOF(),RECNO(),0)
SET KEY TO ppp_serie + ppp_nrodoc
GO TOP
SCAN FOR tip_produc = "P" && Solo Productos
	SCATTER MEMVAR
	m.cod_auxi = ppp_cod_auxi
	m.cod_alma = ppp_cod_alma
	m.cod_alma1 = ppp_cod_alma1
	m.cod_moti = t_t
	m.rad_moti = "ING"
	m.orden = lc_Ord_Mot
	m.orden1 = ""
	IF !EMPTY(m.rad_moti1) AND !EMPTY(m.cod_moti1)
		SELECT cod_orden1 FROM maesmoti WHERE radical+codigo = m.rad_moti1 + m.cod_moti1 INTO CURSOR cTemp
		m.orden1 = cTemp.cod_orden1
		USE
	ENDIF
	m.tipdoc = p_g
	INSERT INTO ka2 FROM MEMVAR
	SELECT ka2
	&& 02/08/2017
	REPLACE fecha_reg WITH ppp_fecha_reg
	REPLACE cod_mone WITH ppp_cod_mone
	REPLACE tipcam_cod WITH ppp_tipcam_cod
	REPLACE tipcam_val WITH ppp_tipcam_val
	&&
	REPLACE ubica1 WITH &ppp_detalle..ubica1
	*** Actualizando Precio de Compra
	lnPrec_Comp_Sol = &ppp_detalle..precio_1
	lnPrec_Comp_Dol = &ppp_detalle..precio_2
	REPLACE precom_sol WITH lnPrec_Comp_Sol
	REPLACE precom_dol WITH lnPrec_Comp_Dol
	***
	*** Actualizando Cantidades
	REPLACE cantid_ing WITH &ppp_detalle..cantidad
	REPLACE cantid_sal WITH 0
	*REPLACE cantid_sld WITH _salcan + &ppp_detalle..cantidad
	***
	*** Actualizando Importe S/. (Ingreso, Salida, Saldo)
	REPLACE impsol_ing WITH &ppp_detalle..cantidad * lnPrec_Comp_Sol && lnPrecio_Soles
	REPLACE impsol_sal WITH 0
	*REPLACE impsol_sld WITH _salimpsol + (&ppp_detalle..cantidad * lnPrecio_Soles)
	***
	*** Actualizando Importe US$ (Ingreso, Salida, Saldo)
	REPLACE impdol_ing WITH &ppp_detalle..cantidad * lnPrec_Comp_Dol && lnPrecio_Dolares
	REPLACE impdol_sal WITH 0
	*REPLACE impdol_sld WITH _salimpdol + (&ppp_detalle..cantidad * lnPrecio_Dolares)
	***
	ln_Record = RECNO("ka2")
	*DO ACT_KAR_PT WITH ka2.cod_articu,ka2.cod_calid,ln_Record
	DO ACT_KAR_PT WITH ka2.cod_articu,ka2.cod_calid,ln_Record,.F.,lc_Cursor_Name,lc_Mot_Prd
	DO ACT_KAR_PT1 WITH ka2.cod_articu,ka2.cod_alma,ka2.cod_calid,ln_Record
ENDSCAN
= MEMVAR_RESTORE(@laVarDetalle) && ccp 11-05-17
= MEMVAR_RESTORE(@laVarKardex) && ccp 11-05-17
SELE &ppp_detalle.
SET KEY TO
IF ln_Recno > 0
	GO ln_Recno
ENDIF
***
*** Cerrando Tablas
IF !ll_Used_ka2
	USE IN ka2
ELSE
	IF !EMPTY(lc_Order_ka2)
		SELECT ka2
		SET ORDER TO &lc_Order_ka2.
	ENDIF
ENDIF
***
*** RESTAURANDO VALORES DE VARIABLE: m.serie y m.nrodoc 29/04/2016
*IF TYPE("lc_serie") != "U"
*	m.serie = lc_serie
*ENDIF
*IF TYPE("lc_nrodoc") != "U"
*	m.nrodoc = lc_nrodoc
*ENDIF
***
*** Actualizando Costo de Producción
IF !EOF(lc_Cursor_Name)
	= COSTO_PRODUCCION(lc_Cursor_Name,.T.)
ENDIF
USE IN (lc_Cursor_Name)
***
SELECT(ln_Select)
RETURN