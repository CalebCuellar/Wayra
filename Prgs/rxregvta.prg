*** creando la estructura del reporte
CREATE CURSOR datos (;
	cod_tipdoc c(04), des_tipdoc c(50), ;
	fecha_reg d(8), ;
	serie c(4), ;
	nrodoc c(10), ;
	cod_auxi c(15), des_auxi c(100), ruc_auxi c(15), ;
	cod_mone c(3), des_mone c(50), ;
	docrel_tip c(4), docrel_ser c(4), docrel_nro c(10), docrel_fec d(8), ;
	cod_anula l(1), ;
	tipcam_cod c(1), tipcam_val n(10,4), ;
	totvta n(12,2), totigv n(12,2), totnet n(12,2) )
INDEX on cod_tipdoc + serie + nrodoc TAG datos

*** pasando los datos al cursor segun rango de fechas
IF xfacven=1
	DO crg_docum WITH 'FACT', 1
ENDIF
IF xbolven=1
	DO crg_docum WITH 'BOLE', 1
ENDIF
IF xnotcre=1
	DO crg_docum WITH 'CRED', -1
ENDIF
IF xnotdeb=1
	DO crg_docum WITH 'DEBI', 1
ENDIF
***
xTit01 = 'REGISTRO DE VENTA'
xTit02 = 'DEL ' + dtoc(xfecini)+' AL '+ dtoc(xfecfin)
xTit03 = '(Expresado En '+IIF(xtipmon=1,'Moneda Nacional','Moneda Extranjera')+')'
***
SELECT datos
replace cod_auxi WITH '', des_auxi WITH 'DOCUMENTO ANULADO', ruc_auxi WITH '' FOR cod_anula
GO top
IF EOF()
	MESSAGEBOX('El proceso del reporte no ha conseguido capturar datos para el reporte',0+64,'Revisar los parámetros de la pantala',10000)
ELSE
	IF xtipprn = 1
		IF .F.
			REPORT FORM RDREGVTA PREVIEW
		ENDIF
		xtempo = "C:\windows\temp\"+PADR("_"+SYS(3),8,'0')+".TMP"
		xtempo = PADR("_"+SYS(3),8,'0')+".TMP"
		REPORT FORM rdregvta NOCONSOLE TO FILE &xtempo
		do __view_2 With "D" , allt(xtempo), 'REGISTRO DE VENTAS'
	ELSE
		REPORT FORM rwregvta PREVIEW
		REPORT FORM rwregvta NOCONSOLE TO PRINTER PROMPT
	endif
ENDIF
IF xexpdat=1
	SELECT datos
	COPY TO C:\Exportar\Registro_de_Ventas TYPE xl5
	MESSAGEBOX('Archivo Generado y Exportado',0+64,'Datos Exportados',5000)
ENDIF
USE IN datos
RETURN



PROCEDURE crg_docum
PARAMETERS ptipdoc, psigno
dtipdoc = ''
DO CASE
	CASE ptipdoc = 'FACT'
		USE IN 0 fact1 ORDER fecha_reg ALIAS cabe  AGAIN	&& Orden : DTOS(fecha_reg)
		dtipdoc = 'FACTURA DE VENTA'
		ctipdoc = '01'
	CASE ptipdoc = 'BOLE'
		USE IN 0 bole1 ORDER fecha_reg ALIAS cabe  AGAIN	&& Orden : DTOS(fecha_reg)
		dtipdoc = 'BOLETA DE VENTA'
		ctipdoc = '03'
	CASE ptipdoc = 'CRED'
		USE IN 0 nocr1 ORDER fecha_reg ALIAS cabe  AGAIN	&& Orden : DTOS(fecha_reg)
		dtipdoc = 'NOTA DE CREDITO'
		ctipdoc = '07'
	CASE ptipdoc = 'DEBI'
		USE IN 0 node1 ORDER fecha_reg ALIAS cabe  AGAIN	&& Orden : DTOS(fecha_reg)
		dtipdoc = 'NOTA DE DEBITO'
		ctipdoc = '08'
ENDCASE
***
USE IN 0 fact1 ORDER fact1     ALIAS pcabe_fact AGAIN	&& Orden : serie + nrodoc
USE IN 0 bole1 ORDER bole1     ALIAS pcabe_bole AGAIN	&& Orden : serie + nrodoc
USE IN 0 nocr1 ORDER nocr1     ALIAS pcabe_cred AGAIN	&& Orden : serie + nrodoc
USE IN 0 node1 ORDER node1     ALIAS pcabe_debi AGAIN	&& Orden : serie + nrodoc
***
USE IN 0 maesclie ORDER codigo ALIAS clie AGAIN		&& orden : codigo
USE IN 0 maesvari ORDER codigo ALIAS vari AGAIN 	&& orden : radical + codigo
USE IN 0 maestica ORDER codigo ALIAS tica AGAIN 	&& orden : DTOS(fecha)

FOR xdias = 0 TO (xfecfin-xfecini)
	xfecha = DTOS(xfecini + xdias)
	IF BETWEEN(xfecha, DTOS(xfecini), dtos(xfecfin))
		SELECT cabe
		SET KEY TO xfecha
		GO TOP
		SCAN
			SELECT datos
			APPEND BLANK
			replace cod_tipdoc WITH ctipdoc
			replace des_tipdoc WITH dtipdoc
			replace fecha_reg  WITH cabe.fecha_reg
			replace serie WITH cabe.serie
			replace nrodoc WITH cabe.nrodoc
			replace cod_auxi with cabe.cod_auxi
			*** buscando en el maestro de clientes
			IF !EMPTY(cabe.cod_auxi)
				SELECT clie
				SET KEY TO ALLTRIM(cabe.cod_auxi)
				GO top
				IF !EOF()
					SELECT datos
					replace des_auxi WITH clie.descri
					replace ruc_auxi WITH clie.cod_ruc
				endif
				SELECT clie
				SET KEY TO
			endif
			***
			select datos
			replace cod_mone WITH cabe.cod_mone
			*** buscando en el maestro de variables
			SELECT vari
			SET KEY TO 'MON' + cabe.cod_mone
			GO top
			IF !EOF()
				SELECT datos
				replace des_mone with vari.descri
			endif
			SELECT vari
			SET KEY TO
			***
			SELECT datos
			replace docrel_tip WITH cabe.docrel_tip
			replace docrel_ser WITH cabe.docrel_ser
			replace docrel_nro WITH cabe.docrel_nro
			***
			DO case
				CASE cabe.docrel_tip = 'FACT'
					SELECT pcabe_fact
					SET KEY TO cabe.docrel_ser + cabe.docrel_nro
					GO top
					IF !eof()
						SELECT datos
						replace docrel_fec WITH pcabe_fact.fecha_reg
					ENDIF
					SELECT pcabe_fact
					SET KEY TO
				CASE cabe.docrel_tip = 'BOLE'
					SELECT pcabe_bole
					SET KEY TO cabe.docrel_ser + cabe.docrel_nro
					GO top
					IF !eof()
						SELECT datos
						replace docrel_fec WITH pcabe_bole.fecha_reg
					ENDIF
					SELECT pcabe_bole
					SET KEY TO
				CASE cabe.docrel_tip = 'CRED'
					SELECT pcabe_cred
					SET KEY TO cabe.docrel_ser + cabe.docrel_nro
					GO top
					IF !eof()
						SELECT datos
						replace docrel_fec WITH pcabe_cred.fecha_reg
					ENDIF
					SELECT pcabe_cred
					SET KEY TO
				CASE cabe.docrel_tip = 'DEBI'
					SELECT pcabe_debi
					SET KEY TO cabe.docrel_ser + cabe.docrel_nro
					GO top
					IF !eof()
						SELECT datos
						replace docrel_fec WITH pcabe_debi.fecha_reg
					ENDIF
					SELECT pcabe_debi
					SET KEY TO
			ENDCASE
			***
			SELECT datos
			replace cod_anula WITH cabe.cod_anula
			***
			IF cabe.cod_anula = .f.
				SELECT datos
				replace tipcam_cod WITH cabe.tipcam_cod
				***
				DO CASE
					CASE cabe.tipcam_cod = 'O'
						SELECT datos
						replace tipcam_val WITH cabe.tipcam_val
					OTHERWISE
						xfecha_doc = IIF(EMPTY(datos.docrel_fec), datos.fecha_reg, datos.docrel_fec)
						SELECT tica
						SET KEY TO DTOS(xfecha_doc)
						GO top
						IF !EOF()
							SELECT datos
							replace tipcam_val WITH IIF(cabe.tipcam_cod='C', tica.compra, tica.venta)
						ENDIF
						SELECT tica
						SET KEY TO
				ENDCASE
				***
				IF IIF(xtipmon=1,'SOL','DOL') = cabe.cod_mone
					SELECT datos
					replace totvta WITH cabe.totvta * psigno
					replace totigv WITH cabe.totigv * psigno
					replace totnet WITH cabe.totnet * psigno
				ELSE
					IF datos.tipcam_val != 0
						DO case
							case cabe.cod_mone = 'SOL'
								SELECT datos
								replace totvta WITH (cabe.totvta / datos.tipcam_val) * psigno
								replace totigv WITH (cabe.totigv / datos.tipcam_val) * psigno
								replace totnet WITH (cabe.totnet / datos.tipcam_val) * psigno
							CASE cabe.cod_mone = 'DOL'
								SELECT datos
								replace totvta WITH (cabe.totvta * datos.tipcam_val) * psigno
								replace totigv WITH (cabe.totigv * datos.tipcam_val) * psigno
								replace totnet WITH (cabe.totnet * datos.tipcam_val) * psigno
						ENDCASE
					endif
				ENDIF
			ENDIF
			SELECT cabe
		ENDSCAN
		SELECT cabe
		SET KEY TO
	ENDIF
ENDFOR

USE IN cabe
USE IN pcabe_fact
USE IN pcabe_bole
USE IN pcabe_cred
USE IN pcabe_debi
USE IN clie
USE IN vari
USE IN tica
RETURN
