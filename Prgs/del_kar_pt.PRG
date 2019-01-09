PARAMETERS pcTipDocu,pcNumSerie,pcNumDocu,ppp_fecha_reg
*** Abriendo Tablas
ll_Used_ka2 = USED("ka2")
IF !ll_Used_ka2
	SELECT 0
	*USE kardex3 ALIAS ka2 AGAIN
	lcNameFile = CREATE_FILE_KARDEX("PT",ppp_fecha_reg)
	USE (lcNameFile) ALIAS ka2 AGAIN
ENDIF
SELE ka2
lc_Order_ka2 = ORDER()
SET ORDER TO documento
***
*** Cursor para actualizar Costo de Producción
lc_Cursor_Name = SYS(2015)
CREATE CURSOR (lc_Cursor_Name)(tipo C(4),serie C(4),nrodoc C(10),item C(4))
INDEX ON tipo + serie + nrodoc + item TAG codigo
lc_Mot_Prd = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","MOT_SAL_PRD")
lc_Mot_Prd = PADR(IIF(!ISNULL(lc_Mot_Prd),lc_Mot_Prd,""),3," ")
***
*** Eliminar Documento del Kardex
SELE ka2
SEEK pcTipDocu + pcNumSerie + pcNumDocu
SCAN WHILE tipdoc + serie + nrodoc = pcTipDocu + pcNumSerie + pcNumDocu
	ln_Record = RECNO("ka2")
	*DO ACT_KAR_PT WITH ka2.cod_articu,PADR(ka2.cod_calid,1),ln_Record
	DO ACT_KAR_PT WITH ka2.cod_articu,PADR(ka2.cod_calid,1),ln_Record,.F.,lc_Cursor_Name,lc_Mot_Prd
	DO ACT_KAR_PT1 WITH ka2.cod_articu,ka2.cod_alma,PADR(ka2.cod_calid,1),ln_Record,.T.
ENDSCAN
***
*** Cerrando Tablas
SELECT ka2
IF !EMPTY(lc_Order_ka2)
	SET ORDER TO &lc_Order_ka2.
ENDIF
IF !ll_Used_ka2
	USE
ENDIF
***
*** Actualizando Costo de Producción
IF !EOF(lc_Cursor_Name)
	= COSTO_PRODUCCION(lc_Cursor_Name,.T.)
ENDIF
USE IN (lc_Cursor_Name)
***