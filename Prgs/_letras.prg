  para N
  priv all
  C = str (N, 12, 2)
  N1 = int (val (subs (C, 1, 3)))
  N2 = int (val (subs (C, 4, 3)))
  N3 = int (val (subs (C, 7, 3)))
  D1 = int (val (subs (C,11, 2)))
  S = ''
  if N1 > 0
    if N1 = 1
      S = 'un millon '
    else
      S = centenas (N1) + ' millones '
    endif
  endif
  if N2 > 0
    if N2 = 1
      S = S + 'mil '
    else
      S = S + centenas (N2) + ' mil '
    endif
  endif
if .f.
  if N3 > 0
    if N3 = 1
      S = S + 'un'
    else
      S = S + centenas (N3)
    endif
  endif
endif
  if N3 > 0
    S = S + centenas (N3)
  endif
  if D1 >= 0
    S = S + iif (N1+N2+N3=0, '', ' y ') +ltri(TRAN(D1,"@L 99"))+'/100'
  endif
*  ? N1, n2, n3, d1
*  ? S
return S

procedure centenas
para N
  C = str (N, 3)
  C1 = subs (C, 1, 1)
  C2 = subs (C, 2, 1)
  C3 = subs (C, 3, 1)
  S1 = ''
  S2 = ''
  S3 = ''
  do case
    case C1 = '1'
      if C2 = '0' .and. C3 = '0'
        S1 = 'cien'
      else
        S1 = 'ciento '
      endif
    case C1 = '2'
      S1 = 'doscientos '
    case C1 = '3'
      S1 = 'trescientos '
    case C1 = '4'
      S1 = 'cuatrocientos '
    case C1 = '5'
      S1 = 'quinientos '
    case C1 = '6'
      S1 = 'seiscientos '
    case C1 = '7'
      S1 = 'setecientos '
    case C1 = '8'
      S1 = 'ochocientos '
    case C1 = '9'
      S1 = 'novecientos '
  endcase
  do case
    case C2 = ' ' .or. C2 = '0'
      S2 = ''
    case C2 = '1'
      do case
        case C3 = '0'
          S2 = 'diez'
        case C3 = '1'
          S2 = 'once'
        case C3 = '2'
          S2 = 'doce'
        case C3 = '3'
          S2 = 'trece'
        case C3 = '4'
          S2 = 'catorce'
        case C3 = '5'
          S2 = 'quince'
        case C3 = '6'
          S2 = 'dieciseis'
        case C3 = '7'
          S2 = 'diecisiete'
        case C3 = '8'
          S2 = 'dieciocho'
        case C3 = '9'
          S2 = 'diecinueve'
      endcase
    case C2 $ '23456789' .and. C3 = '0'
      do case
        case C2 = '2'
          S2 = 'veinte'
        case C2 = '3'
          S2 = 'treinta'
        case C2 = '4'
          S2 = 'cuarenta'
        case C2 = '5'
          S2 = 'cincuenta'
        case C2 = '6'
          S2 = 'sesenta'
        case C2 = '7'
          S2 = 'setenta'
        case C2 = '8'
          S2 = 'ochenta'
        case C2 = '9'
          S2 = 'noventa'
      endcase
    case C2 $ '23456789'
      do case
        case C2 = '2'
          S2 = 'veinti'
        case C2 = '3'
          S2 = 'treinti'
        case C2 = '4'
          S2 = 'cuarenti'
        case C2 = '5'
          S2 = 'cincuenti'
        case C2 = '6'
          S2 = 'sesenti'
        case C2 = '7'
          S2 = 'setenti'
        case C2 = '8'
          S2 = 'ochenti'
        case C2 = '9'
          S2 = 'noventi'
      endcase
  endcase
  do case
    case C2 = '1'
      S3 = ''
    case C3 = ' ' .or. C3 = '0'
      S3 = ''
    case C3 = '1'
      if C1 = ' ' .and. C2 = ' '
        S3 = 'un'
      else
        S3 = 'uno'
      endif
    case C3 = '2'
      S3 = 'dos'
    case C3 = '3'
      S3 = 'tres'
    case C3 = '4'
      S3 = 'cuatro'
    case C3 = '5'
      S3 = 'cinco'
    case C3 = '6'
      S3 = 'seis'
    case C3 = '7'
      S3 = 'siete'
    case C3 = '8'
      S3 = 'ocho'
    case C3 = '9'
      S3 = 'nueve'
  endcase
return S1 + S2 + S3


