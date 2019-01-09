PARAMETERS p_g, t_t, ppp_serie, ppp_nrodoc, ppp_cod_alma, ppp_cod_alma1, ppp_fecha_reg, ppp_tipcam_cod, ppp_tipcam_val, ppp_detalle, ppp_cod_mone
STORE 0 TO _preprosol,_preprodol
ln_Select = SELECT()
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
SELECT indi_proc,radical,cod_orden FROM maesmoti WHERE radical+codigo = "SAL" + t_t INTO CURSOR cTemp
*lc_Cod_Prc = cTemp.indi_proc
*lc_Cod_Rad = cTemp.radical
lc_Ord_Mot = cTemp.cod_orden
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
	m.cod_alma = ppp_cod_alma
	m.cod_alma1 = ppp_cod_alma1
	m.cod_moti = t_t && 21/10/2016
	*m.rad_moti = lc_Cod_Rad
	m.rad_moti = "SAL" && 21/10/2016
	m.orden = lc_Ord_Mot
	m.tipdoc = p_g
	INSERT INTO ka2 FROM MEMVAR
	SELECT ka2
	&& 02/08/2017
	REPLACE fecha_reg WITH ppp_fecha_reg
	REPLACE cod_mone WITH ppp_cod_mone
	REPLACE tipcam_cod WITH ppp_tipcam_cod
	REPLACE tipcam_val WITH ppp_tipcam_val
	&&
	REPLACE precom_sol WITH 0
	REPLACE precom_dol WITH 0
	*REPLACE prepro_sol WITH _preprosol
	*REPLACE prepro_dol WITH _preprodol

	*** Actualizando Cantidades
	&& La Nota de Credito incrementa el Stock
	lnCantidad_Producto = &ppp_detalle..cantidad * IIF(p_g = "CRED",-1,1)
	&&
	REPLACE cantid_ing WITH 0
	REPLACE cantid_sal WITH lnCantidad_Producto
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
*** Actualizando Costo de Producción
IF !EOF(lc_Cursor_Name)
	= COSTO_PRODUCCION(lc_Cursor_Name,.T.)
ENDIF
USE IN (lc_Cursor_Name)
***
SELECT(ln_Select)
RETURN