PARAMETERS pcSerie,pcNumero
ln_Used_Current = SELECT()
*** Abriendo Tablas
ll_Used_Remi1 = USED("remi1")
IF !ll_Used_Remi1
	USE remi1 IN 0 AGAIN
ENDIF
SELECT remi1
lc_Order_Remi1 = ORDER()
SET ORDER TO remi1

ll_Used_Remi2 = USED("remi2")
IF !ll_Used_Remi2
	USE remi2 IN 0 AGAIN
ENDIF
SELECT remi2
lc_Order_Remi2 = ORDER()
SET ORDER TO remi2

ll_Used_Fact1 = USED("fact1")
IF !ll_Used_Fact1
	USE fact1 IN 0 AGAIN
ENDIF
SELECT fact1
lc_Order_Fact1 = ORDER()
SET ORDER TO fact1

ll_Used_Fact2 = USED("fact2")
IF !ll_Used_Fact2
	USE fact2 IN 0 AGAIN
ENDIF
SELECT fact2
lc_Order_Fact2 = ORDER()
SET ORDER TO guirem

ll_Used_Bole1 = USED("bole1")
IF !ll_Used_Bole1
	USE bole1 IN 0 AGAIN
ENDIF
SELECT bole1
lc_Order_Bole1 = ORDER()
SET ORDER TO bole1

ll_Used_Bole2 = USED("bole2")
IF !ll_Used_Bole2
	USE bole2 IN 0 AGAIN
ENDIF
SELECT bole2
lc_Order_Bole2 = ORDER()
SET ORDER TO guirem
***
*** Buscando en GR Cabecera
SELECT remi1
SEEK pcSerie + pcNumero
IF FOUND() AND !remi1.cod_anula
	lnCantidad = 0
	lnFacturado = 0
	*** Buscando en GR Detalle
	SELECT remi2
	SEEK remi1.serie + remi1.nrodoc
	SCAN WHILE serie + nrodoc = remi1.serie + remi1.nrodoc
		lnCantidad = lnCantidad + remi2.cantidad
		lnArticuloFacturado = 0
		STORE "" TO lc_vta_tipdoc,lc_vta_serie,lc_vta_nrodoc
		ld_vta_fecha = CTOD("")
		*** Buscando en Boleta
		SELECT bole2
		SEEK "GUIA" + remi2.serie + remi2.nrodoc + remi2.cod_articu
		SCAN WHILE guirem_tip + guirem_ser + guirem_nro + cod_articu = "GUIA" + remi2.serie + remi2.nrodoc + remi2.cod_articu
			*** Verificando si la Cabecera esta Activa
			SELECT bole1
			SEEK bole2.serie + bole2.nrodoc
			IF FOUND() AND !bole1.cod_anula
				lnArticuloFacturado = lnArticuloFacturado + bole2.cantidad
				IF bole1.fecha_reg > ld_vta_fecha
					lc_vta_tipdoc = "BOLE"
					lc_vta_serie = bole1.serie
					lc_vta_nrodoc = bole1.nrodoc
				ENDIF
			ENDIF
			***
		ENDSCAN
		***
		*** Buscando en Factura
		SELECT fact2
		SEEK "GUIA" + remi2.serie + remi2.nrodoc + remi2.cod_articu
		SCAN WHILE guirem_tip + guirem_ser + guirem_nro + cod_articu = "GUIA" + remi2.serie + remi2.nrodoc + remi2.cod_articu
			*** Verificando si la Cabecera esta Activa
			SELECT fact1
			SEEK fact2.serie + fact2.nrodoc
			IF FOUND() AND !fact1.cod_anula
				lnArticuloFacturado = lnArticuloFacturado + fact2.cantidad
				IF fact1.fecha_reg > ld_vta_fecha
					lc_vta_tipdoc = "FACT"
					lc_vta_serie = fact1.serie
					lc_vta_nrodoc = fact1.nrodoc
				ENDIF
			ENDIF
			***
		ENDSCAN
		***
		lnFacturado = lnFacturado + lnArticuloFacturado
		*** Actualizando Ultimo Documento y Cantidad Facturada
		SELECT remi2
		REPLACE vta_tipdoc WITH lc_vta_tipdoc
		REPLACE vta_serie WITH lc_vta_serie
		REPLACE vta_nrodoc WITH lc_vta_nrodoc
		REPLACE vta_cantid WITH lnArticuloFacturado
		***
	ENDSCAN
	***
	*** Actualizando Estado de la GR
	*SELECT remi1
	*IF lnFacturado = 0
	*	REPLACE estado WITH "PENDIENTE TOTAL"
	*ELSE
	*	IF lnFacturado < lnCantidad
	*		REPLACE estado WITH "PENDIENTE PARCIAL"
	*	ELSE
	*		REPLACE estado WITH "CANCELADO"
	*	ENDIF
	*ENDIF
	***
ENDIF
***
*** Cerrando Tablas
SELECT remi1
IF !EMPTY(lc_Order_Remi1)
	SET ORDER TO &lc_Order_Remi1.
ENDIF
IF !ll_Used_Remi1
	USE
ENDIF
SELECT remi2
IF !EMPTY(lc_Order_Remi2)
	SET ORDER TO &lc_Order_Remi2.
ENDIF
IF !ll_Used_Remi2
	USE
ENDIF

SELECT fact1
IF !EMPTY(lc_Order_Fact1)
	SET ORDER TO &lc_Order_Fact1.
ENDIF
IF !ll_Used_Fact1
	USE
ENDIF
SELECT fact2
IF !EMPTY(lc_Order_Fact2)
	SET ORDER TO &lc_Order_Fact2.
ENDIF
IF !ll_Used_Fact2
	USE
ENDIF

SELECT bole1
IF !EMPTY(lc_Order_Bole1)
	SET ORDER TO &lc_Order_Bole1.
ENDIF
IF !ll_Used_Bole1
	USE
ENDIF
SELECT bole2
IF !EMPTY(lc_Order_Bole2)
	SET ORDER TO &lc_Order_Bole2.
ENDIF
IF !ll_Used_Bole2
	USE
ENDIF
***
SELECT(ln_Used_Current)
RETURN