object fSettings: TfSettings
  Left = 451
  Top = 131
  BorderStyle = bsDialog
  Caption = '#00397^eSettings^cNastaven�'
  ClientHeight = 558
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  ShowHint = True
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 479
    Height = 508
    ActivePage = TabSheet10
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 0
    object TabSheet8: TTabSheet
      Caption = '#00398^eGeneral^cObecn�'
      ImageIndex = 7
      object Label41: TLabel
        Left = 16
        Top = 224
        Width = 376
        Height = 13
        Caption = 
          '#00399^eDictionary entries grid font height:^cVelikost p�sma v m' +
          '��ce slovn�ku:'
      end
      object Label47: TLabel
        Left = 288
        Top = 336
        Width = 122
        Height = 13
        Caption = '#00400^eminutes^cminut'
      end
      object CheckBox26: TCheckBox
        Left = 16
        Top = 128
        Width = 401
        Height = 17
        Hint = 
          '#00401^eSaves statistical information to disk, filename is gener' +
          'ated by date so you can check your progress^cUlo�� na disk �daje' +
          ' o statistice podle aktu�ln�ho data tak�e m��ete sledovat v�voj ' +
          'statistiky'
        Caption = 
          '#00402^eSave statistics to disk (folder STAT)^cUkl�dat statistik' +
          'u na disk (slo�ka STAT)'
        TabOrder = 0
      end
      object CheckBox10: TCheckBox
        Left = 16
        Top = 152
        Width = 433
        Height = 17
        Hint = 
          '#00403^eShows words with non-learned kanji in different color^cZ' +
          'obrazuje slova s nenau�en�mi znaky odli�nou barvou'
        Caption = 
          '#00404^eDifferentiate words with non-learned characters^cOdli�ov' +
          'at slova s nenau�en�mi znaky'
        TabOrder = 1
      end
      object CheckBox11: TCheckBox
        Left = 16
        Top = 200
        Width = 433
        Height = 17
        Hint = 
          '#00405^eColors: green - mastered, yellow - learned, cyan - unlea' +
          'rned, red - problematic^cBarvy: zelen� - dob�e nau�eno, �lut� - ' +
          'nau�eno, modr� - nenau�eno, �erven� - problematick�'
        Caption = 
          '#00406^eShow word learned-status by different background color^c' +
          'Zobrazit nau�enost slov pomoc� r�zn�ch barev pozad�'
        TabOrder = 2
      end
      object CheckBox46: TCheckBox
        Left = 16
        Top = 312
        Width = 433
        Height = 17
        Hint = 
          '#00405^eColors: green - mastered, yellow - learned, cyan - unlea' +
          'rned, red - problematic^cBarvy: zelen� - dob�e nau�eno, �lut� - ' +
          'nau�eno, modr� - nenau�eno, �erven� - problematick�'
        Caption = 
          '#00407^eAuto-save user data on exit^cP�i ukon�en� automaticky ul' +
          'o�it u�ivatelsk� data'
        TabOrder = 3
      end
      object Edit25: TEdit
        Left = 232
        Top = 224
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'Edit25'
      end
      object CheckBox49: TCheckBox
        Left = 16
        Top = 248
        Width = 417
        Height = 17
        Caption = 
          '#00408^eLoad dictionaries on demand^cNahr�vat slovn�ky pouze p�i' +
          ' ��dosti'
        TabOrder = 5
      end
      object CheckBox53: TCheckBox
        Left = 16
        Top = 272
        Width = 353
        Height = 17
        Caption = '#00409^eMulti-line word grids^cV�ce ��dkov� m��ky slov'
        TabOrder = 6
      end
      object CheckBox54: TCheckBox
        Left = 16
        Top = 336
        Width = 193
        Height = 17
        Caption = 
          '#00410^eAuto-save user database every ^cAutomaticky ulo�it u�iv.' +
          ' datab�zi ka�d�ch'
        TabOrder = 7
      end
      object Edit29: TEdit
        Left = 216
        Top = 336
        Width = 65
        Height = 21
        TabOrder = 8
        Text = 'Edit29'
      end
      object CheckBox55: TCheckBox
        Left = 16
        Top = 360
        Width = 417
        Height = 17
        Caption = 
          '#00411^eMake backup of user file into BACKUP folder every day^cU' +
          'd�lat z�lohu u�ivatelsk�ho souboru do BACKUP adres��e ka�d� den'
        TabOrder = 9
      end
      object RadioGroup5: TRadioGroup
        Left = 16
        Top = 12
        Width = 353
        Height = 85
        Hint = 
          '#00432^eSelects what chinese characters are displayed^cV�b�r typ' +
          'u ��nsk�ch znak�, kter� jsou zobrazeny'
        Caption = 
          '#00883^eChinese character mode && character conversion^cRe�im ��' +
          'nsk�ch znak� a konverze'
        ItemIndex = 0
        Items.Strings = (
          '#00434^eTraditional (Big5) only^cPouze tradi�n� (Big5)'
          '#00435^eSimplified (GB2312) only^cPouze zjednodu�en� (GB2312)'
          '#00436^eAll characters (Unicode)^cV�echny znaky (Unicode)')
        TabOrder = 10
      end
      object CheckBox70: TCheckBox
        Left = 16
        Top = 104
        Width = 417
        Height = 17
        Caption = 
          '^eDisplay message when word is added to vocabulary^cZobrazit zpr' +
          '�vu, kdy� je slov��ko p�id�no do slovn�ku'
        TabOrder = 11
      end
    end
    object TabSheet1: TTabSheet
      Caption = '#00412^eRomanization^cRomanizace'
      object GroupBox6: TGroupBox
        Left = 8
        Top = 8
        Width = 457
        Height = 177
        Caption = '#00413^eRomanization of japanese^cRomanizace japon�tiny'
        TabOrder = 0
        object Shape1: TShape
          Left = 16
          Top = 145
          Width = 226
          Height = 20
          Anchors = [akLeft, akTop, akRight]
          Brush.Color = clBtnFace
        end
        object Label16: TLabel
          Left = 16
          Top = 88
          Width = 274
          Height = 13
          Caption = '#00414^cTest romanizace:^eRomanization test:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape9: TShape
          Left = 16
          Top = 126
          Width = 226
          Height = 20
          Anchors = [akLeft, akTop, akRight]
          Brush.Color = clBtnFace
        end
        object PaintBox3: TPaintBox
          Left = 17
          Top = 127
          Width = 224
          Height = 18
          Anchors = [akLeft, akTop, akRight]
          Color = clBtnFace
          ParentColor = False
          OnPaint = PaintBox3Paint
        end
        object Label17: TLabel
          Left = 248
          Top = 120
          Width = 159
          Height = 13
          Caption = '#00415^eJapanese:^cJaponsk�:'
        end
        object Label18: TLabel
          Left = 248
          Top = 136
          Width = 142
          Height = 13
          Caption = '#00416^eEnglish:^cAnglick�:'
        end
        object Label19: TLabel
          Left = 248
          Top = 152
          Width = 127
          Height = 13
          Caption = '#00417^eCzech:^c�esk�:'
        end
        object Label20: TLabel
          Left = 344
          Top = 120
          Width = 46
          Height = 13
          Caption = 'Label20'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label21: TLabel
          Left = 344
          Top = 136
          Width = 46
          Height = 13
          Caption = 'Label21'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label22: TLabel
          Left = 344
          Top = 152
          Width = 46
          Height = 13
          Caption = 'Label22'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object PaintBox1: TPaintBox
          Left = 17
          Top = 146
          Width = 224
          Height = 18
          Anchors = [akLeft, akTop, akRight]
          Color = clBtnFace
          ParentColor = False
          OnPaint = PaintBox1Paint
        end
        object RadioGroup1: TRadioGroup
          Left = 16
          Top = 20
          Width = 185
          Height = 61
          Hint = 
            '#00418^eSelect romanization system used in both input and displa' +
            'y^cV�b�r romaniza�n�ho syst�mu pro vstup i pro zobrazen�'
          Caption = '#00419^eRomanization system^cRomaniza�n� syst�m'
          ItemIndex = 0
          Items.Strings = (
            
              '#00420^eKunreishiki romaji (japanese)^cKunrei�iki r�mad�i (japon' +
              'sk�)'
            '#00421^eHepburn (english)^cHepburn�v (anglick�)'
            '#00422^eCzech^c�esk�')
          TabOrder = 0
          OnClick = RadioGroup1Click
        end
        object RadioGroup2: TRadioGroup
          Left = 216
          Top = 20
          Width = 225
          Height = 61
          Caption = '#00423^eShow phonetic in^cZobraz fonetick� z�pisy v'
          ItemIndex = 0
          Items.Strings = (
            '#00424^eHiragana / Katakana^cHiragan� / Katakan�'
            '#00425^eRomaji^cR�mad�i')
          TabOrder = 1
          OnClick = RadioGroup1Click
        end
        object Edit15: TEdit
          Left = 16
          Top = 104
          Width = 225
          Height = 21
          TabOrder = 2
          OnChange = Edit15Change
        end
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 192
        Width = 457
        Height = 161
        Caption = '#00426^eRomanization of chinese^cRomanizace ��n�tiny'
        TabOrder = 1
        object Label27: TLabel
          Left = 16
          Top = 88
          Width = 274
          Height = 13
          Caption = '#00414^cTest romanizace:^eRomanization test:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape3: TShape
          Left = 16
          Top = 126
          Width = 226
          Height = 20
          Anchors = [akLeft, akTop, akRight]
          Brush.Color = clBtnFace
        end
        object PaintBox2: TPaintBox
          Left = 17
          Top = 127
          Width = 224
          Height = 18
          Anchors = [akLeft, akTop, akRight]
          Color = clBtnFace
          ParentColor = False
          OnPaint = PaintBox2Paint
        end
        object Label28: TLabel
          Left = 248
          Top = 104
          Width = 33
          Height = 13
          Caption = 'PinYin:'
        end
        object Label29: TLabel
          Left = 248
          Top = 120
          Width = 58
          Height = 13
          Caption = 'Wade-Giles:'
        end
        object Label30: TLabel
          Left = 248
          Top = 136
          Width = 24
          Height = 13
          Caption = 'Yale:'
        end
        object Label31: TLabel
          Left = 344
          Top = 104
          Width = 46
          Height = 13
          Caption = 'Label20'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label32: TLabel
          Left = 344
          Top = 120
          Width = 46
          Height = 13
          Caption = 'Label21'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label33: TLabel
          Left = 344
          Top = 136
          Width = 46
          Height = 13
          Caption = 'Label22'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object RadioGroup6: TRadioGroup
          Left = 16
          Top = 20
          Width = 185
          Height = 61
          Hint = 
            '#00418^eSelect romanization system used in both input and displa' +
            'y^cV�b�r romaniza�n�ho syst�mu pro vstup i pro zobrazen�'
          Caption = '#00419^eRomanization system^cRomaniza�n� syst�m'
          ItemIndex = 0
          Items.Strings = (
            'PinYin'
            'Wade-Giles'
            'Yale')
          TabOrder = 0
          OnClick = RadioGroup1Click
        end
        object RadioGroup7: TRadioGroup
          Left = 216
          Top = 20
          Width = 225
          Height = 61
          Caption = '#00423^eShow phonetic in^cZobraz fonetick� z�pisy v'
          ItemIndex = 0
          Items.Strings = (
            'BoPoMoFo'
            'PinYin / Wade-Giles / Yale')
          TabOrder = 1
          OnClick = RadioGroup1Click
        end
        object Edit20: TEdit
          Left = 16
          Top = 104
          Width = 225
          Height = 21
          TabOrder = 2
          OnChange = Edit20Change
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = '#00298^eCharacter list^cSeznam znak�'
      ImageIndex = 1
      object Label35: TLabel
        Left = 16
        Top = 96
        Width = 231
        Height = 13
        Caption = '#00427^eDisplayed radical:^cZobrazen� radik�l:'
      end
      object Label52: TLabel
        Left = 13
        Top = 192
        Width = 647
        Height = 13
        Caption = 
          '#00920^eHow many most frequent compounds to display in "Freq" mo' +
          'de:^cKolik nejfrekventovan�j��ch slo�enin zobrazit v re�imu "Fre' +
          'q"'
      end
      object RadioGroup3: TRadioGroup
        Left = 16
        Top = 12
        Width = 401
        Height = 77
        Caption = '#00428^cVelikost znaku v m��ce^eCharacter size in grid'
        ItemIndex = 0
        Items.Strings = (
          '#00429^cMal�^eSmall'
          '#00430^cSt�edn�^eMedium'
          '#00431^cVelk�^eLarge')
        TabOrder = 0
      end
      object CheckBox1: TCheckBox
        Left = 16
        Top = 144
        Width = 305
        Height = 17
        Caption = 
          '#00437^eShow stroke count in grid^cZobrazovat po�et tah� v m��c' +
          'e'
        TabOrder = 1
      end
      object ComboBox1: TComboBox
        Left = 16
        Top = 112
        Width = 233
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 2
        Items.Strings = (
          'Bushu'
          'Unicode'
          '#00438^eJapanese^cJaponsk�'
          'KanWa'
          'KangXi'
          '#00439^eKorean^cKorejsk�')
      end
      object CheckBox51: TCheckBox
        Left = 8
        Top = 384
        Width = 433
        Height = 17
        Caption = 
          '#00440^eUse grid font for displaying stroke order^cPou��t font m' +
          '��ky pro zobrazen� po�ad� tah�'
        TabOrder = 3
        Visible = False
      end
      object CheckBox57: TCheckBox
        Left = 16
        Top = 168
        Width = 433
        Height = 17
        Caption = 
          '#00891^eSearch by yomi can ignore okurigana^cHled�n� podle yomi ' +
          'm��e ignorovat okuriganu'
        TabOrder = 4
      end
      object Edit34: TEdit
        Left = 336
        Top = 192
        Width = 121
        Height = 21
        TabOrder = 5
        Text = '0'
      end
    end
    object TabSheet4: TTabSheet
      Caption = '#00217^eDictionary^cSlovn�k'
      ImageIndex = 3
      object Label26: TLabel
        Left = 16
        Top = 280
        Width = 336
        Height = 13
        Caption = 
          '#00441^eNot used dictionary files^cNepou��van� soubory se slovn�' +
          'ky:'
        Visible = False
      end
      object GroupBox3: TGroupBox
        Left = 16
        Top = 16
        Width = 441
        Height = 137
        Caption = '#00442^eSearch results order^cPo�ad� v�sledk� hled�n�'
        TabOrder = 0
        object CheckBox4: TCheckBox
          Left = 8
          Top = 16
          Width = 401
          Height = 17
          Caption = 
            '#00443^ePrefer words in user dictionary^cPreferovat slova v u�iv' +
            'atelsk�m slovn�ku'
          TabOrder = 0
        end
        object CheckBox5: TCheckBox
          Left = 8
          Top = 40
          Width = 401
          Height = 17
          Caption = 
            '#00444^ePrefer nouns and verbs^cPreferovat podstatn� jm�na a slo' +
            'vesa'
          TabOrder = 1
        end
        object CheckBox6: TCheckBox
          Left = 8
          Top = 64
          Width = 385
          Height = 17
          Caption = '#00445^ePrefer polite words^cPreferovat zdvo�il� slova'
          TabOrder = 2
        end
        object CheckBox7: TCheckBox
          Left = 8
          Top = 88
          Width = 377
          Height = 17
          Caption = 
            '#00446^ePrefer popular words (marked by "pop")^cPreferovat popul' +
            '�rn� slova (ozna�ena "pop")'
          TabOrder = 3
        end
        object CheckBox59: TCheckBox
          Left = 8
          Top = 112
          Width = 417
          Height = 17
          Caption = 
            '#00921^eOrder by word frequency (where available)^cT��dit podle ' +
            'frekvence slov (kdy� je k dispozici)'
          TabOrder = 4
        end
      end
      object CheckBox8: TCheckBox
        Left = 16
        Top = 160
        Width = 433
        Height = 17
        Caption = 
          '#00447^eReplace kanji with kana for words marked "kana"^cNahradi' +
          't kanji pomoc� kany u slov ozna�en�ch "kana"'
        TabOrder = 1
      end
      object Edit19: TEdit
        Left = 16
        Top = 296
        Width = 441
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 2
        Text = 'Edit19'
        Visible = False
      end
      object CheckBox12: TCheckBox
        Left = 16
        Top = 184
        Width = 433
        Height = 17
        Caption = 
          '#00448^eDisplay only results that fit one page in "Auto" mode^cZ' +
          'obrazit jen v�sledky, kter� se vejdou na str�nku v "Auto" re�imu'
        TabOrder = 3
      end
      object CheckBox50: TCheckBox
        Left = 16
        Top = 208
        Width = 433
        Height = 17
        Caption = 
          '#00449^eAuto-switch to Examples panel^cAutomaticky p�epnout na p' +
          'anel P��klady'
        TabOrder = 4
      end
      object CheckBox58: TCheckBox
        Left = 16
        Top = 232
        Width = 441
        Height = 17
        Caption = 
          '#00922^eDisplay word count for each word^cZobrazovat frekven�n� ' +
          'po�et u ka�d�ho slova'
        TabOrder = 5
      end
    end
    object TabSheet3: TTabSheet
      Caption = '#00450^eFonts^cFonty'
      ImageIndex = 2
      object Label4: TLabel
        Left = 8
        Top = 367
        Width = 229
        Height = 13
        Caption = '#00923^eEnglish font:^cFont pro anglick� texty:'
      end
      object SpeedButton4: TSpeedButton
        Left = 376
        Top = 367
        Width = 73
        Height = 23
        Caption = '#00452^eChoose^cVybrat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton4Click
      end
      object Label5: TLabel
        Left = 8
        Top = 341
        Width = 257
        Height = 13
        Caption = '#00456^eFont for small text:^cFont pro drobn� n�pisy:'
      end
      object SpeedButton5: TSpeedButton
        Left = 376
        Top = 341
        Width = 73
        Height = 23
        Caption = '#00452^eChoose^cVybrat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton5Click
      end
      object Label51: TLabel
        Left = 8
        Top = 395
        Width = 319
        Height = 13
        Caption = '#00924^eRomanization && PinYin font:^cRomaniza�n� a PinYin font:'
      end
      object SpeedButton14: TSpeedButton
        Left = 376
        Top = 393
        Width = 73
        Height = 23
        Caption = '#00452^eChoose^cVybrat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton14Click
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 40
        Width = 457
        Height = 108
        Caption = '#00453^eJapanese fonts^cJaponsk� fonty'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 301
          Height = 13
          Caption = '#00454^eFont for characters in grid:^cFont pro znaky v m��ce:'
        end
        object SpeedButton1: TSpeedButton
          Left = 368
          Top = 24
          Width = 73
          Height = 23
          Caption = '#00452^eChoose^cVybrat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton1Click
        end
        object Label2: TLabel
          Left = 8
          Top = 51
          Width = 272
          Height = 13
          Caption = '#00455^eFont for big characters:^cFont pro velk� znaky:'
        end
        object SpeedButton2: TSpeedButton
          Left = 368
          Top = 51
          Width = 73
          Height = 23
          Caption = '#00452^eChoose^cVybrat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton2Click
        end
        object Label50: TLabel
          Left = 8
          Top = 78
          Width = 327
          Height = 13
          Caption = 
            '#00875^eStroke order display font:^cFont pro zobrazen� po�ad� ta' +
            'h�:'
        end
        object SpeedButton13: TSpeedButton
          Left = 368
          Top = 78
          Width = 73
          Height = 23
          Caption = '#00452^eChoose^cVybrat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton13Click
        end
        object Edit1: TEdit
          Left = 240
          Top = 24
          Width = 129
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
          Text = 'MS Mincho'
        end
        object Edit2: TEdit
          Left = 240
          Top = 51
          Width = 129
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 1
          Text = 'MS Mincho'
        end
        object Edit32: TEdit
          Left = 240
          Top = 78
          Width = 129
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 2
          Text = 'MS Gothic'
        end
      end
      object Edit4: TEdit
        Left = 248
        Top = 367
        Width = 129
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 1
        Text = 'Arial'
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 153
        Width = 457
        Height = 178
        Caption = '#00457^eChinese fonts:^c��nsk� fonty:'
        TabOrder = 2
        object Label6: TLabel
          Left = 8
          Top = 24
          Width = 429
          Height = 13
          Caption = 
            '#00458^eBig5 font for traditional characters in grid:^cBig5 font' +
            ' pro tradi�n� znaky v m��ce:'
        end
        object SpeedButton6: TSpeedButton
          Left = 368
          Top = 24
          Width = 73
          Height = 23
          Caption = '#00452^eChoose^cVybrat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton6Click
        end
        object Label7: TLabel
          Left = 8
          Top = 76
          Width = 400
          Height = 13
          Caption = 
            '#00459^eBig5 font for big traditional characters:^cBig5 font pro' +
            ' velk� tradi�n� znaky:'
        end
        object SpeedButton7: TSpeedButton
          Left = 368
          Top = 76
          Width = 73
          Height = 23
          Caption = '#00452^eChoose^cVybrat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton7Click
        end
        object Label8: TLabel
          Left = 8
          Top = 145
          Width = 282
          Height = 13
          Caption = '#00460^eComplete unicode font:^cKompletn� unicode font:'
        end
        object SpeedButton8: TSpeedButton
          Left = 368
          Top = 145
          Width = 73
          Height = 23
          Caption = '#00452^eChoose^cVybrat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton8Click
        end
        object Label3: TLabel
          Left = 8
          Top = 50
          Width = 493
          Height = 13
          Caption = 
            '#00461^eGB2312 font for simplified characters in grid:^cGB2312 f' +
            'ont pro zjednodu�en� znaky v m��ce:'
        end
        object SpeedButton3: TSpeedButton
          Left = 368
          Top = 50
          Width = 73
          Height = 23
          Caption = '#00452^eChoose^cVybrat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton3Click
        end
        object Label9: TLabel
          Left = 8
          Top = 102
          Width = 464
          Height = 13
          Caption = 
            '#00462^eGB2312 font for big simplified characters:^cGB2312 font ' +
            'pro velk� zjednodu�en� znaky:'
        end
        object SpeedButton9: TSpeedButton
          Left = 368
          Top = 102
          Width = 73
          Height = 23
          Caption = '#00452^eChoose^cVybrat'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = SpeedButton9Click
        end
        object Label10: TLabel
          Left = 8
          Top = 126
          Width = 872
          Height = 14
          Caption = 
            '#00463^eMake sure that the Big5 and GB2312 fonts are either the ' +
            'same or at least look the same.^cUjist�te se, �e oba Big5 a GB23' +
            '12 fonty jsou bu� stejn� nebo stejn� vypadaj�.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          ParentFont = False
        end
        object Edit6: TEdit
          Left = 240
          Top = 24
          Width = 129
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 0
          Text = 'MingLiU'
        end
        object Edit7: TEdit
          Left = 240
          Top = 76
          Width = 129
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 1
          Text = 'MingLiU'
        end
        object Edit8: TEdit
          Left = 240
          Top = 145
          Width = 129
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 2
          Text = 'MingLiU'
        end
        object Edit3: TEdit
          Left = 240
          Top = 50
          Width = 129
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 3
          Text = 'SimSun'
        end
        object Edit9: TEdit
          Left = 240
          Top = 102
          Width = 129
          Height = 21
          Color = clBtnFace
          ReadOnly = True
          TabOrder = 4
          Text = 'SimSun'
        end
      end
      object Button5: TButton
        Left = 8
        Top = 8
        Width = 457
        Height = 25
        Caption = '#00464^eSelect recommended fonts^cNastavit doporu�en� fonty'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = Button5Click
      end
      object Edit5: TEdit
        Left = 248
        Top = 341
        Width = 129
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 4
        Text = 'MS Gothic'
      end
      object Edit33: TEdit
        Left = 248
        Top = 393
        Width = 129
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 5
        Text = 'Arial'
      end
    end
    object TabSheet5: TTabSheet
      Caption = '#00465^eWord list printing^cTisk seznamu slov'
      ImageIndex = 4
      object Label11: TLabel
        Left = 16
        Top = 344
        Width = 374
        Height = 13
        Caption = 
          '#00466^cPo�et ��dek na �tvercov� stran�:^eNumber of lines on squ' +
          'are page:'
      end
      object CheckBox14: TCheckBox
        Left = 16
        Top = 296
        Width = 241
        Height = 17
        Caption = '#00467^ePrint horizontal lines^cTisknout horizont�ln� ��ry'
        TabOrder = 0
      end
      object CheckBox15: TCheckBox
        Left = 224
        Top = 296
        Width = 241
        Height = 17
        Caption = '#00468^ePrint vertical lines^cTisknout vertik�ln� ��ry'
        TabOrder = 1
      end
      object CheckBox16: TCheckBox
        Left = 16
        Top = 320
        Width = 241
        Height = 17
        Caption = '#00469^eVary colors^cSt��dat barvy'
        TabOrder = 2
      end
      object CheckBox17: TCheckBox
        Left = 224
        Top = 320
        Width = 313
        Height = 17
        Caption = '#00470^eDo not print unlearned kanji^cNetisknout nenau�en� znaky'
        TabOrder = 3
      end
      object GroupBox4: TGroupBox
        Left = 16
        Top = 8
        Width = 433
        Height = 281
        Caption = '#00471^eColumns^cSloupce'
        TabOrder = 4
        object Label23: TLabel
          Left = 16
          Top = 248
          Width = 233
          Height = 13
          Caption = '#00472^eUser settings:^cU�ivatelsk� nastaven�:'
        end
        object ListBox1: TListBox
          Left = 16
          Top = 24
          Width = 401
          Height = 217
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ItemHeight = 14
          Items.Strings = (
            '#00473^ePhonetic            |Meaning^c�ten�            |V�znam'
            '#00474^eWritten             |Meaning^cZ�pis            |V�znam'
            '#00475^ePhonetic |Written   |Meaning^c�ten�   |Z�pis   |V�znam'
            '#00476^eWritten  |Phonetic  |Meaning^cZ�pis   |�ten�   |V�znam'
            '#00477^eRomaji   |Kana      |Meaning^cRomaji  |Kana    |V�znam'
            '#00478^ePhonetic1           |Phonetic2^c�ten�1           |�ten�2'
            '#00479^eWritten1            |Written2^cZ�pis1           |Z�pis2'
            '#00480^eMeaning1            |Meaning2^cV�znam1          |V�znam2'
            
              '#00481^ePhonetic1|Phonetic2 |Phonetic3|Phonetic4^c�ten�1  |�ten�' +
              '2  |�ten�3  |�ten�4'
            
              '#00482^eWritten1 |Written2  |Written3 |Written4^cZ�pis1  |Z�pis2' +
              '  |Z�pis3  |Z�pis4'
            
              '#00483^eMeaning1 |Meaning2  |Meaning3 |Meaning4^cV�znam1 |V�znam' +
              '2 |V�znam3 |V�znam4'
            
              '#00484^ePhonetic1|Written1  |Phonetic2|Written2^c�ten�1  |Z�pis1' +
              '  |�ten�2  |Z�pis2'
            
              '#00485^ePhonetic1|Meaning1  |Phonetic2|Meaning2^c�ten�1  |V�znam' +
              '1 |�ten�2  |V�znam2'
            
              '#00486^eWritten1 |Meaning1  |Written2 |Meaning2^cZ�pis1  |V�znam' +
              '1 |Z�pis2  |V�znam2'
            '#00487^eUser settings^cU�ivatelsk� nastaven�')
          ParentFont = False
          TabOrder = 0
          OnClick = ListBox1Click
        end
        object Edit16: TEdit
          Left = 144
          Top = 248
          Width = 273
          Height = 21
          TabOrder = 1
          Text = 'Edit16'
        end
      end
      object Edit10: TEdit
        Left = 16
        Top = 360
        Width = 161
        Height = 21
        TabOrder = 5
        Text = 'Edit10'
      end
    end
    object TabSheet6: TTabSheet
      Caption = '#00488^eCharacter cards printing^cTisk karet znak�'
      ImageIndex = 5
      object Label12: TLabel
        Left = 8
        Top = 8
        Width = 486
        Height = 13
        Caption = 
          '#00489^cPo�et znak� na v��ku na �tvercov� stran�:^eVertical numb' +
          'er of characters on square page:'
      end
      object Label13: TLabel
        Left = 8
        Top = 56
        Width = 512
        Height = 13
        Caption = 
          '#00952^cProstor pro slo�eniny ze slov��ek (ve znac�ch):^eSpace f' +
          'or vocabulary compounds (in characters):'
      end
      object Label14: TLabel
        Left = 8
        Top = 104
        Width = 437
        Height = 13
        Caption = 
          '#00953^cPo�et slo�enin ze slov��ek na v��ku:^eVertical number of' +
          ' vocabulary compounds:'
      end
      object Label15: TLabel
        Left = 8
        Top = 152
        Width = 214
        Height = 13
        Caption = '#00492^eCalligraphy font:^cKaligrafick� font:'
      end
      object SpeedButton10: TSpeedButton
        Left = 136
        Top = 168
        Width = 73
        Height = 23
        Caption = '#00452^eChoose^cVybrat'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        OnClick = SpeedButton10Click
      end
      object Label53: TLabel
        Left = 208
        Top = 104
        Width = 293
        Height = 13
        Caption = '#00951^cPo�et pln�ch slo�enin:^eNumber of full compounds:'
      end
      object Edit11: TEdit
        Left = 8
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 0
        Text = 'Edit11'
      end
      object Edit12: TEdit
        Left = 8
        Top = 72
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'Edit12'
      end
      object Edit13: TEdit
        Left = 8
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'Edit13'
      end
      object CheckBox18: TCheckBox
        Left = 8
        Top = 200
        Width = 217
        Height = 17
        Caption = 
          '#00493^ePrint vocabulary compounds^cTisknout slo�eniny ze slov��' +
          'ek'
        TabOrder = 3
      end
      object CheckBox19: TCheckBox
        Left = 232
        Top = 224
        Width = 209
        Height = 17
        Caption = '#00494^ePrint radical^cTisknout radik�l'
        TabOrder = 4
      end
      object CheckBox20: TCheckBox
        Left = 232
        Top = 248
        Width = 225
        Height = 17
        Caption = '#00495^ePrint alternate form^cTisknout alternativn� formu'
        TabOrder = 5
      end
      object CheckBox21: TCheckBox
        Left = 8
        Top = 272
        Width = 257
        Height = 17
        Caption = '#00496^ePrint outer lines^cTisknout vn�j�� ��ry'
        TabOrder = 6
      end
      object CheckBox22: TCheckBox
        Left = 8
        Top = 224
        Width = 209
        Height = 17
        Caption = '#00497^ePrint readings^cTisknout �ten�'
        TabOrder = 7
      end
      object CheckBox23: TCheckBox
        Left = 8
        Top = 296
        Width = 225
        Height = 17
        Caption = '#00498^ePrint inner lines^cTisknout vnit�n� ��ry'
        TabOrder = 8
      end
      object Edit14: TEdit
        Left = 8
        Top = 168
        Width = 129
        Height = 21
        Color = clBtnFace
        ReadOnly = True
        TabOrder = 9
        Text = 'MingLiU'
      end
      object CheckBox24: TCheckBox
        Left = 8
        Top = 320
        Width = 241
        Height = 17
        Caption = 
          '#00499^ePrint vertically (right to left)^cTisknout vertik�ln� (z' +
          'prava doleva)'
        TabOrder = 10
      end
      object CheckBox25: TCheckBox
        Left = 8
        Top = 344
        Width = 241
        Height = 17
        Caption = '#00500^eLeave space between columns^cVynech m�sto mezi sloupci'
        TabOrder = 11
      end
      object CheckBox44: TCheckBox
        Left = 8
        Top = 248
        Width = 217
        Height = 17
        Caption = '#00501^ePrint definition^cTisknout definici'
        TabOrder = 12
      end
      object CheckBox45: TCheckBox
        Left = 232
        Top = 272
        Width = 217
        Height = 17
        Caption = '#00502^ePrint stroke count^cTisknout po�et tah�'
        TabOrder = 13
      end
      object CheckBox52: TCheckBox
        Left = 232
        Top = 296
        Width = 225
        Height = 17
        Caption = '#00503^ePrint stroke order^cTisknout po�ad� tah�'
        TabOrder = 14
      end
      object CheckBox62: TCheckBox
        Left = 232
        Top = 200
        Width = 217
        Height = 17
        Caption = '#00954^ePrint full compounds^cTisknout pln� slo�eniny'
        TabOrder = 15
      end
      object CheckBox63: TCheckBox
        Left = 232
        Top = 320
        Width = 217
        Height = 17
        Caption = 
          '#00956^eSort compounds by frequency^cT��dit slo�eniny podle frek' +
          'vence'
        TabOrder = 16
      end
      object Edit35: TEdit
        Left = 208
        Top = 120
        Width = 121
        Height = 21
        TabOrder = 17
        Text = 'Edit35'
      end
    end
    object TabSheet7: TTabSheet
      Caption = '#00504^eDatabase maintenance^c�dr�ba datab�ze'
      ImageIndex = 6
      object Label48: TLabel
        Left = 224
        Top = 176
        Width = 105
        Height = 13
        Caption = 'Filename (without ext):'
      end
      object Label49: TLabel
        Left = 336
        Top = 176
        Width = 114
        Height = 13
        Caption = 'Category (with group id):'
      end
      object Button2: TButton
        Left = 16
        Top = 376
        Width = 441
        Height = 25
        Caption = 
          '#00505^eCheck dictionary database indexes^cOtestuj indexy datab�' +
          'ze slovn�ku'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Visible = False
        OnClick = Button2Click
      end
      object Button1: TButton
        Left = 16
        Top = 8
        Width = 441
        Height = 25
        Caption = 
          '#00506^eExport user database into delimited text file^cExportova' +
          't u�ivatelskou datab�zi do textov�ho souboru s odd�lova�i'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 16
        Top = 40
        Width = 441
        Height = 25
        Caption = 
          '#00507^eImport user database from delimited text file^cImportova' +
          't u�ivatelskou datab�zi z textov�ho souboru s odd�lova�i'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 16
        Top = 88
        Width = 441
        Height = 25
        Caption = 
          '#00508^eCheck user dictionary categories^cOtestovat kategorie sl' +
          'ov��ek'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = Button4Click
      end
      object Button11: TButton
        Left = 16
        Top = 136
        Width = 441
        Height = 25
        Caption = 
          '#00509^eShow memory allocation stats^cZobrazit statistiky alokac' +
          'e pam�ti'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
        OnClick = Button11Click
      end
      object Button13: TButton
        Left = 16
        Top = 176
        Width = 201
        Height = 25
        Caption = 'Import .UNI (Unicode 16-bit) as .WKL'
        TabOrder = 5
        OnClick = Button13Click
      end
      object Edit30: TEdit
        Left = 336
        Top = 192
        Width = 121
        Height = 21
        TabOrder = 6
        Text = 'LJLPT 4'
      end
      object Edit31: TEdit
        Left = 224
        Top = 192
        Width = 105
        Height = 21
        TabOrder = 7
        Text = 'JLPT4'
      end
    end
    object TabSheet9: TTabSheet
      Caption = '#00300^eText translator^cP�eklad textu'
      ImageIndex = 8
      object Label25: TLabel
        Left = 16
        Top = 248
        Width = 428
        Height = 13
        Caption = 
          '#00510^eNumber of lines reserved to meaning:^cPo�et ��dek rezerv' +
          'ovan�ch pro v�znam:'
      end
      object GroupBox5: TGroupBox
        Left = 16
        Top = 272
        Width = 449
        Height = 105
        Caption = '#00511^ePrinting^cTisk'
        TabOrder = 0
        object Label24: TLabel
          Left = 16
          Top = 72
          Width = 374
          Height = 13
          Caption = 
            '#00512^eNumber of lines on square page:^cPo�et ��dek na �tvercov' +
            '� stran�:'
        end
        object CheckBox29: TCheckBox
          Left = 16
          Top = 24
          Width = 193
          Height = 17
          Caption = '#00272^eDisplay reading^cZobrazit �ten�'
          TabOrder = 0
        end
        object CheckBox30: TCheckBox
          Left = 232
          Top = 24
          Width = 209
          Height = 17
          Caption = '#00513^eDisplay meaning^cZobrazit v�znam'
          TabOrder = 1
        end
        object CheckBox31: TCheckBox
          Left = 16
          Top = 48
          Width = 265
          Height = 17
          Caption = '#00514^eDo not use colors^cNepou��vat barvy'
          TabOrder = 2
        end
        object CheckBox37: TCheckBox
          Left = 232
          Top = 48
          Width = 377
          Height = 17
          Caption = 
            '#00515^ePrint vertically in columns^cTisknout vertik�ln� do slou' +
            'pc�'
          TabOrder = 3
        end
        object Edit18: TEdit
          Left = 216
          Top = 72
          Width = 121
          Height = 21
          TabOrder = 4
          Text = '20'
        end
      end
      object CheckBox32: TCheckBox
        Left = 16
        Top = 32
        Width = 401
        Height = 17
        Caption = '#00516^eDisplay lines^cZobrazovat ��ry'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object CheckBox33: TCheckBox
        Left = 16
        Top = 56
        Width = 353
        Height = 17
        Caption = 
          '#00517^eDo not display meaning in learned words^cNezobrazovat v�' +
          'znam nau�en�ch slova'
        TabOrder = 2
      end
      object CheckBox34: TCheckBox
        Left = 16
        Top = 128
        Width = 353
        Height = 17
        Caption = '#00518^eDo not search for particles^cNevyhled�vat partikule'
        TabOrder = 3
      end
      object CheckBox35: TCheckBox
        Left = 16
        Top = 80
        Width = 377
        Height = 17
        Caption = 
          '#00519^eDo not display reading of learned kanji^cNezobrazovat �t' +
          'en� nau�en�ch znak�'
        TabOrder = 4
      end
      object CheckBox36: TCheckBox
        Left = 16
        Top = 104
        Width = 393
        Height = 17
        Caption = 
          '#00884^eDisplay transcript above kana^cZobrazovat p�epis nad kan' +
          'ou'
        Checked = True
        State = cbChecked
        TabOrder = 5
      end
      object CheckBox38: TCheckBox
        Left = 16
        Top = 152
        Width = 377
        Height = 17
        Caption = 
          '#00521^eDo not translate hiragana-only words^cNep�ekl�dat slova ' +
          'pouze v hiragan�'
        TabOrder = 6
      end
      object CheckBox40: TCheckBox
        Left = 16
        Top = 200
        Width = 401
        Height = 17
        Caption = 
          '#00522^eDisplay words with user-defined translation in bold^cZob' +
          'razovat slova s u�ivatelsky definovan�m p�ekladem tu�n�'
        Checked = True
        State = cbChecked
        TabOrder = 7
      end
      object Edit17: TEdit
        Left = 232
        Top = 248
        Width = 121
        Height = 21
        TabOrder = 8
        Text = '2'
      end
      object CheckBox42: TCheckBox
        Left = 16
        Top = 176
        Width = 225
        Height = 17
        Caption = '#00523^eLeave space between lines^cVynechat m�sto mezi ��dky'
        Checked = True
        State = cbChecked
        TabOrder = 9
      end
      object CheckBox43: TCheckBox
        Left = 16
        Top = 8
        Width = 433
        Height = 17
        Caption = 
          '#00524^eBreak lines only at word boundaries^cRozd�lovat ��dky je' +
          'n na rozhran� slov'
        Checked = True
        State = cbChecked
        TabOrder = 10
      end
      object CheckBox27: TCheckBox
        Left = 360
        Top = 248
        Width = 97
        Height = 17
        Caption = '#00525^eDouble size^cDvojn�sobn� velikost'
        TabOrder = 11
      end
      object CheckBox41: TCheckBox
        Left = 248
        Top = 32
        Width = 401
        Height = 17
        Caption = 
          '#00526^eDisplay non-japanese chars in grey^cZobrazovat nejaponsk' +
          '� znaky �ed�'
        Checked = True
        State = cbChecked
        TabOrder = 12
        Visible = False
      end
      object CheckBox2: TCheckBox
        Left = 16
        Top = 224
        Width = 401
        Height = 17
        Caption = '#00527^eShow editor hint^cZobrazit n�pov�du p�i psan�'
        Checked = True
        State = cbChecked
        TabOrder = 13
      end
      object CheckBox13: TCheckBox
        Left = 232
        Top = 224
        Width = 225
        Height = 17
        Caption = '#00528^eDisplay meaning on hint^cZobrazit v�znam v n�pov�d�'
        Checked = True
        State = cbChecked
        TabOrder = 14
      end
      object CheckBox56: TCheckBox
        Left = 248
        Top = 176
        Width = 217
        Height = 17
        Caption = 
          '#00529^eLeave space even when reading is off^cVynechat m�sto i k' +
          'dy� je �ten� vypnuto'
        TabOrder = 15
      end
      object cbTranslateNoLongTextWarning: TCheckBox
        Left = 16
        Top = 386
        Width = 457
        Height = 17
        Caption = '^eDo not warn when translating large text chunks'
        TabOrder = 16
      end
    end
    object TabSheet10: TTabSheet
      Caption = '#00530^eCharacter details^cDetaily znak�'
      ImageIndex = 9
      object Label34: TLabel
        Left = 8
        Top = 8
        Width = 230
        Height = 13
        Caption = '#00531^eDisplayed items:^cZobrazen� polo�ky:'
      end
      object SpeedButton11: TSpeedButton
        Left = 448
        Top = 98
        Width = 23
        Height = 79
        Hint = '#00532^eMove up^cP�esu� nahoru'
        Anchors = [akTop, akRight]
        Enabled = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
          3333333333777F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
          3333333777737777F333333099999990333333373F3333373333333309999903
          333333337F33337F33333333099999033333333373F333733333333330999033
          3333333337F337F3333333333099903333333333373F37333333333333090333
          33333333337F7F33333333333309033333333333337373333333333333303333
          333333333337F333333333333330333333333333333733333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton11Click
      end
      object SpeedButton12: TSpeedButton
        Left = 448
        Top = 234
        Width = 23
        Height = 79
        Hint = '#00533^eMove down^cP�esu� dol�'
        Anchors = [akTop, akRight]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
          333333333337F33333333333333033333333333333373F333333333333090333
          33333333337F7F33333333333309033333333333337373F33333333330999033
          3333333337F337F33333333330999033333333333733373F3333333309999903
          333333337F33337F33333333099999033333333373333373F333333099999990
          33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333309033333333333337F7F333333333333090333
          33333333337F7F33333333333300033333333333337773333333}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton12Click
      end
      object ListBox2: TListBox
        Left = 8
        Top = 24
        Width = 438
        Height = 308
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox2Click
      end
      object Button7: TButton
        Left = 8
        Top = 339
        Width = 113
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = '#00534^eAdd...^cP�idat...'
        TabOrder = 1
        OnClick = Button7Click
      end
      object Button8: TButton
        Left = 180
        Top = 339
        Width = 113
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = '#00535^eChange...^cZm�nit...'
        TabOrder = 2
        OnClick = Button8Click
      end
      object Button9: TButton
        Left = 350
        Top = 339
        Width = 97
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = '#00536^eDelete^cZru�it'
        TabOrder = 3
        OnClick = Button9Click
      end
      object Button10: TButton
        Left = 296
        Top = 1
        Width = 150
        Height = 22
        Caption = '#00537^eReset to default^cNastavit implicitn�'
        TabOrder = 4
        OnClick = Button10Click
      end
    end
    object TabSheet11: TTabSheet
      Caption = '#00538^ePopup tool^cPopup okno'
      ImageIndex = 10
      object Label36: TLabel
        Left = 8
        Top = 80
        Width = 349
        Height = 13
        Caption = 
          '#00539^ePopup delay (x100 ms):^cZpo�d�n� p�ed zobrazen�m (x100 m' +
          's):'
      end
      object Label37: TLabel
        Left = 8
        Top = 112
        Width = 341
        Height = 13
        Caption = 
          '#00540^eText scan range (pixels):^cRozsah prohled�v�n� textu (pi' +
          'xely):'
      end
      object Label38: TLabel
        Left = 160
        Top = 112
        Width = 113
        Height = 13
        Caption = '#00541^eLeft^cDoleva'
      end
      object Label39: TLabel
        Left = 312
        Top = 112
        Width = 127
        Height = 13
        Caption = '#00542^eRight^cDoprava'
      end
      object Label40: TLabel
        Left = 8
        Top = 144
        Width = 396
        Height = 13
        Caption = 
          '#00543^eMax. number of dictionary entries:^cMaxim�ln� po�et polo' +
          '�ek ze slovn�ku:'
      end
      object Label43: TLabel
        Left = 8
        Top = 176
        Width = 317
        Height = 13
        Caption = 
          '#00544^eCharacter card size factor:^cFaktor velikosti karty znak' +
          'u:'
      end
      object Label44: TLabel
        Left = 8
        Top = 208
        Width = 850
        Height = 13
        Caption = 
          '#00545^eNumber of characters reserved for compounds on a card (a' +
          'ffects overall popup width):^cPo�et znak� rezervovan�ch pro slo�' +
          'eniny na kart� (ovlivn� celkovou ���ku okna):'
      end
      object Label45: TLabel
        Left = 104
        Top = 224
        Width = 155
        Height = 13
        Caption = '#00546^eMinimum:^cMinim�ln�:'
      end
      object Label46: TLabel
        Left = 264
        Top = 224
        Width = 161
        Height = 13
        Caption = '#00547^eMaximum:^cMaxim�ln�:'
      end
      object CheckBox28: TCheckBox
        Left = 8
        Top = 8
        Width = 353
        Height = 17
        Caption = 
          '#00548^eShow translation for japanese/chinese text^cZobrazit p�e' +
          'klad pro japonsk�/��nsk� text'
        TabOrder = 0
      end
      object CheckBox47: TCheckBox
        Left = 8
        Top = 32
        Width = 353
        Height = 17
        Caption = 
          '#00549^eShow translation for english text (only for screen)^cZob' +
          'razit p�eklad pro anglick� text (pouze v re�imu obrazovky)'
        TabOrder = 1
      end
      object CheckBox48: TCheckBox
        Left = 8
        Top = 56
        Width = 361
        Height = 17
        Caption = '#00550^eShow character details^cZobrazit detaily znaku'
        TabOrder = 2
      end
      object Edit21: TEdit
        Left = 160
        Top = 80
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'Edit21'
      end
      object Edit22: TEdit
        Left = 224
        Top = 112
        Width = 81
        Height = 21
        TabOrder = 4
        Text = 'Edit22'
      end
      object Edit23: TEdit
        Left = 376
        Top = 112
        Width = 81
        Height = 21
        TabOrder = 5
        Text = 'Edit23'
      end
      object Edit24: TEdit
        Left = 224
        Top = 144
        Width = 121
        Height = 21
        TabOrder = 6
        Text = 'Edit24'
      end
      object Edit26: TEdit
        Left = 224
        Top = 176
        Width = 121
        Height = 21
        TabOrder = 7
        Text = 'Edit26'
      end
      object Edit27: TEdit
        Left = 192
        Top = 224
        Width = 65
        Height = 21
        TabOrder = 8
        Text = 'Edit27'
      end
      object Edit28: TEdit
        Left = 344
        Top = 224
        Width = 65
        Height = 21
        TabOrder = 9
        Text = 'Edit28'
      end
    end
    object TabSheet12: TTabSheet
      Caption = '#00551^eColors^cBarvy'
      ImageIndex = 11
      object Shape2: TShape
        Left = 8
        Top = 332
        Width = 105
        Height = 25
        Anchors = [akLeft, akBottom]
      end
      object Label42: TLabel
        Left = 8
        Top = 8
        Width = 148
        Height = 13
        Caption = '#00552^eCategory^cKategorie'
      end
      object ListBox3: TListBox
        Left = 8
        Top = 72
        Width = 457
        Height = 257
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox3Click
      end
      object Button12: TButton
        Left = 120
        Top = 332
        Width = 217
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = '#00553^eChange^cZm�nit'
        TabOrder = 1
        OnClick = Button12Click
      end
      object Button14: TButton
        Left = 344
        Top = 332
        Width = 121
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = '#00554^eRevert to default^cVr�tit na v�choz�'
        TabOrder = 2
        OnClick = Button14Click
      end
      object Button15: TButton
        Left = 336
        Top = 8
        Width = 129
        Height = 25
        Caption = '#00555^eSet all to default^cNastavit v�e na v�choz�'
        TabOrder = 3
        OnClick = Button15Click
      end
      object ComboBox2: TComboBox
        Left = 8
        Top = 24
        Width = 313
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnChange = ComboBox2Change
        Items.Strings = (
          '#00298^eCharacter list^cSeznam znak�'
          '#00556^eWord grids^cM��ky slov'
          '#00557^eWord markers^cP��znaky slov'
          '#00558^eEditor & translator^cEditor / P�ekl�d�n�'
          '#00559^ePopup tool^cPopup n�stroj')
      end
      object CheckBox3: TCheckBox
        Left = 8
        Top = 49
        Width = 457
        Height = 17
        Caption = 
          '#00560^eDo not use colors in character list, use Windows default' +
          ' colors instead^cNepou��vat barvy v seznamu znak�, pou��t nastav' +
          'en� Windows'
        Checked = True
        State = cbChecked
        TabOrder = 5
        OnClick = CheckBox3Click
      end
      object CheckBox39: TCheckBox
        Left = 8
        Top = 49
        Width = 457
        Height = 17
        Caption = 
          '#00561^eDo not use colors in editor, use Windows default colors ' +
          'instead^cNepou��vat barvy v editoru, pou��t m�sto toho barvy Win' +
          'dows'
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnClick = CheckBox39Click
      end
      object CheckBox9: TCheckBox
        Left = 8
        Top = 50
        Width = 433
        Height = 17
        Hint = 
          '#00562^eColors: black - common, grey - uncommon, blue - learned,' +
          ' green - only in names^cBarvy: �ern� - b�n� znak, �ed� - vz�cn�' +
          ', modr� - nau�en�, zelen� - pouze ve jm�nech'
        Caption = 
          '#00563^eDo not use colors in word grids, use Windows default col' +
          'ors instead^cNepou��vat barvy v m��ce slov, pou��t barvy Window' +
          's'
        TabOrder = 7
        OnClick = CheckBox9Click
      end
    end
    object TabSheet13: TTabSheet
      Caption = '^eEditor^cEditor'
      ImageIndex = 12
      object CheckBox60: TCheckBox
        Left = 8
        Top = 8
        Width = 457
        Height = 17
        Caption = '^eAuto-save file on exit^cAutomaticky ulo�it soubor p�i ukon�en�'
        TabOrder = 0
      end
      object CheckBox61: TCheckBox
        Left = 8
        Top = 32
        Width = 457
        Height = 17
        Caption = 
          '^eAuto-load last opened file on start^cAutomaticky nahr�t naposl' +
          'ed otev�en� soubor p�i startu'
        TabOrder = 1
      end
    end
    object TabSheet14: TTabSheet
      Caption = '^eAnnotations^cAnotace'
      ImageIndex = 13
      object Bevel1: TBevel
        Left = 8
        Top = 40
        Width = 457
        Height = 17
        Shape = bsTopLine
      end
      object CheckBox64: TCheckBox
        Left = 11
        Top = 16
        Width = 302
        Height = 17
        Caption = 
          '^eEnable annotations (ANNOTATE.PKG)^cPovolit anotace (ANNOTATE.P' +
          'KG)'
        TabOrder = 0
      end
      object CheckBox65: TCheckBox
        Left = 11
        Top = 54
        Width = 294
        Height = 17
        Caption = 
          '^eRebuild ANNOTATE.PKG from .ANO files if needed whenever WaKan ' +
          'starts^cVytvo�it ANNOTATE.PKG ze soubor� .ANO p�i ka�d�m startu ' +
          'WaKanu kdy� je pot�eba'
        TabOrder = 1
      end
      object CheckBox66: TCheckBox
        Left = 11
        Top = 150
        Width = 326
        Height = 17
        Caption = 
          '^eAllow annotations to play sound files^cPovolit anotac�m p�ehr�' +
          't zvukov� soubory '
        TabOrder = 2
        Visible = False
      end
      object CheckBox67: TCheckBox
        Left = 11
        Top = 78
        Width = 326
        Height = 17
        Caption = 
          '^eAllow annotations to display pictures^cPovolit anotac�m zobraz' +
          'it obr�zky'
        TabOrder = 3
      end
      object CheckBox68: TCheckBox
        Left = 11
        Top = 102
        Width = 326
        Height = 17
        Caption = 
          '^eAllow annotations to display web pages^cPovolit anotac�m zobra' +
          'zit webov� str�nky'
        TabOrder = 4
      end
      object CheckBox69: TCheckBox
        Left = 11
        Top = 126
        Width = 326
        Height = 17
        Caption = 
          '^eAllow annotations to change foreground color^cPovolit anotac�m' +
          ' m�nit barvu pop�ed�'
        TabOrder = 5
      end
      object Button16: TButton
        Left = 72
        Top = 352
        Width = 337
        Height = 25
        Caption = 
          '^eHelp for the annotation feature^cN�pov�da pro funkci anotace (' +
          'anglicky)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = Button16Click
      end
    end
  end
  object BitBtn1: TBitBtn
    Left = 200
    Top = 523
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object Button6: TButton
    Left = 8
    Top = 527
    Width = 177
    Height = 21
    Anchors = [akLeft, akBottom]
    Caption = '#00929^eChange language^cZm�na jazyka'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Button6Click
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = '.wbk'
    Filter = 'WaKan User Data Backup|*.wbk'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 344
    Top = 24
  end
  object SaveDialog2: TSaveDialog
    DefaultExt = '.wbk'
    Filter = 'WaKan User Data Bakup|*.wbk'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofNoChangeDir, ofEnableSizing]
    Left = 392
    Top = 16
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 148
    Top = 352
  end
end
