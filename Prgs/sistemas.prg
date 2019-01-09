CLOSE DATABASE
Do Inicio in Library
sw_ingusu = .f.
DO FORM frm_pass
_SCREEN.HIDE()
frm_pass.SHOW()
READ EVENTS
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
