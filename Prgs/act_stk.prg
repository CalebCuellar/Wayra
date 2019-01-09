PARAMETERS _ingsal, ppp_detalle, ppp_cod_alma, PPP_serie_doc, ppp_nrodoc_doc
*** Abriendo Tablas
ll_Used_aStock = USED("aStock")
IF !ll_Used_aStock
	SELECT 0
	USE stockart ALIAS aStock AGAIN
ENDIF
SELECT aStock
lc_Order_aStock = ORDER()
SET ORDER TO codigo
***
*** Detalle
SELE &ppp_detalle.
IF !EMPTY(PPP_serie_doc + ppp_nrodoc_doc)
	SET KEY TO PPP_serie_doc + ppp_nrodoc_doc
ENDIF 
GO TOP
SCAN FOR tip_produc = "P" && Solo Productos
	SELE aStock
	SET KEY TO &ppp_detalle..cod_articu + ppp_cod_alma + ALLTRIM(&ppp_detalle..nro_lote)
	GO TOP
	IF EOF()
		SELE aStock
		DO WHILE !FLOCK() AND ALIAS() = "ASTOCK"
			WAIT WINDOW "Espere un momento ......." TIME 3
		ENDDO
		APPEND BLANK
		REPLACE tip_produc WITH &ppp_detalle..tip_produc
		REPLACE cod_articu WITH &ppp_detalle..cod_articu
		REPLACE cod_alma WITH ppp_cod_alma
		REPLACE nro_lote WITH ALLTRIM(&ppp_detalle..nro_lote)
	ENDIF
	REPLACE stock_arti WITH aStock.stock_arti + (&ppp_detalle..cantidad * IIF(_ingsal = "I",1,-1))
	UNLOCK
	SELE aStock
	SET KEY TO
	***
ENDSCAN
***
*** Cerrando Tablas
IF !ll_Used_aStock
	USE IN aStock
ELSE
	IF !EMPTY(lc_Order_aStock)
		SELECT aStock
		SET ORDER TO &lc_Order_aStock.
	ENDIF
ENDIF
***
RETURN