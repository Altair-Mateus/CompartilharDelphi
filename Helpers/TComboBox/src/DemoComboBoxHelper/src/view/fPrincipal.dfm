object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Exemplo de uso ComboBox Helper'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Position = poMainFormCenter
  OnShow = FormShow
  TextHeight = 16
  object pnlContainer: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object pnlTitulo: TPanel
      Left = 0
      Top = 0
      Width = 624
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Exemplo de uso Helper TComboBox'
      Color = 1184274
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14737632
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object pnlInferior: TPanel
      Left = 0
      Top = 400
      Width = 624
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Color = 1184274
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 14737632
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object lblDev: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 10
        Width = 282
        Height = 21
        Margins.Left = 5
        Margins.Top = 10
        Margins.Right = 5
        Margins.Bottom = 10
        Align = alLeft
        Caption = 'Desenvolvido por Altair Mateus Toledo Alencastro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14737632
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ExplicitHeight = 16
      end
      object btnGithub: TButton
        AlignWithMargins = True
        Left = 546
        Top = 3
        Width = 75
        Height = 35
        Align = alRight
        Caption = 'Github'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14737632
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnGithubClick
      end
      object btnLinkedin: TButton
        AlignWithMargins = True
        Left = 465
        Top = 3
        Width = 75
        Height = 35
        Align = alRight
        Caption = 'Linkedin'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14737632
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnLinkedinClick
      end
    end
    object pnlCombos: TPanel
      Left = 0
      Top = 41
      Width = 624
      Height = 359
      Align = alClient
      BevelOuter = bvNone
      Color = 1973790
      ParentBackground = False
      TabOrder = 2
      object lblCbxSemEfeitos: TLabel
        Left = 102
        Top = 48
        Width = 142
        Height = 18
        Caption = 'Combo Sem Efeitos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14737632
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object lblCbxComEfeitos: TLabel
        Left = 326
        Top = 48
        Width = 143
        Height = 18
        Caption = 'Combo Com Efeitos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 14737632
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object cbxSemEfeito: TComboBox
        Left = 102
        Top = 78
        Width = 185
        Height = 26
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Items.Strings = (
          'Op'#231#227'o 1'
          'Op'#231#227'o com texto mais longo'
          'Uma op'#231#227'o absurdamente longa s'#243' pra testar o ajuste autom'#225'tico'
          'Curta'
          'Op'#231#227'o intermedi'#225'ria')
      end
      object cbxComEfeitos: TComboBox
        Left = 326
        Top = 78
        Width = 185
        Height = 26
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnDropDown = cbxComEfeitosDropDown
        OnMouseEnter = cbxComEfeitosMouseEnter
      end
      object btnAlimentar: TButton
        Left = 326
        Top = 128
        Width = 75
        Height = 25
        Caption = 'Alimentar'
        TabOrder = 2
        OnClick = btnAlimentarClick
      end
      object btnLimpar: TButton
        Left = 436
        Top = 128
        Width = 75
        Height = 25
        Caption = 'Limpar'
        TabOrder = 3
        OnClick = btnLimparClick
      end
      object Button1: TButton
        Left = 326
        Top = 168
        Width = 185
        Height = 25
        Caption = 'Alimenta com Default'
        TabOrder = 4
        OnClick = Button1Click
      end
    end
  end
end
