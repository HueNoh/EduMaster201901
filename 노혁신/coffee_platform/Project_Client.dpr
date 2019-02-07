program Project_Client;

uses
  System.StartUpCopy,
  FMX.Forms,
  UCoffee_Client in 'UCoffee_Client.pas' {FrmClient},
  USignIn_Client in 'USignIn_Client.pas' {FrmSignClient},
  DMClient in 'DMClient.pas' {DMClientAccess: TDataModule},
  UClientClass in 'UClientClass.pas',
  USelectClient in 'USelectClient.pas' {FrmSelectClient};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmSignClient, FrmSignClient);
  Application.CreateForm(TDMClientAccess, DMClientAccess);
  Application.Run;
end.
