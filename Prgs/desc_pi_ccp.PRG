PARAMETERS pcNameCursorHeader,pcNameCursorDetail,plUpdate,pnFichaQuantity,pcNameCursor1,pcNameCursor2,pcNameCursor3,pcNameCursor4,pcNameCursor5
* pcNameCursorHeader: Cursor Cabecera de Partes de Ingreso(tipo,serie,nrodoc,marca)
* pcNameCursorDetail: Cursor Detalle de Partes de Ingreso(tipo,serie,nrodoc,cod_articu,marca)
* pnFichaQuantity: 0 = Cantidad según PI, 1 = Sino existe PI respeta la Cantidad según OP
pnFichaQuantity = IIF(TYPE("pnFichaQuantity") = "N" AND INLIST(pnFichaQuantity,0,1),pnFichaQuantity,0)
ln_Select = SELECT()
WAIT WINDOW "Consulta de Consumo... Espere un momento" NOWAIT
*** Abriendo Tablas
SELECT 0
USE ordp2 ORDER ordp2 ALIAS op2
SELECT 0
USE ordpftpro ORDER codigo ALIAS opftpro
SELECT 0
USE ordpftpro3 ORDER codigo ALIAS opftpro3
SELECT 0
USE maesinsu ORDER codigo ALIAS insumo AGAIN
SELECT 0
USE maesarti ORDER codigo ALIAS producto AGAIN
SELECT 0
USE maesunid ORDER codigo ALIAS unidad AGAIN
SELECT 0
USE maes_op ORDER codigo ALIAS op AGAIN
CREATE CURSOR cPI1(tipo C(4),serie C(4),nrodoc C(10),fecha_reg D,cod_alma C(3),cod_alma1 C(3),cod_ordprd C(8),des_ordprd C(100),;
	op_serie C(4),op_nrodoc C(10),op_descri C(100),docrel_tip C(4),docrel_ser C(4),docrel_nro C(10),docrel_fec D,;
	ps_gene L,ps1_serie C(4),ps1_nrodoc C(10),ps2_serie C(4),ps2_nrodoc C(10),ps_sw L,marca L)
CREATE CURSOR cPI2(tipo C(4),serie C(4),nrodoc C(10),item C(4),cod_articu C(15),cod_intemp C(50),descri C(150),um C(10),cantidad N(16,6),;
	op_serie C(4),op_nrodoc C(10),op_item C(4),op_arti C(15),op_proc C(5),op_cant N(16,6),op_tipo N(1),docrel_itm C(4),marca L)
INDEX ON tipo+serie+nrodoc+cod_articu TAG codigo
&& Cursor Insumos según Ficha Técnica
CREATE CURSOR cSupplyFT(tipo C(4),serie C(4),nrodoc C(10),art_tipo C(2),art_codi C(15),item C(4),codigo C(15),cod_intemp C(50),cantidad1 N(16,6),merma N(16,6),cantidad2 N(16,6))
INDEX ON tipo+serie+nrodoc+art_tipo+art_codi+item TAG codigo
&& Cursor Insumos\Grupo(Lote o Calidad) según Documento de Salida
CREATE CURSOR cSupplyGP(tipo C(4),serie C(4),nrodoc C(10),item C(4),art_tipo C(2),art_codi C(15),art_grup C(15),cantds N(16,6),cantstk N(16,6),cantstkop N(16,6))
INDEX ON tipo+serie+nrodoc+item+art_tipo+art_codi+art_grup TAG codigo1
INDEX ON tipo+serie+nrodoc+art_tipo+art_codi+art_grup TAG codigo2 ADDITIVE
&& Cursor Documentos de Insumos\Grupo(Lote o Calidad) según Documento de Salida
CREATE CURSOR cSupplyDS(tipo C(4),serie C(4),nrodoc C(10),item C(4),art_tipo C(2),art_codi C(15),art_grup C(15),ds_tipo C(4),ds_serie C(4),ds_nrodoc C(10),ds_fecha D,ds_cantid N(16,6))
INDEX ON tipo+serie+nrodoc+item+art_tipo+art_codi+art_grup+ds_tipo+ds_serie+ds_nrodoc TAG codigo
*****
lc_cod_moti = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","MOT_SAL_PRD")
lc_cod_moti = IIF(!ISNULL(lc_cod_moti),lc_cod_moti,"")
***** Obteniendo Partes de Ingreso *****
SELECT (pcNameCursorHeader)
lnRecnoPI = IIF(!EOF(),RECNO(),0)
SCAN
	lcPI_Type = &pcNameCursorHeader..tipo
	lcPI_Serie = &pcNameCursorHeader..serie
	lcPI_Number = &pcNameCursorHeader..nrodoc
	IF ISNULL(lcPI_Type) OR EMPTY(lcPI_Type) OR ISNULL(lcPI_Serie) OR EMPTY(lcPI_Serie) OR ISNULL(lcPI_Number) OR EMPTY(lcPI_Number)
		LOOP
	ENDIF
	*** Abriendo Tablas
	SELECT 0
	lcTableName = lcPI_Type + "1"
	USE (lcTableName) ORDER (lcTableName) ALIAS pi1 AGAIN
	SELECT 0
	lcTableName = lcPI_Type + "2"
	USE (lcTableName) ORDER (lcTableName) ALIAS pi2 AGAIN
	lcTableProduct = IIF(lcPI_Type = "PARI","insumo","producto")
	***
	*** Solo Partes de Ingreso Activas y que provengan de una Orden de Servicio Activa y del mismo tipo (PI Insumos = OS Insumos ó PI PT = OS PT)
	SELECT pi1
	SEEK lcPI_Serie + lcPI_Number
	llSw = (FOUND() AND !pi1.cod_anula AND INLIST(pi1.docrel_tip,"ORDS","NOTS") AND !EMPTY(pi1.docrel_ser) AND !EMPTY(pi1.docrel_nro) AND ;
		IIF(lcPI_Type = "PARI",(pi1.docrel_tip = "ORDS"),(pi1.docrel_tip = "NOTS")))
	IF llSw	
		SELECT 0
		lcTableName = pi1.docrel_tip + "1"
		USE (lcTableName) ORDER (lcTableName) ALIAS os1 AGAIN
		SEEK pi1.docrel_ser + pi1.docrel_nro
		llSw = (FOUND() AND !os1.cod_anula)
		USE
	ENDIF
	***
	IF llSw
		= SEEK(pi1.cod_ordprd,"op")
		*** Abriendo Tablas
		SELECT 0
		lcTableName = pi1.docrel_tip + "2"
		USE (lcTableName) ORDER (lcTableName) ALIAS os2 AGAIN
		SELECT 0
		lcTableName = pi1.docrel_tip + "3"
		USE (lcTableName) ORDER (lcTableName) ALIAS os3 AGAIN
		***
		*** Parte de Ingreso - Cabecera
		SELE cPI1
		APPEND BLANK
		REPLACE tipo WITH lcPI_Type
		REPLACE serie WITH lcPI_Serie
		REPLACE nrodoc WITH lcPI_Number
		REPLACE fecha_reg WITH pi1.fecha_reg
		REPLACE cod_alma WITH pi1.cod_alma
		REPLACE cod_alma1 WITH pi1.cod_alma1
		REPLACE cod_ordprd WITH pi1.cod_ordprd
		REPLACE des_ordprd WITH pi1.des_ordprd
		REPLACE op_serie WITH PADR(PADL(SUBSTR(pi1.cod_ordprd,1,2),3,"0"),4," ") && ver si se puede eliminar
		REPLACE op_nrodoc WITH PADL(SUBSTR(pi1.cod_ordprd,4,5),10,"0") && ver si se puede eliminar
		REPLACE op_descri WITH op.descliop && ver si se puede eliminar
		REPLACE docrel_tip WITH pi1.docrel_tip
		REPLACE docrel_ser WITH pi1.docrel_ser
		REPLACE docrel_nro WITH pi1.docrel_nro
		REPLACE docrel_fec WITH pi1.docrel_fec
		REPLACE ps_gene WITH pi1.ps_gene
		REPLACE ps1_serie WITH pi1.ps1_serie
		REPLACE ps1_nrodoc WITH pi1.ps1_nrodoc
		REPLACE ps2_serie WITH pi1.ps2_serie
		REPLACE ps2_nrodoc WITH pi1.ps2_nrodoc
		***
		*** Parte de Ingreso - Detalle
		SELECT pi2
		SEEK lcPI_Serie + lcPI_Number
		SCAN WHILE serie + nrodoc = lcPI_Serie + lcPI_Number
			= SEEK(pi2.cod_articu,lcTableProduct)
			= SEEK(&lcTableProduct..cod_unimed,"unidad")
			SELECT cPI2
			APPEND BLANK
			REPLACE tipo WITH lcPI_Type
			REPLACE serie WITH lcPI_Serie
			REPLACE nrodoc WITH lcPI_Number
			REPLACE item WITH pi2.item
			REPLACE cod_articu WITH pi2.cod_articu
			REPLACE cod_intemp WITH &lcTableProduct..cod_intemp
			REPLACE descri WITH &lcTableProduct..descri
			REPLACE um WITH unidad.abrevia
			REPLACE cantidad WITH pi2.cantidad
			REPLACE docrel_itm WITH pi2.docrel_itm
			&& Obteniendo información de la OP
			SELECT os2
			SEEK pi2.docrel_ser + pi2.docrel_nro + pi2.docrel_itm
			IF FOUND()
				&& Capturando el Primer Proceso
				SELECT os3
				SEEK os2.serie + os2.nrodoc + os2.item
				IF FOUND()
					SELECT cPI2
					REPLACE op_serie WITH PADR(PADL(SUBSTR(pi1.cod_ordprd,1,2),3,"0"),4," ")
					REPLACE op_nrodoc WITH PADL(SUBSTR(pi1.cod_ordprd,4,5),10,"0")
					REPLACE op_item WITH os2.itm_op
					REPLACE op_arti WITH os2.art_op
					REPLACE op_proc WITH os3.itm_pro
				ENDIF
				&&
			ENDIF
			&&
		ENDSCAN
		***
		*** Cerrando Tablas
		USE IN os2
		USE IN os3
		***
	ENDIF
	*** Cerrando Tablas
	USE IN pi1
	USE IN pi2
	***
ENDSCAN
*****
***** Productos enviados a fabricar a los Proveedores por: O/P, Item y Proceso *****
CREATE CURSOR cOP_FT(op_serie C(4),op_nrodoc C(10),op_item C(4),op_proc C(5),op_cant N(16,6),cantidad N(16,6),op_tipo N(1))
INDEX ON op_serie+op_nrodoc+op_item+op_proc TAG codigo
CREATE CURSOR cOP_FT1(op_serie C(4),op_nrodoc C(10),op_item C(4),op_proc C(5),;
	os_tipo C(4),os_articu C(15),os_articu1 C(50),os_um C(10),cantidad N(16,6),porcentaje N(6,2))
INDEX ON op_serie+op_nrodoc+op_item+op_proc+os_tipo+os_articu TAG codigo
CREATE CURSOR cOP_FT2(op_serie C(4),op_nrodoc C(10),op_item C(4),op_proc C(5),;
	os_tipo C(4),os_serie C(4),os_nrodoc C(10),os_fecha D,;
	os_item C(4),os_articu C(15),os_articu1 C(50),os_descri C(150),os_um C(10),os_cansoli N(16,6),os_canprod N(16,6))

SELECT op_serie,op_nrodoc,op_item,op_proc FROM cPI2 ;
	WHERE !EMPTY(op_serie) AND !EMPTY(op_nrodoc) AND !EMPTY(op_item) AND !EMPTY(op_proc) ;
	GROUP BY op_serie,op_nrodoc,op_item,op_proc INTO CURSOR cTemp
lnY = RECCOUNT()
lnX = 0
SCAN
	lnX = lnX + 1
	WAIT WINDOW "Consulta de Ordenes de Servicio por Proceso de O/P..." + BARRA(lnX,lnY) + " %" NOWAIT
	*** Recorriendo las Ordenes de Servicio
	FOR lnA = 1 TO 2
		lcOS_Type = IIF(lnA = 1,"ORDS","NOTS")
		*** Abriendo Tablas
		SELECT 0
		lcTableName = lcOS_Type + "1"
		USE (lcTableName) ORDER (lcTableName) ALIAS os1 AGAIN
		SELECT 0
		lcTableName = lcOS_Type + "2"
		USE (lcTableName) ORDER seg_op ALIAS os2 AGAIN
		SELECT 0
		lcTableName = lcOS_Type + "3"
		USE (lcTableName) ORDER (lcTableName) ALIAS os3 AGAIN
		lcTableProduct = IIF(lnA = 1,"insumo","producto")
		***
		SELECT os2
		SEEK cTemp.op_serie + cTemp.op_nrodoc + cTemp.op_item
		SCAN WHILE ser_op + nro_op + itm_op = cTemp.op_serie + cTemp.op_nrodoc + cTemp.op_item
			SELECT os1
			SEEK os2.serie + os2.nrodoc
			llSw = (FOUND() AND !os1.cod_anula)
			IF llSw
				SELECT os3
				SEEK os2.serie + os2.nrodoc + os2.item
				llSw = (FOUND() AND os3.itm_pro = cTemp.op_proc)
			ENDIF
			IF llSw
				= SEEK(os2.cod_articu,lcTableProduct)
				= SEEK(&lcTableProduct..cod_unimed,"unidad")
				lnCantidad_Producida = OS_ITEM_INGRESO(lcOS_Type,os2.serie,os2.nrodoc,os2.item)
				SELECT cOP_FT2
				APPEND BLANK
				REPLACE op_serie WITH cTemp.op_serie
				REPLACE op_nrodoc WITH cTemp.op_nrodoc
				REPLACE op_item WITH cTemp.op_item
				REPLACE op_proc WITH cTemp.op_proc
				REPLACE os_tipo WITH lcOS_Type
				REPLACE os_serie WITH os2.serie
				REPLACE os_nrodoc WITH os2.nrodoc
				REPLACE os_fecha WITH os1.fecha_reg
				REPLACE os_item WITH os2.item
				REPLACE os_articu WITH os2.cod_articu
				REPLACE os_articu1 WITH &lcTableProduct..cod_intemp
				REPLACE os_descri WITH os2.des_articu
				REPLACE os_um WITH unidad.abrevia
				REPLACE os_cansoli WITH os2.cantidad
				REPLACE os_canprod WITH lnCantidad_Producida
			ENDIF
		ENDSCAN
		*** Cerrando Tablas
		USE IN os1
		USE IN os2
		USE IN os3
		***
	ENDFOR
	***
ENDSCAN
USE
&& Totalizando por OP,Proceso y Producto
SELECT op_serie,op_nrodoc,op_item,op_proc,SUM(os_canprod) AS cantidad FROM cOP_FT2 ;
	GROUP BY op_serie,op_nrodoc,op_item,op_proc INTO CURSOR cTemp
SELECT op_serie,op_nrodoc,op_item,op_proc,os_tipo,os_articu,SUM(os_canprod) AS cantidad FROM cOP_FT2 ;
	GROUP BY op_serie,op_nrodoc,op_item,op_proc,os_tipo,os_articu INTO CURSOR cTemp1
INDEX ON op_serie+op_nrodoc+op_item+op_proc+os_tipo+os_articu TAG codigo
SELECT cTemp
SCAN
	&&
	SELECT cOP_FT
	APPEND BLANK
	REPLACE op_serie WITH cTemp.op_serie
	REPLACE op_nrodoc WITH cTemp.op_nrodoc
	REPLACE op_item WITH cTemp.op_item
	REPLACE op_proc WITH cTemp.op_proc
	&& Cantidad según PI
	lnTypeQuantity = 1
	lnQuantity = OP_ITEM_INGRESO(cTemp.op_serie,cTemp.op_nrodoc,cTemp.op_item)
	&&
	IF lnQuantity = 0 AND pnFichaQuantity = 1
		&& Cantidad según OP
		lnTypeQuantity = 0
		SELECT op2
		SEEK cTemp.op_serie + cTemp.op_nrodoc + cTemp.op_item
		lnQuantity = op2.cantidad
		&&
	ENDIF
	SELECT cOP_FT
	REPLACE op_cant WITH lnQuantity
	REPLACE cantidad WITH cTemp.cantidad
	REPLACE op_tipo WITH lnTypeQuantity
	&&
	&&
	SELECT cTemp1
	SEEK cTemp.op_serie + cTemp.op_nrodoc + cTemp.op_item + cTemp.op_proc
	SCAN WHILE op_serie + op_nrodoc + op_item + op_proc = cTemp.op_serie + cTemp.op_nrodoc + cTemp.op_item + cTemp.op_proc
		lcTableProduct = IIF(cTemp1.os_tipo = "ORDS","insumo","producto")
		= SEEK(cTemp1.os_articu,lcTableProduct)
		= SEEK(&lcTableProduct..cod_unimed,"unidad")
		SELECT cOP_FT1
		APPEND BLANK
		REPLACE op_serie WITH cTemp1.op_serie
		REPLACE op_nrodoc WITH cTemp1.op_nrodoc
		REPLACE op_item WITH cTemp1.op_item
		REPLACE op_proc WITH cTemp1.op_proc
		REPLACE os_tipo WITH cTemp1.os_tipo
		REPLACE os_articu WITH cTemp1.os_articu
		REPLACE os_articu1 WITH &lcTableProduct..cod_intemp
		REPLACE os_um WITH unidad.abrevia
		REPLACE cantidad WITH cTemp1.cantidad
		REPLACE porcentaje WITH (cTemp1.cantidad/cTemp.cantidad)
	ENDSCAN
	&&
ENDSCAN
USE
USE IN cTemp1
&&
*****
***** Artículos según Ficha Técnica y Documentos de Salida por Parte de Ingreso (O/S) *****
SELECT cSupplyGP
SET ORDER TO codigo1

SELECT cPI1
lnY = RECCOUNT()
lnX = 0
SCAN
	lnX = lnX + 1
	WAIT WINDOW "Consulta de Fichas Técnicas y Documentos de Salida por P/I..." + BARRA(lnX,lnY) + " %" NOWAIT
	ldPI_Date = cPI1.fecha_reg
	lcPI_Store = cPI1.cod_alma1
	lcOp_Serie = cPI1.op_serie
	lcOp_Number = cPI1.op_nrodoc
	lcOp_Codigo = cPI1.cod_ordprd
	lcOS_Type = cPI1.docrel_tip
	lcOS_Serie = cPI1.docrel_ser
	lcOS_Number = cPI1.docrel_nro
	IF EMPTY(lcOp_Serie) OR EMPTY(lcOp_Number)
		LOOP
	ENDIF
	SELECT cPI2
	SEEK cPI1.tipo + cPI1.serie + cPI1.nrodoc
	SCAN WHILE tipo + serie + nrodoc = cPI1.tipo + cPI1.serie + cPI1.nrodoc
		*lcProductCode = ALLTRIM(cPI2.cod_articu)
		*** Según Ficha Técnica
		IF !EMPTY(cPI2.op_serie) AND !EMPTY(cPI2.op_nrodoc) AND !EMPTY(cPI2.op_arti) AND !EMPTY(cPI2.op_proc)
			SELE cOP_FT
			SEEK cPI2.op_serie + cPI2.op_nrodoc + cPI2.op_item + cPI2.op_proc
			&&
			SELECT cPI2
			REPLACE op_cant WITH cOP_FT.op_cant
			REPLACE op_tipo WITH cOP_FT.op_tipo
			&&
			SELECT opftpro
			SEEK cPI2.op_serie + cPI2.op_nrodoc + cPI2.op_arti + cPI2.op_proc
			SELECT opftpro3
			SEEK cPI2.op_serie + cPI2.op_nrodoc + cPI2.op_arti + cPI2.op_proc
			SCAN WHILE serie + nrodoc + codigo + item = cPI2.op_serie + cPI2.op_nrodoc + cPI2.op_arti + cPI2.op_proc
				SELECT cSupplyFT
				APPEND BLANK
				REPLACE tipo WITH cPI1.tipo
				REPLACE serie WITH cPI1.serie
				REPLACE nrodoc WITH cPI1.nrodoc
				REPLACE art_tipo WITH opftpro3.tipo
				REPLACE art_codi WITH opftpro3.cod_articu
				REPLACE item WITH cPI2.item
				REPLACE codigo WITH cPI2.cod_articu
				REPLACE cod_intemp WITH cPI2.cod_intemp
				*REPLACE cantidad1 WITH (((opftpro3.cantidad1*cOP_FT.op_cant)/cOP_FT.cantidad) * cPI2.cantidad) && ccp
				*REPLACE cantidad2 WITH (((opftpro3.cantidad*cOP_FT.op_cant)/cOP_FT.cantidad) * cPI2.cantidad) && ccp
				lnCantidad1 = cPI2.cantidad
				lnCantidad2 = (cOP_FT.cantidad/cOP_FT.op_cant)
				&& HILOS
				IF cPI2.tipo = "PARI" && PARTE DE INGRESO DE INSUMO
					IF !EMPTY(opftpro.umecodigo) AND opftpro.ftpancho > 0 AND opftpro.ftplargo > 0 && PROCESO TIENE ANCHO Y LARGO
						= SEEK(ALLTRIM(cPI2.cod_articu),"insumo")
						IF insumo.cod_fami = "00002" AND insumo.cod_unimed = opftpro.umecodigo && EL INSUMO ES TELA Y TIENE LA MISMA UM DEL PROCESO
							lnCantidad1 = (cPI2.cantidad * insumo.ancho_val)
							lnCantidad2 = (opftpro.ftpancho * opftpro.ftplargo)
						ENDIF
					ENDIF
				ENDIF
				&&
				&& Aplicando regla de tres simple
				* opftpro3.cantidad ----- lnCantidad2
				*         X         ----- lnCantidad1
				* X = (opftpro3.cantidad * lnCantidad1) / lnCantidad2
				SELECT cSupplyFT
				REPLACE cantidad1 WITH (opftpro3.cantidad1*lnCantidad1)/lnCantidad2
				REPLACE cantidad2 WITH (opftpro3.cantidad*lnCantidad1)/lnCantidad2
				REPLACE merma WITH cSupplyFT.cantidad2 - cSupplyFT.cantidad1
				&&
			ENDSCAN
		ENDIF
		***
		IF !EMPTY(lcOS_Type) AND !EMPTY(lcOS_Serie) AND !EMPTY(lcOS_Number) AND !EMPTY(ldPI_Date) AND !EMPTY(lcPI_Store)
			*** Según Documentos de Salida
			&& Para realizar la liquidación del Almacen del Proveedor se necesita conocer el Número de Lote o Calidad del Producto,
			&& esta información se obtendra de los Documentos de Salida
			FOR lnA = 1 TO 2
				lcOR_Type = IIF(lnA = 1,"ORDR","NOTR")
				*** Abriendo Tablas
				SELECT 0
				lcTableName = lcOR_Type + "1"
				USE (lcTableName) ORDER (lcTableName) ALIAS or1 AGAIN
				SELECT 0
				lcTableName = lcOR_Type + "2"
				USE (lcTableName) ORDER seg_ordser ALIAS or2 AGAIN
				***
				*** Recorriendo Ordenes de Requerimiento
				SELECT or2
				SEEK IIF(lcOS_Type = "ORDS","IN","PT") + lcOS_Serie + lcOS_Number + cPI2.docrel_itm
				SCAN WHILE tip_ordser + ser_ordser + nro_ordser + itm_ordser = IIF(lcOS_Type = "ORDS","IN","PT") + lcOS_Serie + lcOS_Number + cPI2.docrel_itm
					SELECT or1
					SEEK or2.serie + or2.nrodoc
					IF !FOUND() OR or1.cod_anula OR or1.cod_ordprd != lcOp_Codigo
						LOOP
					ENDIF
					*** Recorriendo Partes de Salida y Guías de Remisión por Orden de Requerimiento
					FOR lnB = 1 TO 2
						lcDS_Type = IIF(lnA = 1,IIF(lnB = 1,"PARS","GUIA"),IIF(lnB = 1,"NOTE","REMI"))
						*** Abriendo Tablas
						SELECT 0
						lcTableName = lcDS_Type + "1"
						USE (lcTableName) ORDER (lcTableName) ALIAS ds1 AGAIN
						SELECT 0
						lcTableName = lcDS_Type + "2"
						USE (lcTableName) ORDER docrel ALIAS ds2 AGAIN
						***
						SELECT ds2
						lcSeekField = "docrel_tip + docrel_ser + docrel_nro + docrel_itm"
						lcSeekString = lcOR_Type + or2.serie + or2.nrodoc + or2.item
						SEEK lcSeekString
						&& BORRAR LUEGO QUE SE REGULARICE EL CAMPO docrel_itm DE LOS DOCUMENTOS DE SALIDA
						llSw = FOUND()
						IF !llSw
							lcSeekField = "docrel_tip + docrel_ser + docrel_nro"
							lcSeekString = lcOR_Type + or2.serie + or2.nrodoc
							SEEK lcSeekString
						ENDIF
						&&
						SCAN WHILE &lcSeekField. = lcSeekString
							IF ds2.cod_ordprd != lcOp_Codigo
								LOOP
							ENDIF
							SELECT ds1
							SEEK ds2.serie + ds2.nrodoc
							IF !FOUND() OR ds1.cod_anula OR ds1.fecha_reg > ldPI_Date OR ds1.cod_alma1 != lcPI_Store OR ds1.cod_moti != "004" OR ds1.cod_ordprd != lcOp_Codigo
								LOOP
							ENDIF
							&& BORRAR LUEGO QUE SE REGULARICE EL CAMPO docrel_itm DE LOS DOCUMENTOS DE SALIDA
							IF !llSw
								IF ds2.cod_articu != or2.cod_articu
									LOOP
								ENDIF
							ENDIF
							&&
							lcArticleType = IIF(lnA = 1,"IN","PT")
							lcArticleCode = PADR(ds2.cod_articu,15)
							lcArticleGroup = IIF(lnA = 1,ds2.nro_lote,ds2.cod_calid)
							*** Grupos(Lote o Calidad) Enviados x Documento\Item
							SELECT cSupplyGP
							SEEK cPI1.tipo + cPI1.serie + cPI1.nrodoc + cPI2.item + lcArticleType + lcArticleCode + lcArticleGroup
							IF !FOUND()
								APPEND BLANK
								REPLACE tipo WITH cPI1.tipo
								REPLACE serie WITH cPI1.serie
								REPLACE nrodoc WITH cPI1.nrodoc
								REPLACE item WITH cPI2.item
								REPLACE art_tipo WITH lcArticleType
								REPLACE art_codi WITH lcArticleCode
								REPLACE art_grup WITH lcArticleGroup
							ENDIF
							***
							*** Documentos Enviados x Documento\Item
							SELECT cSupplyDS
							SEEK cPI1.tipo + cPI1.serie + cPI1.nrodoc + cPI2.item + lcArticleType + lcArticleCode + lcArticleGroup + lcDS_Type + ds2.serie + ds2.nrodoc
							IF !FOUND()
								APPEND BLANK
								REPLACE tipo WITH cPI1.tipo
								REPLACE serie WITH cPI1.serie
								REPLACE nrodoc WITH cPI1.nrodoc
								REPLACE item WITH cPI2.item
								REPLACE art_tipo WITH lcArticleType
								REPLACE art_codi WITH lcArticleCode
								REPLACE art_grup WITH lcArticleGroup
								REPLACE ds_tipo WITH lcDS_Type
								REPLACE ds_serie WITH ds2.serie
								REPLACE ds_nrodoc WITH ds2.nrodoc
								REPLACE ds_fecha WITH ds1.fecha_reg
								*REPLACE ds_cantid WITH ds2.cantidad
								IF llSw
									REPLACE ds_cantid WITH ds2.cantidad
								ENDIF
							ENDIF
							IF !llSw
								REPLACE ds_cantid WITH cSupplyDS.ds_cantid + or2.cantidad
							ENDIF
							***
						ENDSCAN
						*** Cerrando Tablas
						USE IN ds1
						USE IN ds2
						***
					ENDFOR
					***
				ENDSCAN
				***
				*** Cerrando Tablas
				USE IN or1
				USE IN or2
				***
			ENDFOR
			***
		ENDIF
	ENDSCAN
ENDSCAN
*****
CREATE CURSOR cSupply1(tipo C(4),serie C(4),nrodoc C(10),item C(4),;
	art_tipo C(2),art_codi C(15),cod_intemp C(50),art_desc C(150),art_um C(10),;
	cantft N(16,6),cantds N(16,6),cantstk N(16,6),cantstkop N(16,6),marca L)
INDEX ON tipo+serie+nrodoc TAG codigo
CREATE CURSOR cSupply2(tipo C(4),serie C(4),nrodoc C(10),;
	item C(4),art_tipo C(2),art_codi C(15),cod_intemp C(50),art_desc C(150),art_um C(10),;
	cantft N(16,6),cantds N(16,6),cantstk N(16,6),cantstkop N(16,6),marca L)
***** Actualizando Stock de Productos *****
SELE cPI1
lnY = RECCOUNT()
lnX = 0
SCAN
	lnX = lnX + 1
	WAIT WINDOW "Consulta de Consumo... Insumos " + BARRA(lnX,lnY) + " %" NOWAIT
	lcPI_Type = cPI1.tipo
	lcPI_Serie = cPI1.serie
	lcPI_Number = cPI1.nrodoc
	ldPI_Date = cPI1.fecha_reg
	lcPI_Store = cPI1.cod_alma1
	lcOp_Codigo = cPI1.cod_ordprd
	*** Insumos por Cabecera del Parte de Ingreso (según Ficha Técnica)
	SELECT cSupplyGP
	SET ORDER TO codigo2
	llMarkHeader1 = .T.
	lnSupply = 0
	SELECT art_tipo,art_codi,SUM(cantidad1) AS totcanti1,SUM(merma) AS totmerma,SUM(cantidad2) AS totcanti2 FROM cSupplyFT ;
		WHERE tipo+serie+nrodoc = lcPI_Type+lcPI_Serie+lcPI_Number GROUP BY art_tipo,art_codi INTO CURSOR cTemp
	SCAN
		*** Actualizando el stock disponible del Insumo\Grupo(Lote o Calidad) relacionados al Producto
		*** En esta actualización se puede repetir el Insumo\Grupo ya que podría estar siendo usado en mas de un Producto del Documento
		SELECT cSupplyGP
		SEEK lcPI_Type + lcPI_Serie + lcPI_Number + cTemp.art_tipo + cTemp.art_codi
		SCAN WHILE tipo + serie + nrodoc + art_tipo + art_codi = lcPI_Type + lcPI_Serie + lcPI_Number + cTemp.art_tipo + cTemp.art_codi
			STORE 0 TO lnCant,lnStock,lnStockOP
			&& Cantidad Enviada según Documentos de Salida
			SELE cSupplyDS
			SEEK lcPI_Type + lcPI_Serie + lcPI_Number + cSupplyGP.item + cTemp.art_tipo + cTemp.art_codi + cSupplyGP.art_grup
			SCAN WHILE tipo + serie + nrodoc + item + art_tipo + art_codi + art_grup = lcPI_Type + lcPI_Serie + lcPI_Number + cSupplyGP.item + cTemp.art_tipo + cTemp.art_codi + cSupplyGP.art_grup
				lnCant = lnCant + cSupplyDS.ds_cantid
			ENDSCAN
			&&
			IF !EMPTY(lcPI_Store) AND !EMPTY(ldPI_Date)
				lcPS_Type = IIF(cTemp.art_tipo = "IN","PARS","NOTE")
				lcPS_Serie = IIF(cTemp.art_tipo = "IN",cPI1.ps1_serie,cPI1.ps2_serie)
				lcPS_Number = IIF(cTemp.art_tipo = "IN",cPI1.ps1_nrodoc,cPI1.ps2_nrodoc)
				DO CASE
					CASE cTemp.art_tipo = "IN"
						= SALDO_ARTICULO(lcPI_Store,cTemp.art_codi,cSupplyGP.art_grup,ldPI_Date,"lnStock")
					CASE cTemp.art_tipo = "PT"
						= SALDO_ARTICULO_PT(lcPI_Store,cTemp.art_codi,ALLTRIM(cSupplyGP.art_grup),ldPI_Date,"lnStock")
				ENDCASE
				lnStockOP = SALDO_ARTICULO_OP(cTemp.art_tipo,lcPI_Store,cTemp.art_codi,ALLTRIM(cSupplyGP.art_grup),lcOp_Codigo,ldPI_Date,"",ldPI_Date)
			ENDIF
			SELECT cSupplyGP
			REPLACE cantds WITH lnCant
			REPLACE cantstk WITH lnStock
			REPLACE cantstkop WITH lnStockOP
		ENDSCAN
		***
		*** Insumos por Cabecera del Parte de Ingreso (según Ficha Técnica)
		lcTableProduct = IIF(cTemp.art_tipo = "IN","insumo","producto")
		= SEEK(ALLTRIM(cTemp.art_codi),lcTableProduct)
		= SEEK(&lcTableProduct..cod_unimed,"unidad")
		lnTotFT = cTemp.totcanti2 && Cantidad según Ficha Técnica
		lnSupply = lnSupply + 1
		lcCodigo = lcPI_Type + lcPI_Serie + lcPI_Number + cTemp.art_tipo + cTemp.art_codi
		&& Se agrupa para NO repetir el stock del Insumo\Grupo
		lnTotCant = 0 && Cantidad Enviada
		lnTotStock = 0 && Cantidad según Stock
		lnTotStockOP = 0 && Cantidad según Stock por OP
		SELECT art_grup,cantds,cantstk,cantstkop FROM cSupplyGP WHERE tipo+serie+nrodoc+art_tipo+art_codi = lcCodigo ;
			GROUP BY art_grup,cantds,cantstk,cantstkop INTO CURSOR cTemp1
		SCAN
			lnTotCant = lnTotCant + cTemp1.cantds
			lnTotStock = lnTotStock + cTemp1.cantstk
			lnTotStockOP = lnTotStockOP + cTemp1.cantstkop
		ENDSCAN
		USE
		&&
		SELE cSupply1
		APPEND BLANK
		REPLACE tipo WITH lcPI_Type
		REPLACE serie WITH lcPI_Serie
		REPLACE nrodoc WITH lcPI_Number
		REPLACE item WITH PADL(lnSupply,4,"0")
		REPLACE art_tipo WITH cTemp.art_tipo
		REPLACE art_codi WITH cTemp.art_codi
		REPLACE cod_intemp WITH &lcTableProduct..cod_intemp
		REPLACE art_desc WITH &lcTableProduct..descri
		REPLACE art_um WITH unidad.abrevia
		REPLACE cantft WITH lnTotFT
		REPLACE cantds WITH lnTotCant
		REPLACE cantstk WITH lnTotStock
		REPLACE cantstkop WITH lnTotStockOP
		REPLACE marca WITH (cSupply1.cantft <= cSupply1.cantstkop)
		IF llMarkHeader1 AND !cSupply1.marca
			llMarkHeader1 = .F.
		ENDIF
		***
	ENDSCAN
	USE
	***
	*** Insumos por Detalle del Parte de Ingreso (según Ficha Técnica)
	SELECT cSupplyGP
	SET ORDER TO codigo1

	llMarkHeader2 = .T.
	SELE cPI2
	SEEK lcPI_Type + lcPI_Serie + lcPI_Number
	SCAN WHILE tipo + serie + nrodoc = lcPI_Type + lcPI_Serie + lcPI_Number
		lcProductItem = cPI2.item
		SELECT art_tipo,art_codi,SUM(cantidad1) AS totcanti1,SUM(merma) AS totmerma,SUM(cantidad2) AS totcanti2 FROM cSupplyFT ;
			WHERE tipo+serie+nrodoc+item = lcPI_Type+lcPI_Serie+lcPI_Number+lcProductItem GROUP BY art_tipo,art_codi INTO CURSOR cTemp
		llMarkDetail = !EOF()
		SCAN
			lnTotFT = cTemp.totcanti2 && Cantidad según Ficha Técnica
			lnTotDS = 0 && Cantidad Enviada
			lnTotStock = 0 && Cantidad según Stock
			lnTotStockOP = 0 && Cantidad según Stock por OP
			SELECT cSupplyGP
			SEEK lcPI_Type + lcPI_Serie + lcPI_Number + cPI2.item + cTemp.art_tipo + cTemp.art_codi
			SCAN WHILE tipo + serie + nrodoc + item + art_tipo + art_codi = lcPI_Type + lcPI_Serie + lcPI_Number + cPI2.item + cTemp.art_tipo + cTemp.art_codi
				lnTotDS = lnTotDS + cSupplyGP.cantds
				lnTotStock = lnTotStock + cSupplyGP.cantstk
				lnTotStockOP = lnTotStockOP + cSupplyGP.cantstkop
			ENDSCAN
			lcTableProduct = IIF(cTemp.art_tipo = "IN","insumo","producto")
			= SEEK(ALLTRIM(cTemp.art_codi),lcTableProduct)
			= SEEK(&lcTableProduct..cod_unimed,"unidad")
			SELE cSupply2
			APPEND BLANK
			REPLACE tipo WITH lcPI_Type
			REPLACE serie WITH lcPI_Serie
			REPLACE nrodoc WITH lcPI_Number
			REPLACE item WITH cPI2.item
			REPLACE art_tipo WITH cTemp.art_tipo
			REPLACE art_codi WITH cTemp.art_codi
			REPLACE cod_intemp WITH &lcTableProduct..cod_intemp
			REPLACE art_desc WITH &lcTableProduct..descri
			REPLACE art_um WITH unidad.abrevia
			REPLACE cantft WITH lnTotFT
			REPLACE cantds WITH lnTotDS
			REPLACE cantstk WITH lnTotStock
			REPLACE cantstkop WITH lnTotStockOP
			REPLACE marca WITH (cSupply2.cantft <= cSupply2.cantstkop)
			IF llMarkDetail AND !cSupply2.marca
				llMarkDetail = .F.
			ENDIF
		ENDSCAN
		USE
		SELE cPI2
		REPLACE marca WITH llMarkDetail
		IF llMarkHeader2 AND !cPI2.marca
			llMarkHeader2 = .F.
		ENDIF
	ENDSCAN
	***
	SELE cPI1
	REPLACE marca WITH (llMarkHeader1 AND llMarkHeader2)
ENDSCAN
*****
***** Actualizando Estado de Cursores Origenes *****
IF TYPE(pcNameCursorHeader + ".marca") != "U"
	SELECT cPI1
	lnY = RECCOUNT()
	lnX = 0
	SCAN
		lnX = lnX + 1
		WAIT WINDOW "Consulta de Consumo... Actualizando Tabla Origen " + BARRA(lnX,lnY) + " %" NOWAIT
		*** Actualizando Cabecera
		SELECT (pcNameCursorHeader)
		LOCATE FOR tipo + serie + nrodoc = cPI1.tipo + cPI1.serie + cPI1.nrodoc
		REPLACE marca WITH cPI1.marca
		***
		IF !EMPTY(pcNameCursorDetail) AND USED(pcNameCursorDetail) AND TYPE(pcNameCursorDetail + ".marca") != "U"
			*** Actualizando Detalle
			SELECT cPI2
			SEEK cPI1.tipo + cPI1.serie + cPI1.nrodoc
			SCAN WHILE tipo + serie + nrodoc = cPI1.tipo + cPI1.serie + cPI1.nrodoc
				SELECT (pcNameCursorDetail)
				*LOCATE FOR tipo + serie + nrodoc + cod_articu = cPI2.tipo + cPI2.serie + cPI2.nrodoc + cPI2.cod_articu
				LOCATE FOR tipo + serie + nrodoc + item = cPI2.tipo + cPI2.serie + cPI2.nrodoc + cPI2.item && CCP
				IF FOUND()
					REPLACE marca WITH cPI2.marca
					IF TYPE(pcNameCursorDetail + ".op_serie") != "U"
						REPLACE op_serie WITH cPI2.op_serie
					ENDIF
					IF TYPE(pcNameCursorDetail + ".op_nrodoc") != "U"
						REPLACE op_nrodoc WITH cPI2.op_nrodoc
					ENDIF
					IF TYPE(pcNameCursorDetail + ".op_item") != "U"
						REPLACE op_item WITH cPI2.op_item
					ENDIF
					IF TYPE(pcNameCursorDetail + ".op_arti") != "U"
						REPLACE op_arti WITH cPI2.op_arti
					ENDIF
					IF TYPE(pcNameCursorDetail + ".op_proc") != "U"
						REPLACE op_proc WITH cPI2.op_proc
					ENDIF
					IF TYPE(pcNameCursorDetail + ".op_cant") != "U"
						REPLACE op_cant WITH cPI2.op_cant
					ENDIF
					IF TYPE(pcNameCursorDetail + ".op_tipo") != "U"
						REPLACE op_tipo WITH cPI2.op_tipo
					ENDIF
				ENDIF
			ENDSCAN
			***
		ENDIF
	ENDSCAN
ENDIF
***
IF plUpdate
	*** 
	ll_Used = USED("maevar")
	SELECT varfac FROM maevar WHERE varrad + varcod = "PXC" + "PXC" INTO CURSOR cTemp
	ln_peso_conos = IIF(FOUND(),cTemp.varfac, 0.030)
	USE
	USE IN IIF(USED("maevar") AND !ll_Used,SELECT("maevar"),0)
	ln_tipcam_cod = "V"
	***
	*** Abriendo Tablas
	SELECT 0
	USE pari1 ORDER pari1 ALIAS piin1 AGAIN
	SELECT 0
	USE pari2 ORDER pari2 ALIAS piin2 AGAIN
	SELECT 0
	USE noti1 ORDER noti1 ALIAS pipt1 AGAIN
	SELECT 0
	USE noti2 ORDER noti2 ALIAS pipt2 AGAIN
	SELECT 0
	USE pars1 ORDER pars1 ALIAS psin1 AGAIN
	SELECT 0
	USE pars2 ORDER pars2 ALIAS psin2 AGAIN
	SELECT 0
	USE note1 ORDER note1 ALIAS pspt1 AGAIN
	SELECT 0
	USE note2 ORDER note2 ALIAS pspt2 AGAIN
	SELECT 0
	USE ords1 ORDER ords1 ALIAS osin1 AGAIN
	SELECT 0
	USE ords2 ORDER ords2 ALIAS osin2 AGAIN
	SELECT 0
	USE nots1 ORDER nots1 ALIAS ospt1 AGAIN
	SELECT 0
	USE nots2 ORDER nots2 ALIAS ospt2 AGAIN
	***
	*** Cursor para la actualización de Costos de Producción
	lcCursorNameCP = SYS(2015)
	CREATE CURSOR (lcCursorNameCP)(tipo C(4),serie C(4),nrodoc C(10),item C(4))
	***
	*** Recorriendo Partes de Ingreso
	SELECT cPI1
	lnY = RECCOUNT()
	lnX = 0
	SCAN
		lnX = lnX + 1
		WAIT WINDOW "Generando Partes de Salida... " + BARRA(lnX,lnY) + " %" NOWAIT
		lcPI_Type = cPI1.tipo
		lcPI_Serie = cPI1.serie
		lcPI_Number = cPI1.nrodoc
		lcTableSiglaPI = IIF(cPI1.tipo = "PARI","IN","PT")
		STORE .F. TO llPS_IN,llPS_PT
		lcPS_IN_Serie = cPI1.ps1_serie
		lcPS_IN_Number = cPI1.ps1_nrodoc
		lcPS_PT_Serie = cPI1.ps2_serie
		lcPS_PT_Number = cPI1.ps2_nrodoc
		*** Registrando Partes de Salida
		FOR lnA = 1 TO 2
			DO CASE
				CASE lnA = 1 && Insumo
					lcProductType = "IN"
					lcTableSiglaPS = "PARS"
					lcPS_Serie = lcPS_IN_Serie
					lcPS_Number = lcPS_IN_Number
					lcFunctionNameDelete = "DEL_KAR.PRG"
					lcFunctionNameRecord = "SAL_KAR.PRG"
					lcCampoGrupo = "nro_lote"
				CASE lnA = 2 && Producto Terminado
					lcProductType = "PT"
					lcTableSiglaPS = "NOTE"
					lcPS_Serie = lcPS_PT_Serie
					lcPS_Number = lcPS_PT_Number
					lcFunctionNameDelete = "DEL_KAR_PT.PRG"
					lcFunctionNameRecord = "SAL_KAR_PT.PRG"
					lcCampoGrupo = "cod_calid"
			ENDCASE
			lcTableNamePS1 = "PS" + lcProductType + "1"
			lcTableNamePS2 = "PS" + lcProductType + "2"
			IF !EMPTY(lcPS_Serie) AND !EMPTY(lcPS_Number)
				*** Eliminando Parte de Salida actual
				SELECT (lcTableNamePS1)
				SEEK lcPS_Serie + lcPS_Number
				IF FOUND()
					ldPS_Date = &lcTableNamePS1..fecha_reg
					SELECT (lcTableNamePS2)
					SEEK lcPS_Serie + lcPS_Number
					SCAN WHILE serie + nrodoc = lcPS_Serie + lcPS_Number
						= BLOQUEARECORD()
						REPLACE del_usu WITH _usuario
						REPLACE del_fec WITH DATE()
						REPLACE del_hor WITH TIME()
						DELETE NEXT 1
						UNLOCK
					ENDSCAN
					SELECT (lcTableNamePS1)
					= BLOQUEARECORD()
					REPLACE del_usu WITH _usuario
					REPLACE del_fec WITH DATE()
					REPLACE del_hor WITH TIME()
					DELETE NEXT 1
					UNLOCK
					*** Eliminando Kardex
					DO &lcFunctionNameDelete. WITH lcTableSiglaPS,lcPS_Serie,lcPS_Number,ldPS_Date
					***
				ENDIF
				***
			ENDIF
			SELECT b.item AS pi_itm,c.* FROM cPI2 b ;
				INNER JOIN cPI1 a ON a.tipo + a.serie + a.nrodoc = b.tipo + b.serie + b.nrodoc ;
				INNER JOIN cSupply2 c ON c.tipo + c.serie + c.nrodoc + c.item = b.tipo + b.serie + b.nrodoc + b.item ;
				WHERE b.tipo + b.serie + b.nrodoc = lcPI_Type + lcPI_Serie + lcPI_Number AND a.marca AND c.marca AND c.art_tipo = lcProductType ;
				AND c.cantft > 0 ORDER BY b.item,c.art_tipo,c.art_codi INTO CURSOR cDetail
			IF !EOF()
				IF EMPTY(lcPS_Serie) OR EMPTY(lcPS_Number)
					lcPS_Serie = "001"
					*** Actualizando Numeración
					lcPS_Number = DOC_OBT_NUM("DOC" + lcTableSiglaPS,lcPS_Serie,.T.,"C",10)
					***
				ENDIF
				*** Cabecera
				ln_tipcam_val = TIPOCAMBIO(cPI1.fecha_reg,ln_tipcam_cod)
				lc_cod_mone = "SOL"
				SELECT(lcTableNamePS1)
				= BLOQUEAFILE()
				APPEND BLANK
				REPLACE serie WITH lcPS_Serie
				REPLACE nrodoc WITH lcPS_Number
				REPLACE fecha_reg WITH cPI1.fecha_reg
				REPLACE cod_moti WITH lc_cod_moti
				REPLACE cod_alma WITH cPI1.cod_alma1
				*REPLACE cod_auxi WITH 
				*REPLACE cod_prov WITH 
				REPLACE cod_mone WITH lc_cod_mone
				REPLACE docrel_tip WITH lcPI_Type
				REPLACE docrel_ser WITH lcPI_Serie
				REPLACE docrel_nro WITH lcPI_Number
				REPLACE docrel_fec WITH cPI1.fecha_reg
				REPLACE docrel_aut WITH .T.
				REPLACE tipcam_cod WITH ln_tipcam_cod
				REPLACE tipcam_val WITH ln_tipcam_val
				REPLACE cod_ordprd WITH cPI1.cod_ordprd
				REPLACE des_ordprd WITH cPI1.des_ordprd
				REPLACE new_usu WITH _usuario
				REPLACE new_fec WITH DATE()
				REPLACE new_hor WITH TIME()
				UNLOCK
				***
				*** Detalle
				SELECT (lcTableNamePS2)
				= BLOQUEAFILE()
				lnItem = 0
				SELECT cDetail
				SCAN
					lnDownload = 0
					SELE cSupplyGP
					*SEEK lcPI_Type + lcPI_Serie + lcPI_Number + cDetail.art_tipo + cDetail.art_codi
					*SCAN WHILE tipo + serie + nrodoc + art_tipo + art_codi = lcPI_Type + lcPI_Serie + lcPI_Number + cDetail.art_tipo + cDetail.art_codi
					SEEK lcPI_Type + lcPI_Serie + lcPI_Number + cDetail.pi_itm + cDetail.art_tipo + cDetail.art_codi
					SCAN WHILE tipo + serie + nrodoc + item + art_tipo + art_codi = lcPI_Type + lcPI_Serie + lcPI_Number + cDetail.pi_itm + cDetail.art_tipo + cDetail.art_codi
						*IF (lnDownload + cSupplyGP.cantstkop) <= cDetail.cantft
						*	lnQuantity = cSupplyGP.cantstkop
						*ELSE
						*	lnQuantity = (cDetail.cantft - lnDownload)
						*ENDIF
						*** Solo se puede retirar (como máximo) la cantidad enviada
						IF (lnDownload + cSupplyGP.cantds) <= cDetail.cantft
							lnQuantity = cSupplyGP.cantds
						ELSE
							lnQuantity = (cDetail.cantft - lnDownload)
						ENDIF
						***
						lnDownload = lnDownload + lnQuantity
						lnItem = lnItem + 1
						SELECT (lcTableNamePS2)
						APPEND BLANK
						REPLACE serie WITH lcPS_Serie
						REPLACE nrodoc WITH lcPS_Number
						REPLACE item WITH PADL(lnItem,4,"0")
						REPLACE cod_articu WITH cDetail.art_codi
						REPLACE des_articu WITH cDetail.art_desc
						REPLACE cod_intemp WITH cDetail.cod_intemp
						REPLACE &lcCampoGrupo. WITH cSupplyGP.art_grup
						IF TYPE(lcTableNamePS2 + ".peso_bruto") != "U"
							REPLACE peso_bruto WITH lnQuantity
						ENDIF
						IF TYPE(lcTableNamePS2 + ".cant_conos") != "U"
							*REPLACE cant_conos WITH 
						ENDIF
						IF TYPE(lcTableNamePS2 + ".peso_conos") != "U"
							REPLACE peso_conos WITH ln_peso_conos
						ENDIF
						REPLACE cantidad WITH lnQuantity
						REPLACE cod_ordprd WITH cPI1.cod_ordprd
						REPLACE des_ordprd WITH cPI1.des_ordprd
						REPLACE new_usu WITH _usuario
						REPLACE new_fec WITH DATE()
						REPLACE new_hor WITH TIME()
						REPLACE tip_produc WITH "P"
						REPLACE docrel_tip WITH lcPI_Type
						REPLACE docrel_ser WITH lcPI_Serie
						REPLACE docrel_nro WITH lcPI_Number
						REPLACE docrel_itm WITH cDetail.pi_itm
						IF lnDownload >= cDetail.cantft
							EXIT
						ENDIF
					ENDSCAN
				ENDSCAN
				SELECT (lcTableNamePS2)
				UNLOCK
				***
				*** Actualizando Kardex
				DO &lcFunctionNameRecord. WITH lcTableSiglaPS,&lcTableNamePS1..cod_moti,&lcTableNamePS1..serie,&lcTableNamePS1..nrodoc,&lcTableNamePS1..cod_alma,"",&lcTableNamePS1..fecha_reg,&lcTableNamePS1..tipcam_cod,&lcTableNamePS1..tipcam_val,lcTableNamePS2,&lcTableNamePS1..cod_mone
				***
				*** Actualizando Variables de Numeración
				DO CASE
					CASE lnA = 1 && Insumo
						llPS_IN = .T.
						lcPS_IN_Serie = lcPS_Serie
						lcPS_IN_Number = lcPS_Number
					CASE lnA = 2 && Producto Terminado
						llPS_PT = .T.
						lcPS_PT_Serie = lcPS_Serie
						lcPS_PT_Number = lcPS_Number
				ENDCASE
				***
			ENDIF
			USE IN cDetail
			***
		ENDFOR
		***
		IF llPS_IN OR llPS_PT
			*** Actualizando Parte de Ingreso
			lcTableNamePI = "PI" + lcTableSiglaPI + "1"
			SELECT (lcTableNamePI)
			SEEK lcPI_Serie + lcPI_Number
			IF FOUND()
				= BLOQUEARECORD()
				&& El Código de TC es Otro y su Valor será referencial. El TC es por cada Item del Detalle y se encuentra en el Kardex
				REPLACE tipcam_cod WITH "O"
				&&
				REPLACE ps_gene WITH .T.
				REPLACE ps1_serie WITH lcPS_IN_Serie
				REPLACE ps1_nrodoc WITH lcPS_IN_Number
				REPLACE ps2_serie WITH lcPS_PT_Serie
				REPLACE ps2_nrodoc WITH lcPS_PT_Number
				UNLOCK
			ENDIF
			***
			*** Actualizando Cursor de Costo de Producción
			SELECT cPI2
			SEEK lcPI_Type + lcPI_Serie + lcPI_Number
			SCAN WHILE tipo + serie + nrodoc = lcPI_Type + lcPI_Serie + lcPI_Number
				INSERT INTO (lcCursorNameCP) VALUES(lcPI_Type,lcPI_Serie,lcPI_Number,cPI2.item)
			ENDSCAN
			***
		ENDIF
	ENDSCAN
	***
	*** Cerrando Tablas
	USE IN piin1
	USE IN piin2
	USE IN pipt1
	USE IN pipt2
	USE IN psin1
	USE IN psin2
	USE IN pspt1
	USE IN pspt2
	USE IN osin1
	USE IN osin2
	USE IN ospt1
	USE IN ospt2
	***
	***
	IF !EOF(lcCursorNameCP)
		= COSTO_PRODUCCION(lcCursorNameCP,.T.)
	ENDIF
	USE IN (lcCursorNameCP)
	***
ENDIF
WAIT CLEAR
SELECT (pcNameCursorHeader)
IF lnRecnoPI > 0
	GO lnRecnoPI
ENDIF
IF !EMPTY(pcNameCursor1)
	SELECT * FROM cSupply1 INTO CURSOR (pcNameCursor1)
ENDIF
IF !EMPTY(pcNameCursor2)
	SELECT * FROM cSupply2 INTO CURSOR (pcNameCursor2)
ENDIF
IF !EMPTY(pcNameCursor3)
	&& Ordenes de Servicio por O/P
	SELECT * FROM cOP_FT2 INTO CURSOR (pcNameCursor3)
ENDIF
IF !EMPTY(pcNameCursor4)
	SELECT * FROM cSupplyGP INTO CURSOR (pcNameCursor4)
ENDIF
IF !EMPTY(pcNameCursor5)
	SELECT * FROM cSupplyDS INTO CURSOR (pcNameCursor5)
ENDIF
*** Cerrando Tablas
USE IN cPI1
USE IN cPI2
USE IN op2
USE IN opftpro
USE IN opftpro3
USE IN insumo
USE IN producto
USE IN unidad
USE IN op
USE IN cSupplyFT
USE IN cSupplyGP
USE IN cSupplyDS
USE IN cSupply1
USE IN cSupply2
USE IN cOP_FT
USE IN cOP_FT1
USE IN cOP_FT2
***
SELECT(ln_Select)
RETURN