unit ZZGO1Modula.Missione;

interface

uses
  ZZModula.Missione;

procedure sendMisssioneFrom_vendita_banco(progressivo: double);
procedure sendMisssioneFrom_fattura_accompagnatoria(progressivo: double);
procedure sendMisssioneFrom_ddt(progressivo: double);

procedure updateMissioneQuantitaInviataOAR(righeMissione: TRigheMissione);
procedure updateMissioneQuantitaInviataOVR(righeMissione: TRigheMissione);
procedure updateMissioneQuantitaInviataVER(righeMissione: TRigheMissione);

implementation


uses
  ZZGO1GESTMODULA,
  ZZGO1Modula.Constants,
  ZZKLib.Constants, ZZKLib.Utils,
  KLib.MySQL.DriverPort, KLib.MySQL.Utils,
  KLib.MyString, KLib.Constants,
  DMARC,
  System.SysUtils;

procedure sendMisssioneFromTipoDocumento(progressivo: double; tipoDocumento: TTipoDocumento); forward;
function getMissioneFromTipoDocumento(progressivo: double; tipoDocumento: TTipoDocumento): TMissione; forward;
procedure updateMissioneQuantitaInviata(righeMissione: TRigheMissione; tableName: string); forward;

procedure sendMisssioneFrom_vendita_banco(progressivo: double);
begin
  sendMisssioneFromTipoDocumento(progressivo, TTipoDocumento.vendita_banco);
end;

procedure sendMisssioneFrom_fattura_accompagnatoria(progressivo: double);
begin
  sendMisssioneFromTipoDocumento(progressivo, TTipoDocumento.fattura_accompagnatoria);
end;

procedure sendMisssioneFrom_ddt(progressivo: double);
begin
  sendMisssioneFromTipoDocumento(progressivo, TTipoDocumento.ddt);
end;

procedure sendMisssioneFromTipoDocumento(progressivo: double; tipoDocumento: TTipoDocumento);
var
  _missione: TMissione;
  _tableNameR: string;
begin
  _missione := getMissioneFromTipoDocumento(progressivo, tipoDocumento);
  sendMissione(_missione);
  _tableNameR := getTipoDocumentoTableNameR(tipoDocumento);
  updateMissioneQuantitaInviata(_missione.righe, _tableNameR);
end;

function _get_SelectMissioneWhereProgressivo_queryStmt(progressivo: double; tipoDocumento: TTipoDocumento): string; forward;
function _get_descrizioneMissione(progressivo: double; tipoDocumento: TTipoDocumento): string; forward;

function getMissioneFromTipoDocumento(progressivo: double; tipoDocumento: TTipoDocumento): TMissione;
const
  ERR_MSG = 'Non è presente nessuna riga da inviare a Modula.';
var
  missione: TMissione;
  _rigaMissione: TRigaMissione;
  _query: TQuery;
  _queryStmt: myString;
  _baiaDestinazione: string;
  _descrizione: string;
  i: integer;
begin
  _queryStmt := _get_SelectMissioneWhereProgressivo_queryStmt(progressivo, tipoDocumento);
  _query := getTQuery(TConnection(ARC.arcdit), _queryStmt);
  _query.Open;

  try
    if _query.RecordCount = 0 then
    begin
      raise Exception.Create(ERR_MSG);
    end;

    _baiaDestinazione := '';
    //    _baiaDestinazione := GGAD6GESUTN.get_baia_vendita_banco_ofCurrentGOUser;
    //    if (_baiaDestinazione = EMPTY_STRING) and (tipoDocumento = TTipoDocumento.vendita_banco) then
    //    begin
    //      _baiaDestinazione := ZZAD6GESTMODULA.get_baia_vendita_banco
    //    end;

    _descrizione := _get_descrizioneMissione(progressivo, tipoDocumento);

    missione.clear;
    with missione do
    begin
      eseguiDirettamente := true;
      baiaDestinazione := _baiaDestinazione;
      tipoOperazione := TTipoOperazione.prelievo;
      progressivo := arc.setta_valore_generatore(ARC.arcdit, MODULA_MISSIONE_PROGRESSIVO);
      descrizione := _descrizione;

      righe := TRigheMissione.Create;
    end;
    for i := 0 to _query.RecordCount - 1 do
    begin
      _rigaMissione.clear;
      with _rigaMissione do
      begin
        codiceArticolo := _query.FieldByName(FIELD_ART_CODICE).AsString;
        quantita := _query.FieldByName(FIELD_QUANTITA).AsFloat;

        progressivo := _query.FieldByName(FIELD_PROGRESSIVO).AsFloat;
        riga := _query.FieldByName(FIELD_RIGA).AsFloat;
      end;
      missione.righe.Add(_rigaMissione);
      _query.Next;
    end;
  finally
    _query.Close;
    FreeAndNil(_query);
  end;

  Result := missione;
end;

function _get_SelectMissioneWhereProgressivo_queryStmt(progressivo: double; tipoDocumento: TTipoDocumento): string;
var
  _testataTableName: string;
  _righeTableName: string;
  _descrizioneDocumento: string;
  queryStmt: myString;
begin

  _testataTableName := getTipoDocumentoTableName(tipoDocumento);
  _righeTableName := getTipoDocumentoTableNameR(tipoDocumento);
  _descrizioneDocumento := getTipoDocumentoAsString(tipoDocumento);

  queryStmt := SELECT_MISSIONE_FROM_TABLE_WHERE_PARAM_PROGRESSIVO_PARAM_TABLE_T_PARAM_TABLE_R_PARAM_VALUE;
  queryStmt.setParamAsFloat(PARAM_PROGRESSIVO, progressivo, MYSQL_DECIMAL_SEPARATOR);
  queryStmt.setParamAsString(PARAM_TABLE_T, _testataTableName);
  queryStmt.setParamAsString(PARAM_TABLE_R, _righeTableName);
  queryStmt.setParamAsSingleQuotedString(PARAM_VALUE, _descrizioneDocumento);

  Result := queryStmt;
end;

function _get_descrizioneMissione(progressivo: double; tipoDocumento: TTipoDocumento): string;
var
  descrizione: string;
  _queryStmt: myString;
begin
  case tipoDocumento of
    _null:
      ;
    bolla:
      ;
    corrispettivo:
      ;
    ddt:
      _queryStmt :=
        'SELECT' + sLineBreak +
        'CONCAT(' + FIELD_SERIE_DOCUMENTO + ' , "/", ' + FIELD_NUMERO_DOCUMENTO + ', " ddt") ' + FIELD_DESCRIZIONE + sLineBreak +
        'FROM' + sLineBreak +
        TABLENAME_DVT + sLineBreak +
        'WHERE' + sLineBreak +
        FIELD_PROGRESSIVO + ' = ' + PARAM_PROGRESSIVO;
    fattura_accompagnatoria:
      _queryStmt :=
        'SELECT' + sLineBreak +
        'CONCAT(' + FIELD_SERIE_DOCUMENTO + ' , "/", ' + FIELD_NUMERO_DOCUMENTO + ', " faav") ' + FIELD_DESCRIZIONE + sLineBreak +
        'FROM' + sLineBreak +
        TABLENAME_FVT + sLineBreak +
        'WHERE' + sLineBreak +
        FIELD_PROGRESSIVO + ' = ' + PARAM_PROGRESSIVO;
    vendita_banco:
      _queryStmt :=
        'SELECT' + sLineBreak +
        'CONCAT(' + FIELD_DATA_DOCUMENTO + ' , " vendita banco" ) ' + FIELD_DESCRIZIONE + sLineBreak +
        'FROM' + sLineBreak +
        TABLENAME_VET + sLineBreak +
        'WHERE' + sLineBreak +
        FIELD_PROGRESSIVO + ' = ' + PARAM_PROGRESSIVO;
  end;
  _queryStmt.setParamAsFloat(PARAM_PROGRESSIVO, progressivo, MYSQL_DECIMAL_SEPARATOR);
  descrizione := getFirstFieldFromSQLStatement(_queryStmt, TConnection(ARC.arcdit));

  Result := descrizione;
end;

procedure updateMissioneQuantitaInviataOAR(righeMissione: TRigheMissione);
begin
  updateMissioneQuantitaInviata(righeMissione, TABLENAME_OAR);
end;

procedure updateMissioneQuantitaInviataOVR(righeMissione: TRigheMissione);
begin
  updateMissioneQuantitaInviata(righeMissione, TABLENAME_OVR);
end;

procedure updateMissioneQuantitaInviataVER(righeMissione: TRigheMissione);
begin
  updateMissioneQuantitaInviata(righeMissione, TABLENAME_VER);
end;

procedure updateMissioneQuantitaInviata(righeMissione: TRigheMissione; tableName: string);
const
  UPDATE_QUANTITA_INVIATA_WHERE_PARAM_TABLE_PARAM_QUANTITA_INVIATA_PARAM_PROGRESSIVO_PARAM_RIGA =
    'INSERT INTO ' + TABLENAME_MODULA_INVIO + ' (' + sLineBreak +
    FIELD_TABELLA + ',' + sLineBreak +
    FIELD_PROGRESSIVO + ',' + sLineBreak +
    FIELD_RIGA + ',' + sLineBreak +
    FIELD_QUANTITA_INVIATA + sLineBreak +
    ')' + sLineBreak +
    'VALUES (' + sLineBreak +
    PARAM_TABLE + ',' + sLineBreak +
    PARAM_PROGRESSIVO + ',' + sLineBreak +
    PARAM_RIGA + ',' + sLineBreak +
    PARAM_QUANTITA_INVIATA + sLineBreak +
    ')' + sLineBreak +
    'ON DUPLICATE KEY UPDATE' + sLineBreak +
    FIELD_QUANTITA_INVIATA + ' = ' + FIELD_QUANTITA_INVIATA + ' + ' + PARAM_QUANTITA_INVIATA;
var
  _rigaMissione: TRigaMissione;
  _queryStmt: myString;
begin
  for _rigaMissione in righeMissione do
  begin
    _queryStmt := UPDATE_QUANTITA_INVIATA_WHERE_PARAM_TABLE_PARAM_QUANTITA_INVIATA_PARAM_PROGRESSIVO_PARAM_RIGA;
    _queryStmt.setParamAsDoubleQuotedString(PARAM_TABLE, tableName);
    _queryStmt.setParamAsFloat(PARAM_QUANTITA_INVIATA, _rigaMissione.quantita, MYSQL_DECIMAL_SEPARATOR);
    _queryStmt.setParamAsFloat(PARAM_PROGRESSIVO, _rigaMissione.progressivo, MYSQL_DECIMAL_SEPARATOR);
    _queryStmt.setParamAsFloat(PARAM_RIGA, _rigaMissione.riga, MYSQL_DECIMAL_SEPARATOR);
    KLib.MySQL.Utils.executeQuery(_queryStmt, KLib.MySQL.DriverPort.TConnection(arc.arcdit));

    if tableName = 'OVR' then
    begin
      _queryStmt := 'UPDATE OVR SET go1_modula_sospeso = "si" WHERE progressivo = :progressivo and riga = :riga';
      _queryStmt.setParamAsFloat(PARAM_PROGRESSIVO, _rigaMissione.progressivo, MYSQL_DECIMAL_SEPARATOR);
      _queryStmt.setParamAsFloat(PARAM_RIGA, _rigaMissione.riga, MYSQL_DECIMAL_SEPARATOR);
      KLib.MySQL.Utils.executeQuery(_queryStmt, KLib.MySQL.DriverPort.TConnection(arc.arcdit));
    end
    else if tableName = 'OAR' then
    begin
      _queryStmt := 'UPDATE OAR SET go1_modula_quantita_da_inviare = 0 WHERE progressivo = :progressivo and riga = :riga';
      _queryStmt.setParamAsFloat(PARAM_PROGRESSIVO, _rigaMissione.progressivo, MYSQL_DECIMAL_SEPARATOR);
      _queryStmt.setParamAsFloat(PARAM_RIGA, _rigaMissione.riga, MYSQL_DECIMAL_SEPARATOR);
      KLib.MySQL.Utils.executeQuery(_queryStmt, KLib.MySQL.DriverPort.TConnection(arc.arcdit));
    end;
  end;
end;

end.
