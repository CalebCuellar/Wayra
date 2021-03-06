PARAMETERS pcNumOrdprd
lcSerie = PADR(PADL(SUBSTR(pcNumOrdprd,1,2),3,"0"),4)
lcNumero = PADL(SUBSTR(pcNumOrdprd,4),10,"0")
*** Abriendo Tablas
SELECT 0
USE ordp2 ORDER ordp2 ALIAS op2 AGAIN
SELECT 0
USE ords1 ORDER ords1 AGAIN
SELECT 0
USE ords2 ORDER cod_articu AGAIN
SELECT 0
USE nots1 ORDER nots1 AGAIN
SELECT 0
USE nots2 ORDER cod_articu AGAIN
SELECT 0
USE maesinsu ORDER codigo ALIAS supplie AGAIN
SELECT 0
USE maesarti ORDER codigo ALIAS article AGAIN
SELECT 0
USE maesmoti ORDER codigo ALIAS motive AGAIN
***
CREATE CURSOR cOP(item C(4),cod_articu C(15),cod_intemp C(50),des_articu C(150),cantidad N(16,6),costo1 N(16,6),costo2 N(16,6),total1 N(16,6),total2 N(16,6))
CREATE CURSOR cProducto(tipo C(2),codigo C(15))
CREATE CURSOR cCosto(item C(4),tipo C(2),concepto C(100),codigo C(15),descri C(150),cod_intemp C(50),codigo1 C(25),cantidad N(16,6),precio1 N(16,6),precio2 N(16,6),total1 N(16,6),total2 N(16,6))
INDEX ON item TAG codigo
*** Cargando detalle de la OP
SELE op2
SEEK lcSerie + lcNumero
SCAN WHILE serie + nrodoc = lcSerie + lcNumero
	SELECT cOP
	APPEND BLANK
	REPLACE item WITH op2.item
	REPLACE cod_articu WITH op2.cod_articu
	REPLACE cod_intemp WITH op2.cod_intemp
	REPLACE des_articu WITH op2.des_articu
	REPLACE cantidad WITH op2.cantidad
ENDSCAN
***
*** Costeando Productos del detalle de la OP
SELECT cOP
SCAN
	***
	ZAP IN cProducto
	INSERT INTO cProducto VALUE("PT",cOp.cod_articu)
	P = 0
	DO WHILE .T.
		P = P + 1
		SELECT cProducto
		IF P <= RECCOUNT()
			GO P && Ubicandonos en el Producto a Costear
			*** Abriendo Tablas
			DO CASE
				CASE cProducto.tipo = "IN"
					SELECT 0
					USE ords1 ORDER ords1 ALIAS os1 AGAIN
					SELECT 0
					USE ords2 ORDER cod_articu ALIAS os2 AGAIN
					lcAliasProducto = "supplie"
				CASE cProducto.tipo = "PT"
					SELECT 0
					USE nots1 ORDER nots1 ALIAS os1 AGAIN
					SELECT 0
					USE nots2 ORDER cod_articu ALIAS os2 AGAIN
					lcAliasProducto = "article"
			ENDCASE
			***
			*** Ordenes de Servicio 
			SELECT os2
			SEEK cProducto.codigo
			SCAN WHILE cod_articu = cProducto.codigo
				SELECT os1
				SEEK os2.serie + os2.nrodoc
				IF os1.cod_anula OR os1.cod_ordprd != pcNumOrdprd
					LOOP
				ENDIF
				lcConcepto = "O/S N� " + ALLTRIM(os2.serie) + "-" + os2.nrodoc + " TIPO DE SERVICIO:" + ALLTRIM(os1.des_tipser)
				lnTipoCambio = IIF(os1.tipcam_cod="O",os1.tipcam_val,TIPO_CAMBIO(os1.fecha_reg,os1.tipcam_cod))
				DO CASE
					CASE os1.cod_mone = "SOL"
						lnPrecio1 = os2.precio_1
						IF lnTipoCambio > 0
							lnPrecio2 = ROUND(os2.precio_1/lnTipoCambio,6)
						ENDIF
					CASE os1.cod_mone = "DOL"
						lnPrecio2 = os2.precio_2
						lnPrecio1 = ROUND(os2.precio_2*lnTipoCambio,6)
				ENDCASE
				SELECT (lcAliasProducto)
				SEEK ALLTRIM(os2.cod_articu)
				INSERT INTO cCosto VALUES(cOP.item,cProducto.tipo,lcConcepto,cProducto.codigo,&lcAliasProducto..descri,&lcAliasProducto..cod_intemp,"",1,lnPrecio1,lnPrecio2,lnPrecio1,lnPrecio2)
				*** Salida seg�n Ordenes de Requerimiento
				FOR I = 1 TO 2
					*** Abriendo Tablas
					DO CASE
						CASE I = 1
							SELECT 0
							USE ordr1 ORDER ordr1 ALIAS or1 AGAIN
							SELECT 0
							USE ordr2 ORDER seg_ordser ALIAS or2 AGAIN
							SELECT 0
							USE guia1 ORDER guia1 ALIAS gr1 AGAIN
							SELECT 0
							USE guia2 ORDER seg_ordreq ALIAS gr2 AGAIN
							lcTipoGuia = "GUIA"
							lcTipo = "IN"
							lcAliasProducto = "supplie"
							
							lcAliasOS1 = "ords1"
							lcAliasOS2 = "ords2"
						CASE I = 2
							SELECT 0
							USE notr1 ORDER notr1 ALIAS or1 AGAIN
							SELECT 0
							USE notr2 ORDER seg_ordser ALIAS or2 AGAIN
							SELECT 0
							USE remi1 ORDER remi1 ALIAS gr1 AGAIN
							SELECT 0
							USE remi2 ORDER seg_ordreq ALIAS gr2 AGAIN
							lcTipoGuia = "REMI"
							lcTipo = "PT"
							lcAliasProducto = "article"
							
							lcAliasOS1 = "nots1"
							lcAliasOS2 = "nots2"
					ENDCASE
					***
					SELECT or2
					SEEK cProducto.tipo + os2.serie + os2.nrodoc + os2.cod_articu
					SCAN WHILE tip_ordser + ser_ordser + nro_ordser + art_ordser = cProducto.tipo + os2.serie + os2.nrodoc + os2.cod_articu
						SELECT or1
						SEEK or2.serie + or2.nrodoc
						IF or1.cod_anula
							LOOP
						ENDIF
						*** Verificando si es un Art�culo en Transformaci�n
						llTransformacion = .F.
						SELECT (lcAliasOS2)
						SEEK or2.cod_articu
						SCAN WHILE cod_articu = or2.cod_articu
							SELECT (lcAliasOS1)
							SEEK &cAliasOS2..serie + &cAliasOS2..nrodoc
							IF &lcAliasOS1..cod_anula = .F. AND &lcAliasOS1..cod_ordprd = pcNumOrdPrd
								llTransformacion = .T.
								INSERT INTO cProducto VALUE(lcTipo,&lcAliasOS2..cod_articu)
								EXIT
							ENDIF
						ENDSCAN
						IF llTransformacion
							LOOP
						ENDIF
						***
						*** Salida seg�n Gu�as de Remisi�n
						SELECT gr2
						SEEK or2.serie + or2.nrodoc + or2.cod_articu
						IF FOUND()
							SCAN WHILE seg_ordreq + cod_articu = or2.serie + or2.nrodoc + or2.cod_articu
								SELECT gr1
								SEEK gr2.serie + gr2.nrodoc
								IF gr1.cod_anula
									LOOP
								ENDIF
								SELECT motive
								SEEK "SAL" + gr1.cod_moti
								lcConcepto = "G/R N� " + ALLTRIM(gr2.serie) + "-" + gr2.nrodoc + " MOTIVO: " + motive.descri
								DO CASE
									CASE I = 1
										lcCodigo = "LOTE: " + gr2.nro_lote
									CASE I = 2
										lcCodigo = "CALIDAD: " + gr2.cod_calid
								ENDCASE
								*** Costo Promedio seg�n Kardex
								STORE 0 TO lnPrePro1,lnPrePro2
								lcNameFile = EXIST_FILE_KARDEX(lcTipo,gr1.fecha_reg)
								IF !EMPTY(lcNameFile)
									SELECT 0
									USE (lcNameFile) ORDER documento ALIAS ka2 AGAIN
									SEEK lcTipoGuia + gr2.serie + gr2.nrodoc + gr2.item
									IF FOUND()
										lnPrePro1 = ka2.preprosol
										lnPrePro2 = ka2.preprodol
									ENDIF
									USE
								ENDIF
								SELECT (lcAliasProducto)
								SEEK ALLTRIM(gr2.cod_articu)
								lnCantidad = 0
								IF os2.cantidad > 0
									lnCantidad = ROUND(gr2.cantidad/os2.cantidad,6) && Cantidad de Insumo empleado x cada unidad del Producto de la OS
								ENDIF
								INSERT INTO cCosto VALUES(cOP.item,lcTipo,lcConcepto,;
									gr2.cod_articu,&lcAliasProducto..descri,&lcAliasProducto..cod_intemp,lcCodigo,lnCantidad,lnPrePro1,lnPrePro2,ROUND(lnCantidad*lnPrePro1,6),ROUND(lnCantidad*lnPrePro2,6))
								***
							ENDSCAN
						ENDIF
						***
					ENDSCAN
					*** Cerrando Tablas
					USE IN or1
					USE IN or2
					USE IN gr1
					USE IN gr2
					***
				ENDFOR
				***
			ENDSCAN
			***
			*** Cerrando Tablas
			USE IN os1
			USE IN os2
			***
		ELSE
			EXIT
		ENDIF
	ENDDO
	***
	*** Actualizando Precio de Costo del Producto
	SELECT cCosto
	SEEK cOP.item
	SCAN WHILE item = cOP.item
		SELECT cOP
		REPLACE costo1 WITH cOP.costo1 + cCosto.total1
		REPLACE costo2 WITH cOP.costo2 + cCosto.total2
	ENDSCAN
	SELECT cOP
	REPLACE total1 WITH ROUND(cOP.costo1 * cOP.cantidad,6)
	REPLACE total2 WITH ROUND(cOP.costo2 * cOP.cantidad,6)
	***
ENDSCAN
***
*** Cerrando Tablas
*USE IN cOP
*USE IN cCosto
USE IN cProducto
USE IN op2
USE IN ords1
USE IN ords2
USE IN nots1
USE IN nots2
USE IN supplie
USE IN article
USE IN motive
***