object fWordList: TfWordList
  Left = 246
  Top = 175
  BorderStyle = bsDialog
  Caption = '#00735^eLearning list wizard^cPr�vodce u�ebn�m seznamem'
  ClientHeight = 399
  ClientWidth = 608
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 360
    Width = 609
    Height = 9
    Shape = bsTopLine
  end
  object Notebook1: TNotebook
    Left = 8
    Top = 7
    Width = 593
    Height = 353
    PageIndex = 1
    TabOrder = 0
    object TPage
      Left = 0
      Top = 0
      Caption = 'Intro'
      object RxLabel3: TRxLabel
        Left = 16
        Top = 4
        Width = 254
        Height = 18
        Caption = '#00736^eWelcome^cV�tejte'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 16
        Top = 40
        Width = 577
        Height = 130
        AutoSize = False
        Caption = 
          '#00737^eWelcome to the word list generation wizard.'#13#10'This wizard' +
          ' can select the proper words for learning. You can check whether' +
          ' you know the selected words and then print the ones you don'#39't k' +
          'now. This method is ideal for learning new words.'#13#10'You can perfo' +
          'rm these three tasks using this wizard:'#13#10'1) Let the wizard selec' +
          't you the words that are suitable for learning or repeating (thi' +
          's process is random but you can alter the criteria)'#13#10'2) Check wh' +
          'ether you know the selected words (words you know are automatica' +
          'lly selected as learned)'#13#10'3) Print or display the words you didn' +
          #39't know'#13#10'Steps 2 and 3 are optional.'#13#10'^cV�tejte v pr�vodci gener' +
          'ov�n�m u�ebn�ho seznamu.'#13#10'Tento pr�vodce v�m pom��e vybrat vhodn' +
          '� slova k nau�en�. M��ete zjistit jestli vybran� slova um�te a p' +
          'ot� vytisknout ta, kter� neum�te. Tato metoda je ide�ln� pro u�e' +
          'n� nov�ch slov��ek.'#13#10'S t�mto pr�vodcem m��ete ud�lat tyto t�i �i' +
          'nnosti:'#13#10'1) Nechat program vybrat slov��ka, kter� jsou vhodn� k ' +
          'nau�en� nebo opakov�n� (tento proces je n�hodn�, ale krit�ria m�' +
          '�ete z'
        Transparent = True
        WordWrap = True
      end
      object Label14: TLabel
        Left = 16
        Top = 176
        Width = 577
        Height = 130
        AutoSize = False
        Transparent = True
        WordWrap = True
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Method'
      object RxLabel4: TRxLabel
        Left = 16
        Top = 4
        Width = 371
        Height = 18
        Caption = '#00738^eWord selection^cV�b�r slov��ek'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 16
        Top = 208
        Width = 313
        Height = 13
        Caption = '#00739^eNumber of selected words:^cPo�et vybran�ch slov��ek:'
      end
      object Label22: TLabel
        Left = 16
        Top = 40
        Width = 609
        Height = 13
        Caption = 
          '#00740^eNumber of words the list will be selected from:^cPo�et s' +
          'lov��ek, ze kter�ch bude vybr�n seznam:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 336
        Top = 40
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label23'
      end
      object RadioGroup1: TRadioGroup
        Left = 16
        Top = 64
        Width = 361
        Height = 57
        Caption = '#00741^eSelect words from^cVybrat slov��ka z'
        ItemIndex = 0
        Items.Strings = (
          '#00742^eDisplayed list^cZobrazen�ho seznamu'
          '#00743^eEntire vocabulary^cCel�ho slovn��ku')
        TabOrder = 0
        OnClick = RadioGroup1Click
      end
      object RadioGroup2: TRadioGroup
        Left = 16
        Top = 128
        Width = 361
        Height = 73
        Caption = '#00744^eSelection method^cMetoda v�b�ru'
        ItemIndex = 0
        Items.Strings = (
          
            '#00745^eSelect some words proper for learning^cVybrat n�jak� slo' +
            'v��ka podle vhodnosti k nau�en�'
          
            '#00746^eSelect some words completely randomly^cVybrat n�jak� slo' +
            'v��ka �pln� n�hodn�'
          '#00747^eSelect all words^cVybrat v�echna slov��ka')
        TabOrder = 1
        OnClick = RadioGroup2Click
      end
      object Edit3: TEdit
        Left = 168
        Top = 208
        Width = 105
        Height = 21
        TabOrder = 2
        Text = '50'
      end
      object Button1: TButton
        Left = 272
        Top = 208
        Width = 105
        Height = 25
        Caption = '#00748^eFit the page^cAkor�t na str�nku'
        TabOrder = 3
        TabStop = False
        OnClick = Button1Click
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 240
        Width = 361
        Height = 17
        Caption = '#00749^eRandomize word order^cPo�ad� slov��ek ur�it n�hodn�'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Purpose'
      object RxLabel5: TRxLabel
        Left = 16
        Top = 4
        Width = 393
        Height = 18
        Caption = '#00750^eSelection criteria^cKrit�ria v�b�ru'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label16: TLabel
        Left = 16
        Top = 40
        Width = 773
        Height = 13
        Caption = 
          '#00751^eSelect which words do you prefer to be in the list and h' +
          'ow strongly you prefer them.^cVyberte, kter� slova up�ednost�uje' +
          'te aby byly v seznamu a jak siln�.'
      end
      object RadioGroup3: TRadioGroup
        Left = 16
        Top = 64
        Width = 561
        Height = 57
        Caption = '#00752^eLearn status^cStav nau�en�'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          '#00753^eNot learned - strongly^cNenau�eno - siln�'
          '#00754^eNot learned - mildly^cNenau�eno - slab�'
          '#00755^eLearned - mildly^cNau�eno - slab�'
          '#00756^eLearned - strongly^cNau�eno - siln�'
          '#00757^eBalance^cVyv�it'
          '#00758^eI don'#39't care^cJe mi to jedno')
        TabOrder = 0
      end
      object RadioGroup4: TRadioGroup
        Left = 16
        Top = 128
        Width = 561
        Height = 57
        Caption = '#00759^eWord added date^cDatum p�id�n� slov��ka'
        Columns = 3
        ItemIndex = 4
        Items.Strings = (
          '#00760^eOld - strongly^cStar� - siln�'
          '#00761^eOld - mildly^cStar� - slab�'
          '#00762^eNew - mildly^cNov� - slab�'
          '#00763^eNew - strongly^cNov� - siln�'
          '#00757^eBalance^cVyv�it'
          '#00758^eI don'#39't care^cJe mi to jedno')
        TabOrder = 1
      end
      object RadioGroup5: TRadioGroup
        Left = 16
        Top = 192
        Width = 561
        Height = 57
        Caption = 
          '#00764^eWord complexity and popularity^cPopularita a slo�itost s' +
          'lov��ka'
        Columns = 3
        ItemIndex = 1
        Items.Strings = (
          '#00765^eSimple - strongly^cJednoduch� - siln�'
          '#00766^eSimple - mildly^cJednoduch� - slab�'
          '#00767^eComplex - mildly^cSlo�it� - slab�'
          '#00768^eComplex - strongly^cSlo�it� - siln�'
          '#00757^eBalance^cVyv�it'
          '#00758^eI don'#39't care^cJe mi to jedno')
        TabOrder = 2
      end
      object RadioGroup6: TRadioGroup
        Left = 16
        Top = 256
        Width = 561
        Height = 57
        Caption = 
          '#00769^eFrequency of inclusions into learning list^cFrekvence za' +
          '�azen� do u�ebn�ho seznamu'
        Columns = 3
        ItemIndex = 1
        Items.Strings = (
          '#00770^eSeldom - strongly^cZ��dka - siln�'
          '#00771^eSeldom - mildly^cZ��dka - slab�'
          '#00772^eOften - mildly^c�asto - slab�'
          '#00773^eOften - strongly^c�asto - siln�'
          '#00757^eBalance^cVyv�it'
          '#00758^eI don'#39't care^cJe mi to jedno')
        TabOrder = 3
      end
      object CheckBox2: TCheckBox
        Left = 16
        Top = 320
        Width = 281
        Height = 17
        Caption = 
          '#00774^ePrefer problematic words^cUp�ednostnit problematick� slo' +
          'va'
        Checked = True
        State = cbChecked
        TabOrder = 4
      end
      object CheckBox3: TCheckBox
        Left = 312
        Top = 320
        Width = 273
        Height = 17
        Caption = 
          '#00775^eChoose only few mastered words^cVybrat jenom n�kolik dob' +
          '�e nau�en�ch slov��ek'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object Button2: TButton
        Left = 344
        Top = 0
        Width = 113
        Height = 25
        Caption = '#00776^eDefault for learning^cV�choz� pro u�en�'
        TabOrder = 6
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 464
        Top = 0
        Width = 121
        Height = 25
        Caption = '#00777^eDefault for repeating^cV�choz� pro opakov�n�'
        TabOrder = 7
        OnClick = Button3Click
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Summary'
      object Label18: TLabel
        Left = 16
        Top = 72
        Width = 279
        Height = 13
        Caption = '#00595^eLearned words:^cNau�en�ch slov��ek:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 16
        Top = 88
        Width = 322
        Height = 13
        Caption = '#00596^eMastered words:^cDob�e nau�en�ch slov��ek:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 16
        Top = 104
        Width = 328
        Height = 13
        Caption = '#00597^eProblematic words:^cProblematick�ch slov��ek:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 16
        Top = 136
        Width = 385
        Height = 13
        Caption = '#00598^eNumber of katakana words:^cPo�et slov��ek v katakan�:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label26: TLabel
        Left = 216
        Top = 72
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label27: TLabel
        Left = 216
        Top = 88
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label27'
      end
      object Label28: TLabel
        Left = 216
        Top = 104
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label28'
      end
      object Label29: TLabel
        Left = 216
        Top = 136
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label29'
      end
      object Label33: TLabel
        Left = 16
        Top = 120
        Width = 307
        Height = 13
        Caption = '#00602^eNon-popular words:^cNepopul�rn� slov��ka:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label35: TLabel
        Left = 216
        Top = 120
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label35'
      end
      object Label42: TLabel
        Left = 16
        Top = 152
        Width = 389
        Height = 13
        Caption = '#00606^eWords with known writing:^cSlov��ka se zn�m�m z�pisem:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label44: TLabel
        Left = 216
        Top = 152
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label29'
      end
      object RxLabel6: TRxLabel
        Left = 16
        Top = 4
        Width = 391
        Height = 18
        Caption = '#00778^eList statistics^cStatistiky seznamu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label17: TLabel
        Left = 16
        Top = 48
        Width = 714
        Height = 13
        Caption = 
          '#00779^eNew learning list was built. It contains these word char' +
          'acteristics.^cByl vytvo�en nov� u�ebn� seznam. Obsahuje tyto cha' +
          'rakteristiky slov��ek:'
      end
      object Label52: TLabel
        Left = 320
        Top = 72
        Width = 40
        Height = 14
        Caption = 'Label52'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsItalic]
        ParentFont = False
      end
      object Button4: TButton
        Left = 16
        Top = 200
        Width = 241
        Height = 25
        Caption = '#00780^eRebuild word list^cVytvo�it seznam znovu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = Button4Click
      end
      object RadioGroup7: TRadioGroup
        Left = 16
        Top = 272
        Width = 561
        Height = 65
        Caption = '#00781^eNext step^cDal�� krok'
        ItemIndex = 0
        Items.Strings = (
          
            '#00782^eCheck whether you know each word in the newly generated ' +
            'list^cZjistit, zda um�te ka�d� slov��ko v nov� vygenerovan�m sez' +
            'namu'
          
            '#00783^eSkip learning test and proceed to printing list^cP�esko�' +
            'it test znalosti a p�ej�t k tisku seznamu')
        TabOrder = 1
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'EvalChoose'
      object RxLabel7: TRxLabel
        Left = 16
        Top = 4
        Width = 588
        Height = 18
        Caption = 
          '#00784^eLearning test settings^cNastaven� testu znalosti slov��e' +
          'k'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RadioGroup8: TRadioGroup
        Left = 16
        Top = 40
        Width = 545
        Height = 265
        Caption = '#00785^eDisplay^cZobrazovat'
        ItemIndex = 6
        Items.Strings = (
          '#00707^ePhonetic^c�ten�'
          '#00632^eWritten^cZ�pis'
          '#00786^eMeaning^cV�znam'
          '#00787^ePhonetic && Written^c�ten� a z�pis'
          '#00788^ePhonetic && Meaning^c�ten� a v�znam'
          '#00789^eWritten && Meaning^cZ�pis a v�znam'
          '#00790^e50% phonetic, 50% written^c50% �ten�, 50% z�pis'
          '#00791^e66% phonetic, 33% written^c66% �ten�, 33% z�pis'
          
            '#00792^e33% phonetic, 33% written, 33% meaning^c33% �ten�, 33% z' +
            '�pis, 33% v�znam'
          
            '#00793^e25% phonetic, 25% written, 50% meaning^c25% �ten�, 25% z' +
            '�pis, 50% v�znam'
          
            '#00794^e50% phonetic, 25% written, 25% meaning^c50% �ten�, 25% z' +
            '�pis, 25% v�znam')
        TabOrder = 0
      end
      object CheckBox6: TCheckBox
        Left = 16
        Top = 320
        Width = 545
        Height = 17
        Caption = 
          '#00876^eDisplay written only if all characters are learned^cZobr' +
          'azit z�pis jen, kdy� jsou v�echny znaky nau�eny'
        TabOrder = 1
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Evaluate'
      object RxLabel8: TRxLabel
        Left = 16
        Top = 4
        Width = 416
        Height = 18
        Caption = '#00795^eLearning test^cTest znalosti slov��ek'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Gauge1: TGauge
        Left = 16
        Top = 40
        Width = 561
        Height = 25
        Progress = 0
      end
      object Label24: TLabel
        Left = 24
        Top = 88
        Width = 160
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '#00060^ePhonetic:^c�ten�:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Shape2: TShape
        Left = 192
        Top = 85
        Width = 381
        Height = 28
        Anchors = [akLeft, akRight, akBottom]
        Brush.Color = clWindow
      end
      object PaintBox1: TPaintBox
        Left = 193
        Top = 86
        Width = 379
        Height = 26
        Anchors = [akLeft, akRight, akBottom]
        Color = clBtnFace
        ParentColor = False
        OnPaint = PaintBox1Paint
      end
      object Shape5: TShape
        Left = 192
        Top = 125
        Width = 381
        Height = 28
        Anchors = [akRight, akBottom]
        Brush.Color = clWindow
      end
      object Label25: TLabel
        Left = 24
        Top = 128
        Width = 152
        Height = 13
        Anchors = [akRight, akBottom]
        Caption = '#00061^eWritten:^cZ�pis:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object PaintBox6: TPaintBox
        Left = 193
        Top = 126
        Width = 379
        Height = 26
        Anchors = [akRight, akBottom]
        Color = clBtnFace
        ParentColor = False
        OnPaint = PaintBox6Paint
      end
      object RxLabel9: TRxLabel
        Left = 438
        Top = 247
        Width = 75
        Height = 18
        Caption = 'Learned'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        Anchors = [akRight, akBottom]
        ParentFont = False
        Transparent = True
      end
      object Label30: TLabel
        Left = 438
        Top = 228
        Width = 142
        Height = 13
        Anchors = [akRight, akBottom]
        Caption = '#00693^eStatus:^cStav:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label31: TLabel
        Left = 24
        Top = 168
        Width = 171
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '#00691^eMeaning:^cV�znam:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label32: TLabel
        Left = 24
        Top = 228
        Width = 182
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '#00694^eCreated:^cVytvo�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label34: TLabel
        Left = 336
        Top = 228
        Width = 236
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '#00695^eLearning list:^cU�ebn� seznam:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label36: TLabel
        Left = 128
        Top = 228
        Width = 177
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '#00696^eLearned:^cNau�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label37: TLabel
        Left = 224
        Top = 228
        Width = 220
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '#00697^eMastered:^cDob�e nau�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label38: TLabel
        Left = 24
        Top = 249
        Width = 48
        Height = 16
        Anchors = [akLeft, akBottom]
        Caption = 'Label15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label39: TLabel
        Left = 128
        Top = 249
        Width = 48
        Height = 16
        Anchors = [akLeft, akBottom]
        Caption = 'Label15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label40: TLabel
        Left = 224
        Top = 249
        Width = 48
        Height = 16
        Anchors = [akLeft, akBottom]
        Caption = 'Label15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Label41: TLabel
        Left = 336
        Top = 249
        Width = 48
        Height = 16
        Anchors = [akLeft, akBottom]
        Caption = 'Label15'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Transparent = True
      end
      object Shape1: TShape
        Left = 192
        Top = 165
        Width = 381
        Height = 28
        Anchors = [akRight, akBottom]
        Brush.Color = clWindow
      end
      object PaintBox2: TPaintBox
        Left = 193
        Top = 166
        Width = 379
        Height = 26
        Anchors = [akRight, akBottom]
        Color = clBtnFace
        ParentColor = False
        OnPaint = PaintBox2Paint
      end
      object Label54: TLabel
        Left = 24
        Top = 200
        Width = 194
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = '#00733^cKategorie:^eCategories:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label55: TLabel
        Left = 192
        Top = 200
        Width = 38
        Height = 13
        Caption = 'Label55'
      end
      object GroupBox2: TGroupBox
        Left = 24
        Top = 272
        Width = 553
        Height = 73
        Anchors = [akLeft, akBottom]
        Caption = '#00796^eTest controls^cOvl�d�n� testu'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 0
        object RxLabel10: TRxLabel
          Left = 184
          Top = 48
          Width = 55
          Height = 13
          Caption = 'Learned'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Anchors = [akRight, akBottom]
          ParentFont = False
          Transparent = True
        end
        object Label43: TLabel
          Left = 8
          Top = 24
          Width = 223
          Height = 13
          Caption = '#00797^eTest result:^cV�sledek testu:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label45: TLabel
          Left = 8
          Top = 48
          Width = 341
          Height = 13
          Caption = '#00798^eState will be changed to:^cStav bude zm�n�n na:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RxLabel11: TRxLabel
          Left = 312
          Top = 48
          Width = 55
          Height = 13
          Caption = 'Learned'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Anchors = [akRight, akBottom]
          ParentFont = False
          Transparent = True
        end
        object RxLabel12: TRxLabel
          Left = 432
          Top = 48
          Width = 55
          Height = 13
          Caption = 'Learned'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Anchors = [akRight, akBottom]
          ParentFont = False
          Transparent = True
        end
        object Button7: TButton
          Left = 184
          Top = 16
          Width = 113
          Height = 25
          Caption = '#00799^e(&Z) Unknown^c(&Z) Nezn�m�'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = Button7Click
        end
        object Button8: TButton
          Tag = 1
          Left = 312
          Top = 16
          Width = 106
          Height = 25
          Caption = '#00800^e(&X) Known^c(&X) Zn�m�'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = Button7Click
        end
        object Button9: TButton
          Tag = 2
          Left = 432
          Top = 16
          Width = 107
          Height = 25
          Caption = '#00801^e(&C) Well known^c(&C) Dob�e zn�m�'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = Button7Click
        end
        object Button10: TButton
          Left = 104
          Top = 32
          Width = 337
          Height = 25
          Caption = '#00802^e(SPACE) Show word^c(SPACE) Zobrazit slovo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = Button10Click
        end
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'EvalResults'
      object RxLabel1: TRxLabel
        Left = 16
        Top = 4
        Width = 568
        Height = 18
        Caption = '#00803^eLearning test results^cV�sledky testu znalosti slov��ek'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 16
        Top = 48
        Width = 209
        Height = 13
        Caption = '#00804^eNo change:^cBeze zm�ny:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 16
        Top = 80
        Width = 361
        Height = 13
        Caption = '#00805^eLearned -> Problematic:^cNau�eno -> Problematick�:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 16
        Top = 96
        Width = 404
        Height = 13
        Caption = 
          '#00806^eMastered -> Problematic:^cDob�e nau�eno -> Problematick�' +
          ':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 16
        Top = 112
        Width = 381
        Height = 13
        Caption = '#00807^eMastered -> Unlearned:^cDob�e nau�eno -> Nenau�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 16
        Top = 136
        Width = 387
        Height = 13
        Caption = '#00808^eProblematic -> Unlearned:^cProblematick� -> Nenau�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 16
        Top = 152
        Width = 361
        Height = 13
        Caption = '#00809^eProblematic -> Learned:^cProblematick� -> Nau�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 16
        Top = 168
        Width = 338
        Height = 13
        Caption = '#00810^eUnlearned -> Learned:^cNenau�eno -> Nau�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 16
        Top = 192
        Width = 381
        Height = 13
        Caption = '#00811^eUnlearned -> Mastered:^cNenau�eno -> Dob�e nau�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 16
        Top = 208
        Width = 355
        Height = 13
        Caption = '#00812^eLearned -> Mastered:^cNau�eno -> Dob�e nau�eno:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 232
        Top = 80
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label12: TLabel
        Left = 232
        Top = 96
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label13: TLabel
        Left = 232
        Top = 112
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label46: TLabel
        Left = 232
        Top = 136
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label47: TLabel
        Left = 232
        Top = 152
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label48: TLabel
        Left = 232
        Top = 168
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label49: TLabel
        Left = 232
        Top = 192
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label50: TLabel
        Left = 232
        Top = 208
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object Label53: TLabel
        Left = 232
        Top = 48
        Width = 38
        Height = 13
        Alignment = taRightJustify
        Caption = 'Label26'
      end
      object RadioGroup9: TRadioGroup
        Left = 24
        Top = 280
        Width = 545
        Height = 57
        Caption = '#00813^eNext action^cDal�� akce'
        ItemIndex = 0
        Items.Strings = (
          
            '#00814^eUpdate word states by test results and proceed to next p' +
            'hase^cAktualizovat stav slov��ek podle v�sledk� testu a pokra�ov' +
            'at dal�� f�z�'
          
            '#00815^eForget test results and proceed to next phase^cZapomenou' +
            't v�sledky testu a pokra�ovat dal�� f�z�')
        TabOrder = 0
      end
    end
    object TPage
      Left = 0
      Top = 0
      Caption = 'Final'
      object RxLabel2: TRxLabel
        Left = 16
        Top = 4
        Width = 656
        Height = 18
        Caption = 
          '#00816^eDisplay / print learning list^cTisk / zobrazen� u�ebn�ho' +
          ' seznamu'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label51: TLabel
        Left = 40
        Top = 200
        Width = 216
        Height = 13
        Caption = '#00817^eCategory name:^cN�zev kategorie:'
        Enabled = False
      end
      object CheckBox4: TCheckBox
        Left = 16
        Top = 232
        Width = 385
        Height = 17
        Caption = 
          '#00818^eUpdate learning list statistics of each word^cAktualizov' +
          'at statistiku u�ebn�ho seznamu u ka�d�ho slov��ka'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object RadioGroup10: TRadioGroup
        Left = 16
        Top = 40
        Width = 561
        Height = 81
        Caption = '#00819^eRemove from learning list^cZ u�ebn�ho seznamu vy�adit'
        ItemIndex = 1
        Items.Strings = (
          '#00820^eNothing^cNic'
          '#00821^eAll mastered words^cV�echna dob�e nau�en� slov��ka'
          '#00822^eAll learned words^cV�echna nau�en� slov��ka')
        TabOrder = 1
      end
      object Button5: TButton
        Left = 16
        Top = 136
        Width = 561
        Height = 25
        Caption = '#00823^ePrint learning list^cVytisknout u�ebn� seznam'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = Button5Click
      end
      object CheckBox5: TCheckBox
        Left = 16
        Top = 176
        Width = 489
        Height = 17
        Caption = 
          '#00824^eSave learning list as new category and display it^cUlo�i' +
          't u�ebn� seznam jako novou kategorii a zobrazit ho'
        TabOrder = 3
        OnClick = CheckBox5Click
      end
      object Edit1: TEdit
        Left = 168
        Top = 200
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 4
        Text = 'Edit1'
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 504
    Top = 368
    Width = 99
    Height = 25
    Cancel = True
    Caption = '#00007^eCancel^cZru�it'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 266
    Top = 368
    Width = 107
    Height = 25
    Caption = '#00825^eContinue^cPokra�ovat'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BitBtn2Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333FF3333333333333003333
      3333333333773FF3333333333309003333333333337F773FF333333333099900
      33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
      99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
      33333333337F3F77333333333309003333333333337F77333333333333003333
      3333333333773333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn3: TBitBtn
    Left = 160
    Top = 368
    Width = 105
    Height = 25
    Caption = '#00826^eBack^cZp�t'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BitBtn3Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333FF3333333333333003333333333333F77F33333333333009033
      333333333F7737F333333333009990333333333F773337FFFFFF330099999000
      00003F773333377777770099999999999990773FF33333FFFFF7330099999000
      000033773FF33777777733330099903333333333773FF7F33333333333009033
      33333333337737F3333333333333003333333333333377333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object BitBtn4: TBitBtn
    Left = 384
    Top = 368
    Width = 113
    Height = 25
    Caption = '#00827^eFinish^cDokon�it'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BitBtn2Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
end
