c='V'
q=0000.00000000
wait window nowait "GENERANDO REPORTE DE MOVIMIENTO DE KARDEX ....." TIMEOUT 3

STORE '" " '      TO qd1, qd2, qd3, qd4, qd5, qd6, qd7
STORE " .T. "     TO qw1, qw3, qw5, qw7
STORE " and .T. " TO qw2, qw4, qw6, qw8

IF xnrorep >= 1
	do case
		case val(lstqui01.codigo) = 1  && tipo de documentos
			qd1 = " a.TipDoc "
			qw1 = " campo1 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui01.codigo) = 2  && Emisores de documentos
			qd1 = " a.TipDoc+' '+a.Serie "
			qw1 = " campo1 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui01.codigo) = 3  && Documento
			qd1 = " a.TipDoc +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
			qw1 = " .T.  "

		case val(lstqui01.codigo) = 4  && Fecha
			qd1 = " dtoc(a.fecha_reg) "
			qw1 = " .T.  "

		case val(lstqui01.codigo) = 5  && Periodo Mensual
			qd1 = " padr(DTOS(a.fecha_reg),6) "
			qw1 = " .T.  "

		case val(lstqui01.codigo) = 6  && Periodo Anual
			qd1 = " str(year(a.fecha_reg),4) "
			qw1 = " .T.  "

		case val(lstqui01.codigo) = 7  && Motivos 
			qd1 = " a.rad_moti+' '+a.cod_moti "
			qw1 = " campo1 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui01.codigo) = 8  && Local de Salida
			qd1 = " a.cod_alma "
			qw1 = " campo1 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui01.codigo) = 9  && Familia del Articulo
			qd1 = " PADR(a.cod_articu,3) "
			qw1 = " campo1 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui01.codigo) = 10  && Sub Familia del Articulo
			qd1 = " PADR(a.cod_articu,6) "
			qw1 = " campo1 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui01.codigo) = 11  && Tipo de Articulo
			qd1 = " PADR(a.cod_articu,9) "
			qw1 = " campo1 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui01.codigo) = 12  && Articulo o Producto
			qd1 = " PADR(a.cod_articu,13) "
			qw1 = " campo1 in (select codigo from cursor_12 where mx = 'X') "
	endcase
ENDIF

IF xnrorep >= 2
	do case
		case val(lstqui02.codigo) = 1  && tipo de documentos
			qd2 = " a.TipDoc "
			qw2 = " and campo2 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui02.codigo) = 2  && Emisores de documentos
			qd2 = " a.TipDoc+' '+a.Serie "
			qw2 = " and campo2 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui02.codigo) = 3  && Documento
			qd2 = " a.TipDoc +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
			qw2 = " and .T.  "

		case val(lstqui02.codigo) = 4  && Fecha
			qd2 = " dtoc(a.fecha_reg) "
			qw2 = " and .T.  "

		case val(lstqui02.codigo) = 5  && Periodo Mensual
			qd2 = " padr(DTOS(a.fecha_reg),6) "
			qw2 = " and .T.  "

		case val(lstqui02.codigo) = 6  && Periodo Anual
			qd2 = " str(year(a.fecha_reg),4) "
			qw2 = " and .T.  "

		case val(lstqui02.codigo) = 7  && Motivos 
			qd2 = " a.rad_moti+' '+a.cod_moti "
			qw2 = " and campo2 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui02.codigo) = 8  && Local de Salida
			qd2 = " a.cod_alma "
			qw2 = " and campo2 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui02.codigo) = 9  && Familia del Articulo
			qd2 = " PADR(a.cod_articu,3) "
			qw2 = " and campo2 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui02.codigo) = 10  && Sub Familia del Articulo
			qd2 = " PADR(a.cod_articu,6) "
			qw2 = " and campo2 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui02.codigo) = 11  && Tipo de Articulo
			qd2 = " PADR(a.cod_articu,9) "
			qw2 = " and campo2 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui02.codigo) = 12  && Articulo o Producto
			qd2 = " PADR(a.cod_articu,13) "
			qw2 = " and campo2 in (select codigo from cursor_12 where mx = 'X') "
	endcase
ENDIF

IF xnrorep >= 3
	do case
		case val(lstqui03.codigo) = 1  && tipo de documentos
			qd3 = " a.TipDoc "
			qw3 = " campo3 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui03.codigo) = 2  && Emisores de documentos
			qd3 = " a.TipDoc+' '+a.Serie "
			qw3 = " campo3 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui03.codigo) = 3  && Documento
			qd3 = " a.TipDoc +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
			qw3 = " .T.  "

		case val(lstqui03.codigo) = 4  && Fecha
			qd3 = " dtoc(a.fecha_reg) "
			qw3 = " .T.  "

		case val(lstqui03.codigo) = 5  && Periodo Mensual
			qd3 = " padr(DTOS(a.fecha_reg),6) "
			qw3 = " .T.  "

		case val(lstqui03.codigo) = 6  && Periodo Anual
			qd3 = " str(year(a.fecha_reg),4) "
			qw3 = " .T.  "

		case val(lstqui03.codigo) = 7  && Motivos 
			qd3 = " a.rad_moti+' '+a.cod_moti "
			qw3 = " campo3 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui03.codigo) = 8  && Local de Salida
			qd3 = " a.cod_alma "
			qw3 = " campo3 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui03.codigo) = 9  && Familia del Articulo
			qd3 = " PADR(a.cod_articu,3) "
			qw3 = " campo3 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui03.codigo) = 10  && Sub Familia del Articulo
			qd3 = " PADR(a.cod_articu,6) "
			qw3 = " campo3 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui03.codigo) = 11  && Tipo de Articulo
			qd3 = " PADR(a.cod_articu,9) "
			qw3 = " campo3 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui03.codigo) = 12  && Articulo o Producto
			qd3 = " PADR(a.cod_articu,13) "
			qw3 = " campo3 in (select codigo from cursor_12 where mx = 'X') "
	endcase
ENDIF

IF xnrorep >= 4
	do case
		case val(lstqui04.codigo) = 1  && tipo de documentos
			qd4 = " a.TipDoc "
			qw4 = " and campo4 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui04.codigo) = 2  && Emisores de documentos
			qd4 = " a.TipDoc+' '+a.Serie "
			qw4 = " and campo4 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui04.codigo) = 3  && Documento
			qd4 = " a.TipDoc +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
			qw4 = " and .T.  "

		case val(lstqui04.codigo) = 4  && Fecha
			qd4 = " dtoc(a.fecha_reg) "
			qw4 = " and .T.  "

		case val(lstqui04.codigo) = 5  && Periodo Mensual
			qd4 = " padr(DTOS(a.fecha_reg),6) "
			qw4 = " and .T.  "

		case val(lstqui04.codigo) = 6  && Periodo Anual
			qd4 = " str(year(a.fecha_reg),4) "
			qw4 = " and .T.  "

		case val(lstqui04.codigo) = 7  && Motivos 
			qd4 = " a.rad_moti+' '+a.cod_moti "
			qw4 = " and campo4 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui04.codigo) = 8  && Local de Salida
			qd4 = " a.cod_alma "
			qw4 = " and campo4 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui04.codigo) = 9  && Familia del Articulo
			qd4 = " PADR(a.cod_articu,3) "
			qw4 = " and campo4 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui04.codigo) = 10  && Sub Familia del Articulo
			qd4 = " PADR(a.cod_articu,6) "
			qw4 = " and campo4 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui04.codigo) = 11  && Tipo de Articulo
			qd4 = " PADR(a.cod_articu,9) "
			qw4 = " and campo4 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui04.codigo) = 12 && Articulo o Producto
			qd4 = " PADR(a.cod_articu,13) "
			qw4 = " and campo4 in (select codigo from cursor_12 where mx = 'X') "
	endcase
ENDIF

IF xnrorep >= 5
	do case
		case val(lstqui05.codigo) = 1  && tipo de documentos
			qd5 = " a.TipDoc "
			qw5 = " campo5 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui05.codigo) = 2  && Emisores de documentos
			qd5 = " a.TipDoc+' '+a.Serie "
			qw5 = " campo5 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui05.codigo) = 3  && Documento
			qd5 = " a.TipDoc +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
			qw5 = " .T.  "

		case val(lstqui05.codigo) = 4  && Fecha
			qd5 = " dtoc(a.fecha_reg) "
			qw5 = " .T.  "

		case val(lstqui05.codigo) = 5  && Periodo Mensual
			qd5 = " padr(DTOS(a.fecha_reg),6) "
			qw5 = " .T.  "

		case val(lstqui05.codigo) = 6  && Periodo Anual
			qd5 = " str(year(a.fecha_reg),4) "
			qw5 = " .T.  "

		case val(lstqui05.codigo) = 7  && Motivos 
			qd5 = " a.rad_moti+' '+a.cod_moti "
			qw5 = " campo5 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui05.codigo) = 8  && Local de Salida
			qd5 = " a.cod_alma "
			qw5 = " campo5 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui05.codigo) = 9  && Familia del Articulo
			qd5 = " PADR(a.cod_articu,3) "
			qw5 = " campo5 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui05.codigo) = 10  && Sub Familia del Articulo
			qd5 = " PADR(a.cod_articu,6) "
			qw5 = " campo5 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui05.codigo) = 11  && Tipo de Articulo
			qd5 = " PADR(a.cod_articu,9) "
			qw5 = " campo5 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui05.codigo) = 12  && Articulo o Producto
			qd5 = " PADR(a.cod_articu,13) "
			qw5 = " campo5 in (select codigo from cursor_12 where mx = 'X') "
	endcase
ENDIF

IF xnrorep >= 6
	do case
		case val(lstqui06.codigo) = 1  && tipo de documentos
			qd6 = " a.TipDoc "
			qw6 = " and campo6 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui06.codigo) = 2  && Emisores de documentos
			qd6 = " a.TipDoc+' '+a.Serie "
			qw6 = " and campo6 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui06.codigo) = 3  && Documento
			qd6 = " a.TipDoc +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
			qw6 = " and .T.  "

		case val(lstqui06.codigo) = 4  && Fecha
			qd6 = " dtoc(a.fecha_reg) "
			qw6 = " and .T.  "

		case val(lstqui06.codigo) = 5  && Periodo Mensual
			qd6 = " padr(DTOS(a.fecha_reg),6) "
			qw6 = " and .T.  "

		case val(lstqui06.codigo) = 6  && Periodo Anual
			qd6 = " str(year(a.fecha_reg),4) "
			qw6 = " and .T.  "

		case val(lstqui06.codigo) = 7  && Motivos 
			qd6 = " a.rad_moti+' '+a.cod_moti "
			qw6 = " and campo6 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui06.codigo) = 8  && Local de Salida
			qd6 = " a.cod_alma "
			qw6 = " and campo6 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui06.codigo) = 9  && Familia del Articulo
			qd6 = " PADR(a.cod_articu,3) "
			qw6 = " and campo6 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui06.codigo) = 10  && Sub Familia del Articulo
			qd6 = " PADR(a.cod_articu,6) "
			qw6 = " and campo6 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui06.codigo) = 11  && Tipo de Articulo
			qd6 = " PADR(a.cod_articu,9) "
			qw6 = " and campo6 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui06.codigo) = 12  && Articulo o Producto
			qd6 = " PADR(a.cod_articu,13) "
			qw6 = " and campo6 in (select codigo from cursor_12 where mx = 'X') "
	endcase
ENDIF

IF xnrorep >= 7
	do case
		case val(lstqui07.codigo) = 1  && tipo de documentos
			qd7 = " a.TipDoc "
			qw7 = " campo7 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui07.codigo) = 2  && Emisores de documentos
			qd7 = " a.TipDoc+' '+a.Serie "
			qw7 = " campo7 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui07.codigo) = 3  && Documento
			qd7 = " a.TipDoc +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
			qw7 = " .T.  "

		case val(lstqui07.codigo) = 4  && Fecha
			qd7 = " dtoc(a.fecha_reg) "
			qw7 = " .T.  "

		case val(lstqui07.codigo) = 5  && Periodo Mensual
			qd7 = " padr(DTOS(a.fecha_reg),6) "
			qw7 = " .T.  "

		case val(lstqui07.codigo) = 6  && Periodo Anual
			qd7 = " str(year(a.fecha_reg),4) "
			qw7 = " .T.  "

		case val(lstqui07.codigo) = 7  && Motivos 
			qd7 = " a.rad_moti+' '+a.cod_moti "
			qw7 = " campo7 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui07.codigo) = 8  && Local de Salida
			qd7 = " a.cod_alma "
			qw7 = " campo7 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui07.codigo) = 9  && Familia del Articulo
			qd7 = " PADR(a.cod_articu,3) "
			qw7 = " campo7 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui07.codigo) = 10  && Sub Familia del Articulo
			qd7 = " PADR(a.cod_articu,6) "
			qw7 = " campo7 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui07.codigo) = 11  && Tipo de Articulo
			qd7 = " PADR(a.cod_articu,9) "
			qw7 = " campo7 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui07.codigo) = 12  && Articulo o Producto
			qd7 = " PADR(a.cod_articu,13) "
			qw7 = " campo7 in (select codigo from cursor_12 where mx = 'X') "
	endcase
ENDIF

USE IN 0 kardex2 ORDER kardex2

qd_1 = "select " + qd1 + " as campo1," + qd2 + " as campo2," + qd3 + " as campo3," + qd4 + " as campo4," + qd5 + " as campo5," +qd6 + " as campo6, "+ qd7 +" as campo7, "
qd_2 = "a.serie, a.nrodoc, a.fecha_reg, a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_articu, "
IF xTipMon = 1
	qd_3 = "a.cantid_ing, a.cantid_sal*-1 as cantid_sal, (a.impsol_ing-a.impsol_sal) as importe "
ELSE
	qd_3 = "a.cantid_ing, a.cantid_sal*-1 as cantid_sal, (a.impdol_ing-a.impdol_sal) as importe "
ENDIF
qd_4 = "where BETWEEN(a.fecha_reg, xfecini, xfecfin) from kardex2 a "
qd_5 = "order by  campo1, campo2, campo3, campo4, campo5, campo6, campo7 into cursor kard"

wait window nowait "PROCESANDO KARDEX....."
&qd_1.;
	&qd_2.;
	&qd_3.;
	&qd_4.;
	&qd_5.

use in kardex2

parcial1 = "select * from kard where " + qw1 + qw2 + " into cursor docu01"

wait window nowait "PROCESANDO CONDICION ....."
&parcial1.

do case
	case xnrorep = 1 .or. xnrorep = 2
		parcial1 = "select * from docu01 into cursor docum1"
		wait window nowait "PROCESANDO (1 Y 2 CONDICION) ....."
		&parcial1.

	case xnrorep = 3 .or. xnrorep = 4

		parcial1 = "select * from docu01 where " + qw3 + qw4 + " into cursor docum1"
		wait window nowait "PROCESANDO (3 Y 4 CONDICION) ....."
		&parcial1.

	case xnrorep = 5 .or. xnrorep = 6

		parcial1 = "select * from docu01 where " + qw3 + qw4 + " into cursor docu11"
		wait window nowait "PROCESANDO (3 Y 4 CONDICION) ....."
		&parcial1.

		parcial1 = "select * from docu11 where " + qw5 + qw6 + " into cursor docum1"
		wait window nowait "PROCESANDO (5 y 6 CONDICION) ....."
		&parcial1.

		use in docu11

	case xnrorep = 7

		parcial1 = "select * from docu01 where " + qw3 + qw4 + " into cursor docu111"
		wait window nowait "PROCESANDO (3 Y 4 CONDICION) ....."
		&parcial1.

		parcial1 = "select * from docu111 where " + qw5 + qw6 + " into cursor docu11"
		wait window nowait "PROCESANDO (5 Y 6 CONDICION) ....."
		&parcial1.

		parcial1 = "select * from docu11 where " + qw5 + " into cursor docum1"
		wait window nowait "PROCESANDO (7 CONDICION) ....."
		&parcial1.

		use in docu111
		use in docu11

endcase

*-------*
do trapre
*-------*

use in kard
use in docum1
use in docu01

qw8    = " .t. "
txtopc = ""

if xConOpc = 1 && and val(matriz6(_matriz6,2)) != 14
	do case
		case val(lstqui08.codigo) = 1  && tipo de documentos
			qw8 = " TipDoc in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui08.codigo) = 2  && Emisores de documentos
			qw8 = " TipDoc+' '+Serie in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui08.codigo) = 3  && Documento
			qw8 = " .T.  "

		case val(lstqui08.codigo) = 4  && Fecha
			qw8 = " .T.  "

		case val(lstqui08.codigo) = 5  && Periodo Mensual
			qw8 = " .T.  "

		case val(lstqui08.codigo) = 6  && Periodo Anual
			qw8 = " .T.  "

		case val(lstqui08.codigo) = 7  && Motivos 
			qw8 = " rad_moti+' '+cod_moti in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui08.codigo) = 8  && Local de Salida
			qw8 = " cod_alma in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui08.codigo) = 9  && Familia del Articulo
			qw8 = " PADR(cod_articu,3) in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui08.codigo) = 10  && Sub Familia del Articulo
			qw8 = " PADR(cod_articu,6) in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui08.codigo) = 11  && Tipo de Articulo
			qw8 = " PADR(cod_articu,9) in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui08.codigo) = 12  && Articulo o Producto
			qw8 = " PADR(cod_articu,13) in (select codigo from cursor_12 where mx = 'X') "
	ENDCASE

ENDIF

wait window nowait "EJECUTANDO ULTIMO PROCESO ....."

SELECT ximprime
eofquery = "select * from ximprime where .t. and " + qw8 + " into cursor imprime"
&eofquery.
use in ximprime

DO Cruce_Data

xTit01 = "Reporte Configurable de Movimiento de Kardex"
xTit02 = "DEL " + DTOC(xfecini) + " AL " + dtoc(xfecfin)
xTit03 = "(Expresado En "+iif(xtipmon=1,"Moneda Nacional","Moneda Extranjera")+")"

SELECT imprime
GO TOP 
if xtipprn = 1
	IF .F.
		REPORT FORM RDMOVCF1 PREVIEW
		REPORT FORM RDMOVCF2 PREVIEW
		REPORT FORM RDMOVCF3 PREVIEW
		REPORT FORM RDMOVCF4 PREVIEW
		REPORT FORM RDMOVCF5 PREVIEW
		REPORT FORM RDMOVCF6 PREVIEW
		REPORT FORM RDMOVCF7 PREVIEW
	ENDIF
	xtempo = "C:\windows\temp\"+PADR("_"+SYS(3),8,'0')+".TMP"
	xtempo = PADR("_"+SYS(3),8,'0')+".TMP"
	do case
		case xnrorep = 1
			REPORT FORM rdmovcf1 NOCONSOLE TO FILE &xtempo
		case xnrorep = 2
			REPORT FORM rdmovcf2 NOCONSOLE TO FILE &xtempo
		case xnrorep = 3
			REPORT FORM rdmovcf3 NOCONSOLE TO FILE &xtempo
		case xnrorep = 4
			REPORT FORM rdmovcf4 NOCONSOLE TO FILE &xtempo
		case xnrorep = 5
			REPORT FORM rdmovcf5 NOCONSOLE TO FILE &xtempo
		case xnrorep = 6
			REPORT FORM rdmovcf6 NOCONSOLE TO FILE &xtempo
		case xnrorep = 7
			REPORT FORM rdmovcf7 NOCONSOLE TO FILE &xtempo
	endcase
	do __view_2 With "D" , allt(xtempo), 'REPORTE CONFIGURABLE DE MOVIMIENTO DE KARDEX'
else
	do case
		case xnrorep = 1
			repo form rwmovcf1 noconsole preview
			repo form rwmovcf1 noconsole to printer prompt
		case xnrorep = 2
			repo form rwmovcf2 noconsole preview
			repo form rwmovcf2 noconsole to printer prompt
		case xnrorep = 3
			repo form rwmovcf3 noconsole preview
			repo form rwmovcf3 noconsole to printer prompt
		case xnrorep = 4
			repo form rwmovcf4 noconsole preview
			repo form rwmovcf4 noconsole to printer prompt
		case xnrorep = 5
			repo form rwmovcf5 noconsole preview
			repo form rwmovcf5 noconsole to printer prompt
		case xnrorep = 6
			repo form rwmovcf6 noconsole preview
			repo form rwmovcf6 noconsole to printer prompt
		case xnrorep = 7
			repo form rwmovcf7 noconsole preview
			repo form rwmovcf7 noconsole to printer prompt
	endcase
endif

IF xexpdat = 1
	xExcel = "C:\Exportar\Reporte_Movimiento_Kardex_Configurable"
	Select imprime
	xExcel = alltrim(xExcel) 
	Copy To &xExcel. Type XL5
	Wait Wind 'Archivo Generado ...............' Time 5
ENDIF
use in imprime
RETURN


*============================================================================================
procedure trapre  		&& carga los documentos al cursor principal
*============================================================================================
wait window nowait "PROCESANDO BASE DE KARDEX"

select docum1
xxcampos = afields( atemporal )
create cursor ximprime from array atemporal

SELECT ximprime
APPEND FROM DBF('docum1')

return


*------------*
function infor
*------------*
parameters _nombre, _valqui
valor = _nombre
do case
	case _valqui = 1
		yyy = val(lstqui01.codigo)

	case _valqui = 2
		yyy = val(lstqui02.codigo)

	case _valqui = 3
		yyy = val(lstqui03.codigo)

	case _valqui = 4
		yyy = val(lstqui04.codigo)

	case _valqui = 5
		yyy = val(lstqui05.codigo)

	case _valqui = 6
		yyy = val(lstqui06.codigo)

	case _valqui = 7
		yyy = val(lstqui07.codigo)
ENDCASE

valor = ALLTRIM(valor)

do case
	case yyy = 1  && tipo de documentos
		*	detalle = IIF( seek(valor, "cursor_01"), iif(sw_verdes=1, allt(cursor_01.codigo) +" ","")+ cursor_01.descri, " ")
		SELECT cursor_01
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_01.descri
		ENDIF
		SELECT cursor_01
		SET KEY TO

	case yyy = 2  && Emisores de documentos
		*detalle = IIF( seek(valor, "cursor_02"), iif(sw_verdes=1, allt(cursor_02.codigo) +" ","")+ cursor_02.descri, " ")
		SELECT cursor_02
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_02.descri
		ENDIF
		SELECT cursor_02
		SET KEY TO

	case yyy = 3  && Documento
		detalle = valor

	case yyy = 4  && Fecha
		detalle = valor

	case yyy = 5  && Periodo Mensual
		detalle = valor

	case yyy = 6  && Periodo Anual
		detalle = valor

	case yyy = 7  && Motivos de venta
		*detalle = IIF( seek(valor, "cursor_07"), iif(sw_verdes=1, allt(cursor_07.codigo) +" ","")+ cursor_07.descri, " ")
		SELECT cursor_07
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_07.descri
		ENDIF
		SELECT cursor_07
		SET KEY TO

	case yyy = 8  && Local de Salida
		*detalle = IIF( seek(valor, "cursor_08"), iif(sw_verdes=1, allt(cursor_08.codigo) +" ","")+ cursor_08.descri, " ")
		SELECT cursor_08
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_08.descri
		ENDIF
		SELECT cursor_08
		SET KEY TO

	case yyy = 9  && Familia del Articulo
		*detalle = IIF( seek(valor, "cursor_12"), iif(sw_verdes=1, allt(cursor_12.codigo) +" ","")+ cursor_12.descri, " ")
		SELECT cursor_09
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_09.descri
		ENDIF
		SELECT cursor_09
		SET KEY TO

	case yyy = 10  && Sub Familia del Articulo
		*detalle = IIF( seek(valor, "cursor_13"), iif(sw_verdes=1, allt(cursor_13.codigo) +" ","")+ cursor_13.descri, " ")
		SELECT cursor_10
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_10.descri
		ENDIF
		SELECT cursor_10
		SET KEY TO

	case yyy = 11  && Tipo de Articulo
		*detalle = IIF( seek(valor, "cursor_14"), iif(sw_verdes=1, allt(cursor_14.codigo) +" ","")+ cursor_14.descri, " ")
		SELECT cursor_11
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_11.descri
		ENDIF
		SELECT cursor_11
		SET KEY TO

	case yyy = 12  && Articulo o Producto
		*detalle = IIF( seek(valor, "cursor_15"), iif(sw_verdes=1, allt(cursor_15.codigo) +" ","")+ cursor_15.descri, " ")
		SELECT cursor_12
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_12.descri
		ENDIF
		SELECT cursor_12
		SET KEY TO

	OTHERWISE
		detalle = valor

ENDCASE

SELECT imprime

return (detalle)


Procedure Cruce_Data

SELECT ;
	LEN(ALLTRIM(campo1)) as len_1, ;
	LEN(ALLTRIM(campo2)) as len_2, ;
	LEN(ALLTRIM(campo3)) as len_3, ;
	LEN(ALLTRIM(campo4)) as len_4, ;
	LEN(ALLTRIM(campo5)) as len_5, ;
	LEN(ALLTRIM(campo6)) as len_6, ;
	LEN(ALLTRIM(campo7)) as len_7 ;
	DISTINCT FROM imprime INTO CURSOR tempo
SELECT tempo
xlen1 = IIF(tempo.len_1=0,1,tempo.len_1)
xlen2 = IIF(tempo.len_2=0,1,tempo.len_2)
xlen3 = IIF(tempo.len_3=0,1,tempo.len_3)
xlen4 = IIF(tempo.len_4=0,1,tempo.len_4)
xlen5 = IIF(tempo.len_5=0,1,tempo.len_5)
xlen6 = IIF(tempo.len_6=0,1,tempo.len_6)
xlen7 = IIF(tempo.len_7=0,1,tempo.len_7)
	
CREATE CURSOR cru_data (;
	cod_campo1 c(xlen1), des_campo1 c(200), ;
	cod_campo2 c(xlen2), des_campo2 c(200), ;
	cod_campo3 c(xlen3), des_campo3 c(200), ;
	cod_campo4 c(xlen4), des_campo4 c(200), ;
	cod_campo5 c(xlen5), des_campo5 c(200), ;
	cod_campo6 c(xlen6), des_campo6 c(200), ;
	cod_campo7 c(xlen7), des_campo7 c(200), ;
	tot_caning n(16,6), tot_cansal n(16,6), tot_cansld n(16,6), tot_import n(16,6) )
INDEX on ;
	PADR(cod_campo1,xlen1,'*') + ;
	PADR(cod_campo2,xlen2,'*') + ;
	PADR(cod_campo3,xlen3,'*') + ;
	PADR(cod_campo4,xlen4,'*') + ;
	PADR(cod_campo5,xlen5,'*') + ;
	PADR(cod_campo6,xlen6,'*') + ;
	PADR(cod_campo7,xlen7,'*') TAG cru_data

select imprime
go top
scan
	***
	m.cod_campo1 = iif( xnrorep >= 1, imprime.campo1, ' ')
	m.cod_campo2 = iif( xnrorep >= 2, imprime.campo2, ' ')
	m.cod_campo3 = iif( xnrorep >= 3, imprime.campo3, ' ')
	m.cod_campo4 = iif( xnrorep >= 4, imprime.campo4, ' ')
	m.cod_campo5 = iif( xnrorep >= 5, imprime.campo5, ' ')
	m.cod_campo6 = iif( xnrorep >= 6, imprime.campo6, ' ')
	m.cod_campo7 = iif( xnrorep >= 7, imprime.campo7, ' ')
	***
	m.des_campo1 = iif(xnrorep >= 1, infor(imprime.campo1,1),' ')
	m.des_campo2 = iif(xnrorep >= 2, infor(imprime.campo2,2),' ')
	m.des_campo3 = iif(xnrorep >= 3, infor(imprime.campo3,3),' ')
	m.des_campo4 = iif(xnrorep >= 4, infor(imprime.campo4,4),' ')
	m.des_campo5 = iif(xnrorep >= 5, infor(imprime.campo5,5),' ')
	m.des_campo6 = iif(xnrorep >= 6, infor(imprime.campo6,6),' ')
	m.des_campo7 = iif(xnrorep >= 7, infor(imprime.campo7,7),' ')
	***
	m.tot_caning = imprime.cantid_ing
	m.tot_cansal = imprime.cantid_sal
	m.tot_cansld = imprime.cantid_ing + imprime.cantid_sal
	m.tot_import = imprime.importe
	***
	xkey_prn = PADR(m.cod_campo1,xlen1,'*') + PADR(m.cod_campo2,xlen2,'*') + PADR(m.cod_campo3,xlen3,'*') + PADR(m.cod_campo4,xlen4,'*') + ;
		PADR(m.cod_campo5,xlen5,'*') + PADR(m.cod_campo6,xlen6,'*') + PADR(m.cod_campo7,xlen7,'*')
	***
	SELECT cru_data
	SET KEY TO ALLTRIM(xkey_prn)
	GO top
	IF EOF()
		APPEND BLANK
		GATHER MEMVAR fields ;
			cod_campo1, des_campo1, ;
			cod_campo2, des_campo2, ;
			cod_campo3, des_campo3, ;
			cod_campo4, des_campo4, ;
			cod_campo5, des_campo5, ;
			cod_campo6, des_campo6, ;
			cod_campo7, des_campo7
	ENDIF
	replace tot_caning WITH cru_data.tot_caning + m.tot_caning
	replace tot_cansal WITH cru_data.tot_cansal + m.tot_cansal
	replace tot_cansld WITH (cru_data.tot_caning + cru_data.tot_cansal)
	replace tot_import WITH cru_data.tot_import + m.tot_import
	***
	SELECT cru_data
	SET KEY TO 
	***
	SELECT imprime
ENDSCAN

SELECT * FROM cru_data ;
	ORDER BY cod_campo1, cod_campo2, cod_campo3, cod_campo4, cod_campo5, cod_campo6, cod_campo7 ;
	INTO CURSOR imprime

USE IN cru_data
USE IN tempo
RETURN


