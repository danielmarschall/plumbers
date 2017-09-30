unit Game;

interface

uses
  SysUtils, Classes, Forms, GameBinStruct;

type
  TPictureType = (ptDia, ptDecision);

  THotspotIndex = 0..2;
  
  TGame = class;
  PHotspot = ^THotspot;
  THotspot = record
    game: TGame;
    lpAction: PActionDef;
    cHotspotTopLeft: TCoord;
    cHotspotBottomRight: TCoord;
  end;

  TShowPictureCallback = procedure(Game: TGame; AFilename: string; AType: TPictureType) of object;
  TPlaySoundCallback = procedure(Game: TGame; AFilename: string) of object;
  TSimpleCallback = procedure(Game: TGame) of object;
  TWaitCallback = procedure(Game: TGame; AMilliseconds: integer) of object;
  TSetHotspotCallback = procedure(Game: TGame; AIndex: THotspotIndex; AHotspot: THotspot) of object;
  TClearHotspotsCallback = procedure(Game: TGame) of object;
  
  TGame = class(TObject)
  private
    FPictureShowCallback: TShowPictureCallback;
    FAsyncSoundCallback: TPlaySoundCallback;
    FExitCallback: TSimpleCallback;
    FWaitCallback: TWaitCallback;
    FSetHotspotCallback: TSetHotspotCallback;
    FClearHotspotsCallback: TClearHotspotsCallback;
    FDirectory: string;
    FScore: integer;
    CurDecisionScene, LastDecisionScene: PSceneDef;
    procedure TryExit;
    procedure PrevDecisionScene;
  protected
    GameData: TGameBinFile;
    function FindScene(ASceneID: integer): PSceneDef;
    procedure Wait(AMilliseconds: integer);
    procedure PlayScene(scene: PSceneDef; goToDecision: boolean);
  public
    procedure PerformAction(action: PActionDef);
    property PictureShowCallback: TShowPictureCallback read FPictureShowCallback write FPictureShowCallback;
    property AsyncSoundCallback: TPlaySoundCallback read FAsyncSoundCallback write FAsyncSoundCallback;
    property ExitCallback: TSimpleCallback read FExitCallback write FExitCallback;
    property WaitCallback: TWaitCallback read FWaitCallback write FWaitCallback;
    property SetHotspotCallback: TSetHotspotCallback read FSetHotspotCallback write FSetHotspotCallback;
    property ClearHotspotsCallback: TClearHotspotsCallback read FClearHotspotsCallback write FClearHotspotsCallback;
    property Directory: string read FDirectory;
    property Score: integer read FScore;
    constructor Create(ADirectory: string);
    procedure Run;
  end;

implementation

{ TGame }

constructor TGame.Create(ADirectory: string);
var
  fs: TFileStream;
  gameBinFilename: string;
begin
  FDirectory := ADirectory;

  gameBinFilename := IncludeTrailingPathDelimiter(ADirectory) + 'GAME.BIN';
  if not FileExists(gameBinFilename) then
  begin
    raise Exception.Create('Cannot find GAME.BIN');
  end;

  fs := TFileStream.Create(gameBinFilename, fmOpenRead);
  try
    fs.ReadBuffer(GameData, SizeOf(GameData));
  finally
    FreeAndNil(fs);
  end;
end;

function TGame.FindScene(ASceneID: integer): PSceneDef;
var
  i: integer;
begin
  for i := 0 to GameData.numScenes - 1 do
  begin
    if GameData.scenes[i].szSceneFolder = Format('SC%.2d', [ASceneID]) then
    begin
      result := @GameData.scenes[i];
      exit;
    end;
  end;
  result := nil;
end;

procedure TGame.TryExit;
begin
  if Assigned(ExitCallback) then ExitCallback(Self);
end;

procedure TGame.PrevDecisionScene;
begin
  if Assigned(LastDecisionScene) then PlayScene(LastDecisionScene, true)
end;

procedure TGame.PerformAction(action: PActionDef);
var
  nextScene: PSceneDef;
begin
  Inc(FScore, action^.scoreDelta);
  if action^.nextSceneID = SCENEID_PREVDECISION then
    PrevDecisionScene
  else if action^.nextSceneID = SCENEID_ENDGAME then
    TryExit
  else
  begin
    nextScene := FindScene(action^.nextSceneID);
    if Assigned(nextScene) then
      PlayScene(nextScene, action^.sceneSegment=1)
    (*
    else
      raise Exception.CreateFmt('Scene %d was not found in GAME.BIN', [action^.nextSceneID]);
    *)
  end;
end;

procedure TGame.Wait(AMilliseconds: integer);
begin
  if Assigned(WaitCallback) then
    WaitCallback(Self, AMilliseconds)
  else
    Sleep(AMilliseconds);
end;

procedure TGame.PlayScene(scene: PSceneDef; goToDecision: boolean);
var
  i: integer;
  hotspot: THotspot;
begin
  if Assigned(ClearHotspotsCallback) then
  begin
    ClearHotspotsCallback(Self);
  end;
  if not goToDecision then
  begin
    if Assigned(AsyncSoundCallback) then
    begin
      AsyncSoundCallback(Self, IncludeTrailingPathDelimiter(FDirectory) +
        scene^.szSceneFolder + PathDelim + scene^.szDialogWav);
    end;
    for i := scene^.pictureIndex to scene^.pictureIndex + scene^.numPics - 1 do
    begin
      if Assigned(PictureShowCallback) then
      begin
        PictureShowCallback(Self, IncludeTrailingPathDelimiter(FDirectory) +
          scene^.szSceneFolder + PathDelim + GameData.pictures[i].szBitmapFile, ptDia);
      end;
      Wait(GameData.pictures[i].duration * 100);
      if Application.Terminated then Abort;
    end;
  end;
  if scene^.szDecisionBmp <> '' then
  begin
    LastDecisionScene := CurDecisionScene;
    CurDecisionScene := scene;
    if Assigned(PictureShowCallback) then
    begin
      PictureShowCallback(Self, IncludeTrailingPathDelimiter(FDirectory) +
        scene^.szSceneFolder + PathDelim + scene^.szDecisionBmp, ptDecision);
    end;
    if Assigned(SetHotspotCallback) then
    begin
      for i := 0 to scene^.numActions - 1 do
      begin
        hotspot.Game := Self;
        hotspot.lpAction := @scene^.actions[i];
        hotspot.cHotspotTopLeft.X := scene^.actions[i].cHotspotTopLeft.X;
        hotspot.cHotspotTopLeft.Y := scene^.actions[i].cHotspotTopLeft.Y;
        hotspot.cHotspotBottomRight.X := scene^.actions[i].cHotspotBottomRight.X;
        hotspot.cHotspotBottomRight.Y := scene^.actions[i].cHotspotBottomRight.Y;        
        SetHotspotCallback(Self, i, hotspot);
      end;
    end;
  end
  else
  begin
    if scene^.numActions > 0 then PerformAction(@scene^.actions[0]);
  end;
end;

procedure TGame.Run;
begin
  if GameData.numScenes = 0 then exit;
  PlayScene(@GameData.Scenes[0], false);
end;

end.