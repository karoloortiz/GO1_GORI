unit GGGO1GESORDVCL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GGKLib.GESORDVCL, Data.DB, MyAccess,
  query_go, DBAccess, MemDS, Vcl.Menus, RzSpnEdt, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Buttons, RzEdit, raizeedit_go, Vcl.Grids, Vcl.DBGrids, RzDBGrid, RzDBEdit,
  Vcl.Mask, RzLabel, RzTabs, Vcl.ExtCtrls, RzPanel, Vcl.ComCtrls, Vcl.ToolWin,
  RzCmboBx, RzDBCmbo;

const
  PROGRAM_NAME = 'GO1GESORDVCL';

type
  TGO1GESORDVCL = class(TGESORDVCL)
    quantita_da_inviare: trzdbnumericedit_go;
    _quantita_da_inviare_lbl: TRzLabel;
    invia_missioni_btn: TRzRapidFireButton;
    _go1_modula_sospeso_lbl: TRzLabel;
    go1_modula_sospeso: trzdbcombobox_go;
    quantita_residua: trzdbnumericedit_go;
    _quantita_residua: TRzLabel;
    procedure v_grigliaEnter(Sender: TObject);
    procedure v_grigliaExit(Sender: TObject);
    procedure invia_missioni_btnClick(Sender: TObject);
    procedure v_grigliaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure go1_modula_sospesoExit(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure inviaMissioniModula;
    procedure assegna_testo_query_codice; override;
  public
    { Public declarations }
  end;

var
  GO1GESORDVCL: TGO1GESORDVCL;

implementation

{$r *.dfm}


uses
  ZZGO1Modula.Constants, ZZGO1Modula.Missione,
  ZZGO1GESTMODULA,
  ZZModula.Missione,
  ZZKLIB.Constants, ZZKLIB.Utils,
  KLib.MySQL.Utils, KLib.MySQL.DriverPort,
  KLib.MyString, KLib.Constants,
  DMARC;

procedure TGO1GESORDVCL.FormCreate(Sender: TObject);
begin
  inherited;
  controlloIniziale_cli_codice_enabled := false;
  controlloIniziale_ind_codice_enabled := false;
end;

procedure TGO1GESORDVCL.assegna_testo_query_codice;
const
  FIELD_STMT_QUANTITA_RESIDUA = '(case when ovr.situazione = "annullato" or ovr.situazione = "revisionato" or ovr.situazione = "consolidato" then 0.0 ' +
    'else ovr.quantita - ovr.quantita_evasa end) ';

  FIELD_STMT_QUANTITA_COLLO =
    TABLENAME_ART + '.' + FIELD_QUANTITA_COLLO + ' ' + FIELD_QUANTITA_COLLO;
  COMPARISON_STMT_QUANTITA_COLLO = TABLENAME_ART + '.' + FIELD_QUANTITA_COLLO + ' > ' + FIELD_STMT_QUANTITA_RESIDUA + ' OR ' + TABLENAME_ART + '.' + FIELD_QUANTITA_COLLO + ' = 0 ';

  FIELD_STMT_MODULA =
    'IF(' + TABLENAME_TUB + '.' + FIELD_MODULA + ' = "' + VALUE_SI + '", IF(' + COMPARISON_STMT_QUANTITA_COLLO + ', "' + VALUE_SI + '", "' + VALUE_NO + '"), "' + VALUE_NO +
    '") ' + FIELD_MODULA;

  FIELD_STMT_QUANTITA_DA_INVIARE =
    'IF(' + TABLENAME_TUB + '.' + FIELD_MODULA + ' = "' + VALUE_SI + '", IF(' + COMPARISON_STMT_QUANTITA_COLLO + ', ' +
    FIELD_STMT_QUANTITA_RESIDUA + ' - if(' + FIELD_QUANTITA_INVIATA + ' is null, 0, ' + FIELD_QUANTITA_INVIATA + ')' +
    ', 0), 0) ' + FIELD_QUANTITA_DA_INVIARE;

  FIELD_STMT_QUANTITA_INVIATA =
    'if(' + FIELD_QUANTITA_INVIATA + ' is null, 0, ' + FIELD_QUANTITA_INVIATA + ') ' + FIELD_QUANTITA_INVIATA;

  INNER_JOIN_TUB =
    'INNER JOIN ' + TABLENAME_TUB + ' ON ' + TABLENAME_TUB + '.' + FIELD_CODICE + ' = ' + TABLENAME_ART + '.' + FIELD_TUB_CODICE;

  LEFT_JOIN_MODULA_INVIO =
    'LEFT JOIN ' + TABLENAME_MODULA_INVIO + ' ON ' + TABLENAME_MODULA_INVIO + '.' + FIELD_TABELLA + ' = "' + TABLENAME_OVR + '"' +
    ' AND ' + TABLENAME_MODULA_INVIO + '.' + FIELD_PROGRESSIVO + ' = ' + TABLENAME_OVR + '.' + FIELD_PROGRESSIVO +
    ' AND ' + TABLENAME_MODULA_INVIO + '.' + FIELD_RIGA + ' = ' + TABLENAME_OVR + '.' + FIELD_RIGA;
begin
  inherited;
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, FIELD_STMT_QUANTITA_COLLO);
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, FIELD_STMT_MODULA);
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, FIELD_STMT_QUANTITA_DA_INVIARE);
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, FIELD_STMT_QUANTITA_INVIATA);
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, 'go1_modula_sospeso');

  testo_query_codice := getSQLStatementWithJoinStmtInsertedIfNotExists(testo_query_codice, INNER_JOIN_TUB);
  testo_query_codice := getSQLStatementWithJoinStmtInsertedIfNotExists(testo_query_codice, LEFT_JOIN_MODULA_INVIO);
end;

procedure TGO1GESORDVCL.invia_missioni_btnClick(Sender: TObject);
const
  CONFIRM_MSG =
    'Inviare le missioni delle righe visualizzate a Modula?';
begin
  inherited;
  if confirmMessage(CONFIRM_MSG) then
  begin
    inviaMissioniModula;
    esegui_query_codice;
    successfulMessage;
  end;
end;

procedure TGO1GESORDVCL.inviaMissioniModula;
var
  _missione: TMissione;
  _descrizioneMissione: string;
  _rigaMissione: TRigaMissione;
  _progressivo_vecchio: double;
  _progressivo_corrente: double;
  _nuovaMissione: boolean;
  _inviaMissione: boolean;
  _esisteMissione: boolean;
  _baia_ordini_vendita: string;
begin
  _baia_ordini_vendita := '';
  //  _baia_ordini_vendita := get_baia_ordini_vendita;

  query_codiceAfterScroll_TGESGRD_enabled := false;
  //  query_codice.DisableControls;

  query_codice.First;

  _progressivo_vecchio := 0;
  _esisteMissione := false;
  while not query_codice.Eof do
  begin
    if (query_codice.FieldByName(FIELD_MODULA).AsString = VALUE_SI)
      and (query_codice.fieldbyname('go1_modula_sospeso').asstring = 'no') then
    begin
      _progressivo_corrente := query_codice.FieldByName(FIELD_PROGRESSIVO).AsFloat;
      _nuovaMissione := _progressivo_corrente <> _progressivo_vecchio;
      if _nuovaMissione then
      begin
        _descrizioneMissione := 'ov n ' + query_codice.FieldByName(FIELD_NUMERO_DOCUMENTO).AsString + ' ' + v_cli_descrizione1.Text;
        _missione.clear;
        with _missione do
        begin
          eseguiDirettamente := false;
          baiaDestinazione := _baia_ordini_vendita;
          tipoOperazione := TTipoOperazione.prelievo;
          progressivo := arc.setta_valore_generatore(ARC.arcdit, MODULA_MISSIONE_PROGRESSIVO);
          descrizione := _descrizioneMissione;
          righe := TRigheMissione.Create;
        end;
      end;

      _rigaMissione.clear;
      with _rigaMissione do
      begin
        codiceArticolo := query_codice.FieldByName(FIELD_ART_CODICE).AsString;
        quantita := query_codice.FieldByName(FIELD_QUANTITA_DA_INVIARE).AsFloat;

        progressivo := query_codice.FieldByName(FIELD_PROGRESSIVO).AsFloat;
        riga := query_codice.FieldByName(FIELD_RIGA).AsFloat;
      end;
      _missione.righe.Add(_rigaMissione);
      _progressivo_vecchio := query_codice.FieldByName(FIELD_PROGRESSIVO).AsFloat;

      _esisteMissione := true;
    end;
    query_codice.Next;

    if not query_codice.Eof then
    begin
      _progressivo_corrente := query_codice.FieldByName(FIELD_PROGRESSIVO).AsFloat;
      _inviaMissione := (_progressivo_corrente <> _progressivo_vecchio) and (_esisteMissione);
    end
    else if _esisteMissione then
    begin
      _inviaMissione := true;
    end
    else
    begin
      _inviaMissione := false;
    end;

    if _inviaMissione then
    begin
      sendMissione(_missione);
      updateMissioneQuantitaInviataOVR(_missione.righe);
      _esisteMissione := false;
      _progressivo_vecchio := 0;
    end;
  end;

  query_codiceAfterScroll_TGESGRD_enabled := true;
  //    query_codice.EnableControls;
end;

procedure TGO1GESORDVCL.go1_modula_sospesoExit(Sender: TObject);
var
  _queryStmt: myString;
  _refresh_query_codice: boolean;
  _resetQuantita_go1_modula_invio: boolean;
begin
  inherited;

  _refresh_query_codice := go1_modula_sospeso.Value <> tabella.fieldbyname('go1_modula_sospeso').asstring;
  _resetQuantita_go1_modula_invio := (go1_modula_sospeso.Value = 'no') and (tabella.fieldbyname('go1_modula_sospeso').asstring = 'si');
  if _refresh_query_codice then
  begin
    if tabella_edit(tabella) then
    begin
      tabella.fieldbyname('go1_modula_sospeso').asstring := go1_modula_sospeso.Value;
      tabella.post;

      if _resetQuantita_go1_modula_invio then
      begin
        _queryStmt := 'DELETE FROM go1_modula_invio WHERE tabella = "OVR" and progressivo = :PROGRESSIVO and riga = :RIGA';
        _queryStmt.setParamAsFloat(PARAM_PROGRESSIVO, tabella.fieldbyname('progressivo').AsFloat, MYSQL_DECIMAL_SEPARATOR);
        _queryStmt.setParamAsFloat(PARAM_RIGA, tabella.fieldbyname('riga').AsFloat, MYSQL_DECIMAL_SEPARATOR);
        KLib.MySQL.Utils.executeQuery(_queryStmt, KLib.MySQL.DriverPort.TConnection(arc.arcdit));
        esegui_query_codice;
      end
      else
      begin
        refreshQueryKeepingPosition(TQuery(query_codice));
      end;
    end;
  end;
end;

procedure TGO1GESORDVCL.v_grigliaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  //  if Column.Title.Caption = 'modula' then
  //  begin
  if (query_codice.fieldbyname('go1_modula_sospeso').asstring = 'si') then
  begin
    v_griglia.canvas.brush.color := clYellow;
    v_griglia.canvas.font.color := clBlack;
  end;

  if (query_codice.fieldbyname(FIELD_MODULA).asstring = VALUE_SI)
    and (query_codice.fieldbyname('go1_modula_sospeso').asstring = 'no') then
  begin
    v_griglia.canvas.brush.color := clLime;
    v_griglia.canvas.font.color := clBlack;
  end;
  //  end;

  v_griglia.defaultdrawcolumncell(rect, datacol, column, state);
end;

procedure TGO1GESORDVCL.v_grigliaEnter(Sender: TObject);
begin
  inherited;
  invia_missioni_btn.Enabled := true;
end;

procedure TGO1GESORDVCL.v_grigliaExit(Sender: TObject);
begin
  inherited;
  invia_missioni_btn.Enabled := false;
end;

initialization

RegisterClass(TGO1GESORDVCL);

end.
