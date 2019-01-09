PARAMETERS PARA_X_FILE
_ruta_base = _rt_bas_ + "\"
DO CASE
	CASE UPPER(para_x_file) = UPPER("usuario.dbf")
		DO crea_file_usuario

	CASE UPPER(para_x_file) = UPPER("tabopc.dbf")
		DO crea_file_tabopc

	CASE UPPER(para_x_file) = 'ALL_FILE'
		***
		DO crea_file_usuario
		DO crea_file_tabopc

ENDCASE
RETURN


PROCEDURE crea_file_usuario
If !File(_ruta_base+"usuario.dbf")
	create cursor tempo (;
		PREFIJ C(03), C0     C(03), NOMBRE C(30), C1     C(30), ;
		CLAVES C(30), C2     C(30), NIVEL  N(03), MENU   C(30), NMANT  N(01), ;
		new_usu c(3), new_fec d(8), new_hor c(8), ;
		mod_usu c(3), mod_fec d(8), mod_hor c(8), ;
		del_usu c(3), del_fec d(8), del_hor c(8) )

	SELECT tempo
	APPEND BLANK
	replace prefij WITH "JCV"
	replace nombre WITH "áíâÜå]ÄåèÅåì~"		&& JULIO CORDOVA
	replace claves WITH "àÇã"				&& KEN

	select tempo
	index on prefij tag prefij
	index on claves tag claves

	SELECT tempo
	INDEX on prefij tag prefij
	INDEX on claves TAG claves
	COPY TO &_ruta_base.usuario WITH cdx TYPE fox2x
	use in tempo
Endif
RETURN


PROCEDURE crea_file_tabopc
If !File(_ruta_base+"tabopc.dbf")		&& crea la tabla de opciones
	create cursor tempo (;
		modulo c(3), nivel c(2), subnivel c(2), ;
		descrip c(75), programa c(75), observa c(75) )

	SELECT tempo
	INDEX on modulo+nivel+subnivel TAG tabopc
	COPY TO &_ruta_base.tabopc WITH cdx TYPE fox2x
	use in tempo
ENDIF

If !File(_ruta_base+"tabacc.dbf")		&& crea la tabla de accesos
	create cursor tempo (;
		usuario c(3), modulo c(3), nivel c(2), subnivel c(2), ;
		c1 c(5), c2 c(5), c3 c(5), c4 c(5) )

	SELECT tempo
	INDEX on usuario+modulo+nivel+subnivel TAG tabacc
	INDEX on modulo+nivel+subnivel TAG modulo
	COPY TO &_ruta_base.tabacc WITH cdx TYPE fox2x
	use in tempo
ENDIF

DO crea_menu_tabopc

RETURN



PROCEDURE crea_menu_tabopc
USE IN 0 tabopc ORDER tabopc ALIAS tabopc_v again
USE IN 0 tabopc ORDER tabopc ALIAS tabopc_p again
USE IN 0 tabacc ORDER tabacc ALIAS tabacc_p AGAIN
***
IF .f.
	=add_menu_opc ('SIS','01','00', 'Maestros Generales', '', '')
	=add_menu_opc ('SIS','01','01', 'Clientes', 'maesclie.EXE', '')
	=add_menu_opc ('SIS','01','02', 'Proveedores', 'maesprov.EXE', '')
	=add_menu_opc ('SIS','01','03', 'Distritos', 'maesdist.EXE', '')
	=add_menu_opc ('SIS','01','04', 'Tipo de Cambio', 'maestica.EXE', '')
	=add_menu_opc ('SIS','01','05', 'Numerador de Documentos', 'maesnume.EXE', '')
	***
	=add_menu_opc ('SIS','01','89', '\-', '', '')
	=add_menu_opc ('SIS','01','90', 'Usuarios', 'maesuser.EXE', '')
	***
	=add_menu_opc ('SIS','02','00', 'Maestros de AlmacÈn', '', '')
	=add_menu_opc ('SIS','02','01', 'Grupos', 'maesgrup.EXE', '')
	=add_menu_opc ('SIS','02','02', 'Familia', 'maesfami.EXE', '')
	=add_menu_opc ('SIS','02','03', 'SubFamilia', 'maessfam.EXE', '')
	=add_menu_opc ('SIS','02','04', 'Tipo', 'maestipo.EXE', '')
	=add_menu_opc ('SIS','02','05', 'Unidades de Medida', 'maesunid.EXE', '')
	=add_menu_opc ('SIS','02','06', 'RelaciÛn de ArtÌculos', 'maesarti.EXE', '')
	=add_menu_opc ('SIS','02','07', '\-', '', '')
	=add_menu_opc ('SIS','02','08', 'Almacenes', 'maesalma.EXE', '')
	=add_menu_opc ('SIS','02','09', 'Vendedores', 'maesvend.EXE', '')
	=add_menu_opc ('SIS','02','10', 'Transportistas', 'maestran.EXE', '')
	=add_menu_opc ('SIS','02','11', 'Motivos de OperaciÛn', 'maesmoti.EXE', '')
	=add_menu_opc ('SIS','02','12', 'Forma de Pagos', 'maesfpag.EXE', '')
	***
	=add_menu_opc ('SIS','02','20', '\-', '')
	=add_menu_opc ('SIS','02','21', 'RelaciÛn de Conceptos', 'maesconc.EXE')
	=add_menu_opc ('SIS','02','22', 'RelaciÛn de Servicios', 'maesserv.EXE')
	***
	=add_menu_opc ('SIS','03','00', 'Documentos de AlmacÈn', '', '')
	=add_menu_opc ('SIS','03','01', 'Partes de Ingreso', 'paringr1.EXE', '')
	=add_menu_opc ('SIS','03','02', 'Partes de Salida', 'parsali1.EXE', '')
	=add_menu_opc ('SIS','03','03', 'GuÌa de RemisiÛn', 'guiremi1.EXE', '')
	***
	=add_menu_opc ('SIS','04','00', 'Documentos de Venta', '', '')
	=add_menu_opc ('SIS','04','01', 'Factura', 'facvent1.EXE', '')
	=add_menu_opc ('SIS','04','02', 'Boleta de Venta', 'bolvent1.EXE', '')
	=add_menu_opc ('SIS','04','03', 'Nota de CrÈdito', 'notcred1.EXE', '')
	=add_menu_opc ('SIS','04','04', 'Nota de DÈbito', 'notdebi1.EXE', '')
	=add_menu_opc ('SIS','04','05', 'Proforma Interna', 'guisali1.EXE', '')
	***
	=add_menu_opc ('SIS','05','00', 'Reportes Generales', '', '')
	=add_menu_opc ('SIS','05','01', 'Registro de Ventas', 'r_regvta.EXE', '')
	=add_menu_opc ('SIS','05','02', 'Consulta R·pida de Stock x ArtÌculo', 'r_constk.EXE', '')
	=add_menu_opc ('SIS','05','03', 'Ultimos Precios de Compra', 'r_ultpre.EXE', '')
	=add_menu_opc ('SIS','05','04', 'Kardex Valorizado', 'r_karval.EXE', '')
*	=add_menu_opc ('SIS','05','05', 'Rep_ ', 'proj_rept_wayra.EXE', '')	
	***
	=add_menu_opc ('SIS','06','00', 'Reportes Configurables', '', '')
	=add_menu_opc ('SIS','06','01', 'Configurable de Ventas', 'r_vtacfg.EXE', '')
	=add_menu_opc ('SIS','06','02', 'Configurable de Movimientos', 'r_movcfg.EXE', '')
	***
	=add_menu_opc ('SIS','99','00', 'Utilitarios', '', '')
	=add_menu_opc ('SIS','99','01', 'ReorganizaciÛn de Kardex Valorizado', 'p_karval.EXE', '')
	=add_menu_opc ('SIS','99','99', 'Salida', 'salida.EXE', '')
endif
***
SELECT tabopc_v
GO top
SCAN
	para00 = passw('JCV')
	para11 = passw(tabopc_v.modulo)
	para22 = passw(tabopc_v.nivel)
	para33 = passw(tabopc_v.subnivel)
	***
	SELECT tabacc_p
	SET KEY TO para00 + para11 + para22 + para33
	GO top
	IF EOF()
		INSERT INTO tabacc_p VALUES (para00, para11, para22, para33, '', '', '', '')
	ENDIF
	SELECT tabacc_p
	SET KEY TO
	***
	SELECT tabopc_v
ENDSCAN
***
USE IN tabopc_p
USE IN tabopc_v
USE IN tabacc_p
RETURN


PROCEDURE add_menu_opc
PARAMETERS para1, para2, para3, para4, para5, para6
*** verifica la tabla de opciones
SELECT tabopc_p
SET KEY TO para1 + para2 + para3
GO top
IF EOF()
	INSERT INTO tabopc_p VALUES (para1, para2, para3, para4, para5, para6)
ENDIF
SELECT tabopc_p
SET KEY TO

*** verifica la tabla de accesos
IF !EMPTY(para5)
	para00 = passw('JCV')
	para11 = passw(para1)
	para22 = passw(para2)
	para33 = passw(para3)

	SELECT tabacc_p
	SET KEY TO para00 + para11 + para22 + para33
	GO top
	IF EOF()
		INSERT INTO tabacc_p VALUES (para00, para11, para22, para33, '', '', '', '')
	ENDIF
	SELECT tabacc_p
	SET KEY TO
ENDIF

RETURN
