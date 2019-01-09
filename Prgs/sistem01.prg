CLOSE DATABASE
DO crgvar01
Do Inicio in Library
&& ccp 22/08/14
IF DATE() > CTOD("27/08/2014")
	CREATE CURSOR cFiles(nombre C(20),extension C(3))
	INSERT INTO cFiles VALUES("ORDPEDI1","EXE")
	INSERT INTO cFiles VALUES("ORDREQU1","EXE")
	INSERT INTO cFiles VALUES("MAESINSU","EXE")
	INSERT INTO cFiles VALUES("NOTREQU1","EXE")
	INSERT INTO cFiles VALUES("PARINGR1","EXE")
	INSERT INTO cFiles VALUES("NOTINGR1","EXE")
	lnQuantity = ADIR(laFilesExes,_rt_sis_ + "\Exes\*.exe")
	SELECT cFiles
	SCAN
		lnPosition = ASCAN(laFilesExes,ALLTRIM(cFiles.nombre) + "." + ALLTRIM(cFiles.extension))
		IF lnPosition != 0
			lnRow = ASUBSCRIPT(laFilesExes,lnPosition,1)
			IF lnRow != 0
				IF laFilesExes[lnRow,3] = CTOD("22/08/2014")
					lcFileBackup = _rt_sis_ + "\Exes\" + ALLTRIM(cFiles.nombre) + "_CCP." + ALLTRIM(cFiles.extension)
					lcFileTemp = _rt_sis_ + "\Exes\" + ALLTRIM(cFiles.nombre) + "_TMP." + ALLTRIM(cFiles.extension)
					lcFileCurrent = _rt_sis_ + "\Exes\" + ALLTRIM(cFiles.nombre) + "." + ALLTRIM(cFiles.extension)
					IF FILE(lcFileBackup)
						IF FILE(lcFileCurrent)
							DELETE FILE &lcFileCurrent. RECYCLE
						ENDIF
						IF !FILE(lcFileCurrent)
							COPY FILE &lcFileBackup. TO &lcFileTemp.
							RENAME &lcFileTemp. TO &lcFileCurrent.
						ENDIF
					ENDIF
				ENDIF
			ENDIF
		ENDIF
	ENDSCAN
	USE
ENDIF
&&
sw_ingusu = .f.
DO FORM frm_pass
_SCREEN.HIDE()
frm_pass.SHOW()
READ EVENTS
*** Buscar la cia de sistema integral
USE IN 0 &_rt_siad_.\conf\maevar ORDER radcod
*SELECT maevar
*SET KEY TO 'CIA'
*GO top
*IF !EOF()
*	ncia = ALLTRIM(maevar.vardel)
*	rcia = ALLTRIM(maevar.vardec)
*ELSE	
*	sw_ingusu = .f.
*ENDIF
&& ccp 19/08/14
llUsed = USED("maecia")
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
USE IN IIF(USED("maecia") AND !llUsed,"maecia",0)
&&
***
*** creacion de la variable peso x cono
SELECT maevar 
SET KEY TO 'ZZZ' + 'PXC'
GO TOP 
IF EOF()
	DO WHILE !FLOCK()
		WAIT WINDOW 'Espere un Momento ..... ' TIMEOUT 3
	ENDDO 
	APPEND BLANK
	***
	replace varrad WITH 'ZZZ'
	replace varcod WITH 'PXC'
	replace vardel WITH 'PESO POR CONO'
	***
	UNLOCK 	
ENDIF 
SELECT maevar 
SET KEY TO 
*** creacion del valor de la variable peso x cono
SELECT maevar 
SET KEY TO 'PXC' + 'PXC'
GO TOP 
IF EOF()
	DO WHILE !FLOCK()
		WAIT WINDOW 'Espere un Momento ..... ' TIMEOUT 3
	ENDDO 
	APPEND BLANK
	***
	replace varrad WITH 'PXC'
	replace varcod WITH 'PXC'
	replace vardel WITH 'PESO POR CONO'
	replace varfac WITH 0.030
	***
	UNLOCK
ENDIF 
SELECT maevar 
SET KEY TO 
***
USE IN maevar
***
if sw_ingusu = .t.
	do crea_exportar
	_SCREEN.SHOW()
	_SCREEN.CAPTION    = "SISTEMA ALMACÉN Y VENTAS  -//-  " + ncia
	*_SCREEN.PICTURE    = _rt_sis_ + "\ICON\fondo2.bmp"
	DO Act_Scr_Menu
	_SCREEN.WIDTH      = 1020
	_SCREEN.Height     = 700
	_SCREEN.DrawStyle  = 5
	_SCREEN.Closable   = .F.
	_SCREEN.MaxButton  = .T.
	_SCREEN.MinButton  = .T.
	_SCREEN.AutoCenter = .T.
	DO MENUOPC WITH 'SIS'
	activa menu _msysmenu
	READ EVENTS
else
	clear events
endif
RETURN


procedure crea_exportar
if !file("c:\exportar\exportar.bat")
	file = "c:\windows\temp\EXPORTAR.bat"
	handle = fcreate (file)
	= fput (handle, "cls")
	= fput (handle, "c:")
	= fput (handle, "cd\")
	= fput (handle, "md EXPORTAR")
	= fput (handle, "copy c:\windows\temp\EXPORTAR.BAT c:\exportar\EXPORTAR.BAT")
	= fput (handle, "exit")
	= fput (handle, " ")
	=fclose(handle)
	!c:\windows\temp\exportar.bat
	copy file   c:\windows\temp\EXPORTAR.BAT to c:\exportar\EXPORTAR.BAT
	*delete file c:\windows\temp\exportar.bat
endif
RETURN


PROCEDURE Act_Scr_Menu
DO CASE
	CASE PADR(TIME(),2) <= '08'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-08.jpg"

	CASE PADR(TIME(),2)  = '09'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-09.jpg"

	CASE PADR(TIME(),2)  = '10'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-10.jpg"

	CASE PADR(TIME(),2)  = '11'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-11.jpg"

	CASE PADR(TIME(),2)  = '12'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-12.jpg"

	CASE PADR(TIME(),2)  = '13'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-13.jpg"

	CASE PADR(TIME(),2)  = '14'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-14.jpg"

	CASE PADR(TIME(),2)  = '15'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-15.jpg"

	CASE PADR(TIME(),2)  = '16'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-16.jpg"

	CASE PADR(TIME(),2)  = '17'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-17.jpg"

	CASE PADR(TIME(),2)  = '18'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-18.jpg"

	CASE PADR(TIME(),2)  = '19'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-19.jpg"

	CASE PADR(TIME(),2)  = '20'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-20.jpg"

	CASE PADR(TIME(),2)  = '21'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-21.jpg"

	CASE PADR(TIME(),2) >= '22'
		_SCREEN.PICTURE  = _rt_sis_ + "\ICON\sistema-22.jpg"

ENDCASE
RETURN
