object fLayout: TfLayout
  Left = 318
  Top = 357
  Width = 407
  Height = 338
  Caption = '#00200^eLayout manager^cMana�er rozvr�en� obrazovky'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 207
    Height = 13
    Caption = '#00201^cStandardn� rozvr�en�:^eStandard layouts:'
  end
  object Label2: TLabel
    Left = 8
    Top = 160
    Width = 334
    Height = 13
    Caption = 
      '#00202^ePercentage screen occupation:^cProcentu�ln� obsazen� obrazovky'+
      ':'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 385
    Height = 129
    ItemHeight = 13
    Items.Strings = (
      '#00203^eWindowed^cOkenn�'
      '#00204^eComplete^c�pln�'
      '#00205^eKanji search^cHled�n� znak�'
      '#00206^eLearning^cU�ebn�'
      '#00207^eTranslation^cP�ekl�d�n�'
      'Editor')
    TabOrder = 0
  end
  object TrackBar1: TTrackBar
    Left = 208
    Top = 160
    Width = 185
    Height = 33
    Max = 100
    Orientation = trHorizontal
    PageSize = 20
    Frequency = 10
    Position = 100
    SelEnd = 0
    SelStart = 0
    TabOrder = 1
    TickMarks = tmBottomRight
    TickStyle = tsAuto
  end
  object Button1: TButton
    Left = 16
    Top = 200
    Width = 369
    Height = 25
    Caption = '#00208^eSet standard layout^cNastavit standardn� rozvr�en�'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 16
    Top = 232
    Width = 369
    Height = 25
    Caption = '#00209^eSave layout^cUlo�it rozvr�en�'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 16
    Top = 264
    Width = 369
    Height = 25
    Caption = '#00210^eLoad layout^cNahr�t rozvr�en�'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button3Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'WaKan Layout Files (*.lay)|*.lay'
    Left = 200
    Top = 48
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.lay'
    Filter = 'WaKan Layout Files (*.lay)|*.lay'
    Left = 240
    Top = 48
  end
end
