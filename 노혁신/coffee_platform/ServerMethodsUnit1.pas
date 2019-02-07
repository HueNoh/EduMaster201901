unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter,
    Datasnap.DSServer, Datasnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Datasnap.Provider, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI;


type
  TServerMethods1 = class(TDSServerModule)
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    SignUpQuery: TFDQuery;
    DupChkQuery: TFDQuery;
    SignUpQuery2: TFDQuery;
    SignInQuery: TFDQuery;
    BizInfoQuery: TFDQuery;
    SignInQueryProvider: TDataSetProvider;
    BizInfoQueryProvider: TDataSetProvider;
    FDConnection1: TFDConnection;
    NotifyQuery: TFDQuery;
    NotifyQueryProvider: TDataSetProvider;
    NotifyInsQuery: TFDQuery;
    SalesQuery: TFDQuery;
    SignUpQuery3: TFDQuery;
    SalesQueryProvider: TDataSetProvider;
    SignUpClientQuery: TFDQuery;
    SignInClientQuery: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function DupChk(ABizNum: string): Integer; // 중복체크: Return > 0 then 중복
    function SignUp(ABizNum, APw, AName, AAddr: string): Boolean; // 사업자 등록
    function SignIn(ABizNum, APw: string): Integer; // 로그인
    function InsertNotify(ABizCode: Integer; AContent: string): Boolean;

    function SignUpClient(AUsrMail, APw: string): Boolean; // 사용자 등록
    function SignInClient(AUsrMail, APw: string): Integer;

  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.InsertNotify(ABizCode: Integer;
  AContent: string): Boolean;
begin
  Result := False;
  NotifyInsQuery.Close;
  NotifyInsQuery.Params[0].AsInteger := ABizCode;
  NotifyInsQuery.Params[1].AsString := AContent;

  try
    NotifyInsQuery.ExecSQL;
    Result := True;
  except

  end;
end;

function TServerMethods1.SignIn(ABizNum, APw: string): Integer;
var
  BizCode: Integer;
begin
  SignInQuery.Close;
  SignInQuery.Params[0].AsString := ABizNum;
  SignInQuery.Params[1].AsString := APw;
  SignInQuery.Open;
  // -999: 불일치, BizCode Return, -998: 중복
  if SignInQuery.RecordCount = 0 then
    Result := -999
  else if SignInQuery.RecordCount = 1 then
  begin
    BizCode := SignInQuery.FieldByName('BIZ_CODE').AsInteger;
    Result := BizCode;
  end
  else
    Result := -998;   //Unique(Biz_num) 제약조건 추가로 필요 없음
//    raise Exception.Create('로그인데이터 중복값 있는지 확인');
end;

function TServerMethods1.SignInClient(AUsrMail, APw: string): Integer;
var
  UsrCode: Integer;
begin
  SignInClientQuery.Close;
  SignInClientQuery.Params[0].AsString := AUsrMail;
  SignInClientQuery.Params[1].AsString := APw;
  SignInClientQuery.Open;
  // -999: 불일치, UsrCode Return, -998 예외
  if SignInClientQuery.RecordCount = 0 then
    Result := -999
  else if SignInClientQuery.RecordCount = 1 then
  begin
    UsrCode := SignInClientQuery.FieldByName('USR_CODE').AsInteger;
    Result := UsrCode;
  end
  else
    Result := -998;

end;

function TServerMethods1.SignUp(ABizNum, APw, AName, AAddr: string): Boolean;
begin
  SignUpQuery.Close;  //사업자가입정보
  SignUpQuery2.Close; //매장정보
  SignUpQuery3.Close; //예약판매정보
  SignUpQuery.Params[0].AsString := ABizNum;
  SignUpQuery.Params[1].AsString := APw;
  SignUpQuery.Params[2].AsString := AName;
  SignUpQuery.Params[3].AsString := AAddr;
  // Tb_Biz, Tb_Biz_Info 트랜잭션 성공/실패
  FDConnection1.StartTransaction;
  try
    SignUpQuery.ExecSQL;
    SignUpQuery2.ExecSQL;
    SignUpQuery3.ExecSQL;
    FDConnection1.Commit;
    Result := True;
  except
    FDConnection1.Rollback;
    Result := False;
  end;

end;

function TServerMethods1.SignUpClient(AUsrMail, APw: string): Boolean;
begin
  SignUpClientQuery.Close;  //사용자 등록

  SignUpClientQuery.Params[0].AsString := AUsrMail;
  SignUpClientQuery.Params[1].AsString := APw;
  // 트랜잭션 시작
  FDConnection1.StartTransaction;
  try
    SignUpClientQuery.ExecSQL;
    FDConnection1.Commit;
    Result := True;
  except
    FDConnection1.Rollback;
    Result := False;
  end;
end;

function TServerMethods1.DupChk(ABizNum: string): Integer;
begin
  DupChkQuery.Close;
  DupChkQuery.Params[0].AsString := ABizNum;
  DupChkQuery.Open;

  Result := DupChkQuery.FieldByName('DupCnt').AsInteger;
end;

end.

