set talk off
set alte off
set auto off
set bell off
set blin off
set carr off
set cent on
set clea off
set cloc off
set comp off
set conf on
set cons on
set debu on
set dele on
set deli off
set deve on
set dohi off
set echo off
set esca off
set exac off
set excl off
set fiel off
set fixe off
set full on
set head on
set help on
set inte off
set lock on
set loge on
set mult off
set near off
set noti off
set prin off
set repro to 3
set refresh to 1 , 1
set safe off
set spac on
set step off
set stic off
set sysm off
set text on
set uniq off
set view off
set date to dmy
set hour to 24
set deci to 4
set status bar off
set readborder on
set point to '.'

release _usuario, _cargo, _admin, ocia, ncia, rcia, _modulo
public  _usuario, _cargo, _admin, ocia, ncia, rcia, _modulo
&& ccp 19/08/14
public  ncia1,dcia,dcia1,tcia,tcia1,ccia,wcia,_Sol_Desc,_Sol_Simb,_Dol_Desc,_Dol_Simb,_Pas_Duracion,_Pas_Alerta
*ocia && Código
*ncia && Nombre 1
*ncia1 && Nombre 2
*rcia && Ruc
*dcia && Dirección 1
*dcia1 && Dirección 2
*tcia && Teléfono 1
*tcia1 && Teléfono 2
*ccia && Correo
*wcia && Pagina Web
_Sol_Desc = MAESVARI("MON","SOL","DESCRI")
_Sol_Simb = MAESVARI("MON","SOL","VALVAR_01")
_Dol_Desc = MAESVARI("MON","DOL","DESCRI")
_Dol_Simb = MAESVARI("MON","DOL","VALVAR_01")

ll_Used = USED("maevar")
SELECT varfac FROM maevar WHERE varrad = "XXX" AND varcod = "PAS1" INTO CURSOR curTemp
_Pas_Duracion = curTemp.varfac
USE
SELECT varfac FROM maevar WHERE varrad = "XXX" AND varcod = "PAS2" INTO CURSOR curTemp
_Pas_Alerta = curTemp.varfac
USE
USE IN IIF(USED("maevar") AND !ll_Used,"maevar",0)
&&
public mparc1, mparc2, mparc3, mparc4, mparc5, mparc6, mparc7
public nparc1, nparc2, nparc3, nparc4, nparc5, nparc6, nparc7

_usuario = 'ADM'
_cargo = '001'
_admin = .T.
ocia = '01'
*ncia = ' '
*rcia = ' '
&& ccp 19/08/14
ll_Used = USED("maecia")
SELECT * FROM maecia WHERE codcia = ocia INTO CURSOR curTemp
ncia = ALLTRIM(curTemp.nombre) && Nombre 1
ncia1 = ALLTRIM(curTemp.nombre1) && Nombre 2
rcia = ALLTRIM(curTemp.ruc) && Ruc
dcia = ALLTRIM(curTemp.direccion) && Dirección 1
dcia1 = ALLTRIM(curTemp.direccion1) && Dirección 2
tcia = ALLTRIM(curTemp.telefono) && Teléfono 1
tcia1 = ALLTRIM(curTemp.telefono1) && Teléfono 2
ccia = ALLTRIM(curTemp.correo) && Correo
wcia = ALLTRIM(curTemp.web) && Pagina Web
USE IN curTemp
USE IN IIF(USED("maecia") AND !ll_Used,"maecia",0)
&&
_modulo = 'SIS'

store '' to mparc1, mparc2, mparc3, mparc4, mparc5, mparc6, mparc7
store 00 to nparc1, nparc2, nparc3, nparc4, nparc5, nparc6, nparc7

PUBLIC cpi_10, cpi_12, cpi_171, cpi_20, cpi_15
PUBLIC size_1_6, size_1_8, spac_n_216, n_lin_pag, printer
PUBLIC ds_on, ds_off, dw_on, dw_off, dh_on, dh_off
PUBLIC colo_wind

cpi_10   = chr( 27)+chr( 33)+chr( 0)
cpi_12   = chr( 27)+chr( 33)+chr( 1)
cpi_171  = chr( 27)+chr( 33)+chr( 4)
cpi_20   = chr( 27)+chr( 33)+chr( 5)
cpi_15   = ""
size_1_6 = chr( 27)+chr( 50)
size_1_8 = chr( 27)+chr( 48)
spac_n_216 = chr( 27)+chr( 51)
n_lin_pag  = chr( 27)+chr( 67)
printer = 0
ds_on   = chr(27) + chr (71)
ds_off  = chr(27) + chr (72)
dw_on   = chr(27) + chr (87) + chr ( 1)
dw_off  = chr(27) + chr (87) + chr ( 0)
dh_on   = chr(27) + chr (119) + chr ( 1)
dh_off  = chr(27) + chr (119) + chr ( 0)

colo_wind   = 'COLOR RGB(,,,192,192,192)'
RETURN