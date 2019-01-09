PARAMETERS pcNameCursorTarget,pcNumberOC,pcTypeDocument,pcSerieDocument,pcNumberDocument,pcNumberOP,pcDescriptionOP
* pcNameCursorTarget = Nombre del Cursor donde se mostrara el saldo de la OC
* pcNumberOC = Número de Orden de Compra (Serie + Número)
* pcTypeDocument = Tipo de Documento
* pcSerieDocument = Serie de Documento
* pcNumberDocument = Numero de Documento
* pcNumberOP = Número de Orden de Producción
* pcDescriptionOP = Descripción de Orden de Producción
ln_Select = SELECT()
*** Abriendo Tablas
ll_Used_notc1 = USED("notc1")
IF !ll_Used_notc1
	USE notc1 IN 0 AGAIN
ENDIF
ll_Used_notc2 = USED("notc2")
IF !ll_Used_notc2
	USE notc2 IN 0 AGAIN
ENDIF
ll_Used_maesarti = USED("maesarti")
IF !ll_Used_maesarti
	USE maesarti IN 0 AGAIN
ENDIF
DO CASE
	CASE pcTypeDocument = "NOTI" && Parte de Ingreso
		*** Faltante por Ingresar
		SELECT 0
		USE noti1 ORDER noti1 ALIAS tConsumo1 AGAIN
		SELECT 0
		USE noti2 ORDER seg_ordcom ALIAS tConsumo2 AGAIN
		***
	CASE pcTypeDocument = "NOTR" && Orden de Requerimiento
		*** Faltante por Retirar
		SELECT 0
		USE notr1 ORDER notr1 ALIAS tConsumo1 AGAIN
		SELECT 0
		USE notr2 ORDER seg_ordcom ALIAS tConsumo2 AGAIN
		***
ENDCASE
***
*** Ordenando Tablas
SELECT notc1
lc_Order_notc1 = ORDER()
SET ORDER TO notc1
SELECT notc2
lc_Order_notc2 = ORDER()
SET ORDER TO notc2
SELECT maesarti
lc_Order_maesarti = ORDER()
SET ORDER TO codigo
***
llOCEstado = .F.
*** Tipo de Cambio
lnTipCam_OC = 0
SELECT notc1
SEEK pcNumberOC
IF FOUND()
	llOCEstado = !notc1.cod_anula
	lnTipCam_OC = IIF(notc1.tipcam_cod = "O",notc1.tipcam_val,TIPO_CAMBIO(notc1.fecha_reg,notc1.tipcam_cod))
ENDIF
***
IF llOCEstado
	*** Correlativo de Item
	SELECT MAX(item) AS ultimo FROM (pcNameCursorTarget) INTO CURSOR cTemp
	lnItem = IIF(!ISNULL(cTemp.ultimo),INT(VAL(cTemp.ultimo)),0)
	USE
	***
	*** Articulos
	SELECT notc2
	SEEK pcNumberOC
	SCAN WHILE serie + nrodoc = pcNumberOC
		*** Verificando existencia de Articulo
		SELECT (pcNameCursorTarget)
		LOCATE FOR cod_articu = notc2.cod_articu
		IF FOUND()
			LOOP
		ENDIF
		***
		*** Consumo
		lnConsumo = 0
		IF USED("tConsumo1") AND USED("tConsumo2")
			SELECT tConsumo2
			SEEK pcNumberOC + notc2.cod_articu
			SCAN WHILE seg_ordcom + cod_articu = pcNumberOC + notc2.cod_articu
				SELECT tConsumo1
				SEEK tConsumo2.serie + tConsumo2.nrodoc
				llSw = (FOUND() AND !tConsumo1.cod_anula)
				IF llSw
					lnConsumo = lnConsumo + tConsumo2.cantidad
				ENDIF
			ENDSCAN
		ENDIF
		***
		lnSaldo = notc2.cantidad - lnConsumo
		IF lnSaldo <= 0
			LOOP
		ENDIF
		= SEEK(PADR(notc2.cod_articu,10),"maesarti")
		*** Ingresando Saldo
		lnItem = lnItem + 1
		SELECT (pcNameCursorTarget)
		APPEND BLANK
		REPLACE serie		WITH pcSerieDocument
		REPLACE nrodoc		WITH pcNumberDocument
		REPLACE item		WITH TRANSFORM(lnItem,"@L 9999")
		REPLACE tip_produc	WITH "P"
		REPLACE cod_articu	WITH notc2.cod_articu
		REPLACE des_articu	WITH notc2.des_articu
		REPLACE cod_intemp	WITH notc2.cod_intemp
		IF TYPE(pcNameCursorTarget + ".des_unimed") # "U" AND TYPE("notc2.des_unimed") = "C"
			REPLACE des_unimed	WITH notc2.des_unimed
		ENDIF
		REPLACE cantidad	WITH lnSaldo
		*lnPrecio_1 = notc2.precio_1
		*lnPrecio_2 = notc2.precio_2
		*IF lnPrecio_1 = 0 AND lnPrecio_2 > 0 AND lnTipCam_OC > 0
		*	lnPrecio_1 = lnPrecio_2 * lnTipCam_OC
		*ENDIF
		*IF lnPrecio_2 = 0 AND lnPrecio_1 > 0 AND lnTipCam_OC > 0
		*	lnPrecio_2 = lnPrecio_1 / lnTipCam_OC
		*ENDIF
		REPLACE precio_1	WITH notc2.precio_1
		REPLACE precio_2	WITH notc2.precio_2
		*REPLACE precio_1	WITH lnPrecio_1
		*REPLACE precio_2	WITH lnPrecio_2
		REPLACE obs_deta	WITH notc2.obs_deta
		*REPLACE cod_calid	WITH m.cod_calid
		*REPLACE des_calid	WITH 
		IF TYPE(pcNameCursorTarget + ".cod_ordprd") # "U" AND TYPE("pcNumberOP") = "C"
			REPLACE cod_ordprd	WITH pcNumberOP
		ENDIF
		IF TYPE(pcNameCursorTarget + ".des_ordprd") # "U" AND TYPE("pcDescriptionOP") = "C"
			REPLACE des_ordprd	WITH pcDescriptionOP
		ENDIF
		*REPLACE peso_bruto	WITH m.peso_bruto
		*REPLACE cant_conos	WITH m.cant_conos
		*REPLACE peso_conos	WITH m.peso_conos
		*REPLACE cod_color	WITH m.cod_color
		*REPLACE des_color	WITH m.des_color
		*REPLACE ubica1		WITH m.Ubica1
		REPLACE seg_ordcom	WITH pcNumberOC
		REPLACE new_usu		WITH _usuario
		REPLACE new_fec		WITH DATE()
		REPLACE new_hor		WITH TIME()
		***
	ENDSCAN
	***
ENDIF
*** Cerrando Tablas
SELECT notc1
IF !EMPTY(lc_Order_notc1)
	SET ORDER TO &lc_Order_notc1.
ENDIF
IF !ll_Used_notc1
	USE
ENDIF
SELECT notc2
IF !EMPTY(lc_Order_notc2)
	SET ORDER TO &lc_Order_notc2.
ENDIF
IF !ll_Used_notc2
	USE
ENDIF
SELECT maesarti
IF !EMPTY(lc_Order_maesarti)
	SET ORDER TO &lc_Order_maesarti.
ENDIF
IF !ll_Used_maesarti
	USE
ENDIF
USE IN IIF(USED("tConsumo1"),"tConsumo1",0)
USE IN IIF(USED("tConsumo2"),"tConsumo2",0)
***
GO TOP IN (pcNameCursorTarget)
SELECT(ln_Select)