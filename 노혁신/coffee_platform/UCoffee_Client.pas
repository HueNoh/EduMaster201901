unit UCoffee_Client;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Data.DB,
  Data.SqlExpr, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFrmClient = class(TForm)
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClient: TFrmClient;

implementation

{$R *.fmx}

uses DMClient, UClientClass;

procedure TFrmClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  action := cafree;

//  Hide;
//  Action := TCloseAction.caFree;
//  FrmClient := nil;


end;

end.
