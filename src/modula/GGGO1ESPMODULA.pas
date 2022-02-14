unit GGGO1ESPMODULA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTable, MyAccess,
  query_go, Data.DB, DBAccess, MemDS, Vcl.Menus, RzButton, Vcl.Buttons,
  RzSpnEdt, Vcl.ExtCtrls, Vcl.ComCtrls, RzPanel, RzTabs, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.Mask, RzEdit, RzDBEdit, raizeedit_go, RzLabel,
  GGFORMBASE;

const
  PROGRAM_NAME = 'GO1ESPMODULA';
  PARAM_ARTICOLI = 'articoli';
  PARAM_GIACENZE = 'giacenze';

type
  TGO1ESPMODULA = class(TFORMBASE)
    _test_btn: TRzRapidFireButton;
    _tests_pnl: TPanel;
    exportArticoli_btn: TButton;
    _data_ultimo_aggiornamento_art_lbl: TLabel;
    _data_ultimo_aggiornamento_art_dateTime: TRzDBDateTimeEdit;
    _data_ultimo_aggiornamento_giacenze_dateTime: TRzDBDateTimeEdit;
    _data_ultimo_aggiornamento_giacenze_lbl: TLabel;
    importGiacenze_btn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure exportArticoli_btnClick(Sender: TObject);
    procedure importGiacenze_btnClick(Sender: TObject);
  private
    procedure _setTabellaQueryStmt;
    procedure _setVisibilityOfTestsArea;
  protected
  public
    procedure tryToExportArticoli;
    procedure tryToImportGiacenze;
    destructor Destroy; override;
  end;

var
  GO1ESPMODULA: TGO1ESPMODULA;

implementation

{$r *.dfm}


uses
  ZZGO1ESPMODULA,
  ZZGO1Modula.Constants,
  ZZKLib.Utils, ZZKLib.Constants,
  DMARC,
  KLib.WaitForm,
  KLib.Utils, KLib.Constants;

procedure TGO1ESPMODULA.FormCreate(Sender: TObject);
begin
  _setTabellaQueryStmt;
  inherited;

  if isScheduledProgram then
  begin
    if parametro_personalizzato = PARAM_ARTICOLI then
    begin
      exportArticoliInSilentMode;
    end
    else if parametro_personalizzato = PARAM_GIACENZE then
    begin
      importGiacenzeInSilentMode;
    end;
    Application.Terminate;
  end;

  _setVisibilityOfTestsArea;
end;

procedure TGO1ESPMODULA._setTabellaQueryStmt;
const
  SELECT_FROM_TABLENAME =
    'SELECT' + sLineBreak +
    '*' + sLineBreak +
    'FROM' + sLineBreak +
    TABLENAME_ESPMODULA + sLineBreak +
    'WHERE' + sLineBreak +
    FIELD_ID + ' = 1';
begin
  tabella.SQL.Text := UpperCase(SELECT_FROM_TABLENAME);
  tabella.Close;
  tabella.Open;
end;

procedure TGO1ESPMODULA.exportArticoli_btnClick(Sender: TObject);
const
  WAITING_MSG = 'Esportazione articoli in corso';
begin
  inherited;
  executeMethodInWaitForm(tryToExportArticoli, WAITING_MSG);
end;

procedure TGO1ESPMODULA.tryToExportArticoli;
begin
  try
    exportArticoli;
    successfulMessage;
    tabella.Refresh;
  except
    on E: Exception do
    begin
      errorMessage(E.Message);
    end;
  end;
end;

procedure TGO1ESPMODULA.importGiacenze_btnClick(Sender: TObject);
const
  WAITING_MSG = 'Importazione giancenze in corso';
begin
  inherited;
  executeMethodInWaitForm(tryToImportGiacenze, WAITING_MSG);
end;

procedure TGO1ESPMODULA.tryToImportGiacenze;
begin
  try
    importGiacenze;
    successfulMessage;
    tabella.Refresh;
  except
    on E: Exception do
    begin
      errorMessage(E.Message);
    end;
  end;
end;

//####################################### TEST AREA #######################################################
procedure TGO1ESPMODULA._setVisibilityOfTestsArea;
begin
  _tests_pnl.Visible := IsDebuggerPresent;
  if not _tests_pnl.Visible then
  begin
    Self.Width := Self.Width - _tests_pnl.Width;
  end;
end;

destructor TGO1ESPMODULA.Destroy;
begin
  inherited;
end;

initialization

RegisterClass(TGO1ESPMODULA);

end.
