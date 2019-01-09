FUNCTION ACTUALIZAR_ORDEN_SERVICIO
PARAMETERS pcOS_Type,pcOS_Serie,pcOS_Number,pcOS_CursorName
* pcOS_Type = Tipo de Documento ("ORDS" o "NOTS")
* pcOS_Serie = Serie de Documento
* pcOS_Number = Número de Documento
* pcOS_CursorName = Nombre del Cursor que contiene el detalle del Documento a actualizar. Campos Obligatorios: item,precio_1,precio_2
ln_Select_Current = SELECT()
*** Abriendo Tablas
SELECT 0
lcOS_TableName = pcOS_Type + "1"
USE (lcOS_TableName) ORDER (lcOS_TableName) ALIAS tOS1 AGAIN
lcPI_Type = IIF(pcOS_Type = "ORDS","PARI","NOTI")
SELECT 0
lcPI_TableName = lcPI_Type + "1"
USE (lcPI_TableName) ORDER (lcPI_TableName) ALIAS tPI1 AGAIN
SELECT 0
lcPI_TableName = lcPI_Type + "2"
USE (lcPI_TableName) ORDER docrel ALIAS tPI2 AGAIN
***
*** Cursor para la actualización de Costos de Producción
lcCursorNameCP = SYS(2015)
CREATE CURSOR (lcCursorNameCP)(tipo C(4),serie C(4),nrodoc C(10),item C(4))
***
***
SELECT tOS1
SEEK pcOS_Serie + pcOS_Number
IF FOUND() AND !tOS1.cod_anula
	SELECT (pcOS_CursorName)
	SCAN
		SELECT tPI2
		SEEK pcOS_Type + pcOS_Serie + pcOS_Number + &pcOS_CursorName..item
		SCAN WHILE docrel_tip + docrel_ser + docrel_nro + docrel_itm = pcOS_Type + pcOS_Serie + pcOS_Number + &pcOS_CursorName..item
			SELECT tPI1
			SEEK tPI2.serie + tPI2.nrodoc
			IF !FOUND() OR tPI1.cod_anula
				LOOP
			ENDIF
			= BLOQUEARECORD()
			REPLACE docrel_fec WITH tOS1.fecha_reg
			UNLOCK
			*** Tipo de Cambio
			lnTC_Code = tPI1.tipcam_cod
			lnTC_Value = 0
			= TIPO_CAMBIO_ACTUALIZAR("lnTC_Code","lnTC_Value",tPI1.cod_moti,tPI1.doccom2fec,tPI1.doccom1fec,tPI1.docrel_fec)
			&& Si Contabilidad NO tiene el TC se jala de Almacen
			IF lnTC_Value = 0
				= TIPO_CAMBIO_ACTUALIZAR("lnTC_Code","lnTC_Value",tPI1.cod_moti,tOS1.fecha_reg)
			ENDIF
			***
			lnPrice_1 = &pcOS_CursorName..precio_1
			lnPrice_2 = &pcOS_CursorName..precio_2
			DO CASE
				CASE tOS1.cod_mone = "SOL"
					lnPrice_2 = IIF(lnTC_Value > 0,ROUND(lnPrice_1/lnTC_Value,6),0)
				CASE tOS1.cod_mone = "DOL"
					lnPrice_1 = ROUND(lnPrice_2 * lnTC_Value,6)
			ENDCASE
			IF tPI2.precio_1 != lnPrice_1 OR tPI2.precio_2 != lnPrice_2
				SELECT tPI2
				= BLOQUEARECORD()
				REPLACE precio_1 WITH lnPrice_1
				REPLACE precio_2 WITH lnPrice_2
				UNLOCK
				INSERT INTO (lcCursorNameCP) VALUES(lcPI_Type,tPI2.serie,tPI2.nrodoc,tPI2.item)
			ENDIF
		ENDSCAN
	ENDSCAN
ENDIF
***
IF !EOF(lcCursorNameCP)
	= COSTO_PRODUCCION(lcCursorNameCP,.T.)
ENDIF
USE IN (lcCursorNameCP)
*** Cerrando Tablas
USE IN tOS1
USE IN tPI1
USE IN tPI2
***
SELECT(ln_Select_Current)
RETURN