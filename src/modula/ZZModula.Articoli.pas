unit ZZModula.Articoli;

interface

uses
  System.Generics.Collections;

type
  TArticolo = record
  public
    codice: string;
    descrizione: string;
    //    descrizione: array [1..100] of char;
    unita_misura: string;

    procedure clear;
  end;

  TArticoli = class(TList<TArticolo>)
  public
    procedure insertIntoModula;
  end;

implementation

uses
  ZZGO1GESTMODULA,
  KLib.SQLServer.DriverPort, KLib.SQLServer.Utils,
  System.SysUtils;

procedure TArticoli.insertIntoModula;
const
  FIELD_ART_OPERAZIONE = 'ART_OPERAZIONE';
  FIELD_ART_ARTICOLO = 'ART_ARTICOLO';
  FIELD_ART_DES = 'ART_DES';
  FIELD_ART_UMI = 'ART_UMI';

  TABLENAME_IMP_ARTICOLI = 'HOST_IMPEXP.dbo.IMP_ARTICOLI';

  PARAM_ART_OPERAZIONE = ':' + FIELD_ART_OPERAZIONE;
  PARAM_ART_ARTICOLO = ':' + FIELD_ART_ARTICOLO;
  PARAM_ART_DES = ':' + FIELD_ART_DES;
  PARAM_ART_UMI = ':' + FIELD_ART_UMI;

  INSERT_INTO_IMP_ARTICOLI_WHERE_PARAM_ART_OPERAZIONE_PARAM_ART_ARTICOLO_PARAM_ART_DES_PARAM_ART_UMI =
    'INSERT INTO ' + TABLENAME_IMP_ARTICOLI + sLineBreak +
    '(' + sLineBreak +
    FIELD_ART_OPERAZIONE + ',' + sLineBreak +
    FIELD_ART_ARTICOLO + ',' + sLineBreak +
    FIELD_ART_DES + ',' + sLineBreak +
    FIELD_ART_UMI + sLineBreak +
    ')' + sLineBreak +
    'VALUES' + sLineBreak +
    '(' + sLineBreak +
    PARAM_ART_OPERAZIONE + ',' + sLineBreak +
    PARAM_ART_ARTICOLO + ',' + sLineBreak +
    PARAM_ART_DES + ',' + sLineBreak +
    PARAM_ART_UMI + sLineBreak +
    ')';
var
  _connessioneModula: TConnection;
  _query: TQuery;
  _articolo: TArticolo;
begin
  if Self.Count > 0 then
  begin
    _connessioneModula := getValidModulaSQLServerConnection;
    _query := getTQuery(_connessioneModula, INSERT_INTO_IMP_ARTICOLI_WHERE_PARAM_ART_OPERAZIONE_PARAM_ART_ARTICOLO_PARAM_ART_DES_PARAM_ART_UMI);
    try
      emptyTable(TABLENAME_IMP_ARTICOLI, _connessioneModula);
      try
        for _articolo in Self do
        begin
          _query.Close;
          _query.ParamByName(FIELD_ART_OPERAZIONE).AsString := 'I';
          _query.ParamByName(FIELD_ART_ARTICOLO).AsString := _articolo.codice;
          _query.ParamByName(FIELD_ART_DES).AsString := Copy(_articolo.descrizione, 1, 100);
          _query.ParamByName(FIELD_ART_UMI).AsString := _articolo.unita_misura;
          _query.OpenOrExecute;
        end;
        _query.close;
      except
        on E: Exception do
        begin
          emptyTable(TABLENAME_IMP_ARTICOLI, _connessioneModula);
          raise Exception.Create(E.Message);
        end;
      end;
    finally
      begin
        _connessioneModula.Connected := false;
        FreeAndNil(_query);
        FreeAndNil(_connessioneModula);
      end;
    end;
  end;
end;

procedure TArticolo.clear;
const
  EMPTY: TArticolo = ();
begin
  Self := EMPTY;
end;

end.
