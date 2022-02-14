object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 404
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 15
    Top = 174
    Width = 250
    Height = 200
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object porta_edit: TEdit
    Left = 35
    Top = 90
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1433'
  end
  object server_edit: TEdit
    Left = 35
    Top = 25
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'localhost'
  end
  object username_edit: TEdit
    Left = 190
    Top = 25
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'sa'
  end
  object password_edit: TEdit
    Left = 190
    Top = 90
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'masterkey'
  end
  object Memo1: TMemo
    Left = 315
    Top = 240
    Width = 185
    Height = 89
    Lines.Strings = (
      'SELECT [AlarmId] FROM '
      '[DMG_MORI_Messenger_V2].'
      '[dbo].[Alarm]')
    TabOrder = 5
  end
  object Button1: TButton
    Left = 300
    Top = 350
    Width = 121
    Height = 25
    Caption = 'openOrExecute query'
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 430
    Top = 350
    Width = 91
    Height = 25
    Caption = 'assegna griglia'
    TabOrder = 7
    OnClick = Button2Click
  end
  object DataSource1: TDataSource
    Left = 245
    Top = 215
  end
end
