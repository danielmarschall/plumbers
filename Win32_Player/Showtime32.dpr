program ShowTime32;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Game in 'Game.pas',
  GameBinStruct in '..\FileFormat\Delphi\GameBinStruct.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
