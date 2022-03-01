inherited GO1GESORDVCL: TGO1GESORDVCL
  Caption = 'GO1GESORDVCL'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pannello_campi: TRzPanel
    inherited tab_control: TRzPageControl
      FixedDimension = 18
      inherited tab_pagina1: TRzTabSheet
        object _quantita_da_inviare_lbl: TRzLabel [2]
          Left = 281
          Top = 6
          Width = 87
          Height = 13
          Caption = 'quantita da inviare'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          ShowAccelChar = False
          Transparent = True
        end
        object _go1_modula_sospeso_lbl: TRzLabel [3]
          Left = 391
          Top = 6
          Width = 76
          Height = 13
          Caption = 'modula sospeso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          ShowAccelChar = False
          Transparent = True
        end
        object _quantita_residua: TRzLabel [4]
          Left = 175
          Top = 6
          Width = 75
          Height = 13
          Caption = 'quantita residua'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = []
          ParentFont = False
          ShowAccelChar = False
          Transparent = True
        end
        object quantita_da_inviare: trzdbnumericedit_go
          Left = 281
          Top = 21
          Width = 101
          Height = 21
          Hint = 'quantit'#224' approntata [Alt+Gi'#249' per aprire la calcolatrice]'
          Margins.Left = 1
          Margins.Top = 1
          DataSource = query_codice_ds
          DataField = 'quantita_da_inviare'
          ReadOnly = True
          Alignment = taLeftJustify
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnlyColor = clBtnFace
          ReadOnlyColorOnFocus = True
          TabOrder = 2
          AllowBlank = False
          IntegersOnly = False
          DisplayFormat = ',0.00;-,0.00;#'
          decimalplaces = 4
        end
        object go1_modula_sospeso: trzdbcombobox_go
          Left = 389
          Top = 20
          Width = 81
          Height = 21
          DataField = 'go1_modula_sospeso'
          DataSource = query_codice_ds
          Style = csDropDownList
          FlatButtons = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnlyColor = clBtnFace
          ReadOnlyColorOnFocus = True
          TabOrder = 3
          OnExit = go1_modula_sospesoExit
          Items.Strings = (
            'si'
            'no')
          Values.Strings = (
            'si'
            'no')
        end
        object quantita_residua: trzdbnumericedit_go
          Left = 175
          Top = 21
          Width = 101
          Height = 21
          Hint = 'quantit'#224' residua'
          Margins.Left = 1
          Margins.Top = 1
          DataSource = query_codice_ds
          DataField = 'quantita_residua'
          ReadOnly = True
          Alignment = taLeftJustify
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Microsoft Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnlyColor = clBtnFace
          ReadOnlyColorOnFocus = True
          TabOrder = 4
          AllowBlank = False
          IntegersOnly = False
          DisplayFormat = ',0.00;-,0.00;#'
          decimalplaces = 4
        end
      end
    end
  end
  inherited pannello_codice: TRzPanel
    inherited v_griglia: trzdbgrid_go
      Columns = <
        item
          Expanded = False
          FieldName = 'numero_documento'
          Title.Alignment = taRightJustify
          Title.Caption = 'ordine'
          Title.Color = clYellow
          Width = 67
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'riga'
          Title.Alignment = taRightJustify
          Title.Color = clYellow
          Width = 28
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'serie_documento'
          Title.Caption = 'serie'
          Title.Color = clYellow
          Width = 55
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'data_documento'
          Title.Alignment = taCenter
          Title.Caption = 'data'
          Title.Color = clYellow
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'art_codice'
          Title.Caption = 'articolo'
          Title.Color = clYellow
          Width = 97
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ovr_descrizione'
          Title.Caption = 'descrizione'
          Title.Color = clYellow
          Width = 340
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tma_codice'
          Title.Caption = 'deposito'
          Title.Color = clYellow
          Width = 47
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'data_consegna'
          Title.Alignment = taCenter
          Title.Caption = 'consegna'
          Title.Color = clYellow
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tum_codice'
          Title.Caption = 'u.m.'
          Title.Color = clYellow
          Width = 39
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantita'
          Title.Color = clYellow
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantita_residua'
          Title.Caption = 'quantita residua'
          Title.Color = clYellow
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'numero_colli'
          Title.Alignment = taRightJustify
          Title.Caption = 'colli'
          Title.Color = clYellow
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'numero_confezioni'
          Title.Alignment = taRightJustify
          Title.Caption = 'confezioni'
          Title.Color = clYellow
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'indirizzo'
          Title.Caption = 'filiale'
          Title.Color = clYellow
          Width = 66
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'riferimento'
          Title.Color = clYellow
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantita_collo'
          Title.Caption = 'quantita collo'
          Title.Color = clYellow
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantita_da_inviare'
          Title.Caption = 'quantita da inviare'
          Title.Color = clYellow
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'quantita_inviata'
          Title.Caption = 'quantita inviata'
          Title.Color = clYellow
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'go1_modula_sospeso'
          Title.Caption = 'modula sospeso'
          Title.Color = clYellow
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'cms_codice'
          Title.Caption = 'commessa'
          Title.Color = clYellow
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'tipologia'
          Title.Caption = 'sottocommessa'
          Title.Color = clYellow
          Width = 100
          Visible = True
        end>
    end
  end
  inherited pannello_bottoni_nuovi: TRzPanel
    inherited tab_pannello_bottoni_nuovi: TRzPageControl
      FixedDimension = 19
      inherited tab_pannello_bottoni_nuovi_base: TRzTabSheet
        object invia_missioni_btn: TRzRapidFireButton
          Left = 0
          Top = 67
          Width = 101
          Height = 26
          Hint = 'cruscotto articolo [F6]'
          Caption = 'invia missioni'
          Enabled = False
          OnClick = invia_missioni_btnClick
        end
      end
      inherited tab_pannello_bottoni_nuovi_extra: TRzTabSheet
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
end
