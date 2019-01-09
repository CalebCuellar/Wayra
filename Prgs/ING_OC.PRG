PARAMETERS pcNameCursorTarget,pcTypeOC,pcNumberOC,pcSerieDocument,pcNumberDocument,pcNumberOP,pcDescriptionOP
* pcNameCursorTarget = Nombre del Cursor donde se mostrara el saldo de la OC
* pcTypeOC = Tipo de Orden de Compra (IN=Insumo, PT=Producto Terminado)
* pcNumberOC = Número de Orden de Compra (Serie + Número)
* pcSerieDocument = Serie de Documento
* pcNumberDocument = Numero de Documento
* pcNumberOP = Número de Orden de Producción
* pcDescriptionOP = Descripción de Orden de Producción
ln_Select = SELECT()
*** Abriendo Tablas
DO CASE
	CASE pcTypeOC = "IN"
		lcTableOC1 = "ordc1"
		lcTableOC2 = "ordc2"
		lcTablePI1 = "pari1"
		lcTablePI2 = "pari2"
		lcTableArticle = "maesinsu"
	CASE pcTypeOC = "PT"
		lcTableOC1 = "notc1"
		lcTableOC2 = "notc2"
		lcTablePI1 = "noti1"
		lcTablePI2 = "noti2"
		lcTableArticle = "maesarti"
ENDCASE
SELECT 0
USE (lcTableOC1) ORDER (lcTableOC1) ALIAS oc1 AGAIN
SELECT 0
USE (lcTableOC2) ORDER (lcTableOC2) ALIAS oc2 AGAIN
SELECT 0
USE (lcTableArticle) ORDER codigo ALIAS article AGAIN
SELECT 0
USE (lcTablePI1) ORDER (lcTablePI1) ALIAS tConsumo1 AGAIN
SELECT 0
*USE (lcTablePI2) ORDER seg_ordcom ALIAS tConsumo2 AGAIN
USE (lcTablePI2) ORDER docrel ALIAS tConsumo2 AGAIN
***
llOCEstado = .F.
*** Tipo de Cambio
lnTipCam_OC = 0
SELECT oc1
SEEK pcNumberOC
IF FOUND()
	llOCEstado = !oc1.cod_anula
	lnTipCam_OC = TIPOCAMBIO(oc1.fecha_reg,"V")
ENDIF
***
IF llOCEstado
	*** Correlativo de Item
	SELECT MAX(item) AS ultimo FROM (pcNameCursorTarget) INTO CURSOR cTemp
	lnItem = IIF(!ISNULL(cTemp.ultimo),INT(VAL(cTemp.ultimo)),0)
	USE
	***
	*** Articulos
	SELECT oc2
	SEEK pcNumberOC
	SCAN WHILE serie + nrodoc = pcNumberOC
		*** Verificando existencia de Articulo
		SELECT (pcNameCursorTarget)
		LOCATE FOR cod_articu = oc2.cod_articu
		IF FOUND()
			LOOP
		ENDIF
		***
		*** Consumo
		lnConsumo = 0
		IF USED("tConsumo1") AND USED("tConsumo2")
			SELECT tConsumo2
			*SEEK pcNumberOC + oc2.cod_articu
			*SCAN WHILE seg_ordcom + cod_articu = pcNumberOC + oc2.cod_articu
			*SEEK IIF(pcTypeOC = "IN","ORDC","NOTC") + pcNumberOC + oc2.cod_articu
			*SCAN WHILE docrel_tip + docrel_ser + docrel_nro + cod_articu = IIF(pcTypeOC = "IN","ORDC","NOTC")+ pcNumberOC + oc2.cod_articu
			SEEK IIF(pcTypeOC = "IN","ORDC","NOTC") + pcNumberOC + oc2.item
			SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = IIF(pcTypeOC = "IN","ORDC","NOTC")+ pcNumberOC + oc2.item
				SELECT tConsumo1
				SEEK tConsumo2.serie + tConsumo2.nrodoc
				IF FOUND() AND !tConsumo1.cod_anula
					lnConsumo = lnConsumo + tConsumo2.cantidad
				ENDIF
			ENDSCAN
		ENDIF
		***
		lnSaldo = oc2.cantidad - lnConsumo
		IF lnSaldo <= 0
			LOOP
		ENDIF
		SELECT article
		SEEK ALLTRIM(oc2.cod_articu)
		*** Ingresando Saldo
		lnItem = lnItem + 1
		SELECT (pcNameCursorTarget)
		APPEND BLANK
		REPLACE serie		WITH pcSerieDocument
		REPLACE nrodoc		WITH pcNumberDocument
		REPLACE item		WITH TRANSFORM(lnItem,"@L 9999")
		REPLACE tip_produc	WITH "P"
		REPLACE cod_articu	WITH oc2.cod_articu
		REPLACE des_articu	WITH oc2.des_articu
		REPLACE cod_intemp	WITH oc2.cod_intemp
		DO CASE
			CASE pcTypeOC = "IN"
				REPLACE cod_color WITH article.cod_colo
				REPLACE des_color WITH article.des_colo
				REPLACE cod_medi1 WITH article.cod_med1
				REPLACE des_medi1 WITH article.des_med1
			CASE pcTypeOC = "PT"
				REPLACE cod_tipmed WITH article.cod_time
				REPLACE des_tipmed WITH article.des_time
				REPLACE cod_medida WITH article.cod_medi
				REPLACE des_medida WITH article.des_medi
				REPLACE cod_color WITH article.cod_col1
				REPLACE des_color WITH article.des_col1
				REPLACE prv_color WITH article.cod_colpr1
				REPLACE cod_unidad WITH article.cod_unimed
				REPLACE des_unidad WITH article.des_unimed
		ENDCASE
		REPLACE cantidad	WITH lnSaldo
		DO CASE
			CASE oc1.cod_mone = "SOL"
				REPLACE precio_1	WITH oc2.precio_1
				REPLACE precio_2	WITH IIF(lnTipCam_OC > 0,ROUND(oc2.precio_1 / lnTipCam_OC,6),0)
			CASE oc1.cod_mone = "DOL"
				REPLACE precio_2	WITH oc2.precio_2
				REPLACE precio_1	WITH IIF(lnTipCam_OC > 0,ROUND(oc2.precio_2 * lnTipCam_OC,6),0)
		ENDCASE
		REPLACE obs_deta	WITH oc2.obs_deta
		*REPLACE nro_lote	WITH m.nro_lote
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
		*REPLACE seg_ordcom	WITH pcNumberOC
		DO CASE
			CASE pcTypeOC = "IN"
				REPLACE docrel_tip WITH "ORDC"
			CASE pcTypeOC = "PT"
				REPLACE docrel_tip WITH "NOTC"
		ENDCASE
		REPLACE docrel_ser	WITH SUBSTR(pcNumberOC,1,4)
		REPLACE docrel_nro	WITH SUBSTR(pcNumberOC,5,10)
		REPLACE docrel_itm	WITH oc2.item
		REPLACE new_usu		WITH _usuario
		REPLACE new_fec		WITH DATE()
		REPLACE new_hor		WITH TIME()
		***
	ENDSCAN
	***
ENDIF
*** Cerrando Tablas
USE IN oc1
USE IN oc2
USE IN tConsumo1
USE IN tConsumo2
USE IN article
***
GO TOP IN (pcNameCursorTarget)
SELECT(ln_Select)