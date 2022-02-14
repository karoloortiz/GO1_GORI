unit ZZGO1ESPMODULA;

interface

procedure exportArticoliInSilentMode;
procedure exportArticoli;
function get_data_ultimo_aggiornamento_art: TDateTime;
procedure importGiacenzeInSilentMode;
procedure importGiacenze;

implementation

uses
  ZZModula.Articoli, ZZGO1Modula.Constants,
  ZZModula.SYSTOREDB.dbo.DAT_SCOMPART, ZZModula.SYSTOREDB.dbo.DAT_ARTICOLI,
  ZZKLib.Constants,
  KLib.MySQL.DriverPort, KLib.MySQL.Utils,
  KLib.Utils, KLib.MyString,
  DMARC,
  System.SysUtils;

procedure update_data_ultimo_aggiornamento_art(date: TDateTime); forward;
procedure update_data_ultimo_aggiornamento_giacenze(date: TDateTime); forward;

procedure exportArticoliInSilentMode;
begin
  tryToExecuteProcedure(exportArticoli);
end;

procedure exportArticoli;
const
  ERR_MSG = 'Non è presente nessun nuovo articolo da inviare al magazzino Modula.';
var
  _query: KLib.MySQL.DriverPort.TQuery;
  _data_ultimo_aggiornamento_art: TDateTime;
  _queryStmt: myString;
  _articoli: TArticoli;
  _articolo: TArticolo;
  i: integer;
  _startedDateTime: TDateTime;
begin
  _data_ultimo_aggiornamento_art := get_data_ultimo_aggiornamento_art;
  _queryStmt := SELECT_FROM_ART_WHERE_PARAM_DATA_ULTIMO_AGGIORNAMENTO_ART;
  _queryStmt.setParamAsDoubleQuotedDateTime(PARAM_DATA_ULTIMO_AGGIORNAMENTO_ART, _data_ultimo_aggiornamento_art);
  _query := KLib.MySQL.DriverPort.getTQuery(TConnection(ARC.arcdit), _queryStmt);
  try
    _query.Open;
    _startedDateTime := getCurrentDateTime;
    if _query.RecordCount = 0 then
    begin
      raise Exception.Create(ERR_MSG);
    end;

    _articoli := TArticoli.Create;
    for i := 0 to _query.RecordCount - 1 do
    begin
      _articolo.clear;
      with _articolo do
      begin
        codice := _query.FieldByName(FIELD_CODICE).AsString;
        descrizione := _query.FieldByName(FIELD_DESCRIZIONE_MODULA).AsString;
        unita_misura := 'PZ';
      end;
      _articoli.Add(_articolo);
      _query.Next;
    end;

    _articoli.insertIntoModula;
    update_data_ultimo_aggiornamento_art(_startedDateTime);
    FreeAndNil(_articoli);
  finally
    _query.Close;
    FreeAndNil(_query);
  end;
end;

function get_data_ultimo_aggiornamento_art: TDateTime;
var
  data_ultimo_aggiornamento_art: TDateTime;
  _query: KLib.MySQL.DriverPort.TQuery;
begin
  _query := KLib.MySQL.DriverPort.getTQuery(TConnection(ARC.arcdit), SELECT_DATA_ULTIMO_AGGIORNAMENTO_ART);
  _query.Open;

  if _query.RecordCount > 0 then
  begin
    data_ultimo_aggiornamento_art := _query.FieldByName(FIELD_DATA_ULTIMO_AGGIORNAMENTO_ART).AsDateTime;
  end
  else
  begin
    data_ultimo_aggiornamento_art := 0;
  end;
  _query.Close;
  FreeAndNil(_query);

  Result := data_ultimo_aggiornamento_art;
end;

procedure update_data_ultimo_aggiornamento_art(date: TDateTime);
var
  _queryStmt: myString;
begin
  _queryStmt := UPDATE_DATA_ULTIMO_AGGIORNAMENTO_ART_WHERE_PARAM_DATA_ULTIMO_AGGIORNAMENTO_ART;
  _queryStmt.setParamAsDoubleQuotedDateTime(PARAM_DATA_ULTIMO_AGGIORNAMENTO_ART, date);
  executeQuery(_queryStmt, TConnection(ARC.arcdit));
end;

procedure importGiacenzeInSilentMode;
begin
  tryToExecuteProcedure(importGiacenze);
end;

procedure importGiacenze;
begin
  ZZModula.SYSTOREDB.dbo.DAT_SCOMPART.importTable;
  ZZModula.SYSTOREDB.dbo.DAT_ARTICOLI.importTable;
  update_data_ultimo_aggiornamento_giacenze(getCurrentDateTime);
end;

procedure update_data_ultimo_aggiornamento_giacenze(date: TDateTime);
var
  _queryStmt: myString;
begin
  _queryStmt := UPDATE_DATA_ULTIMO_AGGIORNAMENTO_GIACENZE_WHERE_PARAM_DATA_ULTIMO_AGGIORNAMENTO_GIACENZE;
  _queryStmt.setParamAsDoubleQuotedDateTime('DATA_ULTIMO_AGGIORNAMENTO_GIACENZE', date);
  executeQuery(_queryStmt, TConnection(ARC.arcdit));
end;

end.
