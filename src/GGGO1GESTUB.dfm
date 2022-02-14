inherited GO1GESTUB: TGO1GESTUB
  Caption = 'GO1GESTUB'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pannello_campi: TRzPanel
    inherited tab_control: TRzPageControl
      FixedDimension = 18
      inherited tab_pagina1: TRzTabSheet
        object go1_modula: TRzDBCheckBox
          Left = 115
          Top = 10
          Width = 149
          Height = 15
          Hint = 
            'spunta per indicare per l'#39'articolo a cui '#232' assegnata l'#39'ubicazion' +
            'e non gestisce l'#39'ubicazione multipla'
          DataField = 'GO1_modula'
          DataSource = tabella_ds
          ValueChecked = 'si'
          ValueUnchecked = 'no'
          Caption = 'gestione magazzino modula'
          TabOrder = 3
        end
      end
    end
  end
  inherited pannello_bottoni_nuovi: TRzPanel
    inherited tab_pannello_bottoni_nuovi: TRzPageControl
      FixedDimension = 19
    end
  end
end
