unit GGGO1GESTUB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GGGESTUB, MyAccess, query_go, Data.DB,
  DBAccess, MemDS, Vcl.Menus, RzSpnEdt, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Buttons, raizeedit_go, Vcl.Mask, RzEdit, RzDBEdit, RzButton, RzRadChk,
  RzDBChk, RzTabs, RzLabel, Vcl.ExtCtrls, RzPanel, Vcl.ComCtrls, Vcl.ToolWin;

const
  PROGRAM_NAME = 'GO1GESTUB';
  TABLE_NAME = 'GO1GESTUB';

type
  TGO1GESTUB = class(TGESTUB)
    go1_modula: TRzDBCheckBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GO1GESTUB: TGO1GESTUB;

implementation

{$r *.dfm}


procedure TGO1GESTUB.FormCreate(Sender: TObject);
begin
  inherited;
  programma_stampa := 'STATUB';
end;

initialization

RegisterClass(TGO1GESTUB);

end.
