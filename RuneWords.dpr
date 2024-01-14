program RuneWords;

uses
  Vcl.Forms,
  MainFrm in 'MainFrm.pas' {Form1},
  GameItems in 'GameItems.pas',
  ItemsLoader in 'ItemsLoader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
