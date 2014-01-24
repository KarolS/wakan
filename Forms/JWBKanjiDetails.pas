unit JWBKanjiDetails;

//{$DEFINE NO_KD_PLACEMENT}
{ Disable saving and restoring of form placement for this window.
 Used to debug form position handling - we must be able to keep track of it even
 with position saving turned off in options }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, FormPlacemnt, UrlLabel, JWBStrings,
  TextTable, JWBForms;

type
  TCharReadings = record
    piny,kory,cany,chiny:string;
    ony,kuny,nany:UnicodeString;
    def:UnicodeString;
  end;
  PCharReadings = ^TCharReadings;

 {
  HellspawnString contains data in various formats depending on the circumstances:
   - for 'U' and 'P' type properties it stores FStrings
   - for the rest of types just strings (Ansi data in fact)
 }
  HellspawnString = string;
  THellspawnStringList = TStringList;

  TfKanjiDetails = class(TForm)
    pnlSecond: TPanel;
    pnlFooter: TPanel;
    btnClose: TButton;
    btnDock: TButton;
    Scrollbox: TScrollBox;
    pbKanjiInfo: TPaintBox;
    FlowPanel1: TFlowPanel;
    RxLabel1: TLabel;
    lblCategories: TLabel;
    cbCategories: TComboBox;
    btnAddToCategory: TSpeedButton;
    FlowPanel2: TFlowPanel;
    ProUrlLabel1: TUrlLabel;
    ProUrlLabel2: TUrlLabel;
    ProUrlLabel3: TUrlLabel;
    ProUrlLabel4: TUrlLabel;
    ProUrlLabel5: TUrlLabel;
    pnlFirst: TPanel;
    FormPlacement1: TFormPlacement;
    ShapeKanji: TShape;
    lblMeaning: TLabel;
    ShapeRadical: TShape;
    pbKanji: TPaintBox;
    pbRadical: TPaintBox;
    ShapeSimplified: TShape;
    pbSimplified: TPaintBox;
    RxLabel10: TLabel;
    RxLabel35: TLabel;
    RxLabel38: TLabel;
    lblStrokeCount: TLabel;
    RxLabel39: TLabel;
    lblRadicalNo: TLabel;
    btnStrokeOrder: TSpeedButton;
    procedure pbKanjiPaint(Sender: TObject);
    procedure pbRadicalPaint(Sender: TObject);
    procedure pbSimplifiedPaint(Sender: TObject);
    procedure btnAddToCategoryClick(Sender: TObject);
    procedure SpeedButton28Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton23Click(Sender: TObject);
    procedure btnStrokeOrderClick(Sender: TObject);
    procedure pbKanjiInfoPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure pbRadicalDblClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnCloseKeyPress(Sender: TObject; var Key: Char);
    procedure btnDockClick(Sender: TObject);
    procedure pbRadicalMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pbKanjiInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pbSimplifiedMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure pbRadicalMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbSimplifiedMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbKanjiInfoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cbCategoriesChange(Sender: TObject);
    procedure pbRadicalMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbSimplifiedMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbKanjiInfoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure ScrollboxClick(Sender: TObject);

  protected
    curChars: FString; //displaying information for these characters
    curSingleChar: FChar; //shortcut if we're displaying a single character
    kval: THellspawnStringList;
    procedure ReloadReadings(CChar: TTextTableCursor; out read: TCharReadings);
    procedure PopulateKval(CChar: TTextTableCursor; const read: TCharReadings);
  public
    procedure Clear;
    procedure SetCharDetails(chars: FString);
    procedure RefreshDetails;

  protected
   { Info box painting }
    function InfoPaint(canvas:TCanvas;w:integer;onlycount:boolean):integer;
    procedure InfoDrawItem(canvas:TCanvas;its,txs:string;l,r:integer;
      var x,y,rh:integer;onlycount:boolean);
    procedure DrawSingleText(canvas:TCanvas;tp:char;l,t,r,fh:integer;s:string);
    function FitText(canvas:TCanvas;tp:char;wrap:boolean;w,fh:integer;
      fname:string;out l:integer;var s: HellspawnString): HellspawnString;

  protected
    FDockMode: TAlign; //this window keeps different size settings for docked and undocked mode
    FDockedWidth: integer; //store docked width/height settings while undocked
    FDockedHeight: integer;
    function GetDockedWidth: integer;
    function GetDockedHeight: integer;
    procedure SetDockedWidth(Value: integer);
    procedure SetDockedHeight(Value: integer);
    procedure WMGetDockedW(var msg: TMessage); message WM_GET_DOCKED_W;
    procedure WMGetDockedH(var msg: TMessage); message WM_GET_DOCKED_H;
    procedure WMSaveDockedWH(var msg: TMessage); message WM_SAVE_DOCKED_WH;
    procedure WMSetDockMode(var msg: TMessage); message WM_SET_DOCK_MODE;
  public
    procedure BeforeDestruction; override;
    procedure UpdateAlignment;
    procedure SetDocked(Value: boolean; Loading: boolean);
    procedure UpdateVisible;
    property DockedWidth: integer read GetDockedWidth write SetDockedWidth;
    property DockedHeight: integer read GetDockedHeight write SetDockedHeight;

  end;

var
  fKanjiDetails: TfKanjiDetails;

  curradno: integer;
  curradical: string;

implementation

uses ShellApi, MemSource, JWBDicSearch, JWBKanji, JWBMenu,
  JWBSettings, JWBUnit, JWBCategories, JWBKanjiCard,
  JWBVocabFilters, JWBKanaConv, JWBCharData;

{$R *.DFM}

var
  cursimple: FString;

procedure TfKanjiDetails.FormCreate(Sender: TObject);
begin
  kval:=TStringList.Create;
  cursimple:='';
  DockedWidth:=321; //fixed docked size
  DockedHeight:=220;
end;

procedure TfKanjiDetails.BeforeDestruction;
begin
 {$IFNDEF NO_KD_PLACEMENT}
 { We do this here because TForm.BeforeDestruction hides the form and there's
  no way to know if it was Visible. }
  if (not fMenu.CharDetDocked) and FormPlacement1.PlacementRestored then
    FormPlacement1.SaveFormPlacement;
 {$ENDIF}
  inherited;
end;

procedure TfKanjiDetails.FormDestroy(Sender: TObject);
begin
  kval.Free;
end;

procedure TfKanjiDetails.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UpdateVisible();
end;

procedure TfKanjiDetails.FormShow(Sender: TObject);
begin
  UpdateVisible();
end;

procedure TfKanjiDetails.FormHide(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then //forms might already cease to exist on destruction
    UpdateVisible();
end;

procedure TfKanjiDetails.UpdateVisible;
begin
  fMenu.aKanjiDetails.Checked:=Self.Visible;
  btnDock.Enabled:=fMenu.CharDetDocked or (fMenu.curdisplaymode in [1,3,4]);
  btnClose.Default:=not fMenu.CharDetDocked;
end;

procedure TfKanjiDetails.pbKanjiPaint(Sender: TObject);
var f:string;
begin
  if chin then
    case fSettings.RadioGroup5.ItemIndex of
      0:f:=FontChinese;
      1:f:=FontChineseGB;
      2:f:=FontRadical;
    end
  else f:=FontJapanese;
  if btnStrokeOrder.Down then
    if chin then f:=FontChinese else f:=FontStrokeOrder;
  pbKanji.Canvas.Brush.Color:=clWindow;
  pbKanji.Canvas.Font.Style:=[];
  if flength(curChars)=1 then begin //can be 0 or multiple chars
    DrawUnicodeChar(pbKanji.Canvas,Rect(1,1,137,137),137,curChars,f);
    if btnStrokeOrder.Down then DrawStrokeOrder(pbKanji.Canvas,1,1,137,137,curChars,12,clBlue);
  end;
end;

procedure TfKanjiDetails.pbRadicalPaint(Sender: TObject);
var f:string;
begin
  f:=FontRadical;
  pbRadical.Canvas.Brush.Color:=clWindow;
  pbRadical.Canvas.Font.Style:=[];
  BeginDrawReg(pbRadical.Canvas);
  DrawUnicodeChar(pbRadical.Canvas,Rect(1,1,48,48),48,curradical,f);
  EndDrawReg;
end;

procedure TfKanjiDetails.pbSimplifiedPaint(Sender: TObject);
begin
  pbSimplified.Canvas.Brush.Color:=clWindow;
  pbSimplified.Canvas.Font.Style:=[];
  BeginDrawReg(pbSimplified.Canvas);
  DrawUnicodeChar(pbSimplified.Canvas,Rect(1,1,48,48),48,cursimple,FontRadical);
  EndDrawReg;
end;


procedure TfKanjiDetails.btnAddToCategoryClick(Sender: TObject);
var catIndex: integer;
  newState: boolean;
  i: integer;
begin
  if curChars='' then exit;
  catIndex := GetSelCatIdx(cbCategories);

 //If any of the chars is not in group, we add all chars to group,
 //else we remove all chars
  newState := not IsAllKnown(catIndex,curChars);
  for i := 1 to flength(curChars) do
    SetKnown(catIndex, fgetch(curChars,i), newState);
  fMenu.ChangeUserData;
  SetCharDetails(curChars); //reload
end;

procedure TfKanjiDetails.SpeedButton28Click(Sender: TObject);
var s:string;
begin
  if curSingleChar=UH_NOCHAR then exit;
  s:='StrokeOrder\'+FStrToHex(curSingleChar)+'.gif';
  ShellExecute(handle,nil,pchar(s),nil,nil,SW_SHOW);
end;

procedure TfKanjiDetails.SpeedButton23Click(Sender: TObject);
begin
  if curSingleChar=UH_NOCHAR then exit;
  clip:=clip+curSingleChar;
  fMenu.SetClipboard;
end;

procedure TfKanjiDetails.btnStrokeOrderClick(Sender: TObject);
begin
  pbKanji.Invalidate;
end;

procedure TfKanjiDetails.pbKanjiInfoPaint(Sender: TObject);
begin
  BeginDrawReg(pbKanjiInfo.Canvas);
  InfoPaint(pbKanjiInfo.Canvas,pbKanjiInfo.Width,false);
  EndDrawReg;
end;

procedure TfKanjiDetails.pbRadicalDblClick(Sender: TObject);
begin
  if curradno<>NoRadical then
    fKanji.FilterByRadical(curradno);
end;

procedure TfKanjiDetails.btnCloseClick(Sender: TObject);
begin
  if fMenu.CharDetDocked then fMenu.aKanjiDetails.Execute else Close;
end;

procedure TfKanjiDetails.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then Close;
end;

procedure TfKanjiDetails.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
var msg, code, i, n: integer;
begin
 { Scrollbox does not support mouse wheel nor even focus, so handle it here }
  if WindowFromPoint(mouse.CursorPos) = scrollbox.Handle then begin
    Handled := true;
    if ssShift in Shift Then
      msg := WM_HSCROLL
    else
      msg := WM_VSCROLL;

    if WheelDelta < 0 then begin
      code := SB_LINEDOWN;
      WheelDelta := -WheelDelta;
    end else
      code := SB_LINEUP;

    n := 3* Mouse.WheelScrollLines * (WheelDelta div WHEEL_DELTA);
    for i := 1 to n do
      scrollbox.Perform(msg, code, 0);
    scrollbox.Perform(msg, SB_ENDSCROLL, 0);
  end;
end;

procedure TfKanjiDetails.ScrollboxClick(Sender: TObject);
begin
  Scrollbox.SetFocus; //does not set by default
end;

procedure TfKanjiDetails.btnCloseKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#27 then Close;
end;

procedure TfKanjiDetails.btnDockClick(Sender: TObject);
begin
  fMenu.SetCharDetDocked(not fMenu.CharDetDocked, false);
end;

procedure TfKanjiDetails.pbRadicalMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  fMenu.IntTipMouseMove(pbRadical,x,y,ssLeft in Shift);
end;

procedure TfKanjiDetails.pbKanjiInfoMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  fMenu.IntTipMouseMove(pbKanjiInfo,x,y,ssLeft in Shift);
end;

procedure TfKanjiDetails.pbSimplifiedMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  fMenu.IntTipMouseMove(pbSimplified,x,y,ssLeft in Shift);
end;

procedure TfKanjiDetails.pbRadicalMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mbRight=Button then fMenu.PopupImmediate(false);
end;

procedure TfKanjiDetails.pbSimplifiedMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mbRight=Button then fMenu.PopupImmediate(false);
end;

procedure TfKanjiDetails.pbKanjiInfoMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mbRight=Button then fMenu.PopupImmediate(false);
end;

procedure TfKanjiDetails.cbCategoriesChange(Sender: TObject);
begin
  RefreshDetails;
end;

procedure TfKanjiDetails.pbRadicalMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mbLeft=Button then fMenu.IntTipMouseUp;
end;

procedure TfKanjiDetails.pbSimplifiedMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mbLeft=Button then fMenu.IntTipMouseUp;
end;

procedure TfKanjiDetails.pbKanjiInfoMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if mbLeft=Button then fMenu.IntTipMouseUp;
end;

procedure TfKanjiDetails.RefreshDetails;
begin
  SetCharDetails(curChars);
end;

procedure TfKanjiDetails.Clear;
begin
  SetCharDetails('');
end;

{
"unicode" can be:
   nil      === no char selected, clear the form
   1 char
   multiple chars
It can also contain unsupported characters, in which case we only show what
is obvious from the char itself.
If there are multiple chars selected, only a limited set of operations is
available.
}
procedure TfKanjiDetails.SetCharDetails(chars:FString);
var i:integer;
  kig:string;
  h:integer;
  cv:string;
  scat:string;
  cv_i1, cv_i2: integer;
  charval: string; //GetCharValue
  read: TCharReadings;
  curindex: integer;
  CChar: TTextTableCursor;
begin
  //Only Kanji are allowed
  for i := 1 to flength(chars) do
    if EvalChar(chars[i])<>EC_IDG_CHAR then begin
      chars := ''; //illegal chars => just clear this window
      break;
    end;

  curChars := chars;
  if flength(curChars)=1 then
    curSingleChar := fgetch(curChars,1)
  else {0 or multiple}
    curSingleChar := UH_NOCHAR;

  curkanji:=UH_NOCHAR;
  curradical:='';
  cursimple:='';
  pbKanji.Invalidate;
  pbRadical.Invalidate;
  pbKanjiInfo.Invalidate;
  RxLabel35.Hide;
  pbSimplified.Hide;
  ShapeSimplified.Hide;
  lblMeaning.Caption:='-';

  CChar := TChar.NewCursor;
  try
    Screen.Cursor:=crHourGlass;
    if (curSingleChar=UH_NOCHAR) or not CChar.Locate('Unicode',curSingleChar) then begin
     //specific char, but not found in the char db -- valid case
      curindex:=-1;
      curkanji:=UH_NOCHAR;
    end else begin
      curindex:=CChar.Int(TCharIndex);
      curkanji:=CChar.FCh(TCharUnicode); //curkanji is defined in another module, we set it because someone depends on it
    end;

    { Url labels }
    if curindex<0 then begin
      ProURLLabel1.Enabled := false;
      ProURLLabel1.URL := '';
      ProURLLabel2.Enabled := false;
      ProURLLabel2.URL := '';
      ProURLLabel3.Enabled := false;
      ProURLLabel3.URL := '';
      ProURLLabel4.Enabled := false;
      ProURLLabel4.URL := '';
      ProURLLabel5.Enabled := false;
      ProURLLabel5.URL := '';
    end else begin
      cv:=GetCharValue(curindex,51);
      ProURLLabel1.Enabled:=cv<>'';
      ProURLLabel1.URL:='http://www.zhongwen.com/cgi-bin/zipux2.cgi?b5=%'+copy(cv,1,2)+'%'+copy(cv,3,2);
      ProURLLabel2.Enabled:=CChar.Int(TCharChinese)=0;
      ProURLLabel2.URL:='http://www.csse.monash.edu.au/cgi-bin/cgiwrap/jwb/wwwjdic?1MKU'+lowercase(FStrToHex(curSingleChar));
      ProURLLabel3.Enabled:=true;
      ProURLLabel3.URL:='http://charts.unicode.org/unihan/unihan.acgi$0x'+lowercase(FStrToHex(curSingleChar));
      cv:=GetCharValue(curindex,54);
      ProURLLabel4.Enabled:=(cv<>'')
        and TryStrToInt(copy(cv,1,2), cv_i1)
        and TryStrToInt(copy(cv,3,2), cv_i2);
      if ProURLLabel4.Enabled then
        ProURLLabel4.URL:='www.ocrat.com/chargif/GB/horiz/'+lowercase(Format('%2x%2x',[cv_i1+160,cv_i2+160]))+'.html';
      cv:=GetCharValue(curindex,57);
      ProURLLabel5.Enabled:=cv<>'';
      ProURLLabel5.URL:='http://web.mit.edu/jpnet/ji/data/'+cv+'.html';
    end;

    //Simplified form
    if curindex<0 then
      charval := ''
    else begin
      charval := GetCharValue(CChar.Int(TCharIndex),43);
      if charval<>'' then
        RxLabel35.Caption:=_l('#00135^eSimplified:')
      else begin
        charval := GetCharValue(CChar.Int(TCharIndex),44);
        if charval<>'' then
          RxLabel35.Caption:=_l('#00136^eTraditional:');
      end;
    end;
    if charval<>'' then
    begin
      cursimple:=hextofstr(charval);
      RxLabel35.Show;
      pbSimplified.Show;
      ShapeSimplified.Show;
    end else begin
      cursimple:='';
      RxLabel35.Hide;
      pbSimplified.Hide;
      ShapeSimplified.Hide;
    end;

    //Radical
    if curindex<0 then
      curradno:=NoRadical
    else
      curradno:=GetCharValueRad(CChar.Int(TCharIndex), fSettings.GetPreferredRadicalType());
    if curradno=NoRadical then begin
      lblRadicalNo.Caption:=_l('#01088^eNone');
      curradical := ''
    end else begin
      lblRadicalNo.Caption:=IntToStr(curradno);
      curradical := RadicalUnicode(curradno);
    end;

    //AddToCategory -- "add" if any of the chars is not in it
    btnAddToCategory.Enabled := flength(curChars)>0;
    cbCategories.Enabled := btnAddToCategory.Enabled;
    if not btnAddToCategory.Enabled then
      btnAddToCategory.Caption := '+' //default will be +
    else
    if (cbCategories.ItemIndex<0)
    or not IsAllKnown(GetSelCatIdx(cbCategories),curChars) then
      btnAddToCategory.Caption:='+'
    else
      btnAddToCategory.Caption:='-';

    //Categories -- include if any of the chars is in it
    scat:='';
    for i:=0 to Length(KanjiCats)-1 do
    begin
      if IsAnyKnown(KanjiCats[i].idx,curChars) then
        if scat='' then
          scat:=KanjiCats[i].name
        else
          scat:=scat+', '+KanjiCats[i].name;
    end;
    if scat='' then scat:='-';
    lblCategories.Caption:=scat;

    //Stroke count/order
    btnStrokeOrder.Enabled := (curindex>=0);
    if curindex<0 then
      lblStrokeCount.Caption := '-'
    else
    if chin then begin
      if CChar.Int(TCharStrokeCount)<255 then lblStrokeCount.Caption:=CChar.Str(TCharStrokeCount) else lblStrokeCount.Caption:='-';
    end else begin
      if CChar.Int(TCharJpStrokeCount)<255 then lblStrokeCount.Caption:=CChar.Str(TCharJpStrokeCount) else lblStrokeCount.Caption:='-';
    end;

    //Kanji color
    if curindex<0 then
      kig:='U'
    else
    if not chin then
    begin
      if CChar.Int(TCharJouyouGrade)<9 then kig:='C'else
      if CChar.Int(TCharJouyouGrade)<10 then kig:='N'else
      kig:='U';
    end else
      if CChar.Int(TCharChFrequency)<=5 then kig:='C'else kig:='U';
    if IsAllKnown(KnownLearned,curChars) then kig:='K';
    case kig[1] of
      'K':RxLabel38.Font.Color:=Col('Kanji_Learned');
      'C':RxLabel38.Font.Color:=Col('Kanji_Common');
      'U':RxLabel38.Font.Color:=Col('Kanji_Rare');
      'N':RxLabel38.Font.Color:=Col('Kanji_Names');
    end;
    case kig[1] of
      'K':RxLabel38.Caption:=_l('#00140^eLearned');
      'C':RxLabel38.Caption:=_l('#00141^eCommon');
      'U':RxLabel38.Caption:=_l('#00142^eRare');
      'N':RxLabel38.Caption:=_l('#00143^eUsed in names');
      'A':RxLabel38.Caption:=_l('#00144^eJapanese and chinese');
      'J':RxLabel38.Caption:=_l('#00145^eJapanese only');
    end;

    if flength(curChars)<1 then
      lblMeaning.Caption := ''
    else
    if flength(curChars)>1 then
      lblMeaning.Caption := _l('#01001^eMultiple kanji selected')
    else begin
      ReloadReadings(CChar, read);
      if chin then
        lblMeaning.Caption:=read.chiny
      else
        lblMeaning.Caption:=read.def;
      PopulateKVal(CChar, read);
    end;

  finally
    FreeAndNil(CChar);
  end;

 { Repaint }
  if curindex>0 then begin
    h:=InfoPaint(pbKanjiInfo.Canvas,pbKanjiInfo.Width,true);
    pbKanjiInfo.Height:=h;
  end else begin
    pbKanjiInfo.Height:=1; //do not make it zero or we'll break panel order (yeah, really)
  end;
  Screen.Cursor:=crDefault;
end;

{ Reloads various character readings from TCharProp table }
procedure TfKanjiDetails.ReloadReadings(CChar: TTextTableCursor; out read: TCharReadings);
var rt: integer; //TCharProp.Int(TCharPropType)
  ws:UnicodeString;
  CCharProp: TCharPropertyCursor;
  def_a, def_u: UnicodeString;
begin
  FillChar(read, sizeof(read), 00); //initializes all strings to ''

  CCharProp := TCharPropertyCursor.Create(TCharProp);
  try
    def_u := '';
    def_a := '';
    CCharProp.SetOrder('');
    CCharProp.Locate('Kanji',CChar.TrueInt(TCharIndex));
    while (not CCharProp.EOF) and (CCharProp.Int(TCharPropKanji)=CChar.Int(TCharIndex)) do
    begin
      rt:=CCharProp.Int(TCharPropTypeId);
      if rt in[1,2,3,4,5,6,7,8,ptJapaneseDefinitionUnicode] then
        ws:=CCharProp.Value;
      case rt of
        1:if read.kory='' then read.kory:=fstrtouni(ws) else read.kory:=read.kory+', '+fstrtouni(ws);
        2:if read.piny='' then read.piny:=fstrtouni(ws) else read.piny:=read.piny+','+fstrtouni(ws);
        3:if def_a='' then def_a:=fstrtouni(ws) else def_a:=def_a+', '+fstrtouni(ws);
        4:if read.ony='' then read.ony:=ws else read.ony:=read.ony+#$FF0C+ws;
        5:if read.kuny='' then read.kuny:=ws else read.kuny:=read.kuny+#$FF0C+ws;
        6:if read.nany='' then read.nany:=ws else read.nany:=read.nany+#$FF0C+ws;
        7:if read.chiny='' then read.chiny:=fstrtouni(ws) else read.chiny:=read.chiny+', '+fstrtouni(ws);
        8:if read.cany='' then read.cany:=fstrtouni(ws) else read.cany:=read.cany+', '+fstrtouni(ws);
        ptJapaneseDefinitionUnicode:
          if def_u='' then def_u:=fstrtouni(ws) else def_u:=def_u+', '+fstrtouni(ws);
      end;
      CCharProp.Next;
    end;
    if def_u<>'' then
      read.def := def_u
    else
      read.def := def_a;
  finally
    FreeAndNil(CCharProp);
  end;
end;

{
PopulateKVal()
Repopulates KVal list which is used to draw various kanji information box
}
procedure TfKanjiDetails.PopulateKval(CChar: TTextTableCursor; const read: TCharReadings);
var
  s: string;
  i:integer;
  propTypeId: integer;
  propType: PCharPropType;
  CCharProp: TCharPropertyCursor;
begin
  kval.Clear;

  CCharProp := TCharPropertyCursor.Create(TCharProp);
  try
    for i:=0 to chardetl.Count-1 do
    begin
      propTypeId := strtoint(GetCharDet(i,0));
      propType := FindCharPropType(propTypeId);
      if propType=nil then continue;

      s:='';
      case propTypeId of
        0:s:='---';
        1:s:=LowerCase(read.kory);
        2:s:=ConvertPinYin(read.piny);
        3:s:=read.def;
        4:s:=fstr(read.ony);
        5:s:=fstr(read.kuny);
        6:s:=fstr(read.nany);
        7:s:=read.chiny;
        8:s:=LowerCase(read.cany);
        100:s:=curSingleChar;
        else
          s := CCharProp.GetCharValues(CChar.TrueInt(TCharIndex), propTypeId, '')
      end;

      if GetCharDet(i,6)<>'' then
        kval.Add(propType.dataType+';'+chardetl[i])
      else
        kval.Add(propType.dataType+';'+chardetl[i]+_l('^e'+propType.englishName));
      kval.Add(s);

    end; //of chardetl enum
  finally
    FreeAndNil(CCharProp);
  end;
end;


{ Info box painting }

function TfKanjiDetails.InfoPaint(canvas:TCanvas;w:integer;onlycount:boolean):integer;
const MARGIN_L=0;
  MARGIN_R=0;
var i:integer;
  x,y,rh:integer;
begin
  x:=MARGIN_L;
  y:=3;
  rh:=0;
  for i:=0 to (kval.Count div 2)-1 do
    InfoDrawItem(canvas,kval[i*2],kval[i*2+1],MARGIN_L,w-MARGIN_R,x,y,rh,onlycount);
  result:=y;
end;

procedure TfKanjiDetails.InfoDrawItem(canvas:TCanvas;its,txs:string;l,r:integer;
  var x,y,rh:integer;onlycount:boolean);
var fh:integer;
    fname:string;
    lbl:string;

  function DoesFit(s:string):boolean;
  var l:integer;
  begin
    FitText(canvas,its[1],true,r-x,fh,fname,l,s);
    if s<>'' then result:=false else result:=true;
  end;
  function GetDet(j:integer):string;
  var s:string;
  begin
    s:=its;
    while j>0 do
    begin
      delete(s,1,pos(';',s));
      dec(j);
    end;
    delete(s,pos(';',s),length(s)-pos(';',s)+1);
    result:=s;
  end;

var lw,rr:integer;
    ws:string;
    s:string;
begin
  if (GetDet(4)='C') and not chin then exit;
  if (GetDet(4)='J') and chin then exit;
  if (GetDet(5)='N') and (txs='') and (its[1]<>'-') then exit;
  if its[1]='R'then its[1]:='U';
  if txs='' then if (its[1]<>'U') and (its[1]<>'R') and (its[1]<>'P') then txs:='-';
  canvas.Font.Style:=[fsBold];
  case GetDet(6)[1] of
    'B':fh:=20;
    'M':fh:=16;
    'S':fh:=12;
  end;
  fname:=FontEnglish;
  if GetDet(3)<>'N'then
  begin
    lbl:=GetDet(7);
    if its[1]<>'-'then lbl:=lbl+':';
    if (GetDet(2)='C') and (x>l) then
    begin
      if not DoesFit(lbl) then
      begin
        x:=l;
        y:=y+rh;
      end;
    end else if x>l then
    begin
      x:=l;
      y:=y+rh;
    end;
    lbl:=FitText(canvas,'S',false,r-x,fh,fname,lw,lbl);
    if not onlycount then if txs<>'---'then DrawSingleText(canvas,'S',x,y,r,fh,lbl);
    lw:=lw+5;
    canvas.Font.Style:=[];
    if (GetDet(3)='W') or ((GetDet(3)='L') and (GetDet(2)='W') and (lw>(r-x) div 2)) then
    begin
      x:=l;
      y:=y+fh+2;
    end else x:=x+lw;
  end;
  canvas.Font.Style:=[];
    if (its[1]='U') or (its[1]='R') then fname:=FontSmall else fname:=FontEnglish;
  rh:=fh+2;
  rr:=r;
  if (GetDet(2)='C') and (x<r div 2) then rr:=(r div 2)-5;
  if (GetDet(2)='W') and (txs<>'---') then
  begin
    s:=txs;
    while s<>'' do
    begin
      ws:=FitText(canvas,its[1],true,r-x,fh,fname,lw,s);
      if not onlycount then if txs<>'---'then DrawSingleText(canvas,its[1],x,y,r,fh,ws);
      x:=l;
      inc(y,rh);
    end;
  end else
  begin
    s:=txs;
    ws:=FitText(canvas,its[1],false,rr-x,fh,fname,lw,s);
    if not onlycount then if txs<>'---'then DrawSingleText(canvas,its[1],x,y,rr,fh,ws);
    if (not onlycount) and (txs='---') then
    begin
      canvas.MoveTo(l,y+7);
      canvas.LineTo(r,y+7);
    end;
    if rr=r then
    begin
      x:=l;
      inc(y,rh);
    end else x:=rr+5;
  end;
end;

procedure TfKanjiDetails.DrawSingleText(canvas:TCanvas;tp:char;l,t,r,fh:integer;s:string);
var font:string;
begin
  if chin then font:=FontRadical else font:=FontSmall;
  if tp='P' then font:=FontEnglish;
  if (tp='U') or (tp='P') then DrawUnicode(canvas,l,t,fh-2,s,font) else
  if (tp='N') or (tp='T') then canvas.TextOut(r-canvas.TextExtent(s).cx,t,s) else
    canvas.TextOut(l,t,s);
end;

{
Prints as much as possible on a canvas in a specified font.
 canvas: The canvas to print on.
 tp: Text type (non exhaustive list: U for unicode, P for what? )
 wrap: Whether wrapping is allowed (?)
 w: ?
 fh: Font height (also width for full-width unicode)
 fname: Font name
 l: [out] Width of the printed part of text.
 s: [in] Text to print. [out] The non-printed remainer of text.
Returns: width taken by printed part of text
}
function TfKanjiDetails.FitText(canvas:TCanvas;tp:char;wrap:boolean;w,fh:integer;
  fname:string;out l:integer;var s: HellspawnString): HellspawnString;

  function countwidth(tp:char;fh:integer;s:string):integer;
  var ts:TSize;
  begin
    if tp='P' then Result:=0 else
    if tp='U' then Result:=flength(s)*(fh-2) else
    begin
      ts:=canvas.TextExtent(s);
      Result:=ts.cx;
    end;
  end;

var cur_span,last_span:string;
  last_i,i,next_i:integer;
begin
  canvas.Font.Name:=fname;
  canvas.Font.Height:=fh;
  if countwidth(tp,fh,s)<=w then
  begin //Text fits completely
    l:=countwidth(tp,fh,s);
    Result:=s;
    s:='';
    exit;
  end;

  cur_span:='';
  i:=0;
  next_i:=0;
  repeat
    last_span:=cur_span;
    last_i:=i;
    i:=next_i;
    if (tp='U') or (tp='P') then cur_span:=fcopy(s,1,next_i) else cur_span:=copy(s,1,next_i);
    if not wrap then begin
      if (tp='U') or (tp='P') then cur_span:=cur_span+UH_ELLIPSIS else cur_span:=cur_span+'...';
      Inc(next_i);
    end else
    if (tp='U') or (tp='P') then
      Inc(next_i)
    else begin
      Inc(next_i);
      while (next_i<length(s)) and (s[next_i+1]<>' ') do inc(next_i);
    end;
  until countwidth(tp,fh,cur_span)>w;

  if last_span='' then begin
    last_span:=cur_span; //if nothing matches at all, at least print one char
    last_i:=next_i;
  end;

  if last_i<0 then last_i:=0;
  if wrap then
  begin
    result:=last_span;
    if (tp='U') or (tp='P') then fdelete(s,1,last_i) else delete(s,1,last_i);
    l:=countwidth(tp,fh,last_span);
  end else
  begin
    result:=last_span;
    s:='';
    l:=countwidth(tp,fh,last_span);
  end;
end;

procedure TfKanjiDetails.UpdateAlignment;
begin
  if FDockMode in [alNone,alLeft,alRight,alClient] then begin //in free floating mode always not Portrait
    pnlFirst.Align := alTop;
//    pnlFooter.Parent := pnlSecond;
  end else begin
    pnlFirst.Align := alLeft;
//    pnlFooter.Parent := pnlFirst;
  end;
  pnlSecond.Align := alClient;
end;

procedure TfKanjiDetails.FormResize(Sender: TObject);
begin
 { If kept on AutoSize, FlowPanels would not properly realign controls when
  their width is expanded, at all }
  if FlowPanel1.AutoSize then begin
    FlowPanel1.AutoSize := false;
    FlowPanel1.Realign;
    FlowPanel1.AutoSize := true;
  end;
  if FlowPanel2.AutoSize then begin
    FlowPanel2.AutoSize := false;
    FlowPanel2.Realign;
    FlowPanel2.AutoSize := true;
  end;
end;

function TfKanjiDetails.GetDockedWidth: integer;
begin
  if FDockMode in [alLeft,alRight] then
    Result := ClientWidth
  else
    Result := FDockedWidth;
end;

function TfKanjiDetails.GetDockedHeight: integer;
begin
  if FDockMode in [alTop,alBottom] then
    Result := ClientHeight
  else
    Result := FDockedHeight;
end;

procedure TfKanjiDetails.SetDockedWidth(Value: integer);
begin
  FDockedWidth := Value;
//It would be nice to support this, but it might break stuff:
{  if FDockMode in [alLeft,alRight] then
    if HostDockSite<>nil then
      HostDockSite.Width := Value; }
end;

procedure TfKanjiDetails.SetDockedHeight(Value: integer);
begin
  FDockedHeight := Value;
//See comment above.
{  if FDockMode in [alTop,alBottom] then
    if HostDockSite<>nil then
      HostDockSite.Height := Value; }
end;

{ Docker calls these to get docked control sizes }
procedure TfKanjiDetails.WMGetDockedW(var msg: TMessage);
begin
  msg.Result := FDockedWidth;
end;

procedure TfKanjiDetails.WMGetDockedH(var msg: TMessage);
begin
  msg.Result := FDockedHeight;
end;

{ Docker calls this to save docked sizes before undocking }
procedure TfKanjiDetails.WMSaveDockedWH(var msg: TMessage);
begin
  if FDockMode in [alLeft,alRight] then
    FDockedWidth := ClientWidth;
  if FDockMode in [alTop,alBottom] then
    FDockedHeight := ClientHeight;
end;

{ Called before docking or after undocking.
 Configures the form to appear in either Docked or Floating mode,
 rearranging controls. }
procedure TfKanjiDetails.WMSetDockMode(var msg: TMessage);
var Value: TAlign;
begin
  Value := TAlign(msg.WParam);
  if FDockMode=Value then exit;
  FDockMode := Value;
  if Value<>alNone then begin //before dock
   //Remove constraints
    Constraints.MinWidth := 0;
    Constraints.MaxWidth := 0;
    Constraints.MinHeight := 0;
   //Realign
    Self.Hide; //it's okay, we're going to be hidden as part of docking anyway
   { UpdateAlignment may rearrange controls, say, from vertical to horizontal
    and some controls may end up with negative width/height due to current width
    being insufficient.
    See JWBForms for comments }
    with SafeRearrange(Self) do try
      UpdateAlignment;
    finally
      Unlock;
    end;
   //Docked sizes will be applied at docking
    btnDock.Caption:=_l('#00172^eUndock');
  end else begin //after undock
   //The form is hidden.
   //Realign
    with SafeRearrange(Self) do try
      UpdateAlignment;
    finally
      Unlock;
    end;
   //Add constraints when undocked
    Constraints.MinWidth := 337;
    Constraints.MaxWidth := 337;
    Constraints.MinHeight := 320;
    btnDock.Caption:=_l('#00173^eDock');
  end;
end;

{ In contrast to WMSetDockMode, this is called before and after a LOGICAL
 dock mode change.
 In other words, while fKanjiDetails is hidden on some pages and PRACTICALLY
 undocked, logically it stays docked and needs not to restore it's undocked
 position. }
procedure TfKanjiDetails.SetDocked(Value: boolean; Loading: boolean);
begin
  if Value then begin //before dock
   {$IFNDEF NO_KD_PLACEMENT}
    if (not Loading) and FormPlacement1.PlacementRestored then
      FormPlacement1.SaveFormPlacement; //save placement before breaking it with docking
   {$ENDIF}
  end else begin //after undock
    if Loading then begin
     //Issue 161: if Loading and undocked, we won't get SetDockMode otherwise, and we have stuff to configure
     //This is hackish.
      Self.Hide;
      FDockMode := alCustom;
      Perform(WM_SET_DOCK_MODE, integer(alNone), 0);
    end;
   {$IFNDEF NO_KD_PLACEMENT}
    FormPlacement1.RestoreFormPlacement([]); //docking breaks placement so we restore it
   {$ENDIF}
  end;
end;

initialization
  curradical:='';

end.
