inherited GO1GESTMODULA: TGO1GESTMODULA
  Caption = 'GO1GESTMODULA'
  ClientHeight = 213
  ClientWidth = 508
  ExplicitWidth = 514
  ExplicitHeight = 262
  PixelsPerInch = 96
  TextHeight = 13
  inherited toolbar: TToolBar
    Width = 508
    ExplicitWidth = 508
  end
  inherited statusbar: TStatusBar
    Top = 193
    Width = 508
    SimplePanel = True
    ExplicitTop = 193
    ExplicitWidth = 508
  end
  object pannello_bottoni_nuovi: TRzPanel [2]
    Left = 393
    Top = 34
    Width = 115
    Height = 159
    Align = alRight
    BorderOuter = fsNone
    TabOrder = 2
    object tab_pannello_bottoni_nuovi: TRzPageControl
      Left = 0
      Top = 26
      Width = 115
      Height = 133
      Hint = ''
      ActivePage = tab_pannello_bottoni_nuovi_base
      Align = alClient
      ParentShowHint = False
      ShowHint = False
      ShowShadow = False
      TabOverlap = 2
      TabIndex = 0
      TabOrder = 0
      TabStop = False
      TabStyle = tsRoundCorners
      TabWidth = 29
      FixedDimension = 19
      object tab_pannello_bottoni_nuovi_base: TRzTabSheet
        Hint = 'base'
        Caption = #10004
        object checkSQLServerSettings_btn: TRzRapidFireButton
          Left = 0
          Top = 0
          Width = 113
          Height = 26
          Hint = 'controlla impostazioni FTP'
          Align = alTop
          Caption = 'controlla connessione'
          OnClick = checkSQLServerSettings_btnClick
          ExplicitTop = 5
        end
      end
    end
    object RzPanel1_bottoni_nuovi: TRzPanel
      Left = 0
      Top = 0
      Width = 115
      Height = 26
      Align = alTop
      BorderOuter = fsNone
      TabOrder = 1
      object tool_f8: TRzRapidFireButton
        Left = 0
        Top = 0
        Width = 59
        Height = 26
        Hint = 'memorizza nell'#39'archivio'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000C01E0000C01E00000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000663333FF663333FF8E8E8EFF8C8C8CFF898989FF868686FF838383FF7F7F
          7FFF7C7C7DFF7A7A7AFF663333FF663333FF663333FF00000000000000006633
          33FFCF6A00FFCB6500FFFAFAFAFFC25C00FFBD5800FFDFDFDFFFD4D4D4FFC8C8
          C8FFBDBDBDFFB3B2B2FFA64000FFA23D00FF663333FF00000000000000006633
          33FFD46E00FFD06A00FFFEFEFEFFC66000FFC15C00FFE6E6E6FFDBDBDAFFD0D0
          CFFFC4C4C5FFB9BAB9FFA94400FFA54000FF663333FF00000000000000006633
          33FFD87300FFD46E00FFFFFFFFFFCB6500FFC66100FFEBECEBFFE2E2E2FFD6D7
          D7FFCCCBCBFFC0C0C0FFAC4700FFA94300FF663333FF00000000000000006633
          33FFDD7700FFD77200FFEFCBA3FFFFFFFFFFF9F9F9FFF1F1F1FFE8E8E8FFDDDE
          DDFFD3D2D2FFC09C7FFFB04A00FFAD4700FF663333FF00000000000000006633
          33FFE07A00FFDC7700FFD87200FFD46E00FFCF6A00FFCA6400FFC56000FFC25B
          00FFBD5700FFB85300FFB44F00FFB04B00FF663333FF00000000000000006633
          33FFE47F00FFE07B00FFDC7600FFD87200FFD36E00FFCF6900FFCA6400FFC660
          00FFC15C00FFBC5700FFB85300FFB44E00FF663333FF00000000000000006633
          33FFE98300FFFFF8ECFFFEF6E6FFFFF3E1FFFEF0DBFFFFEFD5FFFFECD0FFFEEA
          CAFFFEE7C4FFFEE6C0FFFEE4BBFFB85200FF663333FF00000000000000006633
          33FFEC8600FFEFECE7FFEBE7E0FFE7E2D9FFE2DCD3FFDED8CBFFDBD2C4FFD8CE
          BEFFD5CAB8FFD2C6B3FFCFC2ADFFBC5700FF663333FF00000000000000006633
          33FFF08A00FFFFFBF3FFFFF9EEFFFFF7E9FFFFF4E3FFFFF2DEFFFEEFD8FFFEED
          D2FFFFEBCCFFFFE8C6FFFEE7C1FFC15B00FF663333FF00000000000000006633
          33FFF38D00FFF3F1EEFFEFECE8FFEBE7E2FFE7E2DAFFE3DDD3FFDFD8CCFFDBD3
          C6FFD8CEBFFFD5CAB9FFD1C6B4FFC55F00FF663333FF00000000000000006633
          33FFF69000FFFFFDF9FFFFFBF5FFFFFAF0FFFFF8EBFFFFF5E6FFFFF3DFFFFFF0
          DAFFFEEED4FFFFECCFFFFFE9C8FFC96400FF663333FF00000000000000006633
          33FFF99300FFABA8FEFF9EA0FDFF9298FCFF8690FBFF7A89F9FF6F81F8FF647B
          F7FF5B74F5FF526FF4FF4B69F2FFCE6900FF663333FF00000000000000006633
          33FF663333FF2523B3FF2021B3FF1D1EB3FF181CB3FF1519B3FF1017B3FF0D15
          B3FF0A13B3FF0711B3FF0410B3FF663333FF663333FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        OnClick = tool_f8Click
      end
      object tool_f9: TRzRapidFireButton
        Left = 59
        Top = 0
        Width = 59
        Height = 26
        Hint = 'cancella dall'#39'archivio'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000C30E0000C30E00000000000000000000000000000000
          00000000000000000000000000000000000000008342000086CE0000845F0000
          000000000000000000000000000000007509000083B0000081F8000000004B1E
          1EFF4B1E1EFF757575FF737373FF999999FF06078BFF000CBBFF03038AFF7E7E
          B8FF828282FF5F3535FF95787EFF1F1E98FF000392F600028FF54B1E1EFFC14F
          00FFBC4A00FFF8F8F8FFB14100FFC16B2DFF2D2FA6FF030BAAFF0012D3FF0304
          89FF9E9ECFFFCCA390FF1F1F97FF030799FF0006A4FF000083EC4B1E1EFFC753
          00FFC24F00FFFEFEFEFFB64500FFB7500AFFE2E2E9FF1C1D9AFF030BA9FF0010
          CEFF030387FF1A1995FF03089EFF0009B2FF000084F10000812D4B1E1EFFCC58
          00FFC75300FFFFFFFFFFBC4A00FFB64700FFE7E9E7FFE1E1E7FF1C1D9AFF030B
          A9FF000FC9FF030CAFFF000DC1FF030387FF00007F36000000004B1E1EFFD35C
          00FFCB5700FFEABC8CFFFFFFFFFFF7F7F7FFEDEDEDFFE7E7E7FFE0E1EEFF0202
          84FF0010CCFF0016E5FF03048CFF7A77BCFF00000000000000004B1E1EFFD75F
          00FFD15C00FFCC5700FFC75300FFC15000FFC1590CFFCE9163FF202099FF030C
          ABFF0016E1FF000EC2FF010DBCFF07078BFF0000802A000000004B1E1EFFDC65
          00FFD76000FFD15B00FFCC5700FFCB600AFFD3925CFF202099FF030CACFF0019
          EFFF03048CFF111190FF030AA6FF020FC0FF000083ED0000812D4B1E1EFFE269
          00FFFFF6E6FFFEF3DEFFFFEFD8FFFEF0DDFF3032A6FF030CADFF001AF2FF0408
          96FF6D6DBFFFF3E9E2FF1C1B96FF030AA6FF000CBFF5000083D64B1E1EFFE66C
          00FFEAE6E0FFE5E0D7FFE0D9CEFFE6E1D9FF020387FF0016E6FF040798FF5455
          B6FFD8CEBFFFCBBDA7FFC98E65FF1A1B97FF000396F3000084E74B1E1EFFEB70
          00FFFFFAEFFFFFF7E9FFFFF4E2FFFFF3E2FF7574C2FF030387FF4B4CB4FFFFEE
          D5FFFFE2BBFFFEE0B0FFB8510DFF836368FF0000815A000083214B1E1EFFEF74
          00FFEFEDE9FFEAE6E1FFE5E0D9FFE1DAD1FFE2DCD1FFE3DDD3FFDCD4C7FFD0C4
          B2FFC9BBA6FFC4B6A0FFB54500FF522626FF00000000000000004B1E1EFFF377
          00FFFFFCF7FFFFFAF2FFFFF8EBFFFFF6E5FFFFF2DEFFFFEFD5FFFFEBCFFFFEE9
          C7FFFFE6C1FFFFE2B8FFBA4900FF4B1E1EFF00000000000000004B1E1EFFF77A
          00FF9692FEFF8789FCFF7980FBFF6C77FAFF5F6FF7FF5467F6FF4960F4FF4159
          F2FF3854F0FF324EEEFFC04E00FF4B1E1EFF00000000000000004B1E1EFF4B1E
          1EFF13129FFF10119FFF0E0F9FFF0B0D9FFF090C9FFF060A9FFF05099FFF0308
          9FFF02079FFF01069FFF4B1E1EFF4B1E1EFF0000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        OnClick = tool_f9Click
      end
    end
  end
  object pannello_campi: TRzPanel [3]
    Left = 0
    Top = 34
    Width = 393
    Height = 159
    Align = alClient
    BorderOuter = fsNone
    TabOrder = 3
    object tab_control: TRzPageControl
      Left = 0
      Top = 0
      Width = 393
      Height = 159
      Hint = ''
      ActivePage = tab_pagina1
      Align = alClient
      CutCornerSize = 3
      ShowShadow = False
      TabHeight = 18
      TabIndex = 0
      TabOrder = 0
      TabStop = False
      TabStyle = tsCutCorner
      FixedDimension = 18
      object tab_pagina1: TRzTabSheet
        Caption = 'impostazioni magazzino verticale modula'
        object _password_lbl: TRzLabel
          Left = 160
          Top = 45
          Width = 45
          Height = 13
          Caption = 'password'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          ShowAccelChar = False
          Transparent = True
        end
        object _server_lbl: TRzLabel
          Left = 5
          Top = 5
          Width = 29
          Height = 13
          Caption = 'server'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          ShowAccelChar = False
          Transparent = True
        end
        object _username_lbl: TRzLabel
          Left = 5
          Top = 45
          Width = 46
          Height = 13
          Caption = 'username'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          ShowAccelChar = False
          Transparent = True
        end
        object _port_lbl: TRzLabel
          Left = 160
          Top = 5
          Width = 24
          Height = 13
          Caption = 'porta'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          ShowAccelChar = False
          Transparent = True
        end
        object password: trzdbedit_go
          Left = 160
          Top = 60
          Width = 146
          Height = 21
          Margins.Left = 1
          Margins.Top = 1
          DataSource = tabella_ds
          DataField = 'password'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnlyColor = clBtnFace
          ReadOnlyColorOnFocus = True
          TabOrder = 3
        end
        object server: trzdbedit_go
          Left = 5
          Top = 20
          Width = 146
          Height = 21
          Margins.Left = 1
          Margins.Top = 1
          DataSource = tabella_ds
          DataField = 'server'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnlyColor = clBtnFace
          ReadOnlyColorOnFocus = True
          TabOrder = 0
        end
        object username: trzdbedit_go
          Left = 5
          Top = 60
          Width = 146
          Height = 21
          Margins.Left = 1
          Margins.Top = 1
          DataSource = tabella_ds
          DataField = 'username'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnlyColor = clBtnFace
          ReadOnlyColorOnFocus = True
          TabOrder = 2
        end
        object porta: trzdbnumericedit_go
          Left = 160
          Top = 20
          Width = 65
          Height = 21
          Hint = '[Alt+Gi'#249'=apre calcolatrice]'
          DataSource = tabella_ds
          DataField = 'porta'
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnlyColor = clBtnFace
          ReadOnlyColorOnFocus = True
          TabOrder = 1
          AllowBlank = False
          IntegersOnly = False
          DisplayFormat = '#'
        end
      end
    end
  end
  inherited tabella_ds: TMyDataSource
    OnDataChange = tabella_dsDataChange
  end
end
