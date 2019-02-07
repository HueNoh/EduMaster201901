unit UCoffee_Admin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Datasnap.DBClient,
  Datasnap.DSConnect, Data.DB, Data.SqlExpr, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Layouts, System.Rtti, FMX.Grid.Style,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.DBScope,
  FMX.ScrollBox, FMX.Grid, FMX.TabControl, FireDAC.UI.Intf, FireDAC.FMXUI.Login,
  FireDAC.Stan.Intf, FireDAC.Comp.UI, FMX.Objects, FMX.Memo, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  Data.Bind.GenData, Data.Bind.ObjectScope, Data.Bind.DBLinks, Fmx.Bind.DBLinks,
  FMX.DateTimeCtrls, FMX.ListBox, FMX.ComboEdit;

type
  TFrmAdmin = class(TForm)
    Layout1: TLayout;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Btn_Save: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    MemoIntro: TMemo;
    MemoSig: TMemo;
    ImgSig: TImageControl;
    Img1: TImageControl;
    Img2: TImageControl;
    Img3: TImageControl;
    Img4: TImageControl;
    Edt_Notify: TEdit;
    Btn_Save_Notify: TButton;
    ListView1: TListView;
    Label2: TLabel;
    GroupBox5: TGroupBox;
    ImgRes: TImageControl;
    MemoRes: TMemo;
    GroupBox6: TGroupBox;
    DateRes: TDateEdit;
    TimeRes: TTimeEdit;
    GroupBox7: TGroupBox;
    EditResPrice: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Btn_Save_Res: TSpeedButton;
    GroupBox8: TGroupBox;
    Label6: TLabel;
    ComboCpn: TComboEdit;
    ComboResQuantity: TComboEdit;
    EditRes: TEdit;
    BindSourceDB1: TBindSourceDB;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabControl1Change(Sender: TObject);
    procedure Btn_Save_NotifyClick(Sender: TObject);
    procedure Btn_SaveClick(Sender: TObject);
    procedure ListView1DeleteItem(Sender: TObject; AIndex: Integer);
    procedure ComboCpnChange(Sender: TObject);
    procedure Btn_Save_ResClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAdmin: TFrmAdmin;

implementation

{$R *.fmx}
{$R *.iPhone47in.fmx IOS}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPhone55in.fmx IOS}
{$R *.iPhone.fmx IOS}
{$R *.LgXhdpiTb.fmx ANDROID}

uses USignIn_Admin, DMAdmin;
var
  dm: TDMAdminAccess;

procedure TFrmAdmin.TabControl1Change(Sender: TObject);
var
  LItem: TListViewItem;
  I: Integer;
begin
  case TabControl1.TabIndex of
    0: label1.Text := '홈';
    1: begin
        label1.Text := '공지';
        Dm.NotifyQuery.Close;
        Dm.NotifyQuery.ParamByName('BIZ_CODE').AsInteger := BizCode;
        Dm.NotifyQuery.Open;
        // 공지 리스트 뷰 화면에 뿌림
        ListView1.Items.Clear;
        Dm.NotifyQuery.First;
        ListView1.BeginUpdate;
        try
          while not Dm.NotifyQuery.Eof do
          begin
            LItem := ListView1.Items.Add;
            LItem.Text := VarToStr(Dm.NotifyQuery.Fields[2].Value);
            Dm.NotifyQuery.Next;
          end;
        finally
          ListView1.EndUpdate;
        end;
    end;
    2: begin
        label1.Text := '예약설정';
        Dm.SalesQuery.Close;
        Dm.SalesQuery.ParamByName('BIZ_CODE').AsInteger := BizCode;
        Dm.SalesQuery.Open;

    end;
    3: label1.Text := '회원관리';
  end;
end;

procedure TFrmAdmin.Btn_Save_ResClick(Sender: TObject);
begin
  showmessage(VarToStr(Dm.SalesQuery.FieldByName('ONSALE').Value));
//  if Btn_Save_Res.IsPressed then   // 판매시작
//  begin
//    Btn_Save_Res.Text := '판매중..';
//    try
//      Dm.SalesQuery.Edit;
//      try
//        Dm.SalesQuery.FieldByName('TITLE').Value := EditRes.Text;
//        Dm.SalesQuery.FieldByName('CONTENT').Value := MemoRes.Text;
//        Dm.SaveImageS('IMG', ImgRes.Bitmap);
//        Dm.SalesQuery.FieldByName('PRICE').Value := EditResPrice.Text.ToInteger;
//        Dm.SalesQuery.FieldByName('QUANTITY').Value := StrToInt(ComboResQuantity.Text);
//        // 날짜 예외 설정할것
//        Dm.SalesQuery.FieldByName('ST_DATE').Value := StrToDatetime(concat(DateRes.Text, ' ', TimeRes.Text));
//        Dm.SalesQuery.FieldByName('ONSALE').Value := 'Y';
//      except on e:Exception do
//        ShowMessage('저장 오류: ' + e.Message);
//      end;
//    finally
//      Dm.SalesQuery.Post;
//      Dm.SalesQuery.ApplyUpdates(0);
//      Dm.SalesQuery.Refresh;
//      ShowMessage('저장 완료');
//    end;
//  end
//  else                       // 판매종료
//  begin
//    Btn_Save_Res.Text := '판매 종료';
//  end;
end;

procedure TFrmAdmin.Btn_SaveClick(Sender: TObject);
begin
  try
    Dm.BizInfoQuery.Edit;
    try
      Dm.BizInfoQuery.FieldByName('CONTENT').Value := MemoIntro.Text;
      Dm.SaveImage('SIG_IMG', ImgSig.Bitmap);
      Dm.BizInfoQuery.FieldByName('SIG_NAME').Value := MemoSig.Text;
      Dm.SaveImage('IMG_1', Img1.Bitmap);
      Dm.SaveImage('IMG_2', Img2.Bitmap);
      Dm.SaveImage('IMG_3', Img3.Bitmap);
      Dm.SaveImage('IMG_4', Img4.Bitmap);
//      if ComboCpn.Text.IsEmpty then
//        Dm.BizInfoQuery.FieldByName('Coupon').Value := 0
//      else
        Dm.BizInfoQuery.FieldByName('COUPON').Value := StrToInt(ComboCpn.text);
        Cpn := StrToInt(ComboCpn.text); // 쿠폰 발생 갯수 저장
    except on e:Exception do
      ShowMessage('저장 오류: ' + e.Message);
    end;
  finally
    Dm.BizInfoQuery.Post;
    Dm.BizInfoQuery.ApplyUpdates(0);
    Dm.BizInfoQuery.Refresh;
    ShowMessage('저장 완료');
  end;
end;

procedure TFrmAdmin.Btn_Save_NotifyClick(Sender: TObject);
var
  Chk: Boolean;
  Content: string;
  LItem: TListViewItem;
  I: Integer;
begin
  Content := Edt_Notify.Text;
  if not Content.IsEmpty then
  begin
    Chk := Client.InsertNotify(BizCode, Content);
    case Chk of
      True:
      begin
        LItem := ListView1.Items.Insert(0);
        LItem.Text := Content;
      end;
      False: ShowMessage('입력실패: 25글자까지 입력 가능');
    end;
  end;
  Edt_Notify.Text := '';
  Dm.NotifyQuery.Refresh;
  // formcreate: listview desc 정렬 확인
  // dataset append로 변경 확인
end;



procedure TFrmAdmin.ComboCpnChange(Sender: TObject);
begin
//  ShowMessage(ComboCpn.Text);
end;

procedure TFrmAdmin.ListView1DeleteItem(Sender: TObject; AIndex: Integer);
var
  I: Integer;
begin

  ListView1.BeginUpdate;
  try
    Dm.NotifyQuery.Edit;
    Dm.NotifyQuery.First;
    for I := 0 to Dm.NotifyQuery.RecordCount - 1 do
    begin
      if I = AIndex then
        Dm.NotifyQuery.Delete;
      Dm.NotifyQuery.Next;
    end;
  finally
    Dm.NotifyQuery.ApplyUpdates(0);
    DM.NotifyQuery.Refresh;
    ListView1.EndUpdate;
  end;

end;

procedure TFrmAdmin.FormCreate(Sender: TObject);
var
  blobF : TBlobField;
  bs : TStream;
begin

  Dm := TDMAdminAccess.Create(application);
  Dm.BizInfoQuery.Close;
  Dm.BizInfoQuery.ParamByName('BIZ_CODE').AsInteger := BizCode;
  Dm.BizInfoQuery.Open;



  // livebinding 확인 - 잘 안됨
//  try
    MemoIntro.Text := VarToStr(Dm.BizInfoQuery.FieldByName('CONTENT').Value);
    Dm.LoadImage('SIG_IMG', ImgSig.Bitmap);
    MemoSig.Text := VarToStr(Dm.BizInfoQuery.FieldByName('SIG_NAME').Value);
    Dm.LoadImage('IMG_1', Img1.Bitmap);
    Dm.LoadImage('IMG_2', Img2.Bitmap);
    Dm.LoadImage('IMG_3', Img3.Bitmap);
    Dm.LoadImage('IMG_4', Img4.Bitmap);
    ComboCpn.Text := VarToStr(Dm.BizInfoQuery.FieldByName('COUPON').Value);
//  except on e:Exception do
//    ShowMessage('로딩 오류');  //예외처리 확인
//  end;

  dm.BizInfoQuery.Refresh;

//  Memo_Intro.Text := dm.BizInfoQuery.FieldByName('CONTENT').Value;
  TabControl1.ActiveTab := TabItem1;

end;

procedure TFrmAdmin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FrmSignAdmin);
end;

end.
