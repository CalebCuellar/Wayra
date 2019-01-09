PUBLIC _rt_sis_, _rt_bas_, _rt_siad_, _Direc
&& ccp 18/08/14
lcRuta = SYS(5) + SYS(2003)
lcRuta = LEFT(lcRuta,RAT("\",lcRuta)-1)
&&
*_rt_sis_  = '\sistem01'
_rt_sis_  = lcRuta
_rt_bas_ = _rt_sis_ + '\Data01'
*_rt_siad_ = '\CIBY'
&& ccp 18/08/14
SET PROCEDURE TO LIBRARY
lcPathDB = ReadFileIni(_rt_sis_ + "\CONFIG.INI","BSC","DB_PATH")
IF ISNULL(lcPathDB) OR EMPTY(lcPathDB)
	_rt_siad_ = lcRuta + '\CIBY'
ELSE
	_rt_siad_ = lcPathDB
ENDIF
&&
_Direc = _rt_siad_