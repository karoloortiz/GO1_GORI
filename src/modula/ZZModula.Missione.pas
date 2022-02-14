unit ZZModula.Missione;

interface

uses
  System.Generics.Collections;

type
  TTipoOperazione = (inserimento, prelievo, inventario);

  TRigaMissione = record
  public
    codiceArticolo: string;
    quantita: double;
    //for GO DON'T DELETE
    progressivo: double;
    riga: double;
    procedure clear;
  end;

  TRigheMissione = class(TList<TRigaMissione>);

  TMissione = record
  private
    function _getProgressivoAsString: string;
  public
    eseguiDirettamente: boolean;
    tipoOperazione: TTipoOperazione;
    baiaDestinazione: string;
    progressivo: double;
    descrizione: string;
    righe: TRigheMissione;

    property progressivoAsString: string read _getProgressivoAsString;
    procedure clear;
  end;

procedure sendMissione(missione: TMissione);

implementation

uses
  ZZGO1GESTMODULA,
  ZZKLib.Constants,
  KLib.SQLServer.DriverPort, KLib.SQLServer.Utils,
  KLib.MyString, KLib.Constants,
  System.SysUtils;

procedure sendMissione(missione: TMissione);
const
  FIELD_ORD_ELEBAIE = 'ORD_ELEBAIE';
  //  FIELD_ORD_BAIADEST = 'ORD_BAIADEST';
  FIELD_ORD_ORDINE = 'ORD_ORDINE';
  FIELD_ORD_OPERAZIONE = 'ORD_OPERAZIONE';
  FIELD_ORD_DES = 'ORD_DES';
  FIELD_ORD_SOSPESA = 'ORD_SOSPESA';
  FIELD_ORD_TIPOOP = 'ORD_TIPOOP';

  TABLENAME_IMP_ORDINI = 'HOST_IMPEXP.dbo.IMP_ORDINI';

  PARAM_ORD_ELEBAIE = ':' + FIELD_ORD_ELEBAIE;
  //  PARAM_ORD_BAIADEST = ':' + FIELD_ORD_BAIADEST;
  PARAM_ORD_ORDINE = ':' + FIELD_ORD_ORDINE;
  PARAM_ORD_OPERAZIONE = ':' + FIELD_ORD_OPERAZIONE;
  PARAM_ORD_DES = ':' + FIELD_ORD_DES;
  PARAM_ORD_SOSPESA = ':' + FIELD_ORD_SOSPESA;
  PARAM_ORD_TIPOOP = ':' + FIELD_ORD_TIPOOP;

  INSERT_INTO_IMP_ORDINI_WHERE_PARAM_ORD_ELEBAIE_PARAM_ORD_ORDINE_PARAM_ORD_OPERAZIONE_PARAM_ORD_DES_PARAM_ORD_SOSPESA_PARAM_ORD_TIPOOP =
    'IF NOT EXISTS (' + sLineBreak +
    '	SELECT' + sLineBreak +
    '	' + FIELD_ORD_ORDINE + sLineBreak +
    '	FROM ' + sLineBreak +
    '	' + TABLENAME_IMP_ORDINI + sLineBreak +
    ' WHERE ' + sLineBreak +
    '	' + FIELD_ORD_ORDINE + ' = ' + PARAM_ORD_ORDINE + sLineBreak +
    '	)' + sLineBreak +
    'BEGIN' + sLineBreak +
    '	INSERT INTO ' + TABLENAME_IMP_ORDINI + sLineBreak +
    '	(' + sLineBreak +
    '	' + FIELD_ORD_ELEBAIE + ',' + sLineBreak +
    '	' + FIELD_ORD_ORDINE + ',' + sLineBreak +
    ' ' + FIELD_ORD_OPERAZIONE + ',' + sLineBreak +
    ' ' + FIELD_ORD_DES + ',' + sLineBreak +
    '	' + FIELD_ORD_SOSPESA + ',' + sLineBreak +
    ' ' + FIELD_ORD_TIPOOP + sLineBreak +
    '	)' + sLineBreak +
    '	VALUES' + sLineBreak +
    '	(' + sLineBreak +
    ' ' + PARAM_ORD_ELEBAIE + ',' + sLineBreak +
    ' ' + PARAM_ORD_ORDINE + ',' + sLineBreak +
    ' ' + PARAM_ORD_OPERAZIONE + ',' + sLineBreak +
    ' ' + PARAM_ORD_DES + ',' + sLineBreak +
    ' ' + PARAM_ORD_SOSPESA + ',' + sLineBreak +
    ' ' + PARAM_ORD_TIPOOP + sLineBreak +
    '	)' + sLineBreak +
    'END';

  INSERT_INTO_IMP_ORDINI_WHERE_PARAM_ORD_ORDINE_PARAM_ORD_OPERAZIONE_PARAM_ORD_DES_PARAM_ORD_SOSPESA_PARAM_ORD_TIPOOP =
    'IF NOT EXISTS (' + sLineBreak +
    '	SELECT' + sLineBreak +
    '	' + FIELD_ORD_ORDINE + sLineBreak +
    '	FROM ' + sLineBreak +
    '	' + TABLENAME_IMP_ORDINI + sLineBreak +
    ' WHERE ' + sLineBreak +
    '	' + FIELD_ORD_ORDINE + ' = ' + PARAM_ORD_ORDINE + sLineBreak +
    '	)' + sLineBreak +
    'BEGIN' + sLineBreak +
    '	INSERT INTO ' + TABLENAME_IMP_ORDINI + sLineBreak +
    '	(' + sLineBreak +
    '	' + FIELD_ORD_ORDINE + ',' + sLineBreak +
    ' ' + FIELD_ORD_OPERAZIONE + ',' + sLineBreak +
    ' ' + FIELD_ORD_DES + ',' + sLineBreak +
    '	' + FIELD_ORD_SOSPESA + ',' + sLineBreak +
    ' ' + FIELD_ORD_TIPOOP + sLineBreak +
    '	)' + sLineBreak +
    '	VALUES' + sLineBreak +
    '	(' + sLineBreak +
    ' ' + PARAM_ORD_ORDINE + ',' + sLineBreak +
    ' ' + PARAM_ORD_OPERAZIONE + ',' + sLineBreak +
    ' ' + PARAM_ORD_DES + ',' + sLineBreak +
    ' ' + PARAM_ORD_SOSPESA + ',' + sLineBreak +
    ' ' + PARAM_ORD_TIPOOP + sLineBreak +
    '	)' + sLineBreak +
    'END';

  //  INSERT_INTO_IMP_ORDINI_WHERE_PARAM_ORD_BAIADEST_PARAM_ORD_ORDINE_PARAM_ORD_OPERAZIONE_PARAM_ORD_DES_PARAM_ORD_SOSPESA_PARAM_ORD_TIPOOP =
  //    'IF NOT EXISTS (' + sLineBreak +
  //    '	SELECT' + sLineBreak +
  //    '	' + FIELD_ORD_ORDINE + sLineBreak +
  //    '	FROM ' + sLineBreak +
  //    '	' + TABLENAME_IMP_ORDINI + sLineBreak +
  //    ' WHERE ' + sLineBreak +
  //    '	' + FIELD_ORD_ORDINE + ' = ' + PARAM_ORD_ORDINE + sLineBreak +
  //    '	)' + sLineBreak +
  //    'BEGIN' + sLineBreak +
  //    '	INSERT INTO ' + TABLENAME_IMP_ORDINI + sLineBreak +
  //    '	(' + sLineBreak +
  //    '	' + FIELD_ORD_BAIADEST + ',' + sLineBreak +
  //    '	' + FIELD_ORD_ORDINE + ',' + sLineBreak +
  //    ' ' + FIELD_ORD_OPERAZIONE + ',' + sLineBreak +
  //    ' ' + FIELD_ORD_DES + ',' + sLineBreak +
  //    '	' + FIELD_ORD_SOSPESA + ',' + sLineBreak +
  //    ' ' + FIELD_ORD_TIPOOP + sLineBreak +
  //    '	)' + sLineBreak +
  //    '	VALUES' + sLineBreak +
  //    '	(' + sLineBreak +
  //    ' ' + PARAM_ORD_BAIADEST + ',' + sLineBreak +
  //    ' ' + PARAM_ORD_ORDINE + ',' + sLineBreak +
  //    ' ' + PARAM_ORD_OPERAZIONE + ',' + sLineBreak +
  //    ' ' + PARAM_ORD_DES + ',' + sLineBreak +
  //    ' ' + PARAM_ORD_SOSPESA + ',' + sLineBreak +
  //    ' ' + PARAM_ORD_TIPOOP + sLineBreak +
  //    '	)' + sLineBreak +
  //    'END';
  //##########################################################################
  FIELD_RIG_ORDINE = 'RIG_ORDINE';
  FIELD_RIG_ARTICOLO = 'RIG_ARTICOLO';
  FIELD_RIG_QTAR = 'RIG_QTAR';
  PARAM_RIG_ORDINE = ':' + FIELD_RIG_ORDINE;
  PARAM_RIG_ARTICOLO = ':' + FIELD_RIG_ARTICOLO;
  PARAM_RIG_QTAR = ':' + FIELD_RIG_QTAR;

  TABLENAME_IMP_ORDINI_RIGHE = 'HOST_IMPEXP.dbo.IMP_ORDINI_RIGHE';
  INSERT_INTO_IMP_ORDINI_RIGHE_WHERE_PARAM_RIG_ORDINE_PARAM_RIG_ARTICOLO_PARAM_RIG_QTAR =
    'IF NOT EXISTS (' + sLineBreak +
    '	SELECT' + sLineBreak +
    '	' + FIELD_RIG_ORDINE + sLineBreak +
    '	FROM ' + sLineBreak +
    '	' + TABLENAME_IMP_ORDINI_RIGHE + sLineBreak +
    ' WHERE ' + sLineBreak +
    '	' + FIELD_RIG_ORDINE + ' = ' + PARAM_RIG_ORDINE + sLineBreak +
    '	AND ' + FIELD_RIG_ARTICOLO + ' = ' + PARAM_RIG_ARTICOLO + sLineBreak +
    '	)' + sLineBreak +
    'BEGIN' + sLineBreak +
    '	INSERT INTO ' + TABLENAME_IMP_ORDINI_RIGHE + sLineBreak +
    '	(' + sLineBreak +
    '	' + FIELD_RIG_ORDINE + ',' + sLineBreak +
    ' ' + FIELD_RIG_ARTICOLO + ',' + sLineBreak +
    ' ' + FIELD_RIG_QTAR + sLineBreak +
    '	)' + sLineBreak +
    '	VALUES' + sLineBreak +
    '	(' + sLineBreak +
    ' ' + PARAM_RIG_ORDINE + ',' + sLineBreak +
    ' ' + PARAM_RIG_ARTICOLO + ',' + sLineBreak +
    ' ' + PARAM_RIG_QTAR + sLineBreak +
    '	)' + sLineBreak +
    'END' + sLineBreak +
    'ELSE' + sLineBreak +
    'BEGIN' + sLineBreak +
    '	UPDATE ' + TABLENAME_IMP_ORDINI_RIGHE + ' SET ' + sLineBreak +
    ' ' + FIELD_RIG_QTAR + ' = ' + FIELD_RIG_QTAR + ' + ' + PARAM_RIG_QTAR + sLineBreak +
    '	WHERE' + sLineBreak +
    '	' + FIELD_RIG_ORDINE + ' = ' + PARAM_RIG_ORDINE + sLineBreak +
    '	AND ' + FIELD_RIG_ARTICOLO + ' = ' + PARAM_RIG_ARTICOLO + sLineBreak +
    'END';
  //    ###############################
  DELETE_FROM_IMP_ORDINI =
    'DELETE FROM ' + TABLENAME_IMP_ORDINI + sLineBreak +
    'WHERE' + sLineBreak +
    'NOT EXISTS ( ' + sLineBreak +
    ' SELECT' + sLineBreak +
    ' ' + FIELD_RIG_ORDINE + sLineBreak +
    ' FROM ' + sLineBreak +
    ' ' + TABLENAME_IMP_ORDINI_RIGHE + ' ' + TABLENAME_R + sLineBreak +
    ' WHERE' + sLineBreak +
    ' ' + TABLENAME_R + '.' + FIELD_RIG_ORDINE + ' = ' + TABLENAME_IMP_ORDINI + '.' + FIELD_ORD_ORDINE + sLineBreak +
    ' )';
var
  _connessioneModula: KLib.SQLServer.DriverPort.TConnection;
  _queryRighe: KLib.SQLServer.DriverPort.TQuery;
  _eseguiDirettamente: integer;
  _tipoOperazioneAsString: string;
  _rigaMissione: TRigaMissione;
  _descrizioneMissione: string;
  _queryTestataStmt: myString;
begin
  if missione.righe.Count > 0 then
  begin
    case missione.tipoOperazione of
      inserimento:
        _tipoOperazioneAsString := 'V';
      prelievo:
        _tipoOperazioneAsString := 'P';
      inventario:
        _tipoOperazioneAsString := 'I';
    end;

    if missione.eseguiDirettamente then
    begin
      _eseguiDirettamente := 0;
    end
    else
    begin
      _eseguiDirettamente := 1;
    end;

    _connessioneModula := getValidModulaSQLServerConnection;

    if missione.baiaDestinazione <> '' then
    begin
      _queryTestataStmt := INSERT_INTO_IMP_ORDINI_WHERE_PARAM_ORD_ELEBAIE_PARAM_ORD_ORDINE_PARAM_ORD_OPERAZIONE_PARAM_ORD_DES_PARAM_ORD_SOSPESA_PARAM_ORD_TIPOOP;
      _queryTestataStmt.setParamAsSingleQuotedString(PARAM_ORD_ELEBAIE, missione.baiaDestinazione);
    end
    else
    begin
      _queryTestataStmt := INSERT_INTO_IMP_ORDINI_WHERE_PARAM_ORD_ORDINE_PARAM_ORD_OPERAZIONE_PARAM_ORD_DES_PARAM_ORD_SOSPESA_PARAM_ORD_TIPOOP;
    end;
    _queryTestataStmt.setParamAsSingleQuotedString(PARAM_ORD_ORDINE, missione.progressivoAsString);
    _queryTestataStmt.setParamAsSingleQuotedString(PARAM_ORD_OPERAZIONE, 'I');
    _descrizioneMissione := Copy(missione.descrizione, 1, 50);
    _queryTestataStmt.setParamAsSingleQuotedString(PARAM_ORD_DES, _descrizioneMissione);
    _queryTestataStmt.setParamAsFloat(PARAM_ORD_SOSPESA, _eseguiDirettamente);
    _queryTestataStmt.setParamAsSingleQuotedString(PARAM_ORD_TIPOOP, _tipoOperazioneAsString);
    KLib.SQLServer.Utils.executeQuery(_queryTestataStmt, _connessioneModula);

    _queryRighe := KLib.SQLServer.DriverPort.getTQuery(_connessioneModula, INSERT_INTO_IMP_ORDINI_RIGHE_WHERE_PARAM_RIG_ORDINE_PARAM_RIG_ARTICOLO_PARAM_RIG_QTAR);
    for _rigaMissione in missione.righe do
    begin
      _queryRighe.Close;
      _queryRighe.ParamByName(FIELD_RIG_ORDINE).AsString := missione.progressivoAsString;
      _queryRighe.ParamByName(FIELD_RIG_ARTICOLO).AsString := _rigaMissione.codiceArticolo;
      _queryRighe.ParamByName(FIELD_RIG_QTAR).AsFloat := _rigaMissione.quantita;
      _queryRighe.OpenOrExecute;
    end;
    _queryRighe.close;

    KLib.SQLServer.Utils.executeQuery(DELETE_FROM_IMP_ORDINI, _connessioneModula);

    _connessioneModula.Connected := false;

    FreeAndNil(_queryRighe);
    FreeAndNil(_connessioneModula);
  end;
end;

procedure TMissione.clear;
const
  EMPTY: TMissione = ();
begin
  Self := EMPTY;
end;

function TMissione._getProgressivoAsString: string;
begin
  Result := FloatToStr(progressivo);
end;

procedure TRigaMissione.clear;
const
  EMPTY: TRigaMissione = ();
begin
  Self := EMPTY;
end;

end.
