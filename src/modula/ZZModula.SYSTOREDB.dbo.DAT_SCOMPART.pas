unit ZZModula.SYSTOREDB.dbo.DAT_SCOMPART;

interface

procedure importTable;

implementation

uses
  ZZGO1GESTMODULA,
  KLib.SQLServer.DriverPort, KLib.SQLServer.Utils,
  KLib.MySQL.DriverPort, KLib.MySQL.Utils,
  KLib.Utils,
  DMARC,
  KLib.MyString,
  System.SysUtils;

procedure importTable;
const
  SELECT_FROM_DAT_SCOMPART =
    'SELECT' + sLineBreak +
    'SCO_ARTICOLO,' + sLineBreak +
    'SCO_GIAC,' + sLineBreak +
    'SCO_LIM,' + sLineBreak +
    'SCO_CAP' + sLineBreak +
    'FROM' + sLineBreak +
    'SYSTOREDB.dbo.DAT_SCOMPART';
var
  _connessioneModula: KLib.SQLServer.DriverPort.TConnection;
  _queryModula: KLib.SQLServer.DriverPort.TQuery;
  _scriptSQL: string;
begin
  _connessioneModula := getValidModulaSQLServerConnection;
  _queryModula := KLib.SQLServer.DriverPort.getTQuery(_connessioneModula, SELECT_FROM_DAT_SCOMPART);
  _queryModula.OpenOrExecute;
  emptyTable('go1_modula_SYSTOREDB_dbo_DAT_SCOMPART', KLib.MySQL.DriverPort.TConnection(ARC.arcdit));
  _scriptSQL := 'INSERT INTO go1_modula_SYSTOREDB_dbo_DAT_SCOMPART ( SCO_ARTICOLO, SCO_GIAC, SCO_LIM, SCO_CAP ) VALUES' + sLineBreak;
  while not _queryModula.Eof do
  begin
    _scriptSQL := _scriptSQL + '(' +
      getDoubleQuotedString(_queryModula.FieldByName('SCO_ARTICOLO').AsString) + ', ' +
      StringReplace(_queryModula.FieldByName('SCO_GIAC').AsString, ',', '.', [rfReplaceAll]) + ', ' +
      StringReplace(_queryModula.FieldByName('SCO_LIM').AsString, ',', '.', [rfReplaceAll]) + ', ' +
      StringReplace(_queryModula.FieldByName('SCO_CAP').AsString, ',', '.', [rfReplaceAll]) +
      '),' + sLineBreak;

    _queryModula.Next;
  end;
  _queryModula.close;
  _connessioneModula.Connected := false;
  FreeAndNil(_queryModula);
  FreeAndNil(_connessioneModula);

  Delete(_scriptSQL, length(_scriptSQL) - length(sLineBreak), length(sLineBreak) + 1);
  _scriptSQL := _scriptSQL + ';';

  executeQuery(_scriptSQL, KLib.MySQL.DriverPort.TConnection(ARC.arcdit));
end;

end.
