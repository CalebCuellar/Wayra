LPARAMETERS pcNameCursorTarget,pcTypeOS,pcNumberOS,pcSerieDocument,pcNumberDocument,pcNumberOP,pcDescriptionOP
* pcNameCursorTarget = Nombre del Cursor donde se mostrara el saldo de la OS
* pcTypeOS = Tipo de Orden de Servicio (IN=Insumo, PT=Producto Terminado)
* pcNumberOS = Número de Orden de Servicio (Serie + Número)
* pcSerieDocument = Serie de Documento
* pcNumberDocument = Numero de Documento
* pcNumberOP = Número de Orden de Producción
* pcDescriptionOP = Descripción de Orden de Producción
ln_Select = SELECT()
*** Abriendo Tablas
DO CASE
	CASE pcTypeOS = "IN"
		lcTableOS1 = "ords1"
		lcTableOS2 = "ords2"
		lcTablePI1 = "pari1"
		lcTablePI2 = "pari2"
		lcTableArticle = "maesinsu"
	CASE pcTypeOS = "PT"
		lcTableOS1 = "nots1"
		lcTableOS2 = "nots2"
		lcTablePI1 = "noti1"
		lcTablePI2 = "noti2"
		lcTableArticle = "maesarti"
ENDCASE
SELECT 0
USE (lcTableOS1) ORDER (lcTableOS1) ALIAS os1 AGAIN
SELECT 0
USE (lcTableOS2) ORDER (lcTableOS2) ALIAS os2 AGAIN
SELECT 0
USE (lcTableArticle) ORDER codigo ALIAS article AGAIN
SELECT 0
USE (lcTablePI1) ORDER (lcTablePI1) ALIAS consumo1 AGAIN
SELECT 0
*USE (lcTablePI2) ORDER seg_ordser ALIAS consumo2 AGAIN
USE (lcTablePI2) ORDER docrel ALIAS consumo2 AGAIN
***
llOSEstado = .F.
*** Tipo de Cambio
lnTipCam_OS = 0
SELECT os1
SEEK pcNumberOS
IF FOUND()
	llOSEstado = !os1.cod_anula
	lnTipCam_OS = TIPOCAMBIO(os1.fecha_reg,"V")
ENDIF
***
IF llOSEstado
	*** Correlativo de Item
	SELECT MAX(item) AS ultimo FROM (pcNameCursorTarget) INTO CURSOR cTemp
	lnItem = IIF(!ISNULL(cTemp.ultimo),INT(VAL(cTemp.ultimo)),0)
	USE
	***
	*** Articulos
	SELECT os2
	SEEK pcNumberOS
	SCAN WHILE serie + nrodoc = pcNumberOS
		*** Verificando existencia de Articulo en el Cursor Destino
		SELECT (pcNameCursorTarget)
		LOCATE FOR cod_articu = os2.cod_articu
		IF FOUND()
			LOOP
		ENDIF
		***
		*** Cantidad de Producción entregada por el Proveedor
		lnConsumo = 0
		IF USED("consumo1") AND USED("consumo2")
			SELECT consumo2
			*SEEK pcTypeOS + pcNumberOS + os2.cod_articu
			*SCAN WHILE tip_ordser + seg_ordser + cod_articu = pcTypeOS + pcNumberOS + os2.cod_articu
			*SEEK IIF(pcTypeOS = "IN","ORDS","NOTS") + pcNumberOS + os2.cod_articu
			*SCAN WHILE docrel_tip + docrel_ser + docrel_nro + cod_articu = IIF(pcTypeOS = "IN","ORDS","NOTS") + pcNumberOS + os2.cod_articu
			SEEK IIF(pcTypeOS = "IN","ORDS","NOTS") + pcNumberOS + os2.item
			SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = IIF(pcTypeOS = "IN","ORDS","NOTS") + pcNumberOS + os2.item
				SELECT consumo1
				SEEK consumo2.serie + consumo2.nrodoc
				IF FOUND() AND !consumo1.cod_anula
					lnConsumo = lnConsumo + consumo2.cantidad
				ENDIF
			ENDSCAN
		ENDIF
		***
		lnSaldo = os2.cantidad - lnConsumo
		IF lnSaldo <= 0
			LOOP
		ENDIF
		STORE 0 TO lnPrecio1,lnPrecio2
		DO COSTO_DE_PRODUCCION.PRG WITH os1.cod_ordprd,pcTypeOS,os2.cod_articu,os1.serie + os1.nrodoc,"","lnPrecio1","lnPrecio2"
		SELECT article
		SEEK ALLTRIM(os2.cod_articu)
		*** Ingresando Saldo
		lnItem = lnItem + 1
		SELECT (pcNameCursorTarget)
		APPEND BLANK
		REPLACE serie		WITH pcSerieDocument
		REPLACE nrodoc		WITH pcNumberDocument
		REPLACE item		WITH TRANSFORM(lnItem,"@L 9999")
		REPLACE tip_produc	WITH "P"
		REPLACE cod_articu	WITH os2.cod_articu
		REPLACE des_articu	WITH os2.des_articu
		REPLACE cod_intemp	WITH os2.cod_intemp
		DO CASE
			CASE pcTypeOS = "IN"
				REPLACE cod_color WITH article.cod_colo
				REPLACE des_color WITH article.des_colo
				REPLACE cod_medi1 WITH article.cod_med1
				REPLACE des_medi1 WITH article.des_med1
			CASE pcTypeOS = "PT"
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
		REPLACE precio_1	WITH lnPrecio1
		REPLACE precio_2	WITH lnPrecio2
		REPLACE obs_deta	WITH os2.obs_deta
		IF TYPE(pcNameCursorTarget + ".cod_ordprd") # "U" AND TYPE("pcNumberOP") = "C"
			REPLACE cod_ordprd	WITH pcNumberOP
		ENDIF
		IF TYPE(pcNameCursorTarget + ".des_ordprd") # "U" AND TYPE("pcDescriptionOP") = "C"
			REPLACE des_ordprd	WITH pcDescriptionOP
		ENDIF
		*REPLACE tip_ordser	WITH pcTypeOS
		*REPLACE seg_ordser	WITH pcNumberOS
		DO CASE
			CASE pcTypeOS = "IN"
				REPLACE docrel_tip WITH "ORDS"
			CASE pcTypeOS= "PT"
				REPLACE docrel_tip WITH "NOTS"
		ENDCASE
		REPLACE docrel_ser	WITH SUBSTR(pcNumberOS,1,4)
		REPLACE docrel_nro	WITH SUBSTR(pcNumberOS,5,10)
		REPLACE docrel_itm	WITH os2.item
		REPLACE new_usu		WITH _usuario
		REPLACE new_fec		WITH DATE()
		REPLACE new_hor		WITH TIME()
		***
	ENDSCAN
	***
ENDIF
*** Cerrando Tablas
USE IN os1
USE IN os2
USE IN consumo1
USE IN consumo2
USE IN article
***
GO TOP IN (pcNameCursorTarget)
SELECT(ln_Select)