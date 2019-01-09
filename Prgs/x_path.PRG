*Procedure x_path
rutas = ""
rutas = rutas + _rt_sis_ + "\Prgs;"
rutas = rutas + _rt_sis_ + "\Form;"
rutas = rutas + _rt_sis_ + "\Repo;"
rutas = rutas + _rt_sis_ + "\Proj;"
rutas = rutas + _rt_sis_ + "\Exes;"
rutas = rutas + _rt_sis_ + "\icos;"
rutas = rutas + _rt_sis_ + "\class;"
rutas = rutas + _rt_bas_ + ";"
rutas = rutas + _rt_siad_ + "\CONF;" 
rutas = rutas + _rt_siad_ + "\ALMA;" 
rutas = rutas + _rt_siad_ + "\VENT;" 
rutas = rutas + _rt_siad_ + "\CONT;"
rutas = rutas + "\BSC\EXES"
*rutas = rutas + "\BSC\EXES;" + "D:\Sistemas\Sistem01\BSC\VFPE;" + "D:\Sistemas\Sistem01\BSC\VFPP"
SET PATH TO &rutas.
RETURN