program test;

uses
  madExcept,
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  KLib.Async in '..\..\KLib\Delphi_Async_Library\KLib.Async.pas',
  KLib.AsyncMethod in '..\..\KLib\Delphi_Async_Library\KLib.AsyncMethod.pas',
  KLib.MySQL.CLIUtilities in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.CLIUtilities.pas',
  KLib.MySQL.DriverPort in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.DriverPort.pas',
  KLib.MySQL.Info in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.Info.pas',
  KLib.MySQL.IniManipulator in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.IniManipulator.pas',
  KLib.MySQL.Process in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.Process.pas',
  KLib.MySQL.ProcessManager in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.ProcessManager.pas',
  KLib.MySQL.Service in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.Service.pas',
  KLib.MySQL.TemporaryTable in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.TemporaryTable.pas',
  KLib.MySQL.Utils in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.Utils.pas',
  KLib.MySQL.Validate in '..\..\KLib\Delphi_MySQL_Library\KLib.MySQL.Validate.pas',
  KLib.VC_Redist in '..\..\KLib\Delphi_MySQL_Library\KLib.VC_Redist.pas',
  KLib.Constants in '..\..\KLib\Delphi_Utils_Library\KLib.Constants.pas',
  KLib.Generic in '..\..\KLib\Delphi_Utils_Library\KLib.Generic.pas',
  KLib.Graphics in '..\..\KLib\Delphi_Utils_Library\KLib.Graphics.pas',
  KLib.Math in '..\..\KLib\Delphi_Utils_Library\KLib.Math.pas',
  KLib.MemoryRAM in '..\..\KLib\Delphi_Utils_Library\KLib.MemoryRAM.pas',
  KLib.MyIdFTP in '..\..\KLib\Delphi_Utils_Library\KLib.MyIdFTP.pas',
  KLib.MyString in '..\..\KLib\Delphi_Utils_Library\KLib.MyString.pas',
  KLib.StreamWriterUTF8NoBOMEncoding in '..\..\KLib\Delphi_Utils_Library\KLib.StreamWriterUTF8NoBOMEncoding.pas',
  KLib.Types in '..\..\KLib\Delphi_Utils_Library\KLib.Types.pas',
  KLib.Utils in '..\..\KLib\Delphi_Utils_Library\KLib.Utils.pas',
  KLib.Validate in '..\..\KLib\Delphi_Utils_Library\KLib.Validate.pas',
  KLib.Windows in '..\..\KLib\Delphi_Utils_Library\KLib.Windows.pas',
  KLib.WindowsService in '..\..\KLib\Delphi_Utils_Library\KLib.WindowsService.pas',
  KLib.SQLServer.DriverPort in '..\..\KLib\Delphi_SQLServer_Library\KLib.SQLServer.DriverPort.pas',
  KLib.SQLServer.FireDac in '..\..\KLib\Delphi_SQLServer_Library\KLib.SQLServer.FireDac.pas',
  KLib.MyDAC in '..\..\KLib\Delphi_MySQL_Library\Devart\KLib.MyDAC.pas',
  KLib.SQLServer.Validate in '..\..\KLib\Delphi_SQLServer_Library\KLib.SQLServer.Validate.pas',
  KLib.SQLServer.Info in '..\..\KLib\Delphi_SQLServer_Library\KLib.SQLServer.Info.pas',
  KLib.SQLServer.Utils in '..\..\KLib\Delphi_SQLServer_Library\KLib.SQLServer.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
