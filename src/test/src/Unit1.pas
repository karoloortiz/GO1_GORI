unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid;

type
  TForm1 = class(TForm)
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    porta_edit: TEdit;
    server_edit: TEdit;
    username_edit: TEdit;
    password_edit: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    DataSource1: TDataSource;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$r *.dfm}


uses
  KLib.SQLServer.DriverPort,
  KLib.SQLServer.Info,
  KLib.Utils, KLib.Constants, KLib.Windows;

var
  connection: TConnection;
  query: TQuery;

procedure TForm1.Button1Click(Sender: TObject);
var
  //  connection: TConnection;
  //  query: TQuery;
  SQLServercredentials: TSQLServerCredentials;
begin
  with SQLServercredentials do
  begin
    with credentials do
    begin
      username := username_edit.Text;
      password := password_edit.Text;
    end;
    server := server_edit.Text;
    port := StrToInt(porta_edit.Text);
  end;
  connection := getValidSQLServerTConnection(SQLServercredentials);
  connection.Connected := true;

  query := getTQuery(connection, Memo1.Text);

  query.OpenOrExecute;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DataSource1.DataSet := query;
  cxGrid1DBTableView1.DataController.CreateAllItems();
end;

end.
