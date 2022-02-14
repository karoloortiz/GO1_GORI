unit GGGO1GESTMODULA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GGFORMBASE, MyAccess, query_go, Data.DB,
  DBAccess, MemDS, Vcl.Menus, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, RzEdit,
  RzDBEdit, raizeedit_go, RzSpnEdt, Vcl.StdCtrls, Vcl.WinXCtrls, RzLabel,
  Vcl.Buttons, RzTabs, Vcl.ExtCtrls, RzPanel,
  KLib.SQLServer.DriverPort,
  KLib.Types;

const
  PROGRAM_NAME = 'GO1GESTMODULA';
  TABLE_NAME = 'GO1TMODULA';

type
  TGO1GESTMODULA = class(TFORMBASE)
    pannello_bottoni_nuovi: TRzPanel;
    tab_pannello_bottoni_nuovi: TRzPageControl;
    tab_pannello_bottoni_nuovi_base: TRzTabSheet;
    RzPanel1_bottoni_nuovi: TRzPanel;
    tool_f8: TRzRapidFireButton;
    tool_f9: TRzRapidFireButton;
    pannello_campi: TRzPanel;
    tab_control: TRzPageControl;
    tab_pagina1: TRzTabSheet;
    _password_lbl: TRzLabel;
    _server_lbl: TRzLabel;
    _username_lbl: TRzLabel;
    password: trzdbedit_go;
    server: trzdbedit_go;
    username: trzdbedit_go;
    checkSQLServerSettings_btn: TRzRapidFireButton;
    _port_lbl: TRzLabel;
    porta: trzdbnumericedit_go;
    procedure FormCreate(Sender: TObject);
    procedure tool_f8Click(Sender: TObject);
    procedure tool_f9Click(Sender: TObject);
    procedure tabella_dsDataChange(Sender: TObject; Field: TField);
    procedure checkSQLServerSettings_btnClick(Sender: TObject);
  private
    procedure _setTabellaQueryStmt;
  protected

  public
    procedure checkSQLServerSettings;
  end;

var
  GO1GESTMODULA: TGO1GESTMODULA;

implementation

{$r *.dfm}


uses
  ZZGO1GESTMODULA, ZZKLib.Utils,
  KLib.SQLServer.Info;

procedure TGO1GESTMODULA.FormCreate(Sender: TObject);
begin
  inherited;
  _setTabellaQueryStmt;
  tool_f8.Enabled := false;
end;

procedure TGO1GESTMODULA.checkSQLServerSettings_btnClick(Sender: TObject);
begin
  inherited;
  checkSQLServerSettings;
end;

procedure TGO1GESTMODULA.checkSQLServerSettings;
var
  _SQLServercredentials: TSQLServerCredentials;
begin
  with _SQLServercredentials do
  begin
    credentials.username := username.Text;
    credentials.password := password.Text;
  end;
  _SQLServercredentials.server := server.Text;
  _SQLServercredentials.port := StrToInt(porta.Text);

  checkSQLServerCredentials(_SQLServercredentials);
end;

procedure TGO1GESTMODULA.tool_f8Click(Sender: TObject);
begin
  inherited;

  tabella.Edit;
  tabella.Post;
  tabella.Refresh;
  tool_f8.Enabled := false;
end;

procedure TGO1GESTMODULA.tool_f9Click(Sender: TObject);
begin
  inherited;

  if tabella.RecordCount = 1 then
  begin
    tabella.Delete;
    tool_f8.Enabled := false;
  end;
end;

procedure TGO1GESTMODULA.tabella_dsDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  tool_f8.Enabled := true;
end;

procedure TGO1GESTMODULA._setTabellaQueryStmt;
begin
  tabella.SQL.Text := LowerCase(SELECT_FROM_TABLENAME);
  tabella.Close;
  tabella.Open;
end;

initialization

RegisterClass(TGO1GESTMODULA);

end.
