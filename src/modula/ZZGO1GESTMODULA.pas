unit ZZGO1GESTMODULA;

interface

uses
  KLib.SQLServer.DriverPort,
  KLib.SQLServer.Info,
  GGGO1GESTMODULA;

const
  SELECT_FROM_TABLENAME =
    'SELECT' + sLineBreak +
    '*' + sLineBreak +
    'FROM' + sLineBreak +
    TABLE_NAME;

function getValidModulaSQLServerConnection: KLib.SQLServer.DriverPort.TConnection;
function getModulaSQLServerCredentials: TSQLServerCredentials;
//function get_baia_ordini_vendita: string;
//function get_baia_ordini_acquisto: string;
//function get_baia_vendita_banco: string;
//function get_baia_inventario: string;

implementation

uses
  ZZGO1Modula.Constants,
  ZZKLib.Constants,
  KLib.SQLServer.Validate,
  KLib.MySQL.DriverPort,
  DMARC,
  System.SysUtils;

function _get_baia(baiaFieldName: string): string; forward;

function getValidModulaSQLServerConnection: KLib.SQLServer.DriverPort.TConnection;
const
  ERR_MSG = 'Impostazioni server Modula non valide. Controllare il programma ' + PROGRAM_NAME;
var
  connection: KLib.SQLServer.DriverPort.TConnection;
  _SQLServerCredentials: TSQLServerCredentials;
begin
  _SQLServerCredentials := getModulaSQLServerCredentials;
  connection := getValidSQLServerTConnection(_SQLServerCredentials);
  Result := connection;
end;

function getModulaSQLServerCredentials: TSQLServerCredentials;
const
  ERR_MSG = 'Impostazioni server Modula non compilate. Controllare il programma ' + PROGRAM_NAME;
var
  SQLServerCredentials: TSQLServerCredentials;
  _query: KLib.MySQL.DriverPort.TQuery;
begin
  try
    _query := KLib.MySQL.DriverPort.getTQuery(TConnection(ARC.arcdit), SELECT_FROM_TABLENAME);
    _query.Open;

    Assert(_query.RecordCount = 1, ERR_MSG);

    with SQLServerCredentials do
    begin
      with credentials do
      begin
        username := _query.FieldByName(FIELD_USERNAME).AsString;
        password := _query.FieldByName(FIELD_PASSWORD).AsString;
      end;
      server := _query.FieldByName(FIELD_SERVER).AsString;
      port := _query.FieldByName(FIELD_PORTA).AsInteger;
    end;
    _query.Close;
  finally
    FreeAndNil(_query);
  end;

  Result := SQLServerCredentials;
end;

function get_baia_ordini_vendita: string;
var
  baia: string;
begin
  baia := _get_baia(FIELD_BAIA_ORDINI_VENDITA);
  Result := baia;
end;

function get_baia_ordini_acquisto: string;
var
  baia: string;
begin
  baia := _get_baia(FIELD_BAIA_ORDINI_ACQUISTO);
  Result := baia;
end;

function get_baia_vendita_banco: string;
var
  baia: string;
begin
  baia := _get_baia(FIELD_BAIA_VENDITA_BANCO);
  Result := baia;
end;

function get_baia_inventario: string;
const
  FIELD_BAIA = 'baia_inventario';
var
  baia: string;
begin
  baia := _get_baia(FIELD_BAIA);
  Result := baia;
end;

function _get_baia(baiaFieldName: string): string;
const
  ERR_MSG = 'Impostazioni server Modula non compilate. Controllare il programma ' + PROGRAM_NAME;
var
  baia: string;
  _query: KLib.MySQL.DriverPort.TQuery;
begin
  try
    _query := KLib.MySQL.DriverPort.getTQuery(TConnection(ARC.arcdit), SELECT_FROM_TABLENAME);
    _query.Open;

    Assert(_query.RecordCount = 1, ERR_MSG);

    baia := _query.FieldByName(baiaFieldName).AsString;

    _query.Close;
  finally
    FreeAndNil(_query);
  end;

  Result := baia;
end;

end.
