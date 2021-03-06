PARAMETERS pcTipoAlmacen,pcYear,pcFileKardex
ln_Select = SELECT()
lcYearPrevious = PADL(INT(VAL(pcYear)) - 1,4,"0")
***** Obteniendo el Nombre del Archivo que contiene los Saldos del A�o anterior
*lcNameFileSaldos  = pcTipoAlmacen + "SA" + lcYearPrevious + "12"
*lcPathFileSaldos  = UPPER(_rt_bas_) + "\" + lcNameFileSaldos + ".DBF"
*****
***** Obteniendo el Nombre del Archivo que contiene los Saldos x OP del A�o anterior
lcNameFileSaldos  = pcTipoAlmacen + "SB" + lcYearPrevious + "12"
lcPathFileSaldos  = UPPER(_rt_bas_) + "\" + lcNameFileSaldos + ".DBF"
*****
IF FILE(lcPathFileSaldos)
	ll_Used = USED(lcNameFileSaldos)
	DO CASE
		CASE pcTipoAlmacen = "IN"
			*SELECT * FROM (lcPathFileSaldos) ORDER BY cod_articu,cod_alma,nro_lote,tip_produc INTO CURSOR cSaldos
			SELECT * FROM (lcPathFileSaldos) ORDER BY cod_articu,cod_alma,nro_lote,tip_produc,cod_ordprd INTO CURSOR cSaldos
		CASE pcTipoAlmacen = "PT"
			*SELECT * FROM (lcPathFileSaldos) ORDER BY cod_articu,cod_alma,cod_calid,tip_produc INTO CURSOR cSaldos
			SELECT * FROM (lcPathFileSaldos) ORDER BY cod_articu,cod_alma,cod_calid,tip_produc,cod_ordprd INTO CURSOR cSaldos
	ENDCASE
	IF DBF(lcNameFileSaldos) # lcPathFileSaldos
		USE IN cSaldos
	ENDIF
	USE IN IIF(USED(lcNameFileSaldos) AND !ll_Used,lcNameFileSaldos,0)
ELSE
	lcNameFileKardex = "KAR" + pcTipoAlmacen + lcYearPrevious
	lcPathFileKardex = UPPER(_rt_bas_) + "\" + lcNameFileKardex + ".DBF"
	IF FILE(lcPathFileKardex)
		***** No se ha realizado el cierre del a�o anterior
		WAIT WINDOW "No se ha realizado el cierre del A�o " + lcYearPrevious + "." NOWAIT
		ll_Used = USED(lcNameFileKardex)
		DO CASE
			CASE pcTipoAlmacen = "IN"
				*SELECT cod_articu,cod_alma,nro_lote,tip_produc,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(impsol_ing - impsol_sal) AS stock_vals,;
					SUM(impdol_ing - impdol_sal) AS stock_vald,;
					SUM(cant_conos * IIF(rad_moti = "ING",1,-1)) AS stock_cono ;
					FROM (lcPathFileKardex) ;
					GROUP BY cod_articu,cod_alma,nro_lote,tip_produc ;
					INTO CURSOR curTemp
				*SELECT cod_articu,cod_alma,nro_lote,tip_produc,cod_ordprd,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(impsol_ing - impsol_sal) AS stock_vals,;
					SUM(impdol_ing - impdol_sal) AS stock_vald,;
					SUM(cant_conos * IIF(rad_moti = "ING",1,-1)) AS stock_cono ;
					FROM (lcPathFileKardex) ;
					GROUP BY cod_articu,cod_alma,nro_lote,tip_produc,cod_ordprd ;
					INTO CURSOR curTemp
				SELECT cod_articu,cod_alma,nro_lote,tip_produc,cod_ordprd,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(cant_conos * IIF(rad_moti = "ING",1,-1)) AS stock_cono ;
					FROM (lcPathFileKardex) ;
					GROUP BY cod_articu,cod_alma,nro_lote,tip_produc,cod_ordprd ;
					INTO CURSOR curTemp
			CASE pcTipoAlmacen = "PT"
				*SELECT cod_articu,cod_alma,cod_calid,tip_produc,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(impsol_ing - impsol_sal) AS stock_vals,;
					SUM(impdol_ing - impdol_sal) AS stock_vald,;
					SUM(peso_prod * IIF(rad_moti = "ING",1,-1)) AS stock_peso ;
					FROM (lcPathFileKardex) ;
					GROUP BY cod_articu,cod_alma,cod_calid,tip_produc ;
					INTO CURSOR curTemp
				*SELECT cod_articu,cod_alma,cod_calid,tip_produc,cod_ordprd,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(impsol_ing - impsol_sal) AS stock_vals,;
					SUM(impdol_ing - impdol_sal) AS stock_vald,;
					SUM(peso_prod * IIF(rad_moti = "ING",1,-1)) AS stock_peso ;
					FROM (lcPathFileKardex) ;
					GROUP BY cod_articu,cod_alma,cod_calid,tip_produc,cod_ordprd ;
					INTO CURSOR curTemp
				SELECT cod_articu,cod_alma,cod_calid,tip_produc,cod_ordprd,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(peso_prod * IIF(rad_moti = "ING",1,-1)) AS stock_peso ;
					FROM (lcPathFileKardex) ;
					GROUP BY cod_articu,cod_alma,cod_calid,tip_produc,cod_ordprd ;
					INTO CURSOR curTemp
		ENDCASE
		IF USED(lcNameFileKardex) AND DBF(lcNameFileKardex) # lcPathFileKardex
			USE IN curTemp
		ENDIF
		*****
		***** Actualizar los Precios Promedios
		IF USED("curTemp")
			&& Ordenando Kardex para consulta
			SELECT (lcNameFileKardex)
			lc_Order_Kardex = ORDER()
			SET ORDER TO stockart DESCENDING
			&&
			SELECT curTemp
			AFIELDS(laStruc)
			CREATE CURSOR cSaldos FROM ARRAY laStruc
			SELECT curTemp
			SCAN
				SCATTER MEMVAR
				&& �ltimo Precio Promedio
				SELECT (lcNameFileKardex)
				SEEK m.cod_articu + m.cod_alma + IIF(pcTipoAlmacen = "IN",m.nro_lote,m.cod_calid)
				m.preprosol = &lcNameFileKardex..preprosol
				m.preprodol = &lcNameFileKardex..preprodol
				&&
				INSERT INTO cSaldos FROM MEMVAR
			ENDSCAN
			USE
			&& Restableciendo Orden del Kardex
			SELECT (lcNameFileKardex)
			SET ORDER TO
			IF !EMPTY(lc_Order_Kardex)
				SET ORDER TO &lc_Order_Kardex.
			ENDIF
			&&
		ENDIF
		*****
		USE IN IIF(USED(lcNameFileKardex) AND !ll_Used,lcNameFileKardex,0)
	ELSE
		****** No existe informacion de a�os anteriores (Creando cursor vacio de Kardex()
		DO CASE
			CASE pcTipoAlmacen = "IN"
				ll_Used = USED("strukardin")
				*SELECT cod_articu,cod_alma,nro_lote,tip_produc,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(impsol_ing - impsol_sal) AS stock_vals,;
					SUM(impdol_ing - impdol_sal) AS stock_vald,;
					SUM(cant_conos * IIF(rad_moti = "ING",1,-1)) AS stock_cono,;
					preprosol,preprodol,;
					tip_produc ;
					FROM strukardin ;
					GROUP BY cod_articu,cod_alma,nro_lote ;
					INTO CURSOR cSaldos
				*SELECT cod_articu,cod_alma,nro_lote,tip_produc,cod_ordprd,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(impsol_ing - impsol_sal) AS stock_vals,;
					SUM(impdol_ing - impdol_sal) AS stock_vald,;
					SUM(cant_conos * IIF(rad_moti = "ING",1,-1)) AS stock_cono,;
					preprosol,preprodol,;
					tip_produc ;
					FROM strukardin ;
					GROUP BY cod_articu,cod_alma,nro_lote,cod_ordprd ;
					INTO CURSOR cSaldos
				SELECT cod_articu,cod_alma,nro_lote,tip_produc,cod_ordprd,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(cant_conos * IIF(rad_moti = "ING",1,-1)) AS stock_cono,;
					preprosol,preprodol,;
					tip_produc ;
					FROM strukardin ;
					GROUP BY cod_articu,cod_alma,nro_lote,cod_ordprd ;
					INTO CURSOR cSaldos
				USE IN IIF(USED("strukardin") AND !ll_Used,"strukardin",0)
			CASE pcTipoAlmacen = "PT"
				ll_Used = USED("strukardpt")
				*SELECT cod_articu,cod_alma,cod_calid,tip_produc,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(impsol_ing - impsol_sal) AS stock_vals,;
					SUM(impdol_ing - impdol_sal) AS stock_vald,;
					SUM(peso_prod * IIF(rad_moti = "ING",1,-1)) AS stock_peso,;
					preprosol,preprodol,;
					tip_produc ;
					FROM strukardpt ;
					GROUP BY cod_articu,cod_alma,cod_calid ;
					INTO CURSOR cSaldos
				*SELECT cod_articu,cod_alma,cod_calid,tip_produc,cod_ordprd,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(impsol_ing - impsol_sal) AS stock_vals,;
					SUM(impdol_ing - impdol_sal) AS stock_vald,;
					SUM(peso_prod * IIF(rad_moti = "ING",1,-1)) AS stock_peso,;
					preprosol,preprodol,;
					tip_produc ;
					FROM strukardpt ;
					GROUP BY cod_articu,cod_alma,cod_calid,cod_ordprd ;
					INTO CURSOR cSaldos
				SELECT cod_articu,cod_alma,cod_calid,tip_produc,cod_ordprd,;
					SUM(cantid_ing - cantid_sal) AS stock_arti,;
					SUM(peso_prod * IIF(rad_moti = "ING",1,-1)) AS stock_peso,;
					preprosol,preprodol,;
					tip_produc ;
					FROM strukardpt ;
					GROUP BY cod_articu,cod_alma,cod_calid,cod_ordprd ;
					INTO CURSOR cSaldos
				USE IN IIF(USED("strukardpt") AND !ll_Used,"strukardpt",0)
		ENDCASE
		*****
	ENDIF
	*****
ENDIF
IF USED("cSaldos")
	***** Archivo Kardex que va contener los saldos del a�o anterior
	pcAliasKardex = pcFileKardex
	IF EMPTY(pcFileKardex)
		pcFileKardex = CREATE_FILE_KARDEX(pcTipoAlmacen,CTOD("01/01/" + pcYear))
		pcAliasKardex = "KAR" + pcTipoAlmacen + pcYear
	ENDIF
	ll_Used = USED(pcAliasKardex)
	IF !ll_Used
		SELE 0
		USE (pcFileKardex)
	ENDIF
	SELE (pcAliasKardex)
	ll_Exist_Index = .F.
	FOR I = 1 TO 254
		IF !EMPTY(TAG(I))
			ll_Exist_Index = (TAG(I) = "DOCUMENTO")
			IF ll_Exist_Index
				EXIT
			ENDIF
		ELSE
			EXIT
		ENDIF
	ENDFOR
	IF ll_Exist_Index
		lc_Order = ORDER()
		SET ORDER TO documento
		SEEK "SALD"
		SCAN WHILE tipdoc = "SALD"
			DELETE
		ENDSCAN
		IF !EMPTY(lc_Order)
			SET ORDER TO &lc_Order.
		ENDIF
	ENDIF
	*****
	SELE 0
	USE maesmoti ALIAS operacion AGAIN
	SELECT 0
	&& Peso de Conos
	USE maevar ORDER radcod
	zPeso_Conos = IIF(SEEK("PXC" + "PXC","maevar"),maevar.varfac,0.030)
	USE 
	&&
	lnNroDoc = 1
	lnItem = 0
	SELE cSaldos
	*SCAN FOR stock_arti > 0
	SCAN FOR stock_arti != 0
		SCATTER MEMVAR
		lnItem = lnItem + 1
		*m.cod_articu = 
		m.cod_auxi = "50622029"
		m.cod_prov = ""
		*m.cod_alma = 
		m.cod_alma1 = ""
		m.tipdoc = "SALD"
		m.serie = "INI"
		m.nrodoc = PADL(lnNroDoc,10,"0")
		m.item = PADL(lnItem,4,"0")
		m.fecha_reg = CTOD("01/01/" + PADL(INT(VAL(pcYear)),4))
		m.rad_moti = "ING"
		m.cod_moti = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","MOT_SLD_INI")
		*m.cod_ordprd = ""
		m.cod_mone = "SOL" 
		m.tipcam_cod = "V"
		*m.tipcam_val = TIPO_CAMBIO(m.fecha_reg,m.tipcam_cod)
		m.precom_sol = m.preprosol
		m.precom_dol = m.preprodol
		m.prepro_sol = m.preprosol
		m.prepro_dol = m.preprodol
		m.cantid_ing = m.stock_arti
		m.cantid_sal = 0
		m.cantid_sld = m.stock_arti
		m.impsol_ing = (m.stock_arti * m.prepro_sol)
		m.impsol_sal = 0
		m.impsol_sld = (m.stock_arti * m.prepro_sol)
		m.impdol_ing = (m.stock_arti * m.prepro_dol)
		m.impdol_sal = 0
		m.impdol_sld = (m.stock_arti * m.prepro_dol)
		m.tipcam_val = (m.impsol_ing / m.impdol_ing) && De esta manera se genera un TC exacto por cada registro
		DO CASE
			CASE pcTipoAlmacen = "IN"
				*m.nro_lote = 
				m.peso_bruto = 0
				m.cant_conos = m.stock_cono
				m.peso_conos = zPeso_Conos
			CASE pcTipoAlmacen = "PT"
				*m.cod_calid = 
				m.peso_prod = m.stock_peso
		ENDCASE
		= SEEK(m.rad_moti + m.cod_moti,"operacion","codigo")
		m.orden = operacion.cod_orden
		m.docrel_tip = ""
		m.docrel_ser = ""
		m.docrel_nro = ""
		m.docrel_itm = ""
		m.doccom1tip = ""
		m.doccom1ser = ""
		m.doccom1nro = ""
		m.doccom1fec = CTOD("")
		m.doccom2tip = ""
		m.doccom2ser = ""
		m.doccom2nro = ""
		m.doccom2fec = CTOD("")
		*m.tip_produc = 
		m.ubica1 = ""
		m.ord_compra = ""
		m.docori_tip = ""
		m.docori_ser = ""
		m.docori_nro = ""
		m.docori_itm = ""
		***
		INSERT INTO (pcFileKardex) FROM MEMVAR
		IF lnItem >= 9999
			lnNroDoc = lnNroDoc + 1
			lnItem = 0
		ENDIF		
	ENDSCAN
	USE
	IF !ll_Used
		USE IN (pcAliasKardex)
	ENDIF
	USE IN IIF(USED("operacion"),"operacion",0)
ENDIF
SELECT(ln_Select)