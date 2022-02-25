unit GGGO1GESORDAFRN;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GGKLib.GESORDAFRN, Data.DB, MyAccess,
  query_go, DBAccess, MemDS, Vcl.Menus, RzSpnEdt, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Buttons, RzEdit, raizeedit_go, Vcl.Grids, Vcl.DBGrids, RzDBGrid, RzDBEdit,
  Vcl.Mask, RzLabel, RzTabs, Vcl.ExtCtrls, RzPanel, Vcl.ComCtrls, Vcl.ToolWin,
  RzCmboBx, RzDBCmbo;

const
  PROGRAM_NAME = 'GO1GESORDAFRN';

type
  TGO1GESORDAFRN = class(TGESORDAFRN)
    go1_modula_quantita_da_inviare: trzdbnumericedit_go;
    _quantita_da_inviare_lbl: TRzLabel;
    invia_missioni_btn: TRzRapidFireButton;
    v_giacenze: TRzRapidFireButton;
    quantita_residua: trzdbnumericedit_go;
    _quantita_residua: TRzLabel;
    quantita_caricabile: trzdbnumericedit_go;
    _quantita_caricabile_lbl: TRzLabel;
    go1_modula_sospeso: trzdbcombobox_go;
    _go1_modula_sospeso_lbl: TRzLabel;
    procedure v_grigliaEnter(Sender: TObject);
    procedure v_grigliaExit(Sender: TObject);
    procedure invia_missioni_btnClick(Sender: TObject);
    procedure v_grigliaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure go1_modula_quantita_da_inviareExit(Sender: TObject);
    procedure v_giacenzeClick(Sender: TObject);
    procedure go1_modula_sospesoExit(Sender: TObject);
  private
    ultimo_tasto: word;
  protected
    procedure inviaMissioniModula;
    procedure assegna_testo_query_codice; override;
    procedure CMDialogKey(var AMessage: TCMDialogKey); message CM_DIALOGKEY;
  public
    { Public declarations }
  end;

var
  GO1GESORDAFRN: TGO1GESORDAFRN;

implementation

{$r *.dfm}


uses
  ZZGO1Modula.Constants, ZZGO1Modula.Missione,
  ZZGO1GESTMODULA,
  ZZModula.Missione, ZZGO1ESPMODULA,
  KLib.MyString, ZZKLIB.Constants, ZZKLIB.Utils,
  KLib.MySQL.Utils, KLib.MySQL.DriverPort,
  DMARC;

procedure TGO1GESORDAFRN.CMDialogKey(var AMessage: TCMDialogKey);
begin
  ultimo_tasto := AMessage.CharCode;
  inherited;
end;

procedure TGO1GESORDAFRN.FormCreate(Sender: TObject);
begin
  inherited;
  controlloIniziale_frn_codice_enabled := false;
  controlloIniziale_inf_codice_enabled := false;

  ZZGO1ESPMODULA.importGiacenze;
  esegui_query_codice;
end;

procedure TGO1GESORDAFRN.assegna_testo_query_codice;
const
  FIELD_STMT_QUANTITA_INVIATA =
    'if(' + FIELD_QUANTITA_INVIATA + ' is null, 0, ' + FIELD_QUANTITA_INVIATA + ') ' + FIELD_QUANTITA_INVIATA;

  INNER_JOIN_TUB =
    'INNER JOIN ' + TABLENAME_TUB + ' ON ' + TABLENAME_TUB + '.' + FIELD_CODICE + ' = ' + TABLENAME_ART + '.' + FIELD_TUB_CODICE;

  LEFT_JOIN_MODULA_INVIO =
    'LEFT JOIN ' + TABLENAME_MODULA_INVIO + ' ON ' + TABLENAME_MODULA_INVIO + '.' + FIELD_TABELLA + ' = "' + TABLENAME_OAR + '"' +
    ' AND ' + TABLENAME_MODULA_INVIO + '.' + FIELD_PROGRESSIVO + ' = ' + TABLENAME_OAR + '.' + FIELD_PROGRESSIVO +
    ' AND ' + TABLENAME_MODULA_INVIO + '.' + FIELD_RIGA + ' = ' + TABLENAME_OAR + '.' + FIELD_RIGA;

  LEFT_JOIN_MODULA_SCOMPART =
    'LEFT JOIN' + sLineBreak +
    '(' + sLineBreak +
    'SELECT' + sLineBreak +
    'SCO_ARTICOLO,' + sLineBreak +
    '(SUM(SCO_LIM) - SUM(SCO_GIAC)) QUANTITA_CARICABILE' + sLineBreak +
    'FROM' + sLineBreak +
    'go1_modula_systoredb_dbo_dat_scompart' + sLineBreak +
    'GROUP BY' + sLineBreak +
    'SCO_ARTICOLO' + sLineBreak +
    ') MODULA_SCOMPART' + sLineBreak +
    'ON MODULA_SCOMPART.SCO_ARTICOLO = oar.art_codice';

  LEFT_JOIN_ARF =
    'LEFT JOIN arf ON arf.FRN_CODICE = oat.FRN_CODICE AND arf.ART_CODICE = oar.ART_CODICE';
begin
  inherited;

  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, 'tub.go1_modula');
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, 'go1_modula_quantita_da_inviare');
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, 'modula_scompart.quantita_caricabile');
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, FIELD_STMT_QUANTITA_INVIATA);
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, 'IF (arf.CODICE_ARTICOLO_FORNITORE REGEXP "^[0-9]+", right(concat( "....................", arf.CODICE_ARTICOLO_FORNITORE), 20), arf.CODICE_ARTICOLO_FORNITORE) CODICE_ARTICOLO_FORNITORE');
  testo_query_codice := getSQLStatementWithFieldInserted(testo_query_codice, 'go1_modula_sospeso');

  testo_query_codice := getSQLStatementWithJoinStmtInsertedIfNotExists(testo_query_codice, INNER_JOIN_TUB);
  testo_query_codice := getSQLStatementWithJoinStmtInsertedIfNotExists(testo_query_codice, LEFT_JOIN_MODULA_INVIO);
  testo_query_codice := getSQLStatementWithJoinStmtInsertedIfNotExists(testo_query_codice, LEFT_JOIN_MODULA_SCOMPART);
  testo_query_codice := getSQLStatementWithJoinStmtInsertedIfNotExists(testo_query_codice, LEFT_JOIN_ARF);
end;

procedure TGO1GESORDAFRN.invia_missioni_btnClick(Sender: TObject);
const
  CONFIRM_MSG =
    'Inviare le missioni delle righe visualizzate a Modula?';
begin
  inherited;

  if confirmMessage(CONFIRM_MSG) then
  begin
    try
      inviaMissioniModula;
    except
      on E: Exception do
    end;
    esegui_query_codice;
    successfulMessage;
  end;
end;

procedure TGO1GESORDAFRN.inviaMissioniModula;
var
  _missione: TMissione;
  _descrizioneMissione: string;
  _rigaMissione: TRigaMissione;
  _progressivo_vecchio: double;
  _progressivo_corrente: double;
  _nuovaMissione: boolean;
  _inviaMissione: boolean;
  _esisteMissione: boolean;
  _baia_ordini_acquisto: string;
begin
  _baia_ordini_acquisto := '';
  //  _baia_ordini_acquisto := get_baia_ordini_acquisto;

  query_codiceAfterScroll_TGESGRD_enabled := false;
  //  query_codice.DisableControls;
  query_codice.First;

  _progressivo_vecchio := 0;
  _esisteMissione := false;
  while not query_codice.Eof do
  begin
    if (query_codice.FieldByName(FIELD_MODULA).AsString = VALUE_SI)
      and (query_codice.FieldByName('go1_modula_quantita_da_inviare').AsFloat > 0)
      and (query_codice.fieldbyname('go1_modula_sospeso').asstring = 'no') then
    begin
      _progressivo_corrente := query_codice.FieldByName(FIELD_PROGRESSIVO).AsFloat;
      _nuovaMissione := _progressivo_corrente <> _progressivo_vecchio;

      if _nuovaMissione then
      begin
        _descrizioneMissione := 'oa n ' + query_codice.FieldByName(FIELD_NUMERO_DOCUMENTO).AsString + ' ' + v_frn_descrizione1.Text;
        _missione.clear;
        with _missione do
        begin
          eseguiDirettamente := false;
          baiaDestinazione := _baia_ordini_acquisto;
          tipoOperazione := TTipoOperazione.inserimento;
          progressivo := arc.setta_valore_generatore(ARC.arcdit, MODULA_MISSIONE_PROGRESSIVO);
          descrizione := _descrizioneMissione;
          righe := TRigheMissione.Create;
        end;
      end;

      _rigaMissione.clear;
      with _rigaMissione do
      begin
        codiceArticolo := query_codice.FieldByName(FIELD_ART_CODICE).AsString;
        quantita := query_codice.FieldByName('go1_modula_quantita_da_inviare').AsFloat;

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
      updateMissioneQuantitaInviataOAR(_missione.righe);
      _esisteMissione := false;
      _progressivo_vecchio := 0;
    end;
  end;

  query_codiceAfterScroll_TGESGRD_enabled := true;
  //  query_codice.EnableControls;
end;

procedure TGO1GESORDAFRN.go1_modula_quantita_da_inviareExit(Sender: TObject);
begin
  inherited;

  if (ultimo_tasto <> VK_ESCAPE) and (go1_modula_quantita_da_inviare.Value > 0) then
  begin
    if (go1_modula_quantita_da_inviare.Value <= query_codice.fieldbyname('quantita_caricabile').AsFloat) then
    begin
      if tabella_edit(tabella) then
      begin
        tabella.fieldbyname('go1_modula_quantita_da_inviare').AsFloat := go1_modula_quantita_da_inviare.Value;
        tabella.fieldbyname('go1_modula_sospeso').AsString := 'no';
        tabella.post;

        refreshQueryKeepingPosition(TQuery(query_codice));
        if (ultimo_tasto = VK_TAB) or (ultimo_tasto = VK_RETURN) then
        begin
          query_codice.Next;
          if not query_codice.Eof then
          begin
            FocusControl(go1_modula_quantita_da_inviare);
          end;
        end;
      end;
    end
    else
    begin
      //      if (go1_modula_quantita_da_inviare.Value > 0) then
      //      begin
      normalMessage('Valore inserito superiore alla "quantita caricabile"');
      //      end;
      if tabella_edit(tabella) then
      begin
        tabella.fieldbyname('go1_modula_quantita_da_inviare').AsFloat := 0;
        tabella.post;

        refreshQueryKeepingPosition(TQuery(query_codice));
      end;
    end;
  end;
end;

procedure TGO1GESORDAFRN.go1_modula_sospesoExit(Sender: TObject);
var
  _refresh_query_codice: boolean;
begin
  inherited;
  _refresh_query_codice := go1_modula_sospeso.Value <> tabella.fieldbyname('go1_modula_sospeso').asstring;
  if _refresh_query_codice then
  begin
    if tabella_edit(tabella) then
    begin
      tabella.fieldbyname('go1_modula_sospeso').asstring := go1_modula_sospeso.Value;
      tabella.post;

      refreshQueryKeepingPosition(TQuery(query_codice));
    end;
  end;
end;

procedure TGO1GESORDAFRN.v_giacenzeClick(Sender: TObject);
begin
  inherited;
  ZZGO1ESPMODULA.importGiacenze;
  esegui_query_codice;
end;

procedure TGO1GESORDAFRN.v_grigliaDrawColumnCell(Sender: TObject;
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

  if (query_codice.FieldByName(FIELD_MODULA).AsString = VALUE_SI)
    and (query_codice.FieldByName('go1_modula_quantita_da_inviare').AsFloat > 0)
    and (query_codice.fieldbyname('go1_modula_sospeso').asstring = 'no') then
  begin
    v_griglia.canvas.brush.color := cllime;
    v_griglia.canvas.font.color := clblack;
  end;
  //  end;

  v_griglia.defaultdrawcolumncell(rect, datacol, column, state);
end;

procedure TGO1GESORDAFRN.v_grigliaEnter(Sender: TObject);
begin
  inherited;
  invia_missioni_btn.Enabled := true;
end;

procedure TGO1GESORDAFRN.v_grigliaExit(Sender: TObject);
begin
  inherited;
  invia_missioni_btn.Enabled := false;
end;

initialization

RegisterClass(TGO1GESORDAFRN);

end.
