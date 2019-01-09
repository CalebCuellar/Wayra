c='V'
q=0000.00000000
wait window nowait "CREANDO CURSORES DE VENTAS  ....." TIMEOUT 3
DO crea_cursores
wait window nowait "GENERANDO REPORTE DE VENTAS ....." TIMEOUT 3

STORE '" " '      TO qd1, qd2, qd3, qd4, qd5, qd6, qd7
STORE " .T. "     TO qw1, qw3, qw5, qw7
STORE " and .T. " TO qw2, qw4, qw6

IF xnrorep >= 1
	do case
		case val(lstqui01.codigo) = 1  && tipo de documentos
			qd1 = " a.td "
			qw1 = " campo1 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui01.codigo) = 2  && Emisores de documentos
			qd1 = " a.Serie_x "
			qw1 = " campo1 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui01.codigo) = 3  && Documento
			qd1 = " a.td +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
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

		case val(lstqui01.codigo) = 7  && Motivos de venta
			qd1 = " a.cod_moti "
			qw1 = " campo1 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui01.codigo) = 8  && Local de Salida
			qd1 = " a.cod_alma "
			qw1 = " campo1 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui01.codigo) = 9  && Cliente
			qd1 = " a.cod_auxi "
			qw1 = " campo1 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui01.codigo) = 10  && Forma de Pago
			qd1 = " a.cod_fpag "
			qw1 = " campo1 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui01.codigo) = 11  && Vendedor
			qd1 = " a.cod_vend "
			qw1 = " campo1 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui01.codigo) = 12  && Familia del Articulo
			qd1 = " a.tip_produc +'-'+ PADR(a.cod_articu,3) "
			qw1 = " campo1 in (select codigo from cursor_12 where mx = 'X') "

		case val(lstqui01.codigo) = 13  && Sub Familia del Articulo
			qd1 = " a.tip_produc +'-'+ PADR(a.cod_articu,6) "
			qw1 = " campo1 in (select codigo from cursor_13 where mx = 'X') "

		case val(lstqui01.codigo) = 14  && Tipo de Articulo
			qd1 = " a.tip_produc +'-'+ PADR(a.cod_articu,9) "
			qw1 = " campo1 in (select codigo from cursor_14 where mx = 'X') "

		case val(lstqui01.codigo) = 15  && Articulo o Producto
			qd1 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw1 = " campo1 in (select codigo from cursor_15 where mx = 'X') "
			
		case val(lstqui01.codigo) = 16  && relacion de conceptos
			qd1 = " a.tip_produc +'-'+ PADR(a.cod_articu,04) "
			qw1 = " campo1 in (select codigo from cursor_16 where mx = 'X') "	
		
		case val(lstqui01.codigo) = 17  && relacion de servicios
			qd1 = " a.tip_produc +'-'+ PADR(a.cod_articu,04) "
			qw1 = " campo1 in (select codigo from cursor_17 where mx = 'X') "	
			
		case val(lstqui01.codigo) = 18  && relacion de todos los productos
			qd1 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw1 = " campo1 in (select codigo from cursor_18 where mx = 'X') "	
		
		case val(lstqui01.codigo) = 19  && tipos de productos
			qd1 = " a.tip_produc  "
			qw1 = " campo1 in (select codigo from cursor_19 where mx = 'X') "
	endcase
ENDIF

IF xnrorep >= 2
	do case
		case val(lstqui02.codigo) = 1  && tipo de documentos
			qd2 = " a.td "
			qw2 = " and campo2 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui02.codigo) = 2  && Emisores de documentos
			qd2 = " a.Serie_x "
			qw2 = " and campo2 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui02.codigo) = 3  && Documento
			qd2 = " a.td +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
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

		case val(lstqui02.codigo) = 7  && Motivos de venta
			qd2 = " a.cod_moti "
			qw2 = " and campo2 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui02.codigo) = 8  && Local de Salida
			qd2 = " a.cod_alma "
			qw2 = " and campo2 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui02.codigo) = 9  && Cliente
			qd2 = " a.cod_auxi "
			qw2 = " and campo2 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui02.codigo) = 10  && Forma de Pago
			qd2 = " a.cod_fpag "
			qw2 = " and campo2 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui02.codigo) = 11  && Vendedor
			qd2 = " a.cod_vend "
			qw2 = " and campo2 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui02.codigo) = 12  && Familia del Articulo
			qd2 = " a.tip_produc +'-'+ PADR(a.cod_articu,3) "
			qw2 = " and campo2 in (select codigo from cursor_12 where mx = 'X') "

		case val(lstqui02.codigo) = 13  && Sub Familia del Articulo
			qd2 = " a.tip_produc +'-'+ PADR(a.cod_articu,6) "
			qw2 = " and campo2 in (select codigo from cursor_13 where mx = 'X') "

		case val(lstqui02.codigo) = 14  && Tipo de Articulo
			qd2 = " a.tip_produc +'-'+ PADR(a.cod_articu,9) "
			qw2 = " and campo2 in (select codigo from cursor_14 where mx = 'X') "

		case val(lstqui02.codigo) = 15  && Articulo o Producto
			qd2 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw2 = " and campo2 in (select codigo from cursor_15 where mx = 'X') "
			
		case val(lstqui02.codigo) = 16  && maestro de concepto
			qd2 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw2 = " and campo2 in (select codigo from cursor_16 where mx = 'X') "
		
		case val(lstqui02.codigo) = 17  && maestro de servicios
			qd2 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw2 = " and campo2 in (select codigo from cursor_17 where mx = 'X') "
		
		case val(lstqui02.codigo) = 18  && todos los productos
			qd2 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw2 = " and campo2 in (select codigo from cursor_18 where mx = 'X') "
			
		case val(lstqui02.codigo) = 19  && tipos de productos
			qd2 = " a.tip_produc "
			qw2 = " and campo2 in (select codigo from cursor_19 where mx = 'X') "	
		
	endcase
ENDIF

IF xnrorep >= 3
	do case
		case val(lstqui03.codigo) = 1  && tipo de documentos
			qd3 = " a.td "
			qw3 = " campo3 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui03.codigo) = 2  && Emisores de documentos
			qd3 = " a.Serie_x "
			qw3 = " campo3 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui03.codigo) = 3  && Documento
			qd3 = " a.td +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
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

		case val(lstqui03.codigo) = 7  && Motivos de venta
			qd3 = " a.cod_moti "
			qw3 = " campo3 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui03.codigo) = 8  && Local de Salida
			qd3 = " a.cod_alma "
			qw3 = " campo3 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui03.codigo) = 9  && Cliente
			qd3 = " a.cod_auxi "
			qw3 = " campo3 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui03.codigo) = 10  && Forma de Pago
			qd3 = " a.cod_fpag "
			qw3 = " campo3 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui03.codigo) = 11  && Vendedor
			qd3 = " a.cod_vend "
			qw3 = " campo3 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui03.codigo) = 12  && Familia del Articulo
			qd3 = " a.tip_produc +'-'+ PADR(a.cod_articu,3) "
			qw3 = " campo3 in (select codigo from cursor_12 where mx = 'X') "

		case val(lstqui03.codigo) = 13  && Sub Familia del Articulo
			qd3 = " a.tip_produc +'-'+ PADR(a.cod_articu,6) "
			qw3 = " campo3 in (select codigo from cursor_13 where mx = 'X') "

		case val(lstqui03.codigo) = 14  && Tipo de Articulo
			qd3 = " a.tip_produc +'-'+ PADR(a.cod_articu,9) "
			qw3 = " campo3 in (select codigo from cursor_14 where mx = 'X') "

		case val(lstqui03.codigo) = 15  && Articulo o Producto
			qd3 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw3 = " campo3 in (select codigo from cursor_15 where mx = 'X') "
			
		case val(lstqui03.codigo) = 16  && maestro de conceptos
			qd3 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw3 = " campo3 in (select codigo from cursor_16 where mx = 'X') "
		
		case val(lstqui03.codigo) = 17  && maestro de servicios
			qd3 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw3 = " campo3 in (select codigo from cursor_17 where mx = 'X') "	
		
		case val(lstqui03.codigo) = 18  && todos los productos
			qd3 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw3 = " campo3 in (select codigo from cursor_18 where mx = 'X') "
			
		case val(lstqui03.codigo) = 19  && tipos de productos
			qd3 = " a.tip_produc "
			qw3 = " campo3 in (select codigo from cursor_19 where mx = 'X') "	
	endcase
ENDIF

IF xnrorep >= 4
	do case
		case val(lstqui04.codigo) = 1  && tipo de documentos
			qd4 = " a.td "
			qw4 = " and campo4 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui04.codigo) = 2  && Emisores de documentos
			qd4 = " a.Serie_x "
			qw4 = " and campo4 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui04.codigo) = 3  && Documento
			qd4 = " a.td +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
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

		case val(lstqui04.codigo) = 7  && Motivos de venta
			qd4 = " a.cod_moti "
			qw4 = " and campo4 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui04.codigo) = 8  && Local de Salida
			qd4 = " a.cod_alma "
			qw4 = " and campo4 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui04.codigo) = 9  && Cliente
			qd4 = " a.cod_auxi "
			qw4 = " and campo4 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui04.codigo) = 10  && Forma de Pago
			qd4 = " a.cod_fpag "
			qw4 = " and campo4 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui04.codigo) = 11  && Vendedor
			qd4 = " a.cod_vend "
			qw4 = " and campo4 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui04.codigo) = 12  && Familia del Articulo
			qd4 = " a.tip_produc +'-'+ PADR(a.cod_articu,3) "
			qw4 = " and campo4 in (select codigo from cursor_12 where mx = 'X') "

		case val(lstqui04.codigo) = 13  && Sub Familia del Articulo
			qd4 = " a.tip_produc +'-'+ PADR(a.cod_articu,6) "
			qw4 = " and campo4 in (select codigo from cursor_13 where mx = 'X') "

		case val(lstqui04.codigo) = 14  && Tipo de Articulo
			qd4 = " a.tip_produc +'-'+ PADR(a.cod_articu,9) "
			qw4 = " and campo4 in (select codigo from cursor_14 where mx = 'X') "

		case val(lstqui04.codigo) = 15  && Articulo o Producto
			qd4 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw4 = " and campo4 in (select codigo from cursor_15 where mx = 'X') "
			
		case val(lstqui04.codigo) = 16  && maestro de conceptos
			qd4 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw4 = " and campo4 in (select codigo from cursor_16 where mx = 'X') "
			
		case val(lstqui04.codigo) = 17  && maestro de servicios
			qd4 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw4 = " and campo4 in (select codigo from cursor_17 where mx = 'X') "
		
		case val(lstqui04.codigo) = 18  && todos los productos
			qd4 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw4 = " and campo4 in (select codigo from cursor_18 where mx = 'X') "
		
		case val(lstqui04.codigo) = 19  && tipos de productos
			qd4 = " a.tip_produc "
			qw4 = " and campo4 in (select codigo from cursor_19 where mx = 'X') "	
					
	endcase
ENDIF

IF xnrorep >= 5
	do case
		case val(lstqui05.codigo) = 1  && tipo de documentos
			qd5 = " a.td "
			qw5 = " campo5 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui05.codigo) = 2  && Emisores de documentos
			qd5 = " a.Serie_x "
			qw5 = " campo5 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui05.codigo) = 3  && Documento
			qd5 = " a.td +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
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

		case val(lstqui05.codigo) = 7  && Motivos de venta
			qd5 = " a.cod_moti "
			qw5 = " campo5 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui05.codigo) = 8  && Local de Salida
			qd5 = " a.cod_alma "
			qw5 = " campo5 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui05.codigo) = 9  && Cliente
			qd5 = " a.cod_auxi "
			qw5 = " campo5 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui05.codigo) = 10  && Forma de Pago
			qd5 = " a.cod_fpag "
			qw5 = " campo5 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui05.codigo) = 11  && Vendedor
			qd5 = " a.cod_vend "
			qw5 = " campo5 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui05.codigo) = 12  && Familia del Articulo
			qd5 = " a.tip_produc +'-'+ PADR(a.cod_articu,3) "
			qw5 = " campo5 in (select codigo from cursor_12 where mx = 'X') "

		case val(lstqui05.codigo) = 13  && Sub Familia del Articulo
			qd5 = " a.tip_produc +'-'+ PADR(a.cod_articu,6) "
			qw5 = " campo5 in (select codigo from cursor_13 where mx = 'X') "

		case val(lstqui05.codigo) = 14  && Tipo de Articulo
			qd5 = " a.tip_produc +'-'+ PADR(a.cod_articu,9) "
			qw5 = " campo5 in (select codigo from cursor_14 where mx = 'X') "

		case val(lstqui05.codigo) = 15  && Articulo o Producto
			qd5 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw5 = " campo5 in (select codigo from cursor_15 where mx = 'X') "
			
		case val(lstqui05.codigo) = 16  && maestro de conceptos
			qd5 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw5 = " campo5 in (select codigo from cursor_16 where mx = 'X') "
			
		case val(lstqui05.codigo) = 17  && maestro de servicios
			qd5 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw5 = " campo5 in (select codigo from cursor_17 where mx = 'X') "
			
		case val(lstqui05.codigo) = 18  && todos los productos
			qd5 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw5 = " campo5 in (select codigo from cursor_18 where mx = 'X') "
			
		case val(lstqui05.codigo) = 19  && tipo de producto
			qd5 = " a.tip_produc "
			qw5 = " campo5 in (select codigo from cursor_19 where mx = 'X') "	
	endcase
ENDIF

IF xnrorep >= 6
	do case
		case val(lstqui06.codigo) = 1  && tipo de documentos
			qd6 = " a.td "
			qw6 = " and campo6 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui06.codigo) = 2  && Emisores de documentos
			qd6 = " a.Serie_x "
			qw6 = " and campo6 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui06.codigo) = 3  && Documento
			qd6 = " a.td +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
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

		case val(lstqui06.codigo) = 7  && Motivos de venta
			qd6 = " a.cod_moti "
			qw6 = " and campo6 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui06.codigo) = 8  && Local de Salida
			qd6 = " a.cod_alma "
			qw6 = " and campo6 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui06.codigo) = 9  && Cliente
			qd6 = " a.cod_auxi "
			qw6 = " and campo6 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui06.codigo) = 10  && Forma de Pago
			qd6 = " a.cod_fpag "
			qw6 = " and campo6 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui06.codigo) = 11  && Vendedor
			qd6 = " a.cod_vend "
			qw6 = " and campo6 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui06.codigo) = 12  && Familia del Articulo
			qd6 = " a.tip_produc +'-'+ PADR(a.cod_articu,3) "
			qw6 = " and campo6 in (select codigo from cursor_12 where mx = 'X') "

		case val(lstqui06.codigo) = 13  && Sub Familia del Articulo
			qd6 = " a.tip_produc +'-'+ PADR(a.cod_articu,6) "
			qw6 = " and campo6 in (select codigo from cursor_13 where mx = 'X') "

		case val(lstqui06.codigo) = 14  && Tipo de Articulo
			qd6 = " a.tip_produc +'-'+ PADR(a.cod_articu,9) "
			qw6 = " and campo6 in (select codigo from cursor_14 where mx = 'X') "

		case val(lstqui06.codigo) = 15  && Articulo o Producto
			qd6 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw6 = " and campo6 in (select codigo from cursor_15 where mx = 'X') "
			
		case val(lstqui06.codigo) = 16  && maesstro de conceptos
			qd6 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw6 = " and campo6 in (select codigo from cursor_16 where mx = 'X') "
			
		case val(lstqui06.codigo) = 17  && maestro de servicios
			qd6 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw6 = " and campo6 in (select codigo from cursor_17 where mx = 'X') "
			
		case val(lstqui06.codigo) = 18  && todos los productos
			qd6 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw6 = " and campo6 in (select codigo from cursor_18 where mx = 'X') "
			
		case val(lstqui06.codigo) = 19  && tipo de producto
			qd6 = " a.tip_produc "
			qw6 = " and campo6 in (select codigo from cursor_19 where mx = 'X') "			
	endcase
ENDIF

IF xnrorep >= 7
	do case
		case val(lstqui07.codigo) = 1  && tipo de documentos
			qd7 = " a.td "
			qw7 = " campo7 in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui07.codigo) = 2  && Emisores de documentos
			qd7 = " a.Serie_x "
			qw7 = " campo7 in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui07.codigo) = 3  && Documento
			qd7 = " a.td +' - '+ a.serie +'-'+ a.nrodoc +' - '+ dtoc(a.fecha_reg) "
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

		case val(lstqui07.codigo) = 7  && Motivos de venta
			qd7 = " a.cod_moti "
			qw7 = " campo7 in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui07.codigo) = 8  && Local de Salida
			qd7 = " a.cod_alma "
			qw7 = " campo7 in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui07.codigo) = 9  && Cliente
			qd7 = " a.cod_auxi "
			qw7 = " campo7 in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui07.codigo) = 10  && Forma de Pago
			qd7 = " a.cod_fpag "
			qw7 = " campo7 in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui07.codigo) = 11  && Vendedor
			qd7 = " a.cod_vend "
			qw7 = " campo7 in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui07.codigo) = 12  && Familia del Articulo
			qd7 = " a.tip_produc +'-'+ PADR(a.cod_articu,3) "
			qw7 = " campo7 in (select codigo from cursor_12 where mx = 'X') "

		case val(lstqui07.codigo) = 13  && Sub Familia del Articulo
			qd7 = " a.tip_produc +'-'+ PADR(a.cod_articu,6) "
			qw7 = " campo7 in (select codigo from cursor_13 where mx = 'X') "

		case val(lstqui07.codigo) = 14  && Tipo de Articulo
			qd7 = " a.tip_produc +'-'+ PADR(a.cod_articu,9) "
			qw7 = " campo7 in (select codigo from cursor_14 where mx = 'X') "

		case val(lstqui07.codigo) = 15  && Articulo o Producto
			qd7 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw7 = " campo7 in (select codigo from cursor_15 where mx = 'X') " 
		
		case val(lstqui07.codigo) = 16  && maestro de conceptos
			qd7 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw7 = " campo7 in (select codigo from cursor_16 where mx = 'X') "
			
		case val(lstqui07.codigo) = 17 && maestro de servicios
			qd7 = " a.tip_produc +'-'+ PADR(a.cod_articu,4) "
			qw7 = " campo7 in (select codigo from cursor_17 where mx = 'X') "
			
		case val(lstqui07.codigo) = 18 && todos los productos
			qd7 = " a.tip_produc +'-'+ PADR(a.cod_articu,13) "
			qw7 = " campo7 in (select codigo from cursor_18 where mx = 'X') "
			
		case val(lstqui07.codigo) = 19 && tipo de productos
			qd7 = " a.tip_produc "
			qw7 = " campo7 in (select codigo from cursor_19 where mx = 'X') "			
	endcase
ENDIF

qd_1 = "select " + qd1 + " as campo1," + qd2 + " as campo2," + qd3 + " as campo3," + qd4 + " as campo4," + qd5 + " as campo5," +qd6 + " as campo6, "+ qd7 +" as campo7, "
qd_2 = "a.serie, a.nrodoc, a.fecha_reg, a.Serie_x, a.td, a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_articu, a.des_articu, "
qd_3 = "a.cantidad, round(a.precio,6)+0.000000 as precio, a.v_118, a.v_018, a.tipcam_cod, a.tipcam_val "
qd_4 = "where xfacven = 1 from facty a "
qd_5 = "order by  campo1, campo2, campo3, campo4, campo5, campo6, campo7 into cursor fact"

wait window nowait "PROCESANDO FACTURAS ....."
&qd_1.;
	&qd_2.;
	&qd_3.;
	&qd_4.;
	&qd_5.

qd_1 = "select " + qd1 + " as campo1," + qd2 + " as campo2," + qd3 + " as campo3," + qd4 + " as campo4," + qd5 + " as campo5," +qd6 + " as campo6, "+ qd7 +" as campo7, "
qd_2 = "a.serie, a.nrodoc, a.fecha_reg, a.Serie_x, a.td, a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_articu, a.des_articu, "
qd_3 = "a.cantidad, round(a.precio,6)+0.000000  as precio, a.v_118, a.v_018, a.tipcam_cod, a.tipcam_val "
qd_4 = "where xbolven = 1 from boley a "
qd_5 = "order by  campo1, campo2, campo3, campo4, campo5, campo6, campo7 into cursor bole"

wait window nowait "PROCESANDO BOLETAS DE VENTA ....."
&qd_1.;
	&qd_2.;
	&qd_3.;
	&qd_4.;
	&qd_5.

qd_1 = "select " + qd1 + " as campo1," + qd2 + " as campo2," + qd3 + " as campo3," + qd4 + " as campo4," + qd5 + " as campo5," +qd6 + " as campo6, "+ qd7 +" as campo7, "
qd_2 = "a.serie, a.nrodoc, a.fecha_reg, a.Serie_x, a.td, a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_articu, a.des_articu, "
qd_3 = "a.cantidad, round(a.precio,6)+0.000000  as precio, a.v_118, a.v_018, a.tipcam_cod, a.tipcam_val "
qd_4 = "where xnotcre = 1 from nocry a "
qd_5 = "order by  campo1, campo2, campo3, campo4, campo5, campo6, campo7 into cursor nocr"

wait window nowait "PROCESANDO NOTAS DE CREDITO ....."
&qd_1.;
	&qd_2.;
	&qd_3.;
	&qd_4.;
	&qd_5.


*Que_TipDoc='NDE'
qd_1 = "select " + qd1 + " as campo1," + qd2 + " as campo2," + qd3 + " as campo3," + qd4 + " as campo4," + qd5 + " as campo5," +qd6 + " as campo6, "+ qd7 +" as campo7, "
qd_2 = "a.serie, a.nrodoc, a.fecha_reg, a.Serie_x, a.td, a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_articu, a.des_articu, "
qd_3 = "a.cantidad, round(a.precio,6)+0.000000  as precio, a.v_118, a.v_018, a.tipcam_cod, a.tipcam_val "
qd_4 = "where xnotdeb = 1 from nodey a "
qd_5 = "order by  campo1, campo2, campo3, campo4, campo5, campo6, campo7 into cursor node"

wait window nowait "PROCESANDO NOTAS DE DEBITO ....."
&qd_1.;
	&qd_2.;
	&qd_3.;
	&qd_4.;
	&qd_5.


qd_1 = "select " + qd1 + " as campo1," + qd2 + " as campo2," + qd3 + " as campo3," + qd4 + " as campo4," + qd5 + " as campo5," +qd6 + " as campo6, "+ qd7 +" as campo7, "
qd_2 = "a.serie, a.nrodoc, a.fecha_reg, a.Serie_x, a.td, a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_articu, a.des_articu, "
qd_3 = "a.cantidad, round(a.precio,6)+0.000000 as precio, a.v_118, a.v_018, a.tipcam_cod, a.tipcam_val "
qd_4 = "where xproint = 1 from guisy a "
qd_5 = "order by  campo1, campo2, campo3, campo4, campo5, campo6, campo7 into cursor guis"

wait window nowait "PROCESANDO PROFORMAS INTERNAS ....."
&qd_1.;
	&qd_2.;
	&qd_3.;
	&qd_4.;
	&qd_5.


use in facty
use in boley
use in nocry
use in nodey
USE IN guisy

parcial1 = "select * from fact where " + qw1 + qw2 + " into cursor docu01"
parcial2 = "select * from bole where " + qw1 + qw2 + " into cursor docu02"
parcial3 = "select * from nocr where " + qw1 + qw2 + " into cursor docu03"
parcial4 = "select * from node where " + qw1 + qw2 + " into cursor docu04"
parcial5 = "select * from guis where " + qw1 + qw2 + " into cursor docu05"

wait window nowait "PROCESANDO CONDICION ....."
&parcial1.
&parcial2.
&parcial3.
&parcial4.
&parcial5.

do case
	case xnrorep = 1 .or. xnrorep = 2
		parcial1 = "select * from docu01 into cursor docum1"
		parcial2 = "select * from docu02 into cursor docum2"
		parcial3 = "select * from docu03 into cursor docum3"
		parcial4 = "select * from docu04 into cursor docum4"
		parcial5 = "select * from docu05 into cursor docum5"
		wait window nowait "PROCESANDO (1 Y 2 CONDICION) ....."
		&parcial1.
		&parcial2.
		&parcial3.
		&parcial4.
		&parcial5.

	case xnrorep = 3 .or. xnrorep = 4

		parcial1 = "select * from docu01 where " + qw3 + qw4 + " into cursor docum1"
		parcial2 = "select * from docu02 where " + qw3 + qw4 + " into cursor docum2"
		parcial3 = "select * from docu03 where " + qw3 + qw4 + " into cursor docum3"
		parcial4 = "select * from docu04 where " + qw3 + qw4 + " into cursor docum4"
		parcial5 = "select * from docu05 where " + qw3 + qw4 + " into cursor docum5"
		wait window nowait "PROCESANDO (3 Y 4 CONDICION) ....."
		&parcial1.
		&parcial2.
		&parcial3.
		&parcial4.
		&parcial5.

	case xnrorep = 5 .or. xnrorep = 6

		parcial1 = "select * from docu01 where " + qw3 + qw4 + " into cursor docu11"
		parcial2 = "select * from docu02 where " + qw3 + qw4 + " into cursor docu12"
		parcial3 = "select * from docu03 where " + qw3 + qw4 + " into cursor docu13"
		parcial4 = "select * from docu04 where " + qw3 + qw4 + " into cursor docu14"
		parcial5 = "select * from docu05 where " + qw3 + qw4 + " into cursor docu15"
		wait window nowait "PROCESANDO (3 Y 4 CONDICION) ....."
		&parcial1.
		&parcial2.
		&parcial3.
		&parcial4.
		&parcial5.

		parcial1 = "select * from docu11 where " + qw5 + qw6 + " into cursor docum1"
		parcial2 = "select * from docu12 where " + qw5 + qw6 + " into cursor docum2"
		parcial3 = "select * from docu13 where " + qw5 + qw6 + " into cursor docum3"
		parcial4 = "select * from docu14 where " + qw5 + qw6 + " into cursor docum4"
		parcial5 = "select * from docu15 where " + qw5 + qw6 + " into cursor docum5"
		wait window nowait "PROCESANDO (5 y 6 CONDICION) ....."
		&parcial1.
		&parcial2.
		&parcial3.
		&parcial4.
		&parcial5.

		use in docu11
		use in docu12
		use in docu13
		use in docu14
		use in docu15

	case xnrorep = 7

		parcial1 = "select * from docu01 where " + qw3 + qw4 + " into cursor docu111"
		parcial2 = "select * from docu02 where " + qw3 + qw4 + " into cursor docu112"
		parcial3 = "select * from docu03 where " + qw3 + qw4 + " into cursor docu113"
		parcial4 = "select * from docu04 where " + qw3 + qw4 + " into cursor docu114"
		parcial5 = "select * from docu05 where " + qw3 + qw4 + " into cursor docu115"
		wait window nowait "PROCESANDO (3 Y 4 CONDICION) ....."
		&parcial1.
		&parcial2.
		&parcial3.
		&parcial4.
		&parcial5.

		parcial1 = "select * from docu111 where " + qw5 + qw6 + " into cursor docu11"
		parcial2 = "select * from docu112 where " + qw5 + qw6 + " into cursor docu12"
		parcial3 = "select * from docu113 where " + qw5 + qw6 + " into cursor docu13"
		parcial4 = "select * from docu114 where " + qw5 + qw6 + " into cursor docu14"
		parcial5 = "select * from docu115 where " + qw5 + qw6 + " into cursor docu15"
		wait window nowait "PROCESANDO (5 Y 6 CONDICION) ....."
		&parcial1.
		&parcial2.
		&parcial3.
		&parcial4.
		&parcial5.

		parcial1 = "select * from docu11 where " + qw5 + " into cursor docum1"
		parcial2 = "select * from docu12 where " + qw5 + " into cursor docum2"
		parcial3 = "select * from docu13 where " + qw5 + " into cursor docum3"
		parcial4 = "select * from docu14 where " + qw5 + " into cursor docum4"
		parcial5 = "select * from docu15 where " + qw5 + " into cursor docum5"
		wait window nowait "PROCESANDO (7 CONDICION) ....."
		&parcial1.
		&parcial2.
		&parcial3.
		&parcial4.
		&parcial5.

		use in docu111
		use in docu112
		use in docu113
		use in docu114
		use in docu115

		use in docu11
		use in docu12
		use in docu13
		use in docu14
		use in docu15

endcase

*-------*
do trapre
*-------*

use in fact
use in bole
use in nocr
use in node
USE IN guis

use in docum1
use in docum2
use in docum3
use in docum4
use in docum5

use in docu01
use in docu02
use in docu03
use in docu04
use in docu05

qw6    = " .t. "
txtopc = ""

if xConOpc = 1 && and val(matriz6(_matriz6,2)) != 14
	do case
		case val(lstqui08.codigo) = 1  && tipo de documentos
			qw6 = " td in (select codigo from cursor_01 where mx = 'X') "

		case val(lstqui08.codigo) = 2  && Emisores de documentos
			qw6 = " Serie_x in (select codigo from cursor_02 where mx = 'X') "

		case val(lstqui08.codigo) = 3  && Documento
			qw6 = " .T.  "

		case val(lstqui08.codigo) = 4  && Fecha
			qw6 = " .T.  "

		case val(lstqui08.codigo) = 5  && Periodo Mensual
			qw6 = " .T.  "

		case val(lstqui08.codigo) = 6  && Periodo Anual
			qw6 = " .T.  "

		case val(lstqui08.codigo) = 7  && Motivos de venta
			qw6 = " cod_moti in (select codigo from cursor_07 where mx = 'X') "

		case val(lstqui08.codigo) = 8  && Local de Salida
			qw6 = " cod_alma in (select codigo from cursor_08 where mx = 'X') "

		case val(lstqui08.codigo) = 9  && Cliente
			qw6 = " cod_auxi in (select codigo from cursor_09 where mx = 'X') "

		case val(lstqui08.codigo) = 10  && Forma de Pago
			qw6 = " cod_fpag in (select codigo from cursor_10 where mx = 'X') "

		case val(lstqui08.codigo) = 11  && Vendedor
			qw6 = " cod_vend in (select codigo from cursor_11 where mx = 'X') "

		case val(lstqui08.codigo) = 12  && Familia del Articulo
			qw6 = " tip_produc +'-'+ PADR(cod_articu,3) in (select codigo from cursor_12 where mx = 'X') "

		case val(lstqui08.codigo) = 13  && Sub Familia del Articulo
			qw6 = " tip_produc +'-'+ PADR(cod_articu,6) in (select codigo from cursor_13 where mx = 'X') "

		case val(lstqui08.codigo) = 14  && Tipo de Articulo
			qw6 = " tip_produc +'-'+ PADR(cod_articu,9) in (select codigo from cursor_14 where mx = 'X') "

		case val(lstqui08.codigo) = 15  && Articulo o Producto
			qw6 = " tip_produc +'-'+ PADR(cod_articu,13) in (select codigo from cursor_15 where mx = 'X') "

		case val(lstqui08.codigo) = 16  && maestro de conceptos
			qw6 = " tip_produc +'-'+ PADR(cod_articu,4) in (select codigo from cursor_16 where mx = 'X') "
			
		case val(lstqui08.codigo) = 17  && maestro de servicios
			qw6 = " tip_produc +'-'+ PADR(cod_articu,4) in (select codigo from cursor_17 where mx = 'X') "
			
		case val(lstqui08.codigo) = 18  && todos los productos
			qw6 = " tip_produc +'-'+ PADR(cod_articu,13) in (select codigo from cursor_18 where mx = 'X') "
			
		case val(lstqui08.codigo) = 19  && tipo de productos
			qw6 = " tip_produc in (select codigo from cursor_19 where mx = 'X') "
						
	ENDCASE

ENDIF

wait window nowait "EJECUTANDO ULTIMO PROCESO ....."

SELECT ximprime
eofquery = "select * from ximprime where .t. and " + qw6 + " into cursor imprime"
&eofquery.
use in ximprime

DO Cruce_Data

xTit01 = "REPORTE CONFIGURABLE DE VENTAS"
xTit02 = "DEL " + DTOC(xfecini) + " AL " + dtoc(xfecfin)
xTit03 = "(Expresado En "+iif(xtipmon=1,"Moneda Nacional","Moneda Extranjera")+")"

SELECT imprime
GO TOP 
if xtipprn = 1
	IF .F.
		REPORT FORM RDVTACF1 PREVIEW
		REPORT FORM RDVTACF2 PREVIEW
		REPORT FORM RDVTACF3 PREVIEW
		REPORT FORM RDVTACF4 PREVIEW
		REPORT FORM RDVTACF5 PREVIEW
		REPORT FORM RDVTACF6 PREVIEW
		REPORT FORM RDVTACF7 PREVIEW
	ENDIF
	xtempo = "C:\windows\temp\"+PADR("_"+SYS(3),8,'0')+".TMP"
	xtempo = PADR("_"+SYS(3),8,'0')+".TMP"
	do case
		case xnrorep = 1
			REPORT FORM rdvtacf1 NOCONSOLE TO FILE &xtempo
		case xnrorep = 2
			REPORT FORM rdvtacf2 NOCONSOLE TO FILE &xtempo
		case xnrorep = 3
			REPORT FORM rdvtacf3 NOCONSOLE TO FILE &xtempo
		case xnrorep = 4
			REPORT FORM rdvtacf4 NOCONSOLE TO FILE &xtempo
		case xnrorep = 5
			REPORT FORM rdvtacf5 NOCONSOLE TO FILE &xtempo
		case xnrorep = 6
			REPORT FORM rdvtacf6 NOCONSOLE TO FILE &xtempo
		case xnrorep = 7
			REPORT FORM rdvtacf7 NOCONSOLE TO FILE &xtempo
	endcase
	do __view_2 With "D" , allt(xtempo), 'REPORTE DE VENTA CONFIGURABLE'
else
	do case
		case xnrorep = 1
			repo form rwvtacf1 noconsole preview
			repo form rwvtacf1 noconsole to printer prompt
		case xnrorep = 2
			repo form rwvtacf2 noconsole preview
			repo form rwvtacf2 noconsole to printer prompt
		case xnrorep = 3
			repo form rwvtacf3 noconsole preview
			repo form rwvtacf3 noconsole to printer prompt
		case xnrorep = 4
			repo form rwvtacf4 noconsole preview
			repo form rwvtacf4 noconsole to printer prompt
		case xnrorep = 5
			repo form rwvtacf5 noconsole preview
			repo form rwvtacf5 noconsole to printer prompt
		case xnrorep = 6
			repo form rwvtacf6 noconsole preview
			repo form rwvtacf6 noconsole to printer prompt
		case xnrorep = 7
			repo form rwvtacf7 noconsole preview
			repo form rwvtacf7 noconsole to printer prompt
	endcase
endif

IF xexpdat = 1
	xExcel = "C:\Exportar\Reporte_Venta_Configurable"
	Select imprime
	xExcel = alltrim(xExcel) 
	Copy To &xExcel. Type XL5
	Wait Wind 'Archivo Generado ...............' Time 5
ENDIF
use in imprime
RETURN


*============================================================================================
procedure trapre
*============================================================================================
wait window nowait "EXPRESANDO REPORTE EN " + iif( xtipmon = 1 , "NUEVOS SOLES" , "DOLARES AMERICANOS" )

use in 0 maestica orde codigo ALIAS tabtc AGAIN

select docum1
xxcampos = afields( atemporal )
for x = 1 to xxcampos
	if atemporal(x,1)='PRECIO'
		atemporal(x,3) = 16
		atemporal(x,4) = 6
	endif
ENDFOR
create cursor ximprime from array atemporal

select docum1
scan
	scatter memvar
	insert into ximprime from memvar
	*---------*
	do cambprec
	*---------*
	select docum1
endscan

select docum2
scan
	scatter memvar
	insert into ximprime from memvar
	*---------*
	do cambprec
	*---------*
	select docum2
ENDSCAN

select docum3
scan
	scatter memvar
	insert into ximprime from memvar
	*---------*
	do cambprec
	*---------*
	select docum3
endscan

select docum4
scan
	scatter memvar
	insert into ximprime from memvar
	*---------*
	do cambprec
	*---------*
	select docum4
ENDSCAN

select docum5
scan
	scatter memvar
	insert into ximprime from memvar
	*---------*
	do cambprec
	*---------*
	select docum5
endscan
use in tabtc

return


*=============================================================================================
procedure cambprec
*=============================================================================================
tipcam = 0

IF m.tipcam_cod $ 'CV'
	if seek( dtos(m.fecha_reg) , "tabtc" )
		if m.tipcam_cod = 'V'
			tipcam = tabtc.venta
		endif

		if m.tipcam_cod = 'C'
			tipcam = tabtc.Compra
		endif
	else
		wait window "VERIFICAR EL TIPO DE CAMBIO DEL DIA " + dtoc(m.fecha_reg) timeout 3
	endif
else
	if m.tipcam_cod = 'O' and m.tipcam_val != 0
		tipcam = m.tipcam_val
	Endif
endif
if xtipmon = 1
	if m.cod_mone = "DOL"
		select ximprime
		replace precio with iif( precio != 0 and TipCam != 0, precio * tipcam, 0 )
	endif
else
	if m.cod_mone = "SOL"
		select ximprime
		replace precio with iif( precio != 0 and TipCam != 0, precio / tipcam, 0 )
	endif
endif

return



PROCEDURE crea_cursores
***
IF .t. && xfacven=1
	wait window nowait "CARGANDO DOCUMENTACION DE FACTURAS ....."
	DO crg_docu WITH xfecini, xfecfin, 'fact1', 'fact2', 1
	select "FACT" as td, a.serie, a.nrodoc, a.fecha_reg, a.pedido_vta, a.tipcam_cod, a.tipcam_val, ;
		a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_moti, ;
		Val(Str(1.00 + (((a.totigv*100)/a.totvta)/100),10,2)) as v_118, Val(Str(((a.totigv*100)/a.totvta)/100,10,2)) as v_018, ;
		b.tip_produc, b.cod_articu, b.des_articu, ;
		b.cantidad                 , b.precio_1 as precio, 'FACT '+a.Serie as Serie_x ;
		from cfact1 a, cfact2 b where a.serie+a.nrodoc = b.serie+b.nrodoc and ;
		!a.cod_anula into CURSOR facty
	use in Cfact1
	use in Cfact2
ENDIF

IF .t. && xbolven=1
	wait window nowait "CARGANDO DOCUMENTACION DE BOLETAS DE VENTA ....."
	DO crg_docu WITH xfecini, xfecfin, 'bole1', 'bole2', 1
	select "BOLE" as td, a.serie, a.nrodoc, a.fecha_reg, a.pedido_vta, a.tipcam_cod, a.tipcam_val,;
		a.cod_alma, a.cod_auxi , a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_moti, ;
		Val(Str(1.00 + (((a.totigv*100)/a.totvta)/100),10,2)) as v_118, Val(Str(((a.totigv*100)/a.totvta)/100,10,2)) as v_018, ;
		b.tip_produc, b.cod_articu, b.des_articu, ;
		b.cantidad                 , b.precio_1 as precio, 'BOLE '+a.Serie as Serie_x ;
		from cbole1 a, cbole2 b where a.serie+a.nrodoc = b.serie+b.nrodoc AND ;
		!a.cod_anula into CURSOR boley
	use in cbole1
	use in cbole2
ENDIF

IF .t. && xnotcre=1
	wait window nowait "CARGANDO DOCUMENTACION DE NOTAS DE CREDITO ....."
	DO crg_docu WITH xfecini, xfecfin, 'nocr1', 'nocr2', -1
	select "CRED" as td, a.serie, a.nrodoc, a.fecha_reg, a.pedido_vta, a.tipcam_cod, a.tipcam_val,;
		a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_moti, ;
		Val(Str(1.00 + (((a.totigv*100)/a.totvta)/100),10,2)) as v_118, Val(Str(((a.totigv*100)/a.totvta)/100,10,2)) as v_018, ;
		b.tip_produc, b.cod_articu, b.des_articu, ;
		b.cantidad                 , b.precio_1 as precio, 'CRED '+a.Serie as Serie_x ;
		from cnocr1 a, cnocr2 b where a.serie+a.nrodoc = b.serie+b.nrodoc and ;
		!a.cod_anula into CURSOR nocry
	use in cnocr1
	use in cnocr2
ENDIF

IF .t. && xnotdeb=1
	wait window nowait "CARGANDO DOCUMENTACION DE NOTAS DE DEBITO ....."
	DO crg_docu WITH xfecini, xfecfin, 'node1', 'node2', 1
	select "DEBI" as td, a.serie, a.nrodoc, a.fecha_reg, a.pedido_vta, a.tipcam_cod, a.tipcam_val,;
		a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_moti, ;
		Val(Str(1.00 + (((a.totigv*100)/a.totvta)/100),10,2)) as v_118, Val(Str(((a.totigv*100)/a.totvta)/100,10,2)) as v_018, ;
		b.tip_produc, b.cod_articu, b.des_articu, ;
		b.cantidad                 , b.precio_1 as precio, 'DEBI '+a.Serie as Serie_x ;
		from cnode1 a, cnode2 b where a.serie+a.nrodoc = b.serie+b.nrodoc and ;
		!a.cod_anula into CURSOR nodey
	use in cnode1
	use in cnode2
ENDIF

IF .t. && xproint=1
	wait window nowait "CARGANDO DOCUMENTACION PROFORMA INTERNA ....."
	DO crg_docu WITH xfecini, xfecfin, 'guis1', 'guis2', 1
	select "GUIS" as td, a.serie, a.nrodoc, a.fecha_reg, a.pedido_vta, a.tipcam_cod, a.tipcam_val, ;
		a.cod_alma, a.cod_auxi, a.cod_mone, a.cod_vend, a.cod_fpag, a.cod_moti, ;
		Val(Str(1.00 + (((a.totigv*100)/a.totvta)/100),10,2)) as v_118, Val(Str(((a.totigv*100)/a.totvta)/100,10,2)) as v_018, ;
		b.tip_produc, b.cod_articu, b.des_articu, ;
		b.cantidad                 , b.precio_1 as precio, 'GUIS '+a.Serie as Serie_x ;
		from cguis1 a, cguis2 b where a.serie+a.nrodoc = b.serie+b.nrodoc and ;
		!a.cod_anula into CURSOR guisy
	use in Cguis1
	use in Cguis2
ENDIF

RETURN



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

	case yyy = 9  && Cliente
		*detalle = IIF( seek(valor, "cursor_09"), iif(sw_verdes=1, allt(cursor_09.codigo) +" ","")+ cursor_09.descri, " ")
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

	case yyy = 10  && Forma de Pago
		*detalle = IIF( seek(valor, "cursor_10"), iif(sw_verdes=1, allt(cursor_10.codigo) +" ","")+ cursor_10.descri, " ")
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

	case yyy = 11  && Vendedor
		*detalle = IIF( seek(valor, "cursor_11"), iif(sw_verdes=1, allt(cursor_11.codigo) +" ","")+ cursor_11.descri, " ")
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

	case yyy = 12  && Familia del Articulo
		*detalle = IIF( seek(valor, "cursor_12"), iif(sw_verdes=1, allt(cursor_12.codigo) +" ","")+ cursor_12.descri, " ")
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

	case yyy = 13  && Sub Familia del Articulo
		*detalle = IIF( seek(valor, "cursor_13"), iif(sw_verdes=1, allt(cursor_13.codigo) +" ","")+ cursor_13.descri, " ")
		SELECT cursor_13
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_13.descri
		ENDIF
		SELECT cursor_13
		SET KEY TO

	case yyy = 14  && Tipo de Articulo
		*detalle = IIF( seek(valor, "cursor_14"), iif(sw_verdes=1, allt(cursor_14.codigo) +" ","")+ cursor_14.descri, " ")
		SELECT cursor_14
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_14.descri
		ENDIF
		SELECT cursor_14
		SET KEY TO

	case yyy = 15  && Articulo o Producto
		*detalle = IIF( seek(valor, "cursor_15"), iif(sw_verdes=1, allt(cursor_15.codigo) +" ","")+ cursor_15.descri, " ")
		SELECT cursor_15
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_15.descri
		ENDIF
		SELECT cursor_15
		SET KEY TO
		
	case yyy = 16  && maestro de conceptos
		SELECT cursor_16
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_16.descri
		ENDIF
		SELECT cursor_16
		SET KEY TO	

	case yyy = 17  && maestro de servicios
		SELECT cursor_17
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_17.descri
		ENDIF
		SELECT cursor_17
		SET KEY TO
			
	case yyy = 18  && todos los productos
		SELECT cursor_18
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_18.descri
		ENDIF
		SELECT cursor_18
		SET KEY TO
	
	case yyy = 19  && tipos de productos
		SELECT cursor_19
		SET KEY TO valor
		GO TOP
		IF EOF()
			detalle = " "
		ELSE
			detalle = cursor_19.descri
		ENDIF
		SELECT cursor_19
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
	tot_cantid n(16,6), tot_venta n(16,6), tot_igv n(16,6), tot_total n(16,6) )
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
	m.tot_cantid = imprime.cantidad
	m.tot_venta  = valor_rep('B')
	m.tot_igv    = valor_rep('I')
	m.tot_total  = valor_rep('T')
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
	replace tot_cantid WITH cru_data.tot_cantid + m.tot_cantid
	replace tot_venta  WITH cru_data.tot_venta  + m.tot_venta
	replace tot_igv    WITH cru_data.tot_igv    + m.tot_igv
	replace tot_total  WITH cru_data.tot_total  + m.tot_total
	***
	SELECT cru_data
	SET KEY TO 
	***
	SELECT imprime
ENDSCAN

SELECT * FROM cru_data ORDER BY cod_campo1, cod_campo2, cod_campo3, cod_campo4, cod_campo5, cod_campo6, cod_campo7 INTO CURSOR imprime

USE IN cru_data
USE IN tempo
RETURN


PROCEDURE valor_rep
PARAMETERS tipo_valor
reto_valor = 0
DO case
	CASE tipo_valor = 'B'
		reto_valor = round( iif( Imprime.Td="BOLE", Imprime.precio / Imprime.v_118 , Imprime.precio ) * Imprime.cantidad                ,2)
	CASE tipo_valor = 'I'
		reto_valor = round( iif( Imprime.Td="BOLE", Imprime.precio / Imprime.v_118 , Imprime.precio ) * Imprime.cantidad * imprime.v_018,2)
	CASE tipo_valor = 'T'
		reto_valor = round( iif( Imprime.Td="BOLE", Imprime.precio / Imprime.v_118 , Imprime.precio ) * Imprime.cantidad * imprime.v_118,2)
endcase
RETURN reto_valor
