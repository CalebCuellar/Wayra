parameters _ingsal, ppp_detalle, ppp_cod_alma, PPP_serie_doc, ppp_nrodoc_doc

*use in 0 stock_PT order codigo alias aStock again		&& orden : cod_articu+cod_alma+ cod_calid
&& ccp 21/08/14
llUsed_aStock = USED("aStock")
IF !llUsed_aStock
	use in 0 stock_PT alias aStock again
ENDIF
SELECT aStock
lcOrder_aStock = ORDER()
SET ORDER TO codigo
&&
select &ppp_detalle.
IF !EMPTY(PPP_serie_doc + ppp_nrodoc_doc)
	SET KEY TO PPP_serie_doc + ppp_nrodoc_doc
ENDIF 
go top
SCAN FOR tip_produc = 'P'
	select aStock
	set key to &ppp_detalle..cod_articu + ppp_cod_alma + ALLTRIM(&ppp_detalle..cod_calid)
	go top
	if eof()
		select aStock
		do while !Flock() and alias()='ASTOCK'
			wait wind 'Espere un momento .......' time 3
		enddo

		append blank
		replace tip_produc WITH &ppp_detalle..tip_produc
		replace cod_articu with &ppp_detalle..cod_articu
		replace cod_alma   with ppp_cod_alma
		replace cod_calid  WITH ALLTRIM(&ppp_detalle..cod_calid)
		
	endif
	replace stock_arti with aStock.stock_arti + ( &ppp_detalle..cantidad * iif( _ingsal = "I" , 1 , -1 ) )
	UNLOCK
	select aStock
	set key to
	***
	select &ppp_detalle.
ENDSCAN
*use in aStock
&& ccp 21/08/14
IF !llUsed_aStock
	USE IN aStock
ELSE
	IF !EMPTY(lcOrder_aStock)
		SELECT aStock
		SET ORDER TO &lcOrder_aStock.
	ENDIF
ENDIF
&&
return