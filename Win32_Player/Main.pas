unit Main;

// BUG: If you drag the window, the dia show will stop playing, but the sound continues! This makes everything out of sync.
// TODO: When the windows is only resized a little bit (A few pixels), the window should not centered
//       ... Calc the width and height of ALL pictures, and then size the form to the biggest value?
//       ... or hard code the resolution in the INI file?
// Idea: Ini Parameter if fullscreen is applied or not
// Idea: Savestates, speedup, pause, Use Space bar to go to the next decision point.

// -----------------------------------------------------------------------------

// HOTSPOT_RELATIVE_ORIGIN is a new behavior which is not compatible with the original engine.
// With HOTSPOT_RELATIVE_ORIGIN enabled, the coordinates will be relative to the picture
// The original game has the origin at the top left corner of the screen.
// This is a problem because the game as well as the scene editor does not know the
// desired resolution, as it is automatically determined.
// If we would hardcode the desired canvas (640x480) in <ExeName>.ini, then
// it would work, but then, the scene Editor can not know the desired resolution...
{$DEFINE HOTSPOT_RELATIVE_ORIGIN}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Game;

type
  TMainForm = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    StartupTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StartupTimerTimer(Sender: TObject);
    procedure ControlClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
  private
    FHotspots: array[0..2] of THotspot;
    FullscreenMode: boolean;
    procedure cbPictureShow(ASender: TGame; AFilename: string; AType: TPictureType);
    procedure cbAsyncSound(ASender: TGame; AFilename: string);
    procedure cbExit(ASender: TGame);
    procedure cbWait(ASender: TGame; AMilliseconds: integer);
    procedure cbSetHotspot(ASender: TGame; AIndex: THotspotIndex; AHotspot: THotspot);
    procedure cbClearHotspots(ASender: TGame);
    procedure ClickEvent(X, Y: Integer);
  public
    game: TGame;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  MMSystem, IniFiles, Math;

procedure Delay(const Milliseconds: DWord);
var
  FirstTickCount: DWord;
begin
  FirstTickCount := GetTickCount; // TODO: Attention, GetTickCount can overflow
  while not Application.Terminated and ((GetTickCount - FirstTickCount) < Milliseconds) do
  begin
    Application.ProcessMessages;
    Sleep(0);
  end;
end;

function AddThouSeps(const S: string): string;
var 
  LS, L2, I, N: Integer;
  Temp: string;
begin
  // http://www.delphigroups.info/2/11/471892.html
  result := S ;
  LS := Length(S);
  N := 1 ;
  if LS > 1 then
  begin
    if S [1] = '-' then  // check for negative value
    begin
      N := 2;
      LS := LS - 1;
    end;
  end;
  if LS <= 3 then exit;
  L2 := (LS - 1) div 3;
  Temp := '';
  for I := 1 to L2 do
  begin
    Temp := {$IF not Declared(ThousandSeparator)}FormatSettings.{$IFEND}ThousandSeparator + Copy (S, LS - 3 * I + 1, 3) + Temp;
  end;
  Result := Copy (S, N, (LS - 1) mod 3 + 1) + Temp;
  if N > 1 then Result := '-' + Result;
end;

{ TMainForm }

procedure TMainForm.cbPictureShow(ASender: TGame; AFilename: string; AType: TPictureType);
resourcestring
  S_YOUR_SCORE = 'Your score is: %s';
begin
  if FileExists(AFilename) then
  begin
    Image1.Visible := false;
    try
      Image1.Picture.LoadFromFile(AFilename);
      Image1.Autosize := true;
    finally
      // This speeds up the picture loading on very old computers
      Image1.Visible := true;
    end;

    // Make form bigger if necessary
    if Image1.Width > ClientWidth then
    begin
      ClientWidth := Min(Image1.Width, Screen.Width);
      if (ClientWidth >= Screen.Width) then FullscreenMode := true;
      Position := poScreenCenter;
    end;
    if Image1.Height > ClientHeight then
    begin
      ClientHeight := Min(Image1.Height, Screen.Height);
      if (ClientHeight >= Screen.Height) then FullscreenMode := true;
      Position := poScreenCenter;
    end;

    // Center image
    Image1.Left := ClientWidth div 2 - Image1.Width div 2;
    Image1.Top := ClientHeight div 2 - Image1.Height div 2;
  end
  else
  begin
    Image1.Picture := nil;
  end;

  if FullScreenMode then
  begin
    BorderStyle := bsNone;
    FormStyle := fsStayOnTop;
    Case AType of
      ptDia: Screen.Cursor := -1;
      ptDecision: Screen.Cursor := 0;
    End;
  end;

  Panel1.Caption := Format(S_YOUR_SCORE, [AddThouSeps(IntToStr(ASender.Score))]);
  Panel1.Left := 8;
  Panel1.Top := Min(ClientHeight, Screen.Height) - Panel1.Height - 8;
  Panel1.Visible := AType = ptDecision;
end;

procedure TMainForm.cbAsyncSound(ASender: TGame; AFilename: string);
begin
  PlaySound(nil, hinstance, 0);
  if FileExists(AFilename) then
  begin
    PlaySound(PChar(AFilename), hinstance, SND_FILENAME or SND_ASYNC);
  end;
end;

procedure TMainForm.cbSetHotspot(ASender: TGame; AIndex: THotspotIndex; AHotspot: THotspot);
begin
  FHotspots[AIndex] := AHotspot;
end;

procedure TMainForm.cbClearHotspots(ASender: TGame);
var
  i: Integer;
begin
  for i := Low(FHotspots) to High(FHotspots) - 1 do
  begin
    FHotspots[i].lpAction := nil;
  end;
end;

procedure TMainForm.cbExit(ASender: TGame);
begin
  Application.Terminate;
end;

procedure TMainForm.cbWait(ASender: TGame; AMilliseconds: integer);
begin
  //Cursor := crHourglass;
  try
    Delay(AMilliseconds);
  finally
    //Cursor := crDefault;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  ini: TMemIniFile;
  iniFilename: string;
begin
  iniFilename := ChangeFileExt(ExtractFileName(ParamStr(0)), '.ini');

  DoubleBuffered := true;

  if FileExists(iniFilename) then
  begin
    ini := TMemIniFile.Create(iniFilename);
    try
      Caption := ini.ReadString('Config', 'Title', '');
    finally
      FreeAndNil(ini);
    end;
  end;

  try
    Game := TGame.Create('.');
    Game.PictureShowCallback := cbPictureShow;
    Game.AsyncSoundCallback := cbAsyncSound;
    Game.ExitCallback := cbExit;
    Game.WaitCallback := cbWait;
    Game.SetHotspotCallback := cbSetHotspot;
    Game.ClearHotspotsCallback := cbClearHotspots;
    StartupTimer.Enabled := true;
  except
    Application.Terminate;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  // Without this, some audio drivers could crash if you press ESC to end the game.
  // (VPC 2007 with Win95; cpsman.dll crashes sometimes)
  PlaySound(nil, hinstance, 0);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then Close;
end;

procedure TMainForm.ClickEvent(X, Y: Integer);
var
  i: integer;
begin
  // If hotspots are overlaying, the lowest action will be chosen (same behavior as original game)
  for i := Low(FHotspots) to High(FHotspots) do
  begin
    if Assigned(FHotspots[i].lpAction) and
       (X >= FHotspots[i].cHotspotTopLeft.X) and
       (Y >= FHotspots[i].cHotspotTopLeft.Y) and
       (X <= FHotspots[i].cHotspotBottomRight.X) and
       (Y <= FHotspots[i].cHotspotBottomRight.Y) then
    begin
      FHotspots[i].Game.PerformAction(FHotspots[i].lpAction);
      Exit;
    end;
  end;
end;

procedure TMainForm.ControlClick(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  {$IFDEF HOTSPOT_RELATIVE_ORIGIN}
  ClickEvent(X, Y);
  {$ELSE}
  ClickEvent(X+TControl(Sender).Left, Y+TControl(Sender).Top);
  {$ENDIF}
end;

procedure TMainForm.StartupTimerTimer(Sender: TObject);
begin
  StartupTimer.Enabled := false;
  Game.Run;
end;

end.
