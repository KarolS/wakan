object fWordsExpChoose: TfWordsExpChoose
  Left = 374
  Top = 278
  BorderStyle = bsDialog
  Caption = '#00908^eVocabulary export^cExport slov��ek'
  ClientHeight = 119
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 345
    Height = 73
    Caption = 
      '#00909^eChoose which information include^cZvolte, kter� informace zahr'+
      'nout'
    ItemIndex = 0
    Items.Strings = (
      '#00910^eCategory & learned state^cKategorii a stav nau�en�'
      '#00911^eCategory only^cPouze kategorii'
      
        '#00912^eNeither category nor learned state^cAni kategorii ani stav nau'+
        '�en�')
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 32
    Top = 88
    Width = 75
    Height = 25
    TabOrder = 1
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 240
    Top = 88
    Width = 91
    Height = 25
    Caption = '#00913^eCancel^cZru�it'
    TabOrder = 2
    Kind = bkCancel
  end
end
