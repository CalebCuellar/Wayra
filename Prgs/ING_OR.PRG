PARAMETERS pcNameCursorTarget,pcTypeOR,pcNumberOR,pcSerieDocument,pcNumberDocument,pcNumberOP,pcDescriptionOP
* pcNameCursorTarget = Nombre del Cursor donde se mostrara el saldo de la OR
* pcTypeOR = Tipo de Orden de Requerimiento (IN=Insumo, PT=Producto Terminado)
* pcNumberOR = Número de Orden de Requerimiento (Serie + Número)
* pcSerieDocument = Serie de Documento
* pcNumberDocument = Numero de Documento
* pcNumberOP = Número de Orden de Producción
* pcDescriptionOP = Descripción de Orden de Producción
ln_Select = SELECT()
*** Abriendo Tablas
SELECT 0
lcTableName = IIF(pcTypeOR = "IN","ORDR","NOTR") + "1"
USE (lcTableName) ORDER (lcTableName) ALIAS or1 AGAIN
SELECT 0
lcTableName = IIF(pcTypeOR = "IN","ORDR","NOTR") + "2"
USE (lcTableName) ORDER (lcTableName) ALIAS or2 AGAIN
SELECT 0
lcTableName = IIF(pcTypeOR = "IN","MAESINSU","MAESARTI")
USE (lcTableName) ORDER codigo ALIAS article AGAIN
SELECT 0
USE maesprov ORDER codigo ALIAS supplier AGAIN
CREATE CURSOR DCaptura(item C(4),cantidad N(16,6))
INDEX ON item TAG codigo
***
*** Capturando cantidad usada del Requerimiento
FOR lnI = 1 TO 2
	*** Abriendo Tablas
	DO CASE
		CASE lnI = 1
			lcTableSigla = IIF(pcTypeOR = "IN","PARS","NOTE")
		CASE lnI = 2
			lcTableSigla = IIF(pcTypeOR = "IN","GUIA","REMI")
	ENDCASE
	SELECT 0
	lcTableName = lcTableSigla + "1"
	USE (lcTableName) ORDER (lcTableName) ALIAS ds1 AGAIN
	SELECT 0
	lcTableName = lcTableSigla + "2"
	USE (lcTableName) ORDER docrel ALIAS ds2 AGAIN
	***
	SELECT ds2
	SEEK IIF(pcTypeOR = "IN","ORDR","NOTR") + pcNumberOR
	IF FOUND()
		SELECT ds1
		SEEK ds2.serie + ds2.nrodoc
		IF FOUND() AND !ds1.cod_anula
			SELECT ds2
			SCAN WHILE docrel_tip + docrel_ser + docrel_nro = IIF(pcTypeOR = "IN","ORDR","NOTR") + pcNumberOR
				IF EMPTY(ds2.docrel_itm)
					LOOP
				ENDIF
				SELECT DCaptura
				SEEK ds2.docrel_itm
				IF !FOUND()
					APPEND BLANK
				ENDIF
				REPLACE item WITH ds2.docrel_itm
				REPLACE cantidad WITH DCaptura.cantidad + ds2.cantidad
			ENDSCAN
		ENDIF
	ENDIF
	*** Cerrando Tablas
	USE IN ds1
	USE IN ds2
	***
ENDFOR
***
SELECT or1
SEEK pcNumberOR
IF FOUND() AND !or1.cod_anula
	*** Datos de la Cabecera
	m.cod_prov = or1.cod_auxi
	&& Proveedor
	SELE supplier
	SEEK m.cod_prov
	m.cod_prov = supplier.codigo
	m.des_prov = supplier.descri
	m.dir_prov = supplier.direc
	m.ruc_prov = supplier.cod_ruc
	&&
	IF pcTypeOR = "PT" AND !EMPTY(m.cod_moti)
		ll_Used = USED("maesmoti")
		SELECT indi_proc FROM maesmoti WHERE radical + codigo = "SAL" + m.cod_moti INTO CURSOR curTemp
		USE IN IIF(USED("maesmoti") AND !ll_Used,"maesmoti",0)
		llSw = (curTemp.indi_proc = "04")
		USE
		IF llSw
			m.dir_trasla = m.dir_prov
		ENDIF
	ENDIF
	m.tip_ordser = or1.tip_ordser
	m.ser_ordser = or1.ser_ordser
	m.nro_ordser = or1.nro_ordser
	IF !EMPTY(m.tip_ordser) AND !EMPTY(m.ser_ordser) AND !EMPTY(m.nro_ordser)
		&& Tipo de Servicio
		lcTabla = IIF(m.tip_ordser = "IN","ords","nots") + "1"
		SELECT 0
		USE (lcTabla) ORDER &lcTabla.
		SEEK PADR(m.ser_ordser,4," ") + m.nro_ordser
		IF FOUND()
			m.cod_tipser = &lcTabla..cod_tipser
			m.des_tipser = &lcTabla..des_tipser
		ENDIF
		USE
		&&
	ENDIF
	***
	*** Correlativo de Item
	SELECT MAX(item) AS ultimo FROM (pcNameCursorTarget) INTO CURSOR cTemp
	lnItem = IIF(!ISNULL(cTemp.ultimo),INT(VAL(cTemp.ultimo)),0)
	USE
	***
	*** Articulos
	SELECT or2
	SEEK pcNumberOR
	SCAN WHILE serie + nrodoc = pcNumberOR
		*** Verificando existencia de Articulo
		SELECT (pcNameCursorTarget)
		LOCATE FOR docrel_tip+docrel_ser+docrel_nro+docrel_itm = IIF(pcTypeOR="IN","ORDR","NOTR")+pcNumberOR+or2.item
		IF FOUND()
			LOOP
		ENDIF
		***
		IF or2.tip_produc != "P"
			LOOP
		ENDIF
		= SEEK(or2.item,"DCaptura")
		lnSaldo = or2.cantidad - DCaptura.cantidad
		IF lnSaldo <= 0
			LOOP
		ENDIF
		SELECT article
		SEEK ALLTRIM(or2.cod_articu)
		*** Ingresando Saldo
		lnItem = lnItem + 1
		SELECT (pcNameCursorTarget)
		APPEND BLANK
		REPLACE serie		WITH pcSerieDocument
		REPLACE nrodoc		WITH pcNumberDocument
		REPLACE item		WITH TRANSFORM(lnItem,"@L 9999")
		REPLACE tip_produc	WITH "P"
		REPLACE cod_articu	WITH or2.cod_articu
		REPLACE des_articu	WITH or2.des_articu
		REPLACE cod_intemp	WITH or2.cod_intemp
		DO CASE
			CASE pcTypeOR = "IN"
				REPLACE peso_bruto	WITH lnSaldo
				REPLACE peso_conos	WITH zPeso_Conos
				*REPLACE nro_lote	WITH 
			CASE pcTypeOR = "PT"
				*REPLACE cod_calid	WITH 
				*REPLACE des_calid	WITH 
		ENDCASE
		REPLACE cantidad	WITH lnSaldo
		REPLACE cantid_or	WITH lnSaldo
		REPLACE precio_1	WITH 0
		REPLACE precio_2	WITH 0
		IF TYPE(pcNameCursorTarget + ".cod_ordprd") # "U" AND TYPE("pcNumberOP") = "C"
			REPLACE cod_ordprd	WITH pcNumberOP
		ENDIF
		IF TYPE(pcNameCursorTarget + ".des_ordprd") # "U" AND TYPE("pcDescriptionOP") = "C"
			REPLACE des_ordprd	WITH pcDescriptionOP
		ENDIF
		DO CASE
			CASE pcTypeOR = "IN"
				REPLACE docrel_tip WITH "ORDR"
			CASE pcTypeOR = "PT"
				REPLACE docrel_tip WITH "NOTR"
		ENDCASE
		REPLACE docrel_ser	WITH SUBSTR(pcNumberOR,1,4)
		REPLACE docrel_nro	WITH SUBSTR(pcNumberOR,5,10)
		REPLACE docrel_itm	WITH or2.item
		REPLACE new_usu		WITH _usuario
		REPLACE new_fec		WITH DATE()
		REPLACE new_hor		WITH TIME()
		***
	ENDSCAN
	***
ENDIF
*** Cerrando Tablas
USE IN or1
USE IN or2
USE IN article
USE IN supplier
USE IN DCaptura
***
GO TOP IN (pcNameCursorTarget)
SELECT(ln_Select)