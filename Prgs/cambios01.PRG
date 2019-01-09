CLOSE DATABASES

* Agregar nuevas opciones al menu del sistema
USE IN 0 tabopc ORDER tabopc ALIAS menu again		&& modulo+nivel+subnivel
DO cam_01 WITH 'SIS', '02', '20', '\-', ''
DO cam_01 WITH 'SIS', '02', '21', 'Relación de Conceptos', 'maesconc.EXE'
DO cam_01 WITH 'SIS', '02', '22', 'Relación de Servicios', 'maesserv.EXE'
USE IN menu

* agregar un campo nuevo en las tablas del sistema
DO cam_02 WITH 'bole2', 'tip_produc', 'C', '1', '0'
DO cam_02 WITH 'fact2', 'tip_produc', 'C', '1', '0'
DO cam_02 WITH 'guia2', 'tip_produc', 'C', '1', '0'
DO cam_02 WITH 'guis2', 'tip_produc', 'C', '1', '0'
DO cam_02 WITH 'nocr2', 'tip_produc', 'C', '1', '0'
DO cam_02 WITH 'node2', 'tip_produc', 'C', '1', '0'
DO cam_02 WITH 'pari2', 'tip_produc', 'C', '1', '0'
DO cam_02 WITH 'pars2', 'tip_produc', 'C', '1', '0'

DO cam_02 WITH 'kardex2' , 'tip_produc', 'C', '1', '0'
DO cam_02 WITH 'stockart', 'tip_produc', 'C', '1', '0'

RETURN


PROCEDURE cam_02		&& agrega campo nuevo en las tablas del sistema
PARAMETERS para01, para02, para03, para04, para05

*para01 = tabla
*para02 = campo
*para03 = type
*para04 = longitud
*para05 = decimal

SELECT 0
USE &para01. EXCLUSIVE
if type(para01+"."+para02) = "U"
	?DBF()
	comando = "alter table "+para01+" add column "+para02+" "+para03+"("+para04+", "+para05+")"
	&comando.
	replace &para02. WITH 'P' all
	DO case
		CASE UPPER(para01) = 'STOCKART'
			Index on cod_articu + cod_alma Tag Codigo
			Index on cod_alma + cod_articu Tag Almacen
			
		CASE UPPER(para01) = 'KARDEX2'
			index on cod_articu+DTOS(fecha_reg)+orden tag kardex2
			index on tipdoc + serie + nrodoc + item tag documento
			
		OTHERWISE
			INDEX on tip_produc + cod_articu + serie + nrodoc + item tag COD_ARTICU
	ENDCASE
ELSE
	replace &para02. WITH 'P' all
	DO case
		CASE UPPER(para01) = 'STOCKART'
			Index on cod_articu + cod_alma Tag Codigo
			Index on cod_alma + cod_articu Tag Almacen
			
		CASE UPPER(para01) = 'KARDEX2'
			index on cod_articu+DTOS(fecha_reg)+orden tag kardex2
			index on tipdoc + serie + nrodoc + item tag documento
			
		OTHERWISE
			INDEX on tip_produc + cod_articu + serie + nrodoc + item tag COD_ARTICU
	ENDCASE
ENDIF
USE
RETURN


PROCEDURE cam_01
PARAMETERS para01, para02, para03, para04, para05

*para01 = modulo
*para02 = nivel
*para03 = subnivel
*para04 = descripcion
*para05 = programa .exe

SELECT menu
SET KEY TO para01 + para02 + para03		&& 'SIS'+'02'+'20'
GO top
IF EOF()
	INSERT INTO MENU (modulo, nivel, subnivel, descrip, programa) VALUES (para01, para02, para03, para04, para05)
ENDIF
SELECT menu
SET KEY TO
RETURN
