parameters p_g, t_t, ppp_serie, ppp_nrodoc, ppp_cod_alma, ppp_cod_alma1, ppp_fecha_reg, ppp_tipcam_cod, ppp_tipcam_val, ppp_detalle, ppp_cod_mone, ppp_cod_auxi
store 0 to _salcan, _salimpsol, _salimpdol, _preprosol, _preprodol
*use in 0 kardex3  order kardex2 alias ka2
*use in 0 maestica order codigo  alias amaestica
&& ccp 21/08/14
llUsed_ka2 = USED("ka2")
IF !llUsed_ka2
	use in 0 kardex3 alias ka2 again
ENDIF
SELECT ka2
lcOrder_ka2 = ORDER()
SET ORDER TO kardex2

llUsed_amaestica = USED("amaestica")
IF !llUsed_amaestica
	use in 0 maestica alias amaestica again
ENDIF
SELECT amaestica
lcOrder_amaestica = ORDER()
SET ORDER TO codigo
&&

tmp_tipcam = 0
select amaestica
set key to dtos(ppp_fecha_reg)
go top
do case
	case ppp_tipcam_cod = 'C'
		tmp_tipcam = amaestica.compra

	case ppp_tipcam_cod = 'V'
		tmp_tipcam = amaestica.venta

	case ppp_tipcam_cod = 'O'
		tmp_tipcam = ppp_tipcam_val
endcase
select amaestica
set key to

select &ppp_detalle.
SET KEY TO ppp_serie + ppp_nrodoc
go top
SCAN FOR tip_produc = 'P'
	scatter memvar
	***
	m.rad_moti  = aMaesMoti.Radical
	m.cod_auxi  = ppp_cod_auxi
	m.cod_alma  = ppp_cod_alma
	m.cod_alma1 = ppp_cod_alma1
	m.cod_moti  = T_T
	m.rad_moti  = 'ING'
	***
	select ka2
	set key to m.cod_articu
	go bott
	if eof()
		store 0 to _salcan, _salimpsol, _salimpdol, _preprosol, _preprodol
	else
		_salcan    = ka2.cantid_sld
		_salimpsol = ka2.impsol_sld
		_salimpdol = ka2.impdol_sld
		_preprosol = ka2.prepro_sol
		_preprodol = ka2.prepro_dol
	endif
	m.tipdoc = p_g
	insert into ka2 from memvar
	***
	do case
		case amaesmoti.indi_proc $ '02'			&& por compra
			do case
				case ppp_cod_mone = 'SOL'

					replace Ubica1     with	&ppp_detalle..Ubica1					&&	Ubicacion	....
					replace precom_sol with &ppp_detalle..precio_1
					replace precom_dol with iif(tmp_tipcam != 0 and &ppp_detalle..precio_1 != 0, &ppp_detalle..precio_1 / tmp_tipcam, 0)
					***
					replace cantid_ing with &ppp_detalle..cantidad
					replace cantid_sal with 0
					replace cantid_sld with _salcan + &ppp_detalle..cantidad
					***
					replace impsol_ing with &ppp_detalle..cantidad * ka2.precom_sol
					replace impsol_sal with 0
					replace impsol_sld with _salimpsol + (&ppp_detalle..cantidad * ka2.precom_sol)
					***
					replace impdol_ing with &ppp_detalle..cantidad * ka2.precom_dol
					replace impdol_sal with 0
					replace impdol_sld with _salimpdol + (&ppp_detalle..cantidad * ka2.precom_dol)
					***
					_prepro_sol = iif(ka2.cantid_sld !=0 and ka2.impsol_sld != 0, ka2.impsol_sld / ka2.cantid_sld, ka2.precom_sol)
					_prepro_dol = iif(ka2.cantid_sld !=0 and ka2.impdol_sld != 0, ka2.impdol_sld / ka2.cantid_sld, ka2.precom_dol)
					replace prepro_sol with _prepro_sol
					replace prepro_dol with _prepro_dol

				case ppp_cod_mone = 'DOL'

					replace Ubica1     with	&ppp_detalle..Ubica1					&&	Ubicacion	....
					replace precom_dol with &ppp_detalle..precio_1
					replace precom_sol with iif(tmp_tipcam != 0 and &ppp_detalle..precio_1 != 0, &ppp_detalle..precio_1 * tmp_tipcam, 0)
					***
					replace cantid_ing with &ppp_detalle..cantidad
					replace cantid_sal with 0
					replace cantid_sld with _salcan + &ppp_detalle..cantidad
					***
					replace impsol_ing with &ppp_detalle..cantidad * ka2.precom_sol
					replace impsol_sal with 0
					replace impsol_sld with _salimpsol + (&ppp_detalle..cantidad * ka2.precom_sol)
					***
					replace impdol_ing with &ppp_detalle..cantidad * ka2.precom_dol
					replace impdol_sal with 0
					replace impdol_sld with _salimpdol + (&ppp_detalle..cantidad * ka2.precom_dol)
					***
					_prepro_sol = iif(ka2.cantid_sld !=0 and ka2.impsol_sld != 0, ka2.impsol_sld / ka2.cantid_sld, ka2.precom_sol)
					_prepro_dol = iif(ka2.cantid_sld !=0 and ka2.impdol_sld != 0, ka2.impdol_sld / ka2.cantid_sld, ka2.precom_dol)
					replace prepro_sol with _prepro_sol
					replace prepro_dol with _prepro_dol

			endcase

		case amaesmoti.indi_proc $ '03'			&& por apertura
			do case
				case ppp_cod_mone = 'SOL'

					replace Ubica1     with	&ppp_detalle..Ubica1					&&	Ubicacion	....
					replace precom_sol with &ppp_detalle..precio_1
					replace precom_dol with &ppp_detalle..precio_2
					***
					replace cantid_ing with &ppp_detalle..cantidad
					replace cantid_sal with 0
					replace cantid_sld with _salcan + &ppp_detalle..cantidad
					***
					replace impsol_ing with &ppp_detalle..cantidad * ka2.precom_sol
					replace impsol_sal with 0
					replace impsol_sld with _salimpsol + (&ppp_detalle..cantidad * ka2.precom_sol)
					***
					replace impdol_ing with &ppp_detalle..cantidad * ka2.precom_dol
					replace impdol_sal with 0
					replace impdol_sld with _salimpdol + (&ppp_detalle..cantidad * ka2.precom_dol)
					***
					_prepro_sol = iif(ka2.cantid_sld !=0 and ka2.impsol_sld != 0, ka2.impsol_sld / ka2.cantid_sld, ka2.precom_sol)
					_prepro_dol = iif(ka2.cantid_sld !=0 and ka2.impdol_sld != 0, ka2.impdol_sld / ka2.cantid_sld, ka2.precom_dol)
					replace prepro_sol with _prepro_sol
					replace prepro_dol with _prepro_dol

				case ppp_cod_mone = 'DOL'

					replace Ubica1     with	&ppp_detalle..Ubica1					&&	Ubicacion	....
					replace precom_dol with &ppp_detalle..precio_1
					replace precom_sol with &ppp_detalle..precio_2
					***
					replace cantid_ing with &ppp_detalle..cantidad
					replace cantid_sal with 0
					replace cantid_sld with _salcan + &ppp_detalle..cantidad
					***
					replace impsol_ing with &ppp_detalle..cantidad * ka2.precom_sol
					replace impsol_sal with 0
					replace impsol_sld with _salimpsol + (&ppp_detalle..cantidad * ka2.precom_sol)
					***
					replace impdol_ing with &ppp_detalle..cantidad * ka2.precom_dol
					replace impdol_sal with 0
					replace impdol_sld with _salimpdol + (&ppp_detalle..cantidad * ka2.precom_dol)
					***
					_prepro_sol = iif(ka2.cantid_sld !=0 and ka2.impsol_sld != 0, ka2.impsol_sld / ka2.cantid_sld, ka2.precom_sol)
					_prepro_dol = iif(ka2.cantid_sld !=0 and ka2.impdol_sld != 0, ka2.impdol_sld / ka2.cantid_sld, ka2.precom_dol)
					replace prepro_sol with _prepro_sol
					replace prepro_dol with _prepro_dol
			endcase

		other

		    replace Ubica1     with	&ppp_detalle..Ubica1					&&	Ubicacion	....
			replace precom_sol with 0
			replace precom_dol with 0
			replace prepro_sol with _preprosol
			replace prepro_dol with _preprodol
			***
			replace cantid_ing with &ppp_detalle..cantidad
			replace cantid_sal with 0
			replace cantid_sld with _salcan + &ppp_detalle..cantidad
			***
			replace impsol_ing with &ppp_detalle..cantidad * _preprosol
			replace impsol_sal with 0
			replace impsol_sld with _salimpsol + (&ppp_detalle..cantidad * _preprosol)
			***
			replace impdol_ing with &ppp_detalle..cantidad * _preprodol
			replace impdol_sal with 0
			replace impdol_sld with _salimpdol + (&ppp_detalle..cantidad * _preprodol)
	endcase
	select &ppp_detalle.

ENDSCAN
select &ppp_detalle.
SET KEY TO 

*use in ka2
*use in amaestica
&& ccp 21/08/14
IF !llUsed_ka2
	USE IN ka2
ELSE
	IF !EMPTY(lcOrder_ka2)
		SELECT ka2
		SET ORDER TO &lcOrder_ka2.
	ENDIF
ENDIF
IF !llUsed_amaestica
	USE IN amaestica
ELSE
	IF !EMPTY(lcOrder_amaestica)
		SELECT amaestica
		SET ORDER TO &lcOrder_amaestica.
	ENDIF
ENDIF
&&
return