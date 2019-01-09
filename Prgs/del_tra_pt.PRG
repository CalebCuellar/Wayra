PARAMETERS pcDocu_Orig_Tipo,pcDocu_Orig_Serie,pcDocu_Orig_Numero,pcDocu_Dest_Tipo,pcVar_Serie,pcVar_Numero
IF !EMPTY(pcDocu_Orig_Serie) AND !EMPTY(pcDocu_Orig_Numero)
	*** Abriendo Tablas
	DO CASE
		CASE pcDocu_Dest_Tipo = "NOTI"
			SELECT 0
			USE noti1 ORDER docrel ALIAS aPart1 AGAIN		&& docrel_tip+docrel_ser+docrel_nro
			SELECT 0
			USE noti2 ORDER noti2  ALIAS aPart2 AGAIN		&& serie+nrodoc+item
		CASE pcDocu_Dest_Tipo = "NOTE"
			SELECT 0
			USE note1 ORDER docrel ALIAS aPart1 AGAIN		&& docrel_tip+docrel_ser+docrel_nro
			SELECT 0
			USE note2 ORDER note2  ALIAS aPart2 AGAIN		&& serie+nrodoc+item
		CASE pcDocu_Dest_Tipo = "REMI"
			SELECT 0
			USE remi1 ORDER docrel ALIAS aPart1 AGAIN		&& docrel_tip+docrel_ser+docrel_nro
			SELECT 0
			USE remi2 ORDER remi2  ALIAS aPart2 AGAIN		&& serie+nrodoc+item
	ENDCASE
	***
	SELECT aPart1
	SEEK pcDocu_Orig_Tipo + pcDocu_Orig_Serie + pcDocu_Orig_Numero
	SCAN WHILE docrel_tip + docrel_ser + docrel_nro = pcDocu_Orig_Tipo + pcDocu_Orig_Serie + pcDocu_Orig_Numero
		*IF !aPart1.cod_anula
			IF !EMPTY(pcVar_Serie)
				&pcVar_Serie. = aPart1.serie
			ENDIF
			IF !EMPTY(pcVar_Numero)
				&pcVar_Numero. = aPart1.nrodoc
			ENDIF
			*** Actualizando campos de auditoría - Cabecera
			= BLOQUEARECORD()
			REPLACE del_usu WITH _usuario
			REPLACE del_fec WITH DATE()
			REPLACE del_hor WITH TIME()
			UNLOCK
			***
			SELE aPart2
			SEEK aPart1.serie + aPart1.nrodoc
			SCAN WHILE serie + nrodoc = aPart1.serie + aPart1.nrodoc
				*** Actualizando campos de auditoría - Detalle
				SELE aPart2
				= BLOQUEARECORD()
				REPLACE del_usu WITH _usuario
				REPLACE del_fec WITH DATE()
				REPLACE del_hor WITH TIME()
				DELETE NEXT 1
				UNLOCK
				***
			ENDSCAN
		*ENDIF
		DO DEL_KAR_PT WITH pcDocu_Dest_Tipo,aPart1.serie,aPart1.nrodoc,aPart1.fecha_reg
		*** Eliminando Cabecera
		SELECT aPart1
		= BLOQUEARECORD()
		DELETE NEXT 1
		UNLOCK
		***
	ENDSCAN
	*** Cerrando Tablas
	USE IN aPart1
	USE IN aPart2
	***
ENDIF