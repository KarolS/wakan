unit TextTable;

interface
uses MemSource,Classes,SysUtils,Dialogs,StdPrompt,Windows,JWBStrings,JWBIO;

{
Unicode status:
- Table formats aren't going to change and some fields in some tables are
 kept in Ansi hex.
- Strings are returned as FStrings (although not typed as such):
    Ansi field @ Ansi compiler     =>  Ansi contents
    Ansi field @ Unicode compiler  =>  Ansi contents in UnicodeString
    Wide field @ Ansi compiler     =>  Ansi hex contents
    Wide field @ Unicode compiler  =>  Unicode contents
 So basically, you get unchanged text from Ansi fields (and it might be hex)
 and FString from Unicode fields.
}

{
TextTable relies heavily on in-memory structures.
Table header is always kept in memory, and if TextTable.offline is true then
the whole table is, too.
Otherwise the data is read from the disk on demand. 
}

{$DEFINE CURSOR_IN_TABLE}
{ To navigate TTextTable you must use TTextTableCursor.
 However, old code used to call TTextTable.First/Next and so we keep a copy
 of a cursor code inside of a TTextTable. }

{$DEFINE TTSTATS}
{ Keep some potentially slow statistics about table and it's usage.
 Maybe this should only be limited to debug builds. }

const
  AllocDataBufferSz=65536;
  AllocOrderBufferSz=1024;
  AllocStructBufferSz=1024;

type
 { Seek table reference to speed up Locate()
  Retrieve it once, use instead of a textual name.
  For common tables and common seeks, global references are kept. }
  TSeekObject = record
    ind_i: integer; //seek table index
    fld_i: integer; //field index
    reverse: boolean;
  end;
  PSeekObject = ^TSeekObject;

 { Seek table descriptions, parsed to this binary format on load. }
  TSeekFieldDescription = record
    index: integer; //field index
    reverse: boolean;
    strdata: boolean //treat field data as string
  end;
  PSeekFieldDescription = ^TSeekFieldDescription;
  TSeekFieldDescriptions = array of TSeekFieldDescription;

  TSeekDescription = record
    fields: TSeekFieldDescriptions;
  end;
  PSeekDescription = ^TSeekDescription;
  TSeekDescriptions = array of TSeekDescription;

  TTextTableCursor = class;

  TTextTable=class
  protected
   { Table can be loaded/created in-memory or it can be disk-backed.
    When loading from disk, these must be set. }
    Source:TPackageSource;
    Offline:boolean; //do not load all data into memory, only table headers

   { Create-time flags }
    NeedCreateData:boolean; //set if info-schema asked for CreateData
    Precounted:boolean; //set if info-schema says table data is precounted

   //Internal functions, call public ones instead
    constructor Create; overload;
    procedure LoadInfo(AInfo:TStream);
    procedure CreateData();
    procedure LoadData(const AFilename:string;ARawRead:boolean); //only from Source
    procedure PrintDataStats();

  public
    constructor Create(ASource:TPackageSource;const AFilename:string;ARawread,AOffline:boolean); overload;
    constructor Create(AInfo:TStream); overload;
    constructor Create(AInfoLines:array of string); overload;
    destructor Destroy; override;

  public
   { Table settings -- loaded from table configuration }
    rawindex:boolean;
    prebuffer:boolean;
    wordfsize:boolean; //Table stores variable field sizes in Words, not Bytes

   { Fields }
    fieldlist:TStringList; //field names
    fieldtypes:string; //field types
    fieldsizes:string; //see Load()/GetFieldSize()
    fieldcount:byte;
    fieldbuild:TStringList; //type+field names (iIndex, sName)
    varfields_sz:integer; //cached size of variable-length fields part in a struct record

   { Seek table names.
    The point of seek table is to keep records sorted in a particular order.
    The way it's done now, you just have to KNOW what order was that,
    if you're going to use the index. }
    seeks:TStringList;
   { Seek table descriptions in the form "field1+field2+field3".
    Loaded from the table file, used to rebuild indexes if needed.
    First field name ("field1") becomes seek table name }
    seekbuild:TStringList;
    seekbuilddesc:TSeekDescriptions; //Seek table descriptions, parsed.
   { Orders are the same as seekbuilds, only they have different names
     and there's 1 less of them:
                  == seekbuild[0]
        orders[0] == seekbuild[1]
        orders[1] == seekbuild[2]
        ...etc
     Don't ask me why it's like that.
     If you need to expose seek[0] as an order, make it seek[1] by adding
     seekbuild[0]=='0' before it.  }
    orders:TStringList;

    reccount:integer;
    numberdeleted:integer;
    datafpos:integer;
    function FilterPass(rec:integer;fil:string):boolean;
    function TransOrder(rec,order:integer):integer; inline;
    function IsDeleted(rec:integer):boolean;

   //Record sorting
    function ParseSeekDescription(fld:string): TSeekFieldDescriptions;
    function SortRec(r:integer;const fields:TSeekFieldDescriptions):string; overload; //newer cooler version
    function SortRec(r:integer;seekIndex:integer):string; overload; {$IFDEF INLINE}inline;{$ENDIF}
    function SortRecByStr(r:integer; fld:string):string; deprecated;

  protected
   {
    Data: Table data. Raw data, indexed by struct.
    Struct: Record headers.
      Each headers is of size (5+#_of_variable_fields):
        Deleted: boolean, 1 byte
        DataOffset: integer, 4 byte
        For every variable-length field: DataSize: 1 byte
    Index: sorting orders
      array [0..IndexCount-1] x [0..RecCount-1] of RecordNo: integer;
   }
    data,struct,index:pointer;
    databuffer,structbuffer:integer; //free memory available in data and struct ptrs
    datalen:integer; //data length (used)
    struct_recsz:integer; //struct record size
   //Buffer expansion
    procedure ReserveData(const sz: integer);
    procedure ReserveStruct(const sz: integer);

  public
    procedure Reindex;
    function CheckIndex:boolean;
    function Field(const field:string):integer;
    function HasIndex(const index:string):boolean;
    procedure WriteTable(const filename:string;nodelete:boolean);
    property RecordCount:integer read reccount;
    function NewCursor: TTextTableCursor;


  public //Import/export
    procedure ExportToText(t:TCustomFileWriter;ord:string);
    procedure ImportFromText(t:TCustomFileReader;smf:TSMPromptForm;mess:string);

  protected
    nocommit:boolean; //do not update indexes on Add/Edit/Delete. You'll have to Reindex later.
  public
    function AddRecord(values:array of string): integer;
    procedure DeleteRecord(RecNo: integer);
    procedure EditRecord(RecNo: integer; const fields:array of byte;
      const values:array of string; JustInserted:boolean=false);
    procedure Commit(RecNo:integer; JustInserted: boolean = false);
    property NoCommitting:boolean read nocommit write nocommit;

  protected //Field reading
    function GetDataOffset(rec:integer;field:integer):integer;
  public
    function GetFieldSize(recno,field:integer):word;
    function GetField(rec:integer;field:integer):string;
    function GetIntField(rec:integer;field:integer;out value:integer):boolean;
    function GetAnsiField(rec:integer;field:integer):AnsiString;
    procedure SetField(rec:integer;field:integer;const value:string);
    procedure SetAnsiField(rec:integer;field:integer;const value:AnsiString);

  public
    function GetSeekObject(seek: string): TSeekObject;
    function LocateRecord(seek: PSeekObject; value:string; out idx: integer):boolean; overload;
    function LocateRecord(seek: PSeekObject; value:integer; out idx: integer):boolean; overload;

 {$IFDEF CURSOR_IN_TABLE}
  protected
    _intcur: TTextTableCursor;
  public
    procedure First;
    procedure Next;
    function EOF:boolean;
    procedure SetOrder(const index:string);
    procedure SetFilter(const filtr:string);
    function Test(const fil:string):boolean;
  public
    procedure Insert(values:array of string);
    procedure Delete; {$IFDEF INLINE}inline;{$ENDIF}
    procedure Edit(const fields:array of byte;const values:array of string);
    function Locate(seek: PSeekObject; const value:string):boolean; overload; {$IFDEF INLINE}inline;{$ENDIF}
    function Locate(const seek,value:string):boolean; overload; {$IFDEF INLINE}inline;{$ENDIF}
    function Locate(seek:PSeekObject; const value:integer):boolean; overload; {$IFDEF INLINE}inline;{$ENDIF}
    function Locate(const seek:string; const value:integer):boolean; overload; {$IFDEF INLINE}inline;{$ENDIF}
  public
    function Str(field:integer):string; {$IFDEF INLINE}inline;{$ENDIF}
    function Int(field:integer):integer; {$IFDEF INLINE}inline;{$ENDIF}
    function TrueInt(field:integer):integer; {$IFDEF INLINE}inline;{$ENDIF}
    function Bool(field:integer):boolean; {$IFDEF INLINE}inline;{$ENDIF}
   {$IFDEF UNICODE}
    function Fch(field:integer):WideChar; {$IFDEF INLINE}inline;{$ENDIF}
   {$ELSE}
    function Fch(field:integer):string; {$IFDEF INLINE}inline;{$ENDIF}
   {$ENDIF}
 {$ENDIF}

  end;
  TDataCache=array[0..30,0..1] of word;

 { Implements navigation through TextTable records. }
  TTextTableCursor = class
  protected
    FTable: TTextTable;
    cur: integer; //current position in index
    curorder:integer;
    filter:string;
  public
    tcur: integer; //current RecdNo (for this index position)
    constructor Create(ATable: TTextTable);
    procedure First;
    procedure Next;
    function EOF:boolean;
    procedure SetOrder(const index:string);
    procedure SetFilter(const filtr:string);
    function Test(const fil:string):boolean;
    property Table: TTextTable read FTable;

  public
   { Write access to TTextTable MUST BE EXCLUSIVE. ALWAYS. NO EXCEPTIONS. }
    procedure Insert(values:array of string);
    procedure Delete; {$IFDEF INLINE}inline;{$ENDIF}
    procedure Edit(const fields:array of byte; const values:array of string);

  public
    function Locate(seek:PSeekObject; const value:string):boolean; overload; {$IFDEF INLINE}inline;{$ENDIF}
    function Locate(const seek,value:string):boolean; overload; {$IFDEF INLINE}inline;{$ENDIF}
    function Locate(seek:PSeekObject; const value:integer):boolean; overload; {$IFDEF INLINE}inline;{$ENDIF}
    function Locate(const seek:string; const value:integer):boolean; overload; {$IFDEF INLINE}inline;{$ENDIF}


  public
    function Str(field:integer):string; {$IFDEF INLINE}inline;{$ENDIF}
    function AnsiStr(field:integer):AnsiString; {$IFDEF INLINE}inline;{$ENDIF}
    function Int(field:integer):integer; {$IFDEF INLINE}inline;{$ENDIF}
    function TrueInt(field:integer):integer; {$IFDEF INLINE}inline;{$ENDIF}
    function Bool(field:integer):boolean; {$IFDEF INLINE}inline;{$ENDIF}
   {$IFDEF UNICODE}
    function Fch(field:integer):WideChar; {$IFDEF INLINE}inline;{$ENDIF}
   {$ELSE}
    function Fch(field:integer):string; {$IFDEF INLINE}inline;{$ENDIF}
   {$ENDIF}
    function Dehex(field:integer):FString; {$IFDEF INLINE}inline;{$ENDIF}

  end;

procedure ShowAllocStats;

function BoolToStr(b: boolean): string;

implementation

var
  dataalloc,structalloc,indexalloc:integer;
 {$IFDEF TTSTATS}
  statlist:TStringList;
 {$ENDIF}

procedure ShowAllocStats;
begin
 {$IFDEF TTSTATS}
  statlist.SaveToFile('tablestats.txt');
  winexec('notepad.exe tablestats.txt',SW_SHOW);
 {$ELSE}
  raise Exception.Create('Table level statistics not available in this build.');
 {$ENDIF}
end;

function OffsetPtr(source: pointer; ofs: integer): PByte; inline;
begin
  Result := PByte(IntPtr(source)+ofs);
end;

procedure MoveOfs(source,dest:pointer;ofssource,ofsdest:integer;size:integer);
var sp,dp:pbyte;
begin
  sp:=source;
  sp:=PByte(IntPtr(sp)+ofssource); //older Delphi versions can't add pointers
  dp:=dest;
  dp:=PByte(IntPtr(dp)+ofsdest);
  move(sp^,dp^,size);
end;

//That's how TextTable stores bools
function BoolToStr(b:boolean): string;
begin
  if b then Result:='T' else Result:='F';
end;

//Basic Create() to be called by all customized versions
constructor TTextTable.Create;
begin
  inherited Create;
  fieldlist:=TStringList.Create;
  seeks:=TStringList.Create;
  seekbuild:=TStringList.Create;
  orders:=TStringList.Create;
  data:=TStringList.Create;
  fieldbuild:=TStringList.Create;
 {$IFDEF CURSOR_IN_TABLE}
  _intcur := TTextTableCursor.Create(Self);
 {$ENDIF}
  nocommit:=false;
  numberdeleted:=0;
  rawindex:=false;
  self.offline:=false;
end;

{ Loads the table schema and, where possible, the data from disk.
 When ASource is set, AFilename is a file path inside it. }
constructor TTextTable.Create(ASource:TPackageSource;const AFileName:string;ARawread,AOffline:boolean);
var mf: TMemoryFile;
  ms: TStream;
begin
  Self.Create();
  Self.Source:=ASource;
  Self.Offline:=AOffline;

 {$IFDEF TTSTATS}
  if Source<>nil then
    statlist.Add(source.FileName+'->'+AFilename)
  else
    statlist.Add('->'+AFilename);
 {$ENDIF}

 { As an exception, when Source is not set, the file is assumed to be from
  native FS and required to contain $CREATE schema.
  Data files can not be loaded from native FS at this time. }
  if Source<>nil then
  begin
    mf:=Source[AFilename+'.info'];
    if mf=nil then raise Exception.Create('TextTable: Important file missing.');
    ms:=mf.Lock;
  end else begin
    mf:=nil;
    ms:=TFileStream.Create(AFilename,fmOpenRead);
  end;

  LoadInfo(ms);

  if mf<>nil then begin
    mf.Unlock;
    ms := nil;
  end else
    FreeAndNil(ms);

  if NeedCreateData then begin
    CreateData();
    NeedCreateData := false;
  end else
    LoadData(AFilename, ARawRead);

  PrintDataStats();
end;

{ Creates a new empty table according to a info-schema taken from a stream }
constructor TTextTable.Create(AInfo:TStream);
begin
  Self.Create();
  Self.Offline:=false; //can only create data in memory at this time
  LoadInfo(AInfo);
  CreateData();
 {$IFDEF TTSTATS}
  statlist.Add('New table created.');
 {$ENDIF}
end;

{ Sometimes in code it's handier to specify schema line by line }
constructor TTextTable.Create(AInfoLines:array of string);
var ms: TMemoryStream;
  a_line: AnsiString;
  i: integer;
begin
  ms := TMemoryStream.Create;
  try
    for i := Low(AInfoLines) to High(AInfoLines) do begin
      a_line := AnsiString(AInfoLines[i]+#13#10);
      ms.Write(a_line[1], Length(a_line)*SizeOf(AnsiChar));
    end;
    ms.Seek(0, soFromBeginning);
    Self.Create(ms);
  finally
    FreeAndNil(ms);
  end;
end;

{ Reads the database schema from an .info file.  }
procedure TTextTable.LoadInfo(AInfo:TStream);
var sl:TStringList;
  section:char; //current section when parsing info
  s_seek:string;
  i:integer;
begin
  sl:=TStringList.Create;
  sl.LoadFromStream(AInfo);
  NeedCreateData:=false;

  section:=' ';
  prebuffer:=false;
  Precounted:=false;
  wordfsize:=false;
  for i:=0 to sl.Count-1 do
  begin
    if sl[i]='$FIELDS' then section:='f';
    if sl[i]='$ORDERS' then section:='o';
    if sl[i]='$SEEKS' then section:='s';
    if sl[i]='$PREBUFFER' then prebuffer:=true;
    if sl[i]='$PRECOUNTED' then Precounted:=true;
    if sl[i]='$CREATE' then NeedCreateData:=true;
    if sl[i]='$RAWINDEX' then rawindex:=true;
    if sl[i]='$WORDFSIZE' then wordfsize:=true;
    if (length(sl[i])>0) and (sl[i][1]<>'$') then
    case section of
      'f':fieldlist.Add(sl[i]);
      'o':orders.Add(sl[i]);
      's':seeks.Add(sl[i]);
    end;
  end;
  sl.Free;

  fieldcount:=fieldlist.Count;
  fieldtypes:='';
  for i:=0 to fieldcount-1 do fieldtypes:=fieldtypes+fieldlist[i][1];

  varfields_sz:=0;
  fieldsizes:='';
  for i:=0 to fieldcount-1 do
  begin
    if (fieldtypes[i+1]='s') or (fieldtypes[i+1]='x') then begin
      fieldsizes:=fieldsizes+chr(ord('a')+varfields_sz);
      if wordfsize then
        inc(varfields_sz,2)
      else
        inc(varfields_sz,1);
    end else case fieldtypes[i+1] of
      'b':fieldsizes:=fieldsizes+'1';
      'w':fieldsizes:=fieldsizes+'2';
      'i':fieldsizes:=fieldsizes+'4';
      'l':fieldsizes:=fieldsizes+'1';
    end;
  end;
  struct_recsz := 5+varfields_sz;

  for i:=0 to seeks.Count-1 do
  begin
   //Add to seekbuild
    seekbuild.Add(seeks[i]);
   //Will parse to seekbuilddesc later when all schema is loaded
   //Add to seek
    s_seek:=seeks[i];
    if pos('+',seeks[i])>0 then system.delete(s_seek,pos('+',seeks[i]),length(seeks[i])-pos('+',seeks[i])+1);
    seeks[i]:=s_seek;
  end;

  for i:=0 to fieldlist.Count-1 do
  begin
    fieldbuild.Add(fieldlist[i]);
    fieldlist[i]:=copy(fieldlist[i],2,length(fieldlist[i])-1);
  end;

 //Parse seekbuilds -- after schema has been loaded
  SetLength(seekbuilddesc, seekbuild.Count);
  for i := 0 to seekbuild.Count - 1 do begin
   //First seekbuild is sometimes '0' and we don't actually seek by it
    if (i=0) and (seekbuild[0]='0') then begin
      SetLength(seekbuilddesc[i].fields, 0);
      continue;
    end;
    seekbuilddesc[i].fields := ParseSeekDescription(seekbuild[i]);
  end;
end;

{ Initialized empty table indexes and data in memory.
 Only info-schema is required to be parsed by this point. }
procedure TTextTable.CreateData();
begin
  reccount:=0;
  if prebuffer then
    databuffer := AllocDataBufferSz
  else
    databuffer := 0;
  GetMem(data,databuffer);
  GetMem(index,0);
  if prebuffer then
    structbuffer := AllocStructBufferSz
  else
    structbuffer := 0;
  GetMem(struct,structbuffer);
  datalen:=0;
end;

{ Loads table indexes and data from Source.
 Info-schema is required to be parsed by this point. When Offline==true, only
 loads parts of data. }
procedure TTextTable.LoadData(const AFilename:string;ARawRead:boolean);
var bufsize:integer;
  mf:TMemoryFile;
  ms:TStream;
  datasize:integer;
 {$IFDEF TTSTATS}
  totalloc:integer;
 {$ENDIF}

 //For re-counting
  strubuf:pointer;
  struptr:PAnsiChar;
  i,j,k,vk:integer;
  w:word;
  b:byte;
  ww:array[0..511] of byte;
  fs:string;
begin
  if prebuffer then
    bufsize := AllocDataBufferSz
  else
    bufsize := 0;
  mf:=source[AFilename+'.data'];
  if mf=nil then raise Exception.Create('TextTable: Important file missing.');
  if not ARawread then
  begin
    ms:=mf.Lock;
    databuffer:=bufsize;
    GetMem(data,ms.Size+bufsize);
    datalen:=ms.Size-4;
    datasize:=ms.Size;
    ms.Read(data^,4);
    moveofs(data,@reccount,0,0,4);
    ms.Read(data^,datalen);
    mf.Unlock;
  end else
  begin
    if offline then GetMem(data,4) else GetMem(data,mf.Size+bufsize);
    datalen:=mf.Size-4;
    datasize:=mf.Size;
    source.ReadRawData(data^,integer(mf.Position),4);
    datafpos:=IntPtr(mf.Position)+4;
    moveofs(data,@reccount,0,0,4);
    if not offline then
    begin
      source.ReadRawData(data^,integer(mf.Position)+4,datalen);
    end;
  end;
  dataalloc:=dataalloc+(mf.Size+bufsize) div 1024;
  {$IFDEF TTSTATS}
  statlist.Add('  Records: '+inttostr(reccount));
  statlist.Add('  Indexes: '+inttostr(orders.Count));
  statlist.Add('  Data size: '+inttostr((mf.Size+bufsize) div 1000)+'k');
  totalloc:=mf.Size+bufsize;
  {$ENDIF}
  mf:=source[AFilename+'.index'];
  if mf=nil then raise Exception.Create('TextTable: Important file missing.');
  if not ARawread then
  begin
    ms:=mf.Lock;
    GetMem(index,ms.Size);
    ms.Read(index^,ms.Size);
    mf.Unlock;
  end else
  begin
    GetMem(index,mf.Size);
    source.ReadRawData(index^,integer(mf.Position),mf.Size);
  end;
  indexalloc:=indexalloc+mf.Size div 1024;
  {$IFDEF TTSTATS}
  statlist.Add('  Indexes size: '+inttostr(mf.Size div 1000)+'k');
  totalloc:=totalloc+mf.Size;
  {$ENDIF}
  mf:=source[AFilename+'.struct'];
  if mf=nil then raise Exception.Create('TextTable: Important file missing.');
  if prebuffer then
    bufsize := AllocStructBufferSz
  else
    bufsize := 0;
  structbuffer:=bufsize;
  if not ARawread then
  begin
    ms:=mf.Lock;
    GetMem(struct,ms.Size+bufsize);
    ms.Read(struct^,ms.Size);
    mf.Unlock;
   { if mf.Size>4 then
    begin
      showmessage(inttostr(mf.Size)+'.');
      moveofs(strubuf,@i,mf.Size-3,0,4);
      showmessage(inttostr(i));
    end; }
  end else
  begin
    GetMem(struct,mf.Size+bufsize);
    source.ReadRawData(struct^,integer(mf.Position),mf.Size);
   { if mf.Size>4 then
    begin
      showmessage(inttostr(mf.Size)+'.');
      moveofs(strubuf,@i,mf.Size-3,0,4);
      showmessage(inttostr(i));
    end; }
  end;
  structalloc:=structalloc+(mf.Size+bufsize) div 1024;
  {$IFDEF TTSTATS}
  if not precounted then
    statlist.Add('  Structure size: '+inttostr((mf.Size+bufsize+reccount*5) div 1000)+'k')
  else
    statlist.Add('  Structure size: '+inttostr((mf.Size+bufsize) div 1000)+'k');
  totalloc:=totalloc+mf.Size+bufsize;
  statlist.Add('  Total size: '+inttostr(totalloc div 1000)+'k');
  {$ENDIF}
  if not precounted and offline then
    raise Exception.Create('OFFLINE table must be PRECOUNTED!');
  if not precounted then
  begin
    structalloc:=structalloc+(reccount*5) div 1024;
    dec(datasize,4);
    strubuf:=struct;
    struptr:=strubuf;
    struct:=nil;
    GetMem(struct,reccount*struct_recsz+bufsize);
    fs:='';
    for i:=0 to fieldcount-1 do fs:=fs+fieldbuild[i][1];
    i:=0;
    w:=0;
    j:=0;
    k:=0;
    vk:=0;
    while i<datasize do
    begin
      case fs[k+1] of
        'b':b:=1;
        'w':b:=2;
        'i':b:=4;
        'l':b:=1;
        'x','s':begin
          b:=ord(struptr^);
          inc(struptr);
          ww[vk]:=b;
          if wordfsize then begin
            ww[vk+1]:=0;
            inc(vk,2);
          end else
            inc(vk,1);
        end;
      end;
      inc(w,b);
      inc(k);
      if k=fieldcount then
      begin
        k:=0;
        b:=0;
        moveofs(@b,struct,0,j,1);
        moveofs(@i,struct,0,j+1,4);
        moveofs(@ww,struct,0,j+5,varfields_sz);
        inc(j,struct_recsz);
        inc(i,w);
        w:=0;
        vk:=0;
      end;
    end;
    FreeMem(strubuf);
    if j>reccount*struct_recsz+bufsize then
      raise Exception.Create('Table "'+AFilename+'" is corrupt.');
    dec(datasize,i);
    if datasize<>0 then
      raise Exception.Create('Table "'+AFilename+'" is corrupt.');
  end;
end;

{ Outputs total size of all data in every column into stats log.
 Maybe we should make this run only on debug? I bet it's slow. }
procedure TTextTable.PrintDataStats();
{$IFDEF TTSTATS}
var i, j, cn: integer;
{$ENDIF}
begin
 {$IFDEF TTSTATS}
  for i:=0 to fieldcount-1 do
  begin
    cn:=0;
    for j:=0 to reccount-1 do inc(cn,GetFieldSize(j,i));
    statlist.Add('  Field '+fieldlist[i]+': '+inttostr(cn div 1000)+'k');
  end;
  statlist.Add('');
 {$ENDIF}
end;

procedure TTextTable.WriteTable(const filename:string;nodelete:boolean);
procedure wfbuf(var f:file;buf:pointer;var bufpos:integer;buflimit:integer;source:pointer;sourcepos,sourcelength:integer);
begin
  if bufpos+sourcelength<buflimit then
  begin
    moveofs(source,buf,sourcepos,bufpos,sourcelength);
    inc(bufpos,sourcelength);
  end else
  begin
    blockwrite(f,buf^,bufpos);
    bufpos:=0;
    moveofs(source,buf,sourcepos,bufpos,sourcelength);
    inc(bufpos,sourcelength);
  end;
end;
var t:textfile;
    i,j,k:integer;
    il:TStringList;
    b:byte;
    f1,f2:file;
    bufdata,bufstruct,buforder:pointer;
    bufdatapos,bufstructpos,buforderpos:integer;
    c:char;
    l:integer;
    w:word;
    mypos:integer;
begin
  if offline then
    raise Exception.Create('Cannot save to "'+filename+'": cannot write offline table.');
  assignfile(t,filename+'.info');
  rewrite(t);
  writeln(t,'$TEXTTABLE');
  if prebuffer then writeln(t,'$PREBUFFER');
  writeln(t,'$PRECOUNTED');
  if rawindex then writeln(t,'$RAWINDEX');
  if wordfsize then writeln(t,'$WORDFSIZE');
  writeln(t,'$FIELDS');
  for i:=0 to fieldbuild.Count-1 do writeln(t,fieldbuild[i]);
  writeln(t,'$ORDERS');
  for i:=0 to orders.Count-1 do writeln(t,orders[i]);
  writeln(t,'$SEEKS');
  for i:=0 to seekbuild.Count-1 do writeln(t,seekbuild[i]);
  closefile(t);
  il:=TStringList.Create;
  j:=0;
  assignfile(f1,filename+'.data');
  rewrite(f1,1);
  assignfile(f2,filename+'.struct');
  rewrite(f2,1);
  getmem(bufdata,64000);
  getmem(bufstruct,64000);
  getmem(buforder,64000);
  if nodelete then
  begin
    i:=recordcount;
    blockwrite(f1,i,4);
    blockwrite(f1,data^,datalen);
    blockwrite(f2,struct^,reccount*struct_recsz);
    closefile(f1);
    closefile(f2);
    assignfile(f1,filename+'.index');
    rewrite(f1,1);
    blockwrite(f1,index^,orders.Count*reccount*4);
    closefile(f1);
  end else
  begin
    bufdatapos:=0; bufstructpos:=0; buforderpos:=0;
    i:=recordcount-numberdeleted;
    wfbuf(f1,bufdata,bufdatapos,64000,@i,0,4);
    mypos:=0;
    for i:=0 to recordcount-1 do
    begin
      moveofs(struct,@b,i*struct_recsz,0,1);
      if b=1 then il.Add('DEAD') else
      begin
        wfbuf(f2,bufstruct,bufstructpos,64000,@b,0,1);
        wfbuf(f2,bufstruct,bufstructpos,64000,@mypos,0,4);
        il.Add(inttostr(j));
        inc(j);
        w:=0;
        moveofs(struct,@l,i*struct_recsz+1,0,4);
        for k:=0 to fieldcount-1 do
        begin
          b:=GetFieldSize(i,k);
          c:=fieldtypes[k+1];
          if (c='x') or (c='s') then
            wfbuf(f2,bufstruct,bufstructpos,64000,@b,0,1);
          wfbuf(f1,bufdata,bufdatapos,64000,data,l+w,b);
          w:=w+b;
          mypos:=mypos+b;
        end;
      end;
    end;
    blockwrite(f1,bufdata^,bufdatapos);
    blockwrite(f2,bufstruct^,bufstructpos);
    closefile(f1);
    closefile(f2);
    assignfile(f1,filename+'.index');
    rewrite(f1,1);
    for i:=0 to orders.Count-1 do for j:=0 to recordcount-1 do
    begin
      l:=TransOrder(j,i);
      if il[l]<>'DEAD' then
      begin
        l:=strtoint(il[l]);
        wfbuf(f1,buforder,buforderpos,64000,@l,0,4);
      end;
    end;
    blockwrite(f1,buforder^,buforderpos);
    closefile(f1);
  end;
  freemem(bufdata,64000);
  freemem(bufstruct,64000);
  freemem(buforder,64000);
end;

destructor TTextTable.Destroy;
begin
  seeks.Free;
  orders.Free;
  fieldlist.Free;
  seekbuild.Free;
  fieldbuild.Free;
  freemem(data);
  freemem(index);
  freemem(struct);
end;

function TTextTable.NewCursor: TTextTableCursor;
begin
  Result := TTextTableCursor.Create(Self);
end;


{
GetFieldSize()
Heavily used function. Should be very optimized.
}
function TTextTable.GetFieldSize(recno,field:integer):word;
var c:char;
begin
  c:=fieldsizes[field+1];
  if (c>='1') and (c<='9') then
    Result := ord(c)-ord('0')
  else
    if wordfsize then
      Result := PWord(OffsetPtr(struct, recno*struct_recsz+(ord(c)-ord('a'))+5))^
    else
      Result := OffsetPtr(struct, recno*struct_recsz+(ord(c)-ord('a'))+5)^;
end;

function TTextTable.GetDataOffset(rec:integer;field:integer):integer;
var i,ii:integer;
begin
  ii:=rec*struct_recsz;
  Result:=PInteger(OffsetPtr(struct, ii+1))^;
  for i:=0 to field-1 do Result:=Result+GetFieldSize(rec,i);
end;

//Swaps bytes in every word
//sz is the number of bytes
procedure SwapBytes(pb: PByte; sz: integer); inline;
var b: byte;
  i: integer;
begin
  //Swap bytes
  for i := 0 to sz div 2 - 1 do begin
    b := PByteArray(pb)[2*i+0];
    PByteArray(pb)[2*i+0] := PByteArray(pb)[2*i+1];
    PByteArray(pb)[2*i+1] := b;
  end;
end;

{
Read the field value for a record.
This is a HEAVILY used function, so let's be as fast as we can.
Everything which is already in memory is read from memory directly. If we're
working in offline mode, it's read from the disc in one go.
}
function TTextTable.GetField(rec:integer;field:integer):string;
{$IFNDEF UNICODE}
const HexChars: AnsiString = '0123456789ABCDEF';
{$ENDIF}
var ofs:integer;
  sz:word;
  tp:char; //field type. Char because FieldTypes is string.
  b:byte;
  w:word;
  l:integer;
  c: AnsiChar;
 {$IFDEF UNICODE}
  ansi_s: AnsiString;
 {$ELSE}
  pb: PByte;
  pc: PChar;
 {$ENDIF}
begin
  if rec>=reccount then
    raise Exception.Create('Read beyond!');
  ofs:=GetDataOffset(rec,field);
  tp:=fieldtypes[field+1];
  sz:=GetFieldSize(rec,field);
  case tp of
  'b': begin
     if offline then
       source.ReadRawData(b,datafpos+ofs,1)
     else
       b := OffsetPtr(data, ofs)^;
     result:=inttostr(b);
   end;
  'w':begin
     if offline then
       source.ReadRawData(w,datafpos+ofs,2)
     else
       w := PWord(OffsetPtr(data, ofs))^;
     result:=inttostr(w);
   end;
  'i':begin
     if offline then
       source.ReadRawData(l,datafpos+ofs,4)
     else
       l := PInteger(OffsetPtr(data, ofs))^;
     result:=inttostr(l);
   end;
  'l':begin
     if offline then
       source.ReadRawData(c,datafpos+ofs,1)
     else
       c := PAnsiChar(OffsetPtr(data, ofs))^;
     if (c>#0) and (c<>'F') and (c<>'f') then c:='T' else c:='F';
     result:=Char(c);
   end;
  //AnsiString.
  's':begin
    {$IFNDEF UNICODE}
     SetLength(Result, sz);
     if offline then
       source.ReadRawData(PAnsiChar(Result)^,datafpos+ofs,sz)
     else
       move(OffsetPtr(data, ofs)^, PAnsiChar(Result)^, sz);
    {$ELSE}
     SetLength(ansi_s, sz);
     if offline then
       source.ReadRawData(PAnsiChar(ansi_s)^,datafpos+ofs,sz)
     else
       move(OffsetPtr(data, ofs)^, PAnsiChar(ansi_s)^, sz);
     Result := string(ansi_s);
    {$ENDIF}
   end;
  //UnicodeString. On non-unicode compilers reads as hex, thus 'x'.
  'x': begin
    {$IFDEF UNICODE}
     SetLength(Result, sz div 2 + sz mod 2);
     if offline then
       source.ReadRawData(PWideChar(Result)^,datafpos+ofs,sz)
     else
       move(OffsetPtr(data, ofs)^, PWideChar(Result)^, sz);
     SwapBytes(PByte(Result), sz);
    {$ELSE}
     SetLength(Result, 2*sz);
     if offline then begin
      //If we're offline we beter read everything in one go!
      //Position it in the second half of the buffer so that it won't be
      //overwritten too early when we rewrite the string.
       source.ReadRawData(Result[sz+1],datafpos+ofs,sz);
       pb := PByte(@Result[sz+1]);
     end else
      //If we have data in memory, let's just use it from there.
       pb := OffsetPtr(data, ofs);
     pc := PChar(@Result[1]);
     for l:=0 to sz-1 do begin
       pc^ := char(HexChars[1 + pb^ shr 4]);
       Inc(pc);
       pc^ := char(HexChars[1 + pb^ and $0F]);
       Inc(pc);
       Inc(pb);
     end;
    {$ENDIF}
   end;
  end;
end;

//If the field is numeric, reads it without conversions,
//else does the usual "read string + StrToInt" routine.
function TTextTable.GetIntField(rec:integer;field:integer;out value: integer):boolean;
var tp: char;
  ofs: integer;
  b: byte;
  w: word;
  l: integer;
  s: string;
begin
  tp:=fieldtypes[field+1];
  case tp of
  'b': begin
     ofs:=GetDataOffset(rec,field);
     if offline then
       source.ReadRawData(b,datafpos+ofs,1)
     else
       b := OffsetPtr(data, ofs)^;
     value:=b;
     Result:=true;
   end;
  'w':begin
     ofs:=GetDataOffset(rec,field);
     if offline then
       source.ReadRawData(w,datafpos+ofs,2)
     else
       w := PWord(OffsetPtr(data, ofs))^;
     value:=w;
     Result:=true;
   end;
  'i':begin
     ofs:=GetDataOffset(rec,field);
     if offline then
       source.ReadRawData(l,datafpos+ofs,4)
     else
       l := PInteger(OffsetPtr(data, ofs))^;
     value:=l;
     Result:=true;
   end;
  else
    s := GetField(rec,field);
    if (length(s)>0) and (s[length(s)]='''') then system.delete(s,length(s),1);
    if (length(s)>0) and (s[1]='''') then system.delete(s,1,1);
    Result := TryStrToInt(s, value);
  end;
end;

{ Useful when you don't want the Unicode->Ansi conversion to interfere, such as for RawByteStrings }
function TTextTable.GetAnsiField(rec:integer;field:integer):AnsiString;
var ofs:integer;
  sz:word;
  tp:char; //field type. Char because FieldTypes is string.
begin
  if rec>=reccount then
    raise Exception.Create('Read beyond!');
  ofs:=GetDataOffset(rec,field);
  tp:=fieldtypes[field+1];
  sz:=GetFieldSize(rec,field);
  case tp of
  //AnsiString.
  's':begin
     SetLength(Result, sz);
     if offline then
       source.ReadRawData(PAnsiChar(Result)^,datafpos+ofs,sz)
     else
       move(OffsetPtr(data, ofs)^, PAnsiChar(Result)^, sz);
   end;
  else
    raise Exception.Create('Unsupported field type in GetAnsiField');
  end;
end;

//Setting fields is not supported for offline dictionaries.
//It's only used for user data anyway, which is never offline.
procedure TTextTable.SetField(rec:integer;field:integer;const value:string);
var ofs:integer;
  sz:word;
  tp:char;
  b:byte;
  w:word;
  l:integer;
 {$IFDEF UNICODE}
  ansi_s: AnsiString;
  value_c: UnicodeString;
 {$ELSE}
  i: integer;
  pb: PByte;
  pc: PChar;
 {$ENDIF}
begin
  if rec>=reccount then
    raise Exception.Create('Write beyond!');
  ofs:=GetDataOffset(rec,field);
  tp:=fieldtypes[field+1];
  sz:=GetFieldSize(rec,field);

  case tp of
  'b': begin
     if TryStrToInt(value, l) then
       b := l
     else
       b := 0;
     PByte(OffsetPtr(data, ofs))^ := b;
   end;
  'w': begin
     if TryStrToInt(value, l) then
       w := l
     else
       w := 0;
     PWord(OffsetPtr(data, ofs))^ := w;
   end;
  'i': begin
     if not TryStrToInt(value, l) then
       l := 0;
     PInteger(OffsetPtr(data, ofs))^ := l;
   end;
  'l': begin
     if upcase(value[1])='T' then b:=1 else b:=0;
     PByte(OffsetPtr(data, ofs))^ := b;
   end;
  's': begin
    {$IFNDEF UNICODE}
     if sz>0 then
       move(PAnsiChar(value)^, OffsetPtr(data, ofs)^, sz);
    {$ELSE}
     if sz>0 then begin
       ansi_s := AnsiString(value);
       move(PAnsiChar(ansi_s)^, OffsetPtr(data, ofs)^, sz);
     end;
    {$ENDIF}
   end;
  'x': begin
    {$IFNDEF UNICODE}
     pb := OffsetPtr(data, ofs);
     pc := PChar(value);
     for i := 0 to sz - 1 do begin
       pb^ := HexCharCode(pc^) shl 4;
       Inc(pc);
       pb^ := pb^ + HexCharCode(pc^);
       Inc(pc);
       Inc(pb);
     end;
    {$ELSE}
     if sz>0 then begin
       value_c := value; //can't mess with someone else's string
       UniqueString(value_c);
       SwapBytes(PByte(value_c), sz);
       move(PWideChar(value_c)^, OffsetPtr(data, ofs)^, sz);
     end;
    {$ENDIF}
   end;
  end;
end;

{ See comments for GetAnsiField }
procedure TTextTable.SetAnsiField(rec:integer;field:integer;const value:AnsiString);
var ofs:integer;
  sz:word;
  tp:char;
begin
  if rec>=reccount then
    raise Exception.Create('Write beyond!');
  ofs:=GetDataOffset(rec,field);
  tp:=fieldtypes[field+1];
  sz:=GetFieldSize(rec,field);

  case tp of
  's': begin
     if sz>0 then
       move(PAnsiChar(value)^, OffsetPtr(data, ofs)^, sz);
   end;
  else
    raise Exception.Create('Unsupported field type in SetAnsiField');
  end;
end;


{$IFDEF CURSOR_IN_TABLE}
function TTextTable.Str(field:integer):string;
begin
  Result := _intcur.Str(field);
end;

function TTextTable.Int(field:integer):integer;
begin
  Result := _intcur.Int(field);
end;

function TTextTable.TrueInt(field:integer):integer;
begin
  Result := _intcur.TrueInt(field);
end;

function TTextTable.Bool(field:integer):boolean;
begin
  Result := _intcur.Bool(field);
end;

//Returns one character (in older versions nothing is guaranteed but it was always this way)
{$IFDEF UNICODE}
function TTextTable.Fch(field:integer):WideChar;
begin
  Result := _intcur.Fch(field);
end;
{$ELSE}
function TTextTable.Fch(field:integer):string;
begin
  Result := _intcur.Fch(field);
end;
{$ENDIF}
{$ENDIF}



function TTextTable.FilterPass(rec:integer;fil:string):boolean;
var c,i:integer;
    p1,p2,el:string;
    cx:char;
begin
  try
    if fil='' then
    begin
      result:=true;
      exit;
    end;
    if fil[1]='(' then
    begin
      c:=0;
      i:=1;
      repeat
        if fil[i]='(' then inc(c);
        if fil[i]=')' then dec(c);
        inc(i);
      until c=0;
      p1:=copy(fil,2,i-3);
      p2:='';
      el:='';
      system.delete(fil,1,length(p1)+2);
      if i<length(fil) then
      begin
        el:=copy(fil,1,pos('(',fil)-1);
        system.delete(fil,1,length(el));
        p2:=fil;
      end;
      if el='' then result:=FilterPass(rec,p1) else
      if UpperCase(el)=' AND ' then result:=FilterPass(rec,p1) and FilterPass(rec,p2)
      else if UpperCase(el)=' OR ' then result:=FilterPass(rec,p1) or FilterPass(rec,p2)
      else result:=false;
    end else
    begin
      if pos('=',fil)<>0 then
      begin
        p1:=copy(fil,1,pos('=',fil)-1);
        cx:='=';
      end else if pos('<',fil)<>0 then
      begin
        p1:=copy(fil,1,pos('<',fil)-1);
        cx:='<';
      end else
      begin
        p1:=copy(fil,1,pos('>',fil)-1);
        cx:='>';
      end;
      system.delete(fil,1,length(p1)+1);
      if fil[1]='''' then system.delete(fil,1,1);
      if fil[length(fil)]='''' then system.delete(fil,length(fil),1);
      result:=false;
      if (cx='=') and (UpperCase(GetField(rec,strtoint(p1)))=UpperCase(fil)) then result:=true;
      if (cx='<') and (strtoint(GetField(rec,strtoint(p1)))<strtoint(fil)) then result:=true;
      if (cx='>') and (strtoint(GetField(rec,strtoint(p1)))>strtoint(fil)) then result:=true;
    end;
  except result:=false; end;
end;

{ Retrieves a record number by a seek table id (order) and a seek table record number (rec).
  The table has to be loaded. }
function TTextTable.TransOrder(rec,order:integer):integer;
begin
  if order=-1 then
    Result:=rec
  else
    Result:=PInteger(OffsetPtr(index, (order*reccount+rec)*4))^;
end;

{$IFDEF CURSOR_IN_TABLE}
procedure TTextTable.First;
begin
  _intcur.First;
end;

function TTextTable.Test(const fil:string):boolean;
begin
  Result := _intcur.Test(fil);
end;

procedure TTextTable.Next;
begin
  _intcur.Next;
end;

function TTextTable.EOF:boolean;
begin
  Result := _intcur.EOF;
end;

procedure TTextTable.SetOrder(const index:string);
begin
  _intcur.SetOrder(index);
end;

procedure TTextTable.SetFilter(const filtr:string);
begin
  _intcur.SetFilter(filtr);
end;
{$ENDIF}


function ReverseString(s:string):string;
var i:integer;
begin
  result:='';
  for i:=length(s) downto 1 do result:=result+s[i];
end;

function TTextTable.GetSeekObject(seek: string): TSeekObject;
begin
  Result.ind_i:=seeks.IndexOf(seek)-1;
  Result.reverse:=false;
  if (seek[1]='<') then
  begin
    system.delete(seek,1,1);
    Result.reverse:=true;
  end;
  Result.fld_i:=fieldlist.IndexOf(seek);
end;

{ LocateRecord():
 Locates first matching record by using a given seek table.
 Returns true and record index in seek table if there are matches,
 or false and record index for record just after where the match would have occured.
 To convert seek index to record index call TransOrder(idx, seek.ind_i) }
function TTextTable.LocateRecord(seek: PSeekObject; value:string; out idx: integer):boolean;
var sn:integer;       //seek table number
  fn:integer;         //field number
  reverse:boolean;
  l,r,c:integer;
  s:string;
  RecNo: integer;
begin
  sn := seek.ind_i;
  fn := seek.fld_i;
  reverse := seek.reverse;

  idx := -1;
  Result := false;
  if (sn<-1) or (fn<0) then
    exit;

  if reverse then value:=ReverseString(value);
  value := uppercase(value);

  idx := RecCount+1; //if there are no records this'll be used

 //Initiate binary search
  l:=0;
  r:=reccount-1;
  if l<=r then repeat
    c:=((r-l) div 2)+l;
    s:=GetField(TransOrder(c,sn),fn);
    if reverse then
      s:=ReverseString(s);
    if rawindex then
      if value<=uppercase(s) then r:=c else l:=c+1
    else
      if AnsiCompareStr(value,uppercase(s))<=0 then r:=c else l:=c+1;
    if l>=r then
    begin
      idx:=l;
      RecNo:=TransOrder(idx,sn);
      while (idx<reccount) and IsDeleted(RecNo) do
      begin
        inc(idx);
        RecNo:=TransOrder(idx,sn);
      end;
      Result := idx<reccount;
      if Result then begin
        s:=GetField(RecNo,fn);
        Result := (value=uppercase(s));
      end;
      exit;
    end;
  until false;
end;

{ Same but for numbers. May at times be faster (if the field is actually numberic in the DB and not string) }
function TTextTable.LocateRecord(seek: PSeekObject; value:integer; out idx: integer):boolean;
var sn:integer;       //seek table number
  fn:integer;         //field number
  l,r,c:integer;
  i_s: integer;      //integer value for "s", when number==true
  RecNo: integer;
begin
  sn := seek.ind_i;
  fn := seek.fld_i;
 //"reverse" is ignored for numeric lookups

  idx := -1;
  Result := false;
  if (sn<-1) or (fn<0) then
    exit;

  idx := RecCount+1; //if there are no records this'll be used

 //Initiate binary search
  l:=0;
  r:=reccount-1;
  if l<=r then repeat
    c:=((r-l) div 2)+l;

    if not GetIntField(TransOrder(c,sn),fn,i_s) then
      r := c
    else
      if value<=i_s then r:=c else l:=c+1;

    if l>=r then
    begin
      idx:=l;
      RecNo:=TransOrder(idx,sn);
      while (idx<reccount) and (IsDeleted(RecNo)) do
      begin
        inc(idx);
        RecNo:=TransOrder(idx,sn);
      end;
      Result := (idx<reccount) and GetIntField(RecNo,fn,i_s) and (value=i_s);
      exit;
    end;
  until false;
end;

{$IFDEF CURSOR_IN_TABLE}
//Faster version, by seek object
function TTextTable.Locate(seek: PSeekObject; const value:string):boolean;
begin
  Result := _intcur.Locate(seek, value);
end;

//Slower version, specifying seek by a string name
function TTextTable.Locate(const seek,value:string):boolean;
begin
  Result := _intcur.Locate(seek,value);
end;

function TTextTable.Locate(seek:PSeekObject; const value:integer):boolean;
begin
  Result := _intcur.Locate(seek, value);
end;

function TTextTable.Locate(const seek:string; const value:integer):boolean;
begin
  Result := _intcur.Locate(seek,value);
end;
{$ENDIF}

function TTextTable.Field(const field:string):integer;
begin
  result:=fieldlist.IndexOf(field);
end;

function TTextTable.IsDeleted(rec:integer):boolean;
begin
  Result := PBoolean(IntPtr(struct)+rec*struct_recsz)^;
end;

function GetFieldValueSize(ftype: char; const fval: string): integer;
begin
  case ftype of
    'b':Result:=1;
    'w':Result:=2;
    'i':Result:=4;
    'l':Result:=1;
    's':Result:=length(fval);
   {$IFDEF UNICODE}
    'x':Result:=length(fval) * 2;
   {$ELSE}
    'x':Result:=length(fval) div 2;
   {$ENDIF}
  else
    Result := 0;
  end;
end;

{ Ensures that there's at least sz free bytes available in data buffer }
procedure TTextTable.ReserveData(const sz: integer);
var p:pointer;
begin
  if databuffer>=sz then exit;
  databuffer:=Trunc(datalen*0.4)+AllocDataBufferSz; //incremental growth
  if sz>=databuffer then //still not enough
    databuffer := sz*2;
  GetMem(p,datalen+databuffer);
  if data<>nil then
    move(data^,p^,datalen);
  freemem(data);
  data:=p;
end;

procedure TTextTable.ReserveStruct(const sz: integer);
var p:pointer;
begin
  if structbuffer>=sz then exit;
  structbuffer:=Trunc((reccount*struct_recsz)*0.4)+AllocStructBufferSz;
  if sz>=structbuffer then //still not enough
    structbuffer := sz*2;
  GetMem(p,(reccount*struct_recsz)+structbuffer);
  if struct<>nil then
    move(struct^,p^,reccount*struct_recsz);
  freemem(struct);
  struct:=p;
end;

{ Appends record to the table, returns its RecNo }
function TTextTable.AddRecord(values:array of string): integer;
var totsize:integer;
    i:integer;
    c:char;
    a:array of byte;
    k:integer;
  fsz:word; //field size
begin
  if offline then
    raise Exception.Create('Cannot insert into offline table.');
  if High(values)+1<>fieldcount then raise Exception.Create('Invalid values array count (TTextTable.Insert).');

 { Fill record header, allocate memory then call Edit() to copy data }
  ReserveStruct(struct_recsz);
  dec(structbuffer,struct_recsz);
  PByte(IntPtr(struct)+reccount*struct_recsz)^ := 0;
  PInteger(IntPtr(struct)+reccount*struct_recsz+1)^ := datalen;
  totsize:=0;
  k:=0;
  for i:=0 to fieldcount-1 do
  begin
    c:=fieldbuild[i][1];
    fsz:=GetFieldValueSize(c, values[i]);
    if (c='x') or (c='s') then begin
      if wordfsize then begin
        if fsz>65530 then fsz := 65530; { Only this much bytes will be stored }
        PWord(IntPtr(struct)+reccount*struct_recsz+5+k)^ := fsz;
        inc(k,2);
      end else begin
        if fsz>250 then fsz := 250;
        PByte(IntPtr(struct)+reccount*struct_recsz+5+k)^ := fsz;
        inc(k,1);
      end;
    end;
    Inc(totsize,fsz);
  end;

  ReserveData(totsize);
  dec(databuffer,totsize);
  Inc(datalen,totsize);

  SetLength(a,fieldcount);
  for i:=0 to fieldcount-1 do a[i]:=i;
  Result := reccount;
  inc(reccount);
  EditRecord(Result, a, values, {JustInserted=}true);
end;

procedure TTextTable.DeleteRecord(RecNo: integer);
begin
  PBoolean(IntPtr(struct)+RecNo*struct_recsz)^ := true;
  inc(numberdeleted);
end;

procedure TTextTable.EditRecord(RecNo: integer; const fields:array of byte;
  const values:array of string; JustInserted:boolean=false);
var i,j:integer;
    sz:byte;
    tp:char;
    willinsert:boolean;
    a:array of string;
    fnd:boolean;
begin
  if offline then
    raise Exception.Create('Cannot edit offline table');
  willinsert:=false;
  for i:=0 to High(values) do
  begin
    sz:=GetFieldSize(RecNo,fields[i]);
    tp:=fieldtypes[fields[i]+1];
    if ((tp='s') and (sz<>length(values[i])))
   {$IFDEF UNICODE}
    or ((tp='x') and (sz<>length(values[i]) * 2))
   {$ELSE}
    or ((tp='x') and (sz<>length(values[i]) div 2))
   {$ENDIF}
    then willinsert:=true;
  end;
  if not justinserted and willinsert then
  begin
    SetLength(a,fieldcount);
    for i:=0 to fieldcount-1 do
    begin
      fnd:=false;
      for j:=0 to High(values) do
        if fields[j]=i then
        begin
          fnd:=true;
          a[i]:=values[j];
        end;
      if not fnd then a[i]:=Self.GetField(RecNo,i);
    end;
    DeleteRecord(RecNo);
    AddRecord(a);
    exit;
  end;
  for i:=0 to High(values) do
    SetField(RecNo, fields[i], values[i]);
  if not nocommit then Commit(RecNo, JustInserted);
end;

{$IFDEF CURSOR_IN_TABLE}
procedure TTextTable.Insert(values:array of string);
begin
  _intcur.Insert(values);
end;

procedure TTextTable.Delete;
begin
  _intcur.Delete();
end;

procedure TTextTable.Edit(const fields:array of byte; const values:array of string);
begin
  _intcur.Edit(fields,values);
end;
{$ENDIF}



function TTextTable.ParseSeekDescription(fld:string): TSeekFieldDescriptions;
var i:integer;
  fx:string;
  reverse:boolean;
  desc: PSeekFieldDescription;
begin
  SetLength(Result, 0);
  while length(fld)>0 do
  begin
    if pos('+',fld)>0 then
    begin
      fx:=copy(fld,1,pos('+',fld)-1);
      system.delete(fld,1,length(fx)+1);
    end else
    begin
      fx:=fld;
      fld:='';
    end;
    reverse:=false;
    if fx[1]='<' then
    begin
      system.delete(fx,1,1);
      reverse:=true;
    end;
    i:=Field(fx);
    if i=-1 then raise Exception.Create('Unknown seek field '+fx+' (TTextTable.Commit).');

    SetLength(Result, Length(Result)+1);
    desc := @Result[Length(Result)-1];
    desc.index := i;
    desc.reverse := reverse;
    desc.strdata := (fieldbuild[i][1]='s') or (fieldbuild[i][1]='x')
  end;
end;

function TTextTable.SortRec(r:integer;const fields:TSeekFieldDescriptions):string;
var j, idx: integer;
  s3: string;
begin
  Result := '';
  for j := 0 to Length(fields) - 1 do begin
    idx := fields[j].index;
    if fields[j].strdata then
    begin
      if not fields[j].reverse then
        Result:=Result+GetField(r,idx)+#9
      else
        Result:=Result+ReverseString(GetField(r,idx))+#9;
    end else
    begin
      s3:=GetField(r,idx);
      while length(s3)<6 do s3:='0'+s3;
      Result:=Result+s3+#9;
    end;
  end;
  while (length(Result)>0) and (Result[length(Result)]=#9) do system.delete(Result,length(Result),1);
  Result:=uppercase(Result);
end;

function TTextTable.SortRec(r:integer;seekIndex:integer):string;
begin
  Result := SortRec(r, seekbuilddesc[seekIndex].fields);
end;

{ This is the functionality older SortRec had. I'm keeping it just in case
 there really is a case when we SortRec by something other than the contents of
 a built-in index. }
function TTextTable.SortRecByStr(r:integer; fld:string):string;
var desc: TSeekFieldDescriptions;
begin
  desc := ParseSeekDescription(fld);
  Result := SortRec(r, desc);
end;

procedure TTextTable.Commit(RecNo:integer; JustInserted: boolean);
var p:pointer;
    i:integer;
    j,k:integer;
    s:string;
    fnd:boolean;
begin
  if justinserted then
  begin
    getmem(p,reccount*orders.Count*4);
    for i:=0 to orders.Count-1 do moveofs(index,p,i*(reccount-1)*4,i*reccount*4,(reccount-1)*4);
    freemem(index);
    index:=p;
  end else
  begin
    for i:=0 to orders.Count-1 do
      for j:=0 to reccount-1 do if TransOrder(j,i)=RecNo then
        moveofs(index,index,i*reccount*4+j*4+4,i*reccount*4+j*4,(reccount-j-1)*4);
  end;
  k:=RecNo;
  for i:=0 to orders.Count-1 do
  begin
    s:=sortrec(RecNo,i+1);
    fnd:=false;
    for j:=0 to reccount-2 do if AnsiCompareStr(sortrec(TransOrder(j,i),i+1),s)>=0 then
    begin
      moveofs(index,index,i*reccount*4+j*4,i*reccount*4+j*4+4,(reccount-j-1)*4);
      moveofs(@k,index,0,i*reccount*4+j*4,4);
      fnd:=true;
      break;
    end;
    if not fnd then moveofs(@k,index,0,i*reccount*4+(reccount-1)*4,4);
  end;
end;

{procedure TTextTable.SortIndex(ino:integer;a,b:integer);
var c:integer;
    li,ri:TStringList;
    i,k:integer;
    sc,sa:string;
begin
  if a=b then exit;
  // choose cue point
  c:=a+(b-a) div 2;
  sc:=SortRec(TransOrder(c,ino),seekbuild[ino+1]);
  li:=TStringList.Create;
  ri:=TStringList.Create;
  for i:=a to b do
  if i<>c then begin
    sa:=SortRec(TransOrder(i,ino),seekbuild[ino+1]);
    if sa>sc then ri.Add(inttostr(TransOrder(i,ino))) else li.Add(inttostr(TransOrder(i,ino)));
  end;
  for i:=0 to li.Count-1 do
  begin
    k:=strtoint(li[i]);
    moveofs(@k,index,0,ino*reccount*4+a*4+i*4,4);
  end;
  k:=c;
  moveofs(@k,index,0,ino*reccount*4+a*4+li.Count*4,4);
  for i:=0 to ri.Count-1 do
  begin
    k:=strtoint(ri[i]);
    moveofs(@k,index,0,ino*reccount*4+a*4+i*4+li.Count*4+4,4);
  end;
  if li.Count>1 then SortIndex(ino,a,a+li.Count-1);
  if ri.Count>1 then SortIndex(ino,b-ri.Count+1,b);
  li.Free;
  ri.Free;
end;}

function CustomSortCompare(list:TStringList;index1,index2:integer):integer;
begin
  result:=CompareStr(uppercase(list[index1]),uppercase(list[index2]));
end;

procedure TTextTable.Reindex;
var i,j:integer;
  sl:TStringList;
  p:pointer;
begin
  getmem(p,reccount*orders.Count*4);
  freemem(index);
  index:=p;
  sl:=TStringList.Create;
  for i:=0 to orders.Count-1 do
  begin
    sl.Clear;
    for j:=0 to reccount-1 do
      sl.AddObject(SortRec(j,i+1),pointer(j));
    if rawindex then
      sl.CustomSort(CustomSortCompare)
    else
      sl.Sort; //uses AnsiCompareStr too
    for j:=0 to reccount-1 do
      PInteger(IntPtr(index)+i*reccount*4+j*4)^ := integer(sl.Objects[j]); //there's really only integer stored, even on 64bit platforms
  end;
  sl.Free;
end;

function TTextTable.CheckIndex:boolean;
var i,j:integer;
    s1,s2:string;
begin
  for i:=0 to orders.Count-1 do if seekbuild.Count>i+1 then
  begin
    s1:='';
    for j:=0 to reccount-1 do
    begin
      s2:=sortrec(transorder(j,i),i+1);
      if ((not rawindex) and (AnsiCompareStr(s2,s1)<0)) or
         ((rawindex) and (s2<s1)) then
      begin
        result:=false;
        exit;
      end;
      s1:=s2;
    end;
  end;
  result:=true;
end;

function TTextTable.HasIndex(const index:string):boolean;
begin
  Result := orders.IndexOf(index)>=0;
end;


{ Import/export }
{ This will only work properly on Ansi }

procedure TTextTable.ExportToText(t:TCustomFileWriter;ord:string);
var i,j:integer;
    s,s2:string;
    ordn:integer;
begin
  s:='';
  for i:=0 to fieldlist.Count-1 do s:=s+';'+fieldlist[i];
  ordn:=orders.IndexOf(ord);
  s[1]:='>';
  t.Writeln(s);
  for i:=0 to reccount-1 do
  begin
    s:='';
    for j:=0 to fieldlist.Count-1 do
    begin
      s2:=GetField(TransOrder(i,ordn),j);
      while pos(';',s2)>0 do s2:=copy(s2,1,pos(';',s2)-1)+','+copy(s2,pos(';',s2)+1,length(s2)-pos(';',s2));
      s:=s+';'+s2;
    end;
    s[1]:='+';
    t.Writeln(s);
  end;
  t.Writeln('.');
end;

procedure TTextTable.ImportFromText(t:TCustomFileReader;smf:TSMPromptForm;mess:string);
var s:string;
    i,j:integer;
    fld:TStringList;
    a:array of string;
    s2:string;
    cnt:integer;
begin
  nocommit:=true;
  s := t.ReadLn();
  system.delete(s,1,1);
  fld:=TStringList.Create;
  while s<>'' do
  begin
    if s[1]=';' then system.delete(s,1,1);
    if pos(';',s)>0 then s2:=copy(s,1,pos(';',s)-1) else s2:=s;
    system.delete(s,1,length(s2));
    fld.Add(s2);
  end;
  cnt:=0;
  s := t.ReadLn();
  while s[1]<>'.' do
  begin
    inc(cnt);
    if cnt=1 then begin end;
    system.delete(s,1,1);
    SetLength(a,fieldcount);
    for i:=0 to fieldcount-1 do a[i]:='0';
    i:=0;
    while s<>'' do
    begin
      if s[1]=';' then system.delete(s,1,1);
      if (pos(';',s)>0) and (i<fieldcount-1) then s2:=copy(s,1,pos(';',s)-1) else s2:=s;
      system.delete(s,1,length(s2));
      j:=fieldlist.IndexOf(fld[i]);
      if j<>-1 then a[j]:=s2;
      inc(i);
    end;
    Insert(a);
    s := t.ReadLn();
  end;
  fld.Free;
  nocommit:=false;
  if smf<>nil then smf.SetMessage(mess+' (indexing)...');
  Reindex;
  if smf<>nil then smf.SetMessage(mess+'...');
end;



{ TTextTableCursor }

constructor TTextTableCursor.Create(ATable: TTextTable);
begin
  inherited Create;
  FTable := ATable;
  cur:=-1;
  tcur:=0;
  curorder:=-1;
  filter:='';
end;

procedure TTextTableCursor.First;
begin
  cur:=-1;
  tcur:=0;
  Next;
end;

procedure TTextTableCursor.Next;
var stop:boolean;
begin
  repeat
    inc(cur);
    if cur<Table.RecCount then
    begin
      tcur:=Table.TransOrder(cur,curorder);
      if tcur>=Table.RecCount then
        raise Exception.Create('Index problem');
      if filter='' then
        stop:=not Table.IsDeleted(tcur)
      else
        stop:=not Table.IsDeleted(tcur) and Table.FilterPass(tcur,filter);
    end else
    begin
      tcur:=cur;
      stop:=true;
    end;
  until stop;
end;

function TTextTableCursor.EOF:boolean;
begin
  result:=(cur>=Table.RecCount);
end;

procedure TTextTableCursor.SetOrder(const index:string);
begin
  curorder:=Table.orders.IndexOf(index);
  First;
end;

procedure TTextTableCursor.SetFilter(const filtr:string);
begin
  filter:=filtr;
end;

function TTextTableCursor.Test(const fil:string):boolean;
begin
  Result := Table.FilterPass(tcur,fil);
end;


procedure TTextTableCursor.Insert(values:array of string);
begin
  tcur := Table.AddRecord(values);
end;

procedure TTextTableCursor.Delete;
begin
  Table.DeleteRecord(tcur);
end;

procedure TTextTableCursor.Edit(const fields:array of byte; const values:array of string);
begin
  Table.EditRecord(tcur, fields, values);
end;


//Slower version, specifying seek by a string name
function TTextTableCursor.Locate(const seek,value:string):boolean;
var so: TSeekObject;
begin
  so := Table.GetSeekObject(seek);
  Result := Locate(@so, value);
end;

//Faster version, by seek object
function TTextTableCursor.Locate(seek: PSeekObject; const value:string):boolean;
var idx: integer;
begin
  Result := Table.LocateRecord(seek, value, idx);
  cur := idx;
  if (idx>=0) and (idx<Table.RecordCount) then
    tcur := Table.TransOrder(idx, seek.ind_i)
  else
    tcur := Table.RecordCount; //-1 is not detected as EOF
end;

function TTextTableCursor.Locate(const seek:string; const value:integer):boolean;
var so: TSeekObject;
begin
  so := Table.GetSeekObject(seek);
  Result := Locate(@so, value);
end;

function TTextTableCursor.Locate(seek:PSeekObject; const value:integer):boolean;
var idx: integer;
begin
  Result := Table.LocateRecord(seek, value, idx);
  cur := idx;
  if (idx>=0) and (idx<Table.RecordCount) then
    tcur := Table.TransOrder(idx, seek.ind_i)
  else
    tcur := Table.RecordCount; //-1 is not detected as EOF
end;


function TTextTableCursor.Str(field:integer):string;
begin
  Result:=Table.GetField(tcur,field);
end;

function TTextTableCursor.AnsiStr(field:integer):AnsiString;
begin
  Result:=Table.GetAnsiField(tcur,field);
end;

function TTextTableCursor.Int(field:integer):integer;
begin
  if not Table.GetIntField(tcur,field,Result) then
    Result := 0;
end;

function TTextTableCursor.TrueInt(field:integer):integer;
begin
  if not Table.GetIntField(tcur,field,Result) then
    raise Exception.Create('Cannot convert this to integer: '+Table.GetField(tcur,field));
end;

function TTextTableCursor.Bool(field:integer):boolean;
var s: string;
begin
  s := Table.GetField(tcur,field);
  Result :=(Length(s)>0) and (UpCase(s[1])='T');
end;

{
For single characters stored as 'x'-type strings.
Returns one unicode character in FChar.
}
{$IFDEF UNICODE}
function TTextTableCursor.Fch(field:integer):WideChar;
var s: string;
begin
  s := Str(field);
  if Length(s)<=0 then
    Result := #0000
  else
    Result := s[1];
end;
{$ELSE}
//On older versions character is not guaranteed, but it was always this way.
function TTextTableCursor.Fch(field:integer):string;
begin
  Result := Str(field);
end;
{$ENDIF}

{
For unicode strings stored as hex in 'a'-type strings.
Returns contents in FString.
}
function TTextTableCursor.Dehex(field:integer):FString;
begin
 {$IFDEF UNICODE}
  Result := HexToUnicode(Str(field));
 {$ELSE}
  Result := Str(field);
 {$ENDIF}
end;


initialization
  dataalloc:=0;
  structalloc:=0;
  indexalloc:=0;
 {$IFDEF TTSTATS}
  statlist:=TStringList.Create;
 {$ENDIF}

finalization
 {$IFDEF TTSTATS}
  statlist.Free;
 {$ENDIF}

end.
