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
    function DupChk(ABizNum: string): Integer; // �ߺ�üũ: Return > 0 then �ߺ�
    function SignUp(ABizNum, APw, AName, AAddr: string): Boolean; // ����� ���
    function SignIn(ABizNum, APw: string): Integer; // �α���
    function InsertNotify(ABizCode: Integer; AContent: string): Boolean;

    function SignUpClient(AUsrMail, APw: string): Boolean; // ����� ���
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
  // -999: ����ġ, BizCode Return, -998: �ߺ�
  if SignInQuery.RecordCount = 0 then
    Result := -999
  else if SignInQuery.RecordCount = 1 then
  begin
    BizCode := SignInQuery.FieldByName('BIZ_CODE').AsInteger;
    Result := BizCode;
  end
  else
    Result := -998;   //Unique(Biz_num) �������� �߰��� �ʿ� ����
//    raise Exception.Create('�α��ε����� �ߺ��� �ִ��� Ȯ��');
end;

function TServerMethods1.SignInClient(AUsrMail, APw: string): Integer;
var
  UsrCode: Integer;
begin
  SignInClientQuery.Close;
  SignInClientQuery.Params[0].AsString := AUsrMail;
  SignInClientQuery.Params[1].AsString := APw;
  SignInClientQuery.Open;
  // -999: ����ġ, UsrCode Return, -998 ����
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
  SignUpQuery.Close;  //����ڰ�������
  SignUpQuery2.Close; //��������
  SignUpQuery3.Close; //�����Ǹ�����
  SignUpQuery.Params[0].AsString := ABizNum;
  SignUpQuery.Params[1].AsString := APw;
  SignUpQuery.Params[2].AsString := AName;
  SignUpQuery.Params[3].AsString := AAddr;
  // Tb_Biz, Tb_Biz_Info Ʈ����� ����/����
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
  SignUpClientQuery.Close;  //����� ���

  SignUpClientQuery.Params[0].AsString := AUsrMail;
  SignUpClientQuery.Params[1].AsString := APw;
  // Ʈ����� ����
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

