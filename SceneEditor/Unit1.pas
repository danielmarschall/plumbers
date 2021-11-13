unit Unit1;

(*
 * Plumbers Don't Wear Ties - Inofficial Scene Editor
 * Copyright 2017 - 2020 Daniel Marschall, ViaThinkSoft
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *)

// TODO: the "folder open" icons look like you can CHOOSE a file, not open it!
//       - change the icon to something else
//       - add open-dialogs for choosing the bmp and wav files
// TODO: Give controls better names
// TODO: When loading the file, check if dependencies are broken and output a warning
// Idea: About the hotspot / action markings:
//       - anti moiree?
//       - allow user to draw a rectangle with drag'n'drop instead of left and right mouse button.
//         also, automatically determine the left/top and right/bottom border, so the user can draw the rectange in every direction
// Idea: unused liste auch bei decision page anzeigen
// Idea: Function to re-order stuff?

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, Grids, GameBinStruct, ComCtrls, ExtCtrls, MPlayer,
  Menus;

const
  CUR_VER = '2020-06-08';

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button10: TButton;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    SpinEdit1: TSpinEdit;
    Edit1: TEdit;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ListBox2: TListBox;
    TabSheet5: TTabSheet;
    Label3: TLabel;
    Image1: TImage;
    Label10: TLabel;
    Label11: TLabel;
    Edit2: TEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    SpinEdit6: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    ComboBox1: TComboBox;
    TabSheet2: TTabSheet;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    ComboBox2: TComboBox;
    SpinEdit17: TSpinEdit;
    SpinEdit18: TSpinEdit;
    SpinEdit19: TSpinEdit;
    SpinEdit20: TSpinEdit;
    SpinEdit21: TSpinEdit;
    TabSheet3: TTabSheet;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox3: TComboBox;
    SpinEdit7: TSpinEdit;
    SpinEdit8: TSpinEdit;
    SpinEdit9: TSpinEdit;
    SpinEdit10: TSpinEdit;
    SpinEdit11: TSpinEdit;
    SpinEdit12: TSpinEdit;
    Image2: TImage;
    Edit3: TEdit;
    SpinEdit13: TSpinEdit;
    Label12: TLabel;
    Label16: TLabel;
    Button13: TButton;
    Button14: TButton;
    MediaPlayer1: TMediaPlayer;
    Timer1: TTimer;
    GroupBox2: TGroupBox;
    Button15: TButton;
    Button17: TButton;
    Button16: TButton;
    Label18: TLabel;
    Label17: TLabel;
    ListBox3: TListBox;
    Label19: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Button11: TButton;
    Button12: TButton;
    Button18: TButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Close1: TMenuItem;
    Newfile1: TMenuItem;
    Savetogamebin1: TMenuItem;
    Saveandtest1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Addtoscene1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Image3: TImage;
    Button19: TButton;
    PageControl3: TPageControl;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    CheckBox1: TCheckBox;
    TabSheet8: TTabSheet;
    Button20: TButton;
    procedure ListBox1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit12Change(Sender: TObject);
    procedure ActionTargetChange(Sender: TObject);
    procedure ActionSpinEditsChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBox2Click(Sender: TObject);
    procedure SpinEdit13Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Image1MouseLeave(Sender: TObject);
    procedure ListBox3DblClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Image1MouseEnter(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Addtoscene1Click(Sender: TObject);
    procedure ListBox3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ListBox3Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button20Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    Game: TGameBinFile;
    GameBak: TGameBinFile;
    PlayStart: Cardinal;
    MediaplayerOpened: boolean;
    StopPlayRequest: boolean;
    FirstTickCount: Cardinal;
    procedure ShowSceneBmp;
    function CurScene: PSceneDef;
    procedure LoadScene;
    procedure Load;
    procedure Save;
    procedure ReloadActionSceneLists;
    function GetGreatestSceneID: integer;
    function SearchSceneIDGapFromTop: integer;
    procedure RedrawDecisionBitmap;
    function CurPicture: PPictureDef;
    function CurPictureTimepos: Cardinal;
    procedure New;
    procedure NewScene;
    procedure SetupGUIAfterLoad;
    procedure RecalcSlideshowLength;
    procedure RecalcSoundtrackLength;
    procedure RecalcUnusedFiles;
    procedure RecalcStats;
    procedure HandlePossibleEmptySceneList;
    procedure DisableEnableSceneControls(enable: boolean);
    procedure DisableEnablePictureControls(enable: boolean);
    procedure DisableEnableFileControls(enable: boolean);
    class procedure AspectRatio(image: TImage; panel: TControl);
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Math, MMSystem, ShellAPI;

const
  DEFAULT_DURATION = 0;
  DEFAULT_FILENAME = 'DUMMY.BMP';

function GetSceneIDFromName(sceneName: string): Integer;
resourcestring
  S_SCENENAME_INVALID = 'Scene name invalid';
var
  sSceneID: string;
begin
  if Copy(sceneName, 1, 2) <> 'SC' then raise Exception.Create(S_SCENENAME_INVALID);
  sSceneID := Copy(sceneName, 3, 2);
  if not TryStrToInt(sSceneID, result) then raise Exception.Create(S_SCENENAME_INVALID);
end;

procedure SelectFilenameBase(Edit: TEdit);
begin
  if Edit.CanFocus then
  begin
    Edit.SetFocus;
    Edit.SelStart := 0;
    Edit.SelLength := Pos('.', Edit.Text)-1;
  end;
end;

function _DecisecondToTime(ds: integer): string;
begin
  result := FormatDatetime('hh:nn:ss', ds / 10 / (24*60*60))+','+IntToStr(ds mod 10);
end;

{ TForm1 }

function TForm1.GetGreatestSceneID: integer;
var
  i: integer;
begin
  result := -1;
  for i := 0 to ListBox1.Items.Count - 1 do
  begin
    result := Max(result, GetSceneIDFromName(ListBox1.Items.Strings[i]));
  end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  sE1, sE2, sE3, sE4: TSpinEdit;

  procedure _Go;
  begin
    if Button = mbLeft then
    begin
      sE1.Value := Round(Image1.Picture.Width*(X/Image1.Width));
      sE2.Value := Round(Image1.Picture.Height*(Y/Image1.Height));
    end
    else if Button = mbRight then
    begin
      sE3.Value := Round(Image1.Picture.Width*(X/Image1.Width));
      sE4.Value := Round(Image1.Picture.Height*(Y/Image1.Height));
    end;
  end;

begin
  if PageControl1.ActivePage = TabSheet1 then
  begin
    sE1 := SpinEdit3;
    sE2 := SpinEdit2;
    sE3 := SpinEdit4;
    sE4 := SpinEdit5;
    _Go;
  end
  else if PageControl1.ActivePage = TabSheet2 then
  begin
    sE1 := SpinEdit17;
    sE2 := SpinEdit18;
    sE3 := SpinEdit19;
    sE4 := SpinEdit20;
    _Go;
  end
  else if PageControl1.ActivePage = TabSheet3 then
  begin
    sE1 := SpinEdit7;
    sE2 := SpinEdit8;
    sE3 := SpinEdit10;
    sE4 := SpinEdit9;
    _Go;
  end;
end;

procedure TForm1.Image1MouseEnter(Sender: TObject);
begin
  Label28.Visible := true;
  Label29.Visible := true;
end;

procedure TForm1.Image1MouseLeave(Sender: TObject);
begin
  Label10.Caption := '';
  Label28.Visible := false;
  Label29.Visible := false;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
resourcestring
  S_COORDS = 'Coords: [%d, %d]';
begin
  label10.Caption := Format(S_COORDS, [Round(Image1.Picture.Width*(X/Image1.Width)),
                                       Round(Image1.Picture.Height*(Y/Image1.Height))]);
end;

function TForm1.SearchSceneIDGapFromTop: integer;
var
  i: integer;
begin
  result := -1;
  for i := 99 downto 0 do
  begin
    if ListBox1.Items.IndexOf(Format('SC%.2d', [i])) = -1 then
    begin
      result := i;
      exit;
    end;
  end;
end;

procedure TForm1.Button10Click(Sender: TObject);
resourcestring
  S_NOTFOUND = 'GAME.BIN saved; ShowTime32.exe not found.';
begin
  Save;
  if not FileExists('ShowTime32.exe') then raise Exception.Create(S_NOTFOUND);
  ShellExecute(Application.Handle, 'open', 'ShowTime32.exe', '', '', SW_NORMAL);
end;

procedure TForm1.Button11Click(Sender: TObject);
var
  fileName: string;
begin
  fileName := IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + CurScene^.szDecisionBmp;
  if not FileExists(fileName) then exit;
  ShellExecute(Application.Handle, 'open', PChar(fileName), '', '', SW_NORMAL);
end;

procedure TForm1.Button12Click(Sender: TObject);
var
  fileName: string;
begin
  fileName := IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + CurPicture^.szBitmapFile;
  if not FileExists(fileName) then exit;
  ShellExecute(Application.Handle, 'open', Pchar(fileName), '', '', SW_NORMAL);
end;

procedure TForm1.Button13Click(Sender: TObject);
var
  fileName: string;
begin
  fileName := CurScene^.szSceneFolder;
  if not DirectoryExists(fileName) then MkDir(fileName);
  ShellExecute(Application.Handle, 'open', 'explorer.exe', PChar(fileName), '', SW_NORMAL);
end;

procedure TForm1.HandlePossibleEmptySceneList;
begin
  if Game.numScenes = 0 then
  begin
    PageControl2.ActivePage := nil;
    PageControl2.Pages[0].TabVisible := false;
    PageControl2.Pages[1].TabVisible := false;
  end
  else
  begin
    if PageControl2.ActivePage = nil then PageControl2.ActivePageIndex := 0;
    PageControl2.Pages[0].TabVisible := true;
    PageControl2.Pages[1].TabVisible := true;
  end;
end;

procedure TForm1.Button14Click(Sender: TObject);
resourcestring
  S_DISCARD = 'Are you sure you want to discard all changes and create a new game file?';
begin
  if MessageDlg(S_DISCARD, mtConfirmation, mbYesNoCancel, 0) = mrYes then
  begin
    New;
  end;
end;

procedure TForm1.DisableEnableSceneControls(enable: boolean);
begin
  ListBox1.Enabled := enable;
  Button1.Enabled := enable;
  Button2.Enabled := enable;
  Button4.Enabled := enable;
  Button5.Enabled := enable;
end;

procedure TForm1.DisableEnablePictureControls(enable: boolean);
begin
  Button8.Enabled := enable;
  Button9.Enabled := enable;
  Button6.Enabled := enable;
  Button7.Enabled := enable;
end;

procedure TForm1.DisableEnableFileControls(enable: boolean);
begin
  Button3.Enabled := enable;
  Button10.Enabled := enable;
  Button14.Enabled := enable;
end;

var
  AutomaticNextDia: boolean;

procedure TForm1.Button15Click(Sender: TObject);
var
  decisionBMP: string;
  PictureLastFrame: Cardinal;
  i: integer;
  DecisionPicSet: boolean;
begin
  if PlayStart <> 0 then
  begin
    if MediaplayerOpened and not AutomaticNextDia then
    begin
      if MediaPlayer1.Mode = mpPlaying then MediaPlayer1.Stop;
      Mediaplayer1.TimeFormat := tfMilliseconds;
      if CurPictureTimepos*100 < Cardinal(MediaPlayer1.Length) then
      begin
        MediaPlayer1.Position := CurPictureTimepos * 100;
        MediaPlayer1.Play;
      end;
    end;
    AutomaticNextDia := false;
    FirstTickCount := GetTickCount;
    PlayStart := GetTickCount - CurPictureTimepos * 100;
  end
  else
  begin
    TabSheet5.TabVisible := false;
    DisableEnablePictureControls(false);
    DisableEnableSceneControls(false);
    DisableEnableFileControls(false);
    Edit1.Enabled := false;
    Edit3.Enabled := false;
    SpinEdit1.Enabled := false;
    SpinEdit13.Enabled := false;
    Label18.Font.Color := clGreen;
    try
      Timer1.Enabled := false;

      RecalcSoundtrackLength; // optional

      Mediaplayer1.FileName := Format('%s\%s', [CurScene^.szSceneFolder, CurScene^.szDialogWav]);
      if FileExists(Mediaplayer1.FileName) then
      begin
        Mediaplayer1.TimeFormat := tfMilliseconds;
        Mediaplayer1.Open;
        MediaplayerOpened := true;
        if CurPictureTimepos*100 < Cardinal(MediaPlayer1.Length) then
        begin
          MediaPlayer1.Position := CurPictureTimepos * 100;
          MediaPlayer1.Play;
        end;
      end
      else
      begin
        MediaplayerOpened := false;
        MediaPlayer1.FileName := '';
      end;
      PlayStart := GetTickCount - CurPictureTimepos * 100;
      Timer1.Enabled := true;

      {$REGION 'Calculate PictureLastFrame'}
      PictureLastFrame := 0;
      for i := 0 to CurScene^.numPics-1 do
      begin
        Inc(PictureLastFrame, Game.pictures[CurScene^.pictureIndex + i].duration);
      end;
      PictureLastFrame := PictureLastFrame * 100;
      {$ENDREGION}

      DecisionPicSet := false;
      while not Application.Terminated and
            not StopPlayRequest and
            (
                  (MediaPlayer1.Mode = mpPlaying) or
                  (GetTickCount - PlayStart <= PictureLastFrame)
            ) do
      begin
        if GetTickCount - PlayStart <= PictureLastFrame then
        begin
          DecisionPicSet := false;
          FirstTickCount := GetTickCount;
          while not Application.Terminated and ((GetTickCount - FirstTickCount) < CurPicture^.duration * 100) and not StopPlayRequest do
          begin
            Application.ProcessMessages;
            Sleep(0);
          end;

          if not Application.Terminated and (ListBox2.ItemIndex < ListBox2.Count-1) and not StopPlayRequest then
          begin
            ListBox2.ItemIndex := ListBox2.ItemIndex + 1;
            AutomaticNextDia := true;
            ListBox2Click(ListBox2);
          end;
        end
        else
        begin
          if not DecisionPicSet then
          begin
            decisionBMP := IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + CurScene^.szDecisionBmp;
            if (CurScene^.szDecisionBmp <> '') and FileExists(decisionBMP) then
            begin
              Image2.Picture.LoadFromFile(decisionBMP);
              AspectRatio(Image2, Panel2);
            end
            else
            begin
              Image2.Picture := nil;
            end;
            DecisionPicSet := true;
          end;
          Application.ProcessMessages;
          Sleep(0);
        end;
      end;
    finally
      PlayStart := 0;
      if MediaPlayer1.Mode = mpPlaying then MediaPlayer1.Stop;
      if MediaplayerOpened then MediaPlayer1.Close;
      StopPlayRequest := false;
      Label18.Font.Color := clWindowText;
      Timer1.Enabled := false;
      DisableEnableFileControls(true);
      DisableEnableSceneControls(true);
      DisableEnablePictureControls(true);
      TabSheet5.TabVisible := true;
      Edit1.Enabled := true;
      SpinEdit1.Enabled := true;
      Edit3.Enabled := true;
      SpinEdit13.Enabled := true;
      Label18.Caption := _DecisecondToTime(CurPictureTimepos);
      ListBox2Click(ListBox2);
    end;
  end;
end;

procedure TForm1.ShowSceneBmp;
var
  Filename: string;
begin
  Filename := string(IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + CurPicture^.szBitmapFile);
  if FileExists(Filename) then
  begin
    Image2.Picture.LoadFromFile(Filename);
    AspectRatio(Image2, Panel2);
  end
  else
  begin
    Image2.Picture := nil;
  end;
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
  ListBox2.ItemIndex := 0; // go to the beginning
  ListBox2Click(ListBox2); // load picture data
  Button15Click(Button15); // play
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
  if PlayStart <> 0 then
  begin
    Timer1.Enabled := false;
    if MediaplayerOpened then MediaPlayer1.Stop;
    StopPlayRequest := true;
  end;
end;

procedure TForm1.Button18Click(Sender: TObject);
var
  fileName: string;
begin
  fileName := IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + CurScene^.szDialogWav;
  if not FileExists(fileName) then exit;
  ShellExecute(Application.Handle, 'open', PChar(fileName), '', '', SW_NORMAL);
end;

procedure TForm1.Button19Click(Sender: TObject);
resourcestring
  S_DISCARD = 'Are you sure you want to discard all changes?';
begin
  if MessageDlg(S_DISCARD, mtConfirmation, mbYesNoCancel, 0) = mrYes then
  begin
    CopyMemory(@Game, @GameBak, SizeOf(Game));
    SetupGUIAfterLoad;
  end;
end;

procedure TForm1.NewScene;
resourcestring
  S_SCENE_FULL = 'No more space for another scene';
var
  sceneID: integer;
  newScene: PSceneDef;
begin
  if ListBox1.Items.Count = 100 then
  begin
    raise Exception.Create(S_SCENE_FULL);
  end;

  sceneID := GetGreatestSceneID+1;
  if sceneID >= Length(Game.scenes) then sceneID := SearchSceneIDGapFromTop;

  newScene := Game.AddSceneAtEnd(sceneID);
  newScene.actions[0].nextSceneID := SCENEID_ENDGAME;
  newScene.pictureIndex := Game.numPics;
  ListBox1.Items.Add(newScene.szSceneFolder);
  ReloadActionSceneLists;
  HandlePossibleEmptySceneList;
  ListBox1.ItemIndex := ListBox1.Items.Count - 1;
  ListBox1Click(ListBox1);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  NewScene;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
  Game.Defrag;
  RecalcStats;
end;

procedure TForm1.Button2Click(Sender: TObject);
resourcestring
  S_CONFLICT = 'Can''t delete this scene. There are following dependencies:'+#13#10#13#10+'%s';
  S_SCENEID = 'Scene %s, action #%d';
  // S_ONLYONE = 'Can''t delete the scene if there is only one.';
  S_REALLY_DEL = 'Do you really want to delete scene %s?';
  S_NEW_INTRO = 'Attention: This will make %s to your new intro sequence. Is that OK?';
var
  iScene, iAction, sceneID: integer;
  conflicts: TStringList;
  sWarning: string;
  bakItemindex: integer;
begin
  if ListBox1.Count = 0 then exit;

  (*
  if ListBox1.Count = 1 then
  begin
    raise Exception.Create(S_ONLYONE);
  end;
  *)

  conflicts := TStringList.Create;
  try
    sceneID := GetSceneIDFromName(CurScene^.szSceneFolder);
    for iScene := 0 to Game.numScenes-1 do
    begin
      for iAction := 0 to Game.scenes[iScene].numActions-1 do
      begin
        if Game.scenes[iScene].actions[iAction].nextSceneID = sceneID then
        begin
          conflicts.Add(Format(S_SCENEID, [Game.scenes[iScene].szSceneFolder, iAction+1]));
        end;
      end;
    end;
    if conflicts.Count > 0 then
    begin
      raise Exception.CreateFmt(S_CONFLICT, [conflicts.Text]);
    end;
  finally
    FreeAndNil(conflicts);
  end;

  sWarning := Format(S_REALLY_DEL, [CurScene^.szSceneFolder]);
  if (ListBox1.ItemIndex = 0) and (ListBox1.Count >= 2) then
    sWarning := Format(S_NEW_INTRO, [ListBox1.Items[ListBox1.ItemIndex+1]]);
  if (MessageDlg(sWarning, mtConfirmation, mbYesNoCancel, 0) <> mrYes) then
  begin
    Exit;
  end;

  Game.DeleteScene(ListBox1.ItemIndex);

  bakItemindex := ListBox1.ItemIndex;
  ListBox1.Items.Delete(bakItemindex);
  ReloadActionSceneLists;
  HandlePossibleEmptySceneList;
  if ListBox1.Count > 0 then
  begin
    if bakItemindex = ListBox1.Count then Dec(bakItemindex);
    Listbox1.ItemIndex := bakItemindex;
    ListBox1Click(ListBox1);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Save;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if ListBox1.ItemIndex <= 0 then exit;
  Game.SwapScene(ListBox1.ItemIndex, ListBox1.ItemIndex-1);
  ListBox1.Items.Exchange(ListBox1.ItemIndex, ListBox1.ItemIndex-1);
  ReloadActionSceneLists;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if ListBox1.ItemIndex = ListBox1.Count-1 then exit;
  Game.SwapScene(ListBox1.ItemIndex, ListBox1.ItemIndex+1);
  ListBox1.Items.Exchange(ListBox1.ItemIndex, ListBox1.ItemIndex+1);
  ReloadActionSceneLists;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  pic: PPictureDef;
begin
  if ListBox2.Items.Count > 0 then
    pic := Game.AddPictureBetween(CurScene^.pictureIndex + Max(ListBox2.ItemIndex+1,0), false)
  else
    pic := Game.AddPictureBetween(CurScene^.pictureIndex + Max(ListBox2.ItemIndex,0), true);
  pic.duration     := DEFAULT_DURATION;
  pic.szBitmapFile := DEFAULT_FILENAME;
  if ListBox2.ItemIndex = -1 then
  begin
    ListBox2.Items.Insert(ListBox2.Count, Format('(%d) %s', [DEFAULT_DURATION, DEFAULT_FILENAME]));
    ListBox2.ItemIndex := ListBox2.Count - 1;
  end
  else
  begin
    ListBox2.Items.Insert(ListBox2.ItemIndex+1, Format('(%d) %s', [DEFAULT_DURATION, DEFAULT_FILENAME]));
    ListBox2.ItemIndex := ListBox2.ItemIndex + 1;
  end;
  ListBox2Click(Listbox2);
  SelectFilenameBase(Edit3);
  RecalcStats;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  bakIdx: integer;
begin
  if Listbox2.Count > 0 then
  begin
    bakIdx := ListBox2.ItemIndex;
    Game.DeletePicture(CurScene^.pictureIndex + bakIdx);
    ListBox2.Items.Delete(bakIdx);
    if ListBox2.Count > 0 then
    begin
      if bakIdx = ListBox2.Count then Dec(bakIdx);
      ListBox2.ItemIndex := bakIdx;
      ListBox2Click(Listbox2);
    end;
    RecalcUnusedFiles;
  end;
  RecalcStats;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  if ListBox2.ItemIndex <= 0 then exit;
  Game.SwapPicture(CurScene^.pictureIndex+ListBox2.ItemIndex, CurScene^.pictureIndex+ListBox2.ItemIndex-1);
  ListBox2.Items.Exchange(ListBox2.ItemIndex, ListBox2.ItemIndex-1);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  if ListBox2.ItemIndex = ListBox2.Count-1 then exit;
  Game.SwapPicture(CurScene^.pictureIndex+ListBox2.ItemIndex, CurScene^.pictureIndex+ListBox2.ItemIndex+1);
  ListBox2.Items.Exchange(ListBox2.ItemIndex, ListBox2.ItemIndex+1);
end;

procedure TForm1.Save;
var
  fs: TFileStream;
begin
  CopyMemory(@GameBak, @Game, SizeOf(Game));

  fs := TFileStream.Create('GAME.BIN', fmOpenWrite or fmCreate);
  try
    fs.WriteBuffer(Game, SizeOf(Game));
  finally
    FreeAndNil(fs);
  end;
end;

procedure TForm1.ActionTargetChange(Sender: TObject);
resourcestring
  S_ASSERT_SENDER = 'Unexpected sender for ActionTargetChange()';
var
  actionIdx: integer;
  itemIdx: Integer;
begin
       if Sender = ComboBox1 then actionIdx := 0
  else if Sender = ComboBox2 then actionIdx := 1
  else if Sender = ComboBox3 then actionIdx := 2
  else raise Exception.Create(S_ASSERT_SENDER);

  itemIdx := TComboBox(Sender).ItemIndex;
  if itemIdx = 0 then
    CurScene^.actions[actionIdx].nextSceneID := SCENEID_ENDGAME
  else if itemIdx = 1 then
    CurScene^.actions[actionIdx].nextSceneID := SCENEID_PREVDECISION
  else
    CurScene^.actions[actionIdx].nextSceneID := GetSceneIDFromName(ListBox1.Items[itemIdx - 2]);
end;

procedure TForm1.Addtoscene1Click(Sender: TObject);
var
  fil: string;
begin
  if ListBox3.ItemIndex = -1 then exit;
  fil := ListBox3.Items[ListBox3.ItemIndex];
  Button6.Click;
  Edit3.Text := fil;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  _WriteStringToFilename(@CurScene^.szDialogWav, Edit1.Text);
  RecalcSoundtrackLength;
  RecalcUnusedFiles;

  Label24.Visible := not FileExists(IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + Edit1.Text);
  Label25.Visible := not FileExists(IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + 'E' + Edit1.Text);

  Button18.Visible := CurScene^.szDialogWav <> '';
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
  _WriteStringToFilename(@CurScene^.szDecisionBmp, Edit2.Text);
  RecalcUnusedFiles;
  RedrawDecisionBitmap;
  Label27.Visible := not FileExists(IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + Edit2.Text) and not (Edit2.Text = '');
  Button11.Visible := CurScene^.szDecisionBmp <> '';
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
  _WriteStringToFilename(@CurPicture^.szBitmapFile, Edit3.Text);
  ListBox2.Items[ListBox2.ItemIndex] := Format('(%d) %s', [CurPicture^.duration, CurPicture^.szBitmapFile]);
  RecalcUnusedFiles;
  ShowSceneBmp;
  Label26.Visible := not FileExists(IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + Edit3.Text);
  Button12.Visible := CurPicture^.szBitmapFile <> '';
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
resourcestring
  S_SAVE_CHANGES = 'Do you want to save the changes?';
begin
  if not CompareMem(@Game, @GameBak, SizeOf(Game)) then
  begin
    case MessageDlg(S_SAVE_CHANGES, mtConfirmation, mbYesNoCancel, 0) of
      mrYes:
      begin
        Save;
        CanClose := true;
      end;
      mrNo:
      begin
        CanClose := true;
      end;
      mrCancel:
      begin
        CanClose := false;
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  PageControl3.ActivePageIndex := 0;
  Label10.Caption := '';
  Label21.Caption := '';
  Label23.Caption := '';
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if FileExists('GAME.BIN') then
    Load
  else
    New;
end;

function TForm1.CurScene: PSceneDef;
resourcestring
  S_NO_SCENE_AVAILABLE = 'No scenes available. Please create one.';
  S_NO_SCENE_SELECTED = 'No scene selected. Please select one.';
begin
  if ListBox1.Count = 0 then raise Exception.Create(S_NO_SCENE_AVAILABLE);
  if ListBox1.ItemIndex = -1 then raise Exception.Create(S_NO_SCENE_SELECTED);
  result := @Game.scenes[ListBox1.ItemIndex];
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  LoadScene;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  Button16Click(Button16);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  RedrawDecisionBitmap;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
  Close;
end;

function TForm1.CurPicture: PPictureDef;
resourcestring
  S_NO_PICTURE_AVAILABLE = 'No pictures available. Please create one.';
  S_NO_PICTURE_SELECTED = 'No picture selected. Please select one.';
begin
  if ListBox2.Count = 0 then raise Exception.Create(S_NO_PICTURE_AVAILABLE);
  if ListBox2.ItemIndex = -1 then raise Exception.Create(S_NO_PICTURE_SELECTED);
  result := @Game.pictures[CurScene^.pictureIndex + ListBox2.ItemIndex]
end;

function TForm1.CurPictureTimepos: Cardinal;
var
  i: integer;
begin
  result := 0;
  for i := curScene^.pictureIndex to curScene^.pictureIndex + ListBox2.ItemIndex - 1 do
  begin
    Inc(result, Game.pictures[i].duration);
  end;
end;

class procedure TForm1.AspectRatio(image: TImage; panel: TControl);
var
  wi, hi, ws, hs: integer;
  ri, rs: double;
begin
  wi := image.Picture.Width;
  hi := image.Picture.Height;
  ri := wi / hi;

  ws := panel.Width;
  hs := panel.Height;
  rs := ws / hs;

  if rs > ri then
  begin
    image.Width  := Round(wi * hs/hi);
    image.Height := hs;
  end
  else
  begin
    image.Width  := ws;
    image.Height := Round(hi * ws/wi);
  end;

  image.Left := Round(panel.Width  / 2 - image.Width  / 2);
  image.Top  := Round(panel.Height / 2 - image.Height / 2);
end;

procedure TForm1.ListBox2Click(Sender: TObject);
var
  bakEvent: TNotifyEvent;
begin
  if CurScene^.numPics = 0 then
  begin
    SpinEdit13.Value := 0;

    bakEvent := Edit3.OnChange;
    try
      Edit3.OnChange := nil;
      Edit3.Text := '';
    finally
      Edit3.OnChange := bakEvent;
    end;

    Label18.Caption := '';
    Image2.Picture := nil;
    exit;
  end;
  
  SpinEdit13.Value := CurPicture^.duration;
  Edit3.Text := string(CurPicture^.szBitmapFile);

  ShowSceneBmp;

  Label18.Caption := _DecisecondToTime(CurPictureTimepos);

  if PlayStart <> 0 then
  begin
    Button15Click(Button15);
  end;

  RecalcStats;
end;

procedure TForm1.ListBox2DblClick(Sender: TObject);
begin
  Button15Click(Button15);
end;

procedure TForm1.ListBox3Click(Sender: TObject);
var
  fileName: string;
begin
  if ListBox3.ItemIndex = -1 then exit;
  fileName := IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + ListBox3.Items[ListBox3.ItemIndex];

  if not FileExists(FileName) then
  begin
    Image3.Visible := false;
    exit;
  end;

  try
    Image3.Picture.LoadFromFile(Filename);
    AspectRatio(Image3, Panel3);
    Image3.Visible := true;
  except
    Image3.Visible := false;
    // It could also be a sound file, so we do not show errors
  end;
end;

procedure TForm1.ListBox3DblClick(Sender: TObject);
var
  fileName: string;
begin
  if ListBox3.ItemIndex = -1 then exit;
  fileName := IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + ListBox3.Items[ListBox3.ItemIndex];
  if not FileExists(FileName) then exit;
  ShellExecute(Application.Handle, 'open', PChar(fileName), '', '', SW_NORMAL);
end;

procedure TForm1.ListBox3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  APoint: TPoint;
  Index: integer;
begin
  if Button = mbRight then
  begin
    APoint.X := X;
    APoint.Y := Y;
    Index := TListbox(Sender).ItemAtPos(APoint, True);
    if Index > -1 then TListbox(Sender).Selected[Index] := True;
  end;
end;

procedure TForm1.SetupGUIAfterLoad;
var
  i: integer;
begin
  ListBox1.Clear;
  for i := 0 to Game.numScenes - 1 do
  begin
    ListBox1.Items.Add(string(Game.scenes[i].szSceneFolder));
  end;
  (*
  if ListBox1.Items.Count = 0 then
  begin
    NewScene;
  end;
  *)

  ReloadActionSceneLists;
  HandlePossibleEmptySceneList;

  if ListBox1.Count > 0 then
  begin
    ListBox1.ItemIndex := 0;
    ListBox1Click(Listbox1);
  end;
end;

procedure TForm1.New;
begin
  PageControl1.ActivePageIndex := 0;
  PageControl2.ActivePageIndex := 0;
  PageControl3.ActivePageIndex := 0;
  Label10.Caption := '';
  Label21.Caption := '';
  Label23.Caption := '';

  ZeroMemory(@Game, SizeOf(Game));
  ZeroMemory(@GameBak, SizeOf(Game));

  SetupGUIAfterLoad;
end;

procedure TForm1.Load;
resourcestring
  S_CORRECTED_PICTURE_COUNT = 'Picture count was wrong. Value was corrected.';
var
  fs: TFileStream;
begin
  fs := TFileStream.Create('GAME.BIN', fmOpenRead);
  try
    fs.ReadBuffer(Game, SizeOf(Game));
  finally
    FreeAndNil(fs);
  end;

  CopyMemory(@GameBak, @Game, SizeOf(Game));

  if Game.RealPictureCount <> Game.numPics then
  begin
    MessageDlg(S_CORRECTED_PICTURE_COUNT, mtInformation, [mbOk], 0);
    Game.numPics := Game.RealPictureCount;
  end;

  SetupGUIAfterLoad;
end;

procedure TForm1.RecalcSlideshowLength;
var
  i: integer;
  Sum: integer;
begin
  Sum := 0;
  for i := CurScene^.pictureIndex to CurScene^.pictureIndex + CurScene^.numPics - 1 do
  begin
    Inc(Sum, Game.pictures[i].duration);
  end;
  Label21.Caption := _DecisecondToTime(Sum);
end;

procedure TForm1.RecalcUnusedFiles;
var
  i, idx: integer;
  SR: TSearchRec;
  ext: string;
  sl: TStringList;
  s: string;
begin
  sl := TStringList.Create;
  try
    if FindFirst(IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + '*.*', faArchive, SR) = 0 then
    begin
      repeat
        ext := UpperCase(ExtractFileExt(SR.Name));
        if ((ext <> '.PK' {Adobe Audition}) and (ext <> '.DB' {Windows Thumbnail})) then
        begin
          sl.Add(SR.Name); //Fill the list
        end;
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;

    // Remove the entries which are present
    for i := CurScene^.pictureIndex to CurScene^.pictureIndex+CurScene^.numPics-1 do
    begin
      idx := sl.IndexOf(Game.pictures[i].szBitmapFile);
      if idx <> -1 then sl.Delete(idx);
    end;

    idx := sl.IndexOf(Edit1.Text);
    if idx <> -1 then sl.Delete(idx);
    idx := sl.IndexOf('E'+Edit1.Text);
    if idx <> -1 then sl.Delete(idx);

    idx := sl.IndexOf(Edit2.Text);
    if idx <> -1 then sl.Delete(idx);

    idx := sl.IndexOf(Edit3.Text);
    if idx <> -1 then sl.Delete(idx);

    if sl.Text <> ListBox3.Items.Text then
    begin
      i := ListBox3.ItemIndex;
      if i >= 0 then
        s := ListBox3.Items.Strings[i]
      else
        s := '';
      ListBox3.Items.Assign(sl);
      i := ListBox3.Items.IndexOf(s);
      if i >= 0 then
        ListBox3.ItemIndex := i
      else
        Image3.Visible := false;
    end;
  finally
    sl.Free;
  end;
end;

procedure TForm1.RecalcSoundtrackLength;
var
  FileName: string;
resourcestring
  S_NA = 'n/a';
begin
  if MediaPlayer1.Mode = mpPlaying then exit;

  FileName := IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + CurScene^.szDialogWav;
  if not FileExists(FileName) then
  begin
    Label23.Caption := S_NA;
    exit;
  end;
  MediaPlayer1.FileName := FileName;
  MediaPlayer1.TimeFormat := tfMilliseconds;
  MediaPlayer1.Open;
  Label23.Caption := _DecisecondToTime(MediaPlayer1.Length div 100);
  MediaPlayer1.Close;
end;

procedure TForm1.LoadScene;

  procedure _SelectActionComboBox(ComboBox: TComboBox; sceneID: SmallInt);
  var
    idx: Integer;
  begin
    if sceneID = SCENEID_ENDGAME then
      ComboBox.ItemIndex := 0
    else if sceneID = SCENEID_PREVDECISION then
      ComboBox.ItemIndex := 1
    else
    begin
      idx := Game.FindSceneIndex(sceneID);
      if idx = -1 then
        ComboBox.ItemIndex := -1
      else
        ComboBox.ItemIndex := 2 + idx;
    end;
  end;

  procedure _PreparePictureList;
  var
    i: integer;
    //pic: PPictureDef;
  begin
    ListBox2.Clear;

    if CurScene^.numPics = 0 then
    begin
      (*
      pic := Game.AddPictureBetween(CurScene^.pictureIndex + Max(ListBox2.ItemIndex,0));
      pic.duration := DEFAULT_DURATION;
      pic.szBitmapFile := DEFAULT_FILENAME;
      *)
    end;

    for i := CurScene^.pictureIndex to CurScene^.pictureIndex + CurScene^.numPics - 1 do
    begin
      Listbox2.Items.Add(Format('(%d) %s', [Game.pictures[i].duration, Game.pictures[i].szBitmapFile]));
    end;
  end;

begin
  SpinEdit1.Value := GetSceneIDFromName(CurScene^.szSceneFolder);
  Edit1.Text := string(CurScene^.szDialogWav);
  Edit2.Text := string(CurScene^.szDecisionBmp);

  _PreparePictureList;
  ListBox2.ItemIndex := 0;
  ListBox2Click(Listbox2);

  _SelectActionComboBox(ComboBox1, CurScene^.actions[0].nextSceneID);
  _SelectActionComboBox(ComboBox2, CurScene^.actions[1].nextSceneID);
  _SelectActionComboBox(ComboBox3, CurScene^.actions[2].nextSceneID);

  SpinEdit12.Value := CurScene^.numActions;
  SpinEdit12Change(SpinEdit12);
  PageControl1.ActivePageIndex := 0;

  SpinEdit3.Value  := CurScene^.actions[0].cHotspotTopLeft.X;
  SpinEdit17.Value := CurScene^.actions[1].cHotspotTopLeft.X;
  SpinEdit7.Value  := CurScene^.actions[2].cHotspotTopLeft.X;
  SpinEdit2.Value  := CurScene^.actions[0].cHotspotTopLeft.Y;
  SpinEdit18.Value := CurScene^.actions[1].cHotspotTopLeft.Y;
  SpinEdit8.Value  := CurScene^.actions[2].cHotspotTopLeft.Y;
  SpinEdit4.Value  := CurScene^.actions[0].cHotspotBottomRight.X;
  SpinEdit19.Value := CurScene^.actions[1].cHotspotBottomRight.X;
  SpinEdit10.Value := CurScene^.actions[2].cHotspotBottomRight.X;
  SpinEdit5.Value  := CurScene^.actions[0].cHotspotBottomRight.Y;
  SpinEdit20.Value := CurScene^.actions[1].cHotspotBottomRight.Y;
  SpinEdit9.Value  := CurScene^.actions[2].cHotspotBottomRight.Y;
  SpinEdit6.Value  := CurScene^.actions[0].scoreDelta;
  SpinEdit21.Value := CurScene^.actions[1].scoreDelta;
  SpinEdit11.Value := CurScene^.actions[2].scoreDelta;

  RedrawDecisionBitmap;

  RecalcSlideshowLength;
  RecalcSoundtrackLength;

  RecalcUnusedFiles;

  RecalcStats;
end;

procedure TForm1.RecalcStats;
begin
  Label35.Caption := IntToStr(ListBox1.ItemIndex) + ' / ' + IntToStr(Game.numScenes);

  if ListBox2.ItemIndex >= 0 then
    Label31.Caption := IntToStr(CurScene^.pictureIndex) + ' + ' + IntToStr(ListBox2.ItemIndex) + ' = ' + IntToStr(CurScene^.pictureIndex+ListBox2.ItemIndex)
  else
    Label31.Caption := IntToStr(CurScene^.pictureIndex);

  Label33.Caption := IntToStr(CurScene^.numPics) + ' / ' + IntToStr(Game.numPics);

  Label37.Caption := IntToStr(CurScene^.numActions) + ' / ' + IntToStr(Game.RealActionCount);
end;

procedure TForm1.ReloadActionSceneLists;

  procedure _ReloadActionSceneLists(ComboBox: TComboBox);
  resourcestring
    S_TERMINATE = 'Terminate program';
    S_PREV_DEC = 'Previous decision';
  var
    prevSelection: string;
    i: Integer;
  begin
    prevSelection := ComboBox.Text;
    try
      ComboBox.Items.Clear;
      ComboBox.Items.Add(S_TERMINATE);
      ComboBox.Items.Add(S_PREV_DEC);
      ComboBox.Items.AddStrings(ListBox1.Items);
    finally
      ComboBox.ItemIndex := 0;
      for i := ComboBox.Items.Count - 1 downto 0 do
      begin
        if ComboBox.Items.Strings[i] = prevSelection then
        begin
          ComboBox.ItemIndex := i;
        end;
      end;
    end;
  end;

begin
  _ReloadActionSceneLists(ComboBox1);
  _ReloadActionSceneLists(ComboBox2);
  _ReloadActionSceneLists(ComboBox3);
end;

procedure TForm1.SpinEdit12Change(Sender: TObject);
begin
  TabSheet3.TabVisible := SpinEdit12.Value >= 3;
  if PageControl1.ActivePage = TabSheet3 then PageControl1.ActivePage := TabSheet2;

  TabSheet2.TabVisible := SpinEdit12.Value >= 2;
  if PageControl1.ActivePage = TabSheet2 then PageControl1.ActivePage := TabSheet1;

  // TabSheet1.TabVisible := SpinEdit12.Value >= 1;

  CurScene^.numActions := SpinEdit12.Value;

  // QUE: zero data of actions which are inactive (numActions<action)?

  RecalcStats;
  RedrawDecisionBitmap;
end;

procedure TForm1.SpinEdit13Change(Sender: TObject);
begin
  if SpinEdit13.Text = '' then exit;
  CurPicture^.duration := SpinEdit13.Value;
  ListBox2.Items[ListBox2.ItemIndex] := Format('(%d) %s', [CurPicture^.duration, CurPicture^.szBitmapFile]);
  RecalcSlideshowLength;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);

  function _CountNumScenes(str: string): integer;
  var
    i: integer;
  begin
    result := 0;
    for i := 0 to ListBox1.Count-1 do
    begin
      if ListBox1.Items[i] = str then Inc(result);
    end;
  end;

var
  sNew: string;
begin
  // TODO: warn if dependencies are broken

  if SpinEdit1.Text = '' then exit;
  CurScene; // verify that a scene exists and is selected
  sNew := Format('SC%.2d', [SpinEdit1.Value]);
  ListBox1.Items[ListBox1.ItemIndex] := sNew;
  Label17.Visible := _CountNumScenes(sNew) > 1;
  ReloadActionSceneLists;
  _WriteStringToFilename(@CurScene^.szSceneFolder, ListBox1.Items[ListBox1.ItemIndex]);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  ms: Cardinal;
begin
  ms := GetTickCount - PlayStart;
  Label18.Caption := FormatDatetime('hh:nn:ss', ms / 1000 / (24*60*60)) + ',' + IntToStr(ms mod 1000 div 100);
end;

procedure TForm1.About1Click(Sender: TObject);
begin
  ShowMessage('Plumbers Don''t Wear Ties - GAME.BIN editor (can be also used to create new games based on the "ShowTime" engine!)'+#13#10#13#10+'Written by Daniel Marschall (www.daniel-marschall.de)'+#13#10#13#10+'Published by ViaThinkSoft (www.viathinksoft.com)'+#13#10#13#10+'Current version: ' + CUR_VER);
end;

procedure TForm1.ActionSpinEditsChange(Sender: TObject);
begin
  if TSpinEdit(Sender).Text = '' then exit; // user is about to enter a negative value
  if TSpinEdit(Sender).Text = '-' then exit; // user is about to enter a negative value

       if Sender = SpinEdit3  then CurScene^.actions[0].cHotspotTopLeft.X := TSpinEdit(Sender).Value
  else if Sender = SpinEdit17 then CurScene^.actions[1].cHotspotTopLeft.X := TSpinEdit(Sender).Value
  else if Sender = SpinEdit7  then CurScene^.actions[2].cHotspotTopLeft.X := TSpinEdit(Sender).Value
  else if Sender = SpinEdit2  then CurScene^.actions[0].cHotspotTopLeft.Y := TSpinEdit(Sender).Value
  else if Sender = SpinEdit18 then CurScene^.actions[1].cHotspotTopLeft.Y := TSpinEdit(Sender).Value
  else if Sender = SpinEdit8  then CurScene^.actions[2].cHotspotTopLeft.Y := TSpinEdit(Sender).Value
  else if Sender = SpinEdit4  then CurScene^.actions[0].cHotspotBottomRight.X := TSpinEdit(Sender).Value
  else if Sender = SpinEdit19 then CurScene^.actions[1].cHotspotBottomRight.X := TSpinEdit(Sender).Value
  else if Sender = SpinEdit10 then CurScene^.actions[2].cHotspotBottomRight.X := TSpinEdit(Sender).Value
  else if Sender = SpinEdit5  then CurScene^.actions[0].cHotspotBottomRight.Y := TSpinEdit(Sender).Value
  else if Sender = SpinEdit20 then CurScene^.actions[1].cHotspotBottomRight.Y := TSpinEdit(Sender).Value
  else if Sender = SpinEdit9  then CurScene^.actions[2].cHotspotBottomRight.Y := TSpinEdit(Sender).Value
  else if Sender = SpinEdit6  then CurScene^.actions[0].scoreDelta := TSpinEdit(Sender).Value
  else if Sender = SpinEdit21 then CurScene^.actions[1].scoreDelta := TSpinEdit(Sender).Value
  else if Sender = SpinEdit11 then CurScene^.actions[2].scoreDelta := TSpinEdit(Sender).Value;

  RedrawDecisionBitmap;
end;

procedure TForm1.RedrawDecisionBitmap;
var
  Filename: string;
begin
  FileName := string(IncludeTrailingPathDelimiter(CurScene^.szSceneFolder) + Edit2.Text);

  Image1.Visible := FileExists(FileName);

  if not FileExists(FileName) then exit;

  Image1.Picture.Bitmap.LoadFromFile(FileName);
  AspectRatio(Image1, Panel1);

  Image1.Picture.Bitmap.PixelFormat := pf24bit; // Extend the palette, so we have red, green and blue guaranteed.

  Image1.Canvas.Brush.Style := bsDiagCross;

  if (CheckBox1.Checked or (CurScene^.numActions >= 1)) and
     (SpinEdit3.Value < SpinEdit4.Value) and (SpinEdit2.Value < SpinEdit5.Value) then
  begin
    Image1.Canvas.Pen.Color := clRed;
    Image1.Canvas.Brush.Color := clRed;
    Image1.Canvas.Rectangle(SpinEdit3.Value,  SpinEdit2.Value,  SpinEdit4.Value,  SpinEdit5.Value);
  end;

  if (CheckBox1.Checked or (CurScene^.numActions >= 2)) and
     (SpinEdit17.Value < SpinEdit19.Value) and (SpinEdit18.Value < SpinEdit20.Value) then
  begin
    Image1.Canvas.Pen.Color := clLime;
    Image1.Canvas.Brush.Color := clLime;
    Image1.Canvas.Rectangle(SpinEdit17.Value, SpinEdit18.Value, SpinEdit19.Value, SpinEdit20.Value);
  end;

  if (CheckBox1.Checked or (CurScene^.numActions >= 3)) and
     (SpinEdit7.Value < SpinEdit10.Value) and (SpinEdit8.Value < SpinEdit9.Value) then
  begin
    Image1.Canvas.Pen.Color := clBlue;
    Image1.Canvas.Brush.Color := clBlue;
    Image1.Canvas.Rectangle(SpinEdit7.Value,  SpinEdit8.Value,  SpinEdit10.Value, SpinEdit9.Value);
  end;
end;

end.
