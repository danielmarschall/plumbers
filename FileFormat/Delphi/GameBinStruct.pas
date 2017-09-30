unit GameBinStruct;

{$A-}

interface

const
  SCENEID_PREVDECISION = -1;
  SCENEID_ENDGAME      = 32767;

type
  PCoord = ^TCoord;
  TCoord = packed record
    x: Word;
    y: Word;
  end;

  PActionDef = ^TActionDef;
  TActionDef = packed record
    scoreDelta: Integer;
    nextSceneID: SmallInt;  // will jump to the scene with the name "SC<nextSceneID>"
                            // 7FFF (32767) = end game
                            // FFFF (   -1) = go back to the last decision
    sceneSegment: SmallInt; // 0 = scene from beginning, 1 = decision page
    cHotspotTopLeft: TCoord;
    cHotspotBottomRight: TCoord;
  end;

  PAnsiFileName = ^TAnsiFileName;
  TAnsiFileName = array[0..13] of AnsiChar;

  PSceneDef = ^TSceneDef;
  TSceneDef = packed record
    numPics: Word;
    pictureIndex: Word;
    numActions: Word;
    szSceneFolder: TAnsiFileName; // Foldername *must* be "SCxx" (case sensitive) where xx stands for a 2 digit ID
    szDialogWav:   TAnsiFileName;
    szDecisionBmp: TAnsiFileName;
    actions: array[0..2] of TActionDef;
  end;

  PPictureDef = ^TPictureDef;
  TPictureDef = packed record
    duration: Word; // deciseconds
    szBitmapFile: TAnsiFileName;
  end;

  PGameBinFile = ^TGameBinFile;
  TGameBinFile = packed record
    unknown1: array[0..6] of Word;
    numScenes: Word;
    numPics: Word;
    unknown2: array[0..1] of Word;
    scenes: array[0..99] of TSceneDef;        // Scenes start at 0x0016
    pictures: array[0..1999] of TPictureDef;  // Pictures start at 0x2596
    function AddSceneAtEnd(SceneID: integer): PSceneDef;
    procedure DeleteScene(SceneIndex: integer);
    procedure SwapScene(IndexA, IndexB: integer);
    procedure DeletePicture(PictureIndex: integer);
    procedure SwapPicture(IndexA, IndexB: integer);
    function AddPictureBetween(Index: integer): PPictureDef;
  end;

procedure _WriteStringToFilename(x: PAnsiFileName; s: AnsiString);

implementation

uses
  Windows, SysUtils, Math;

procedure _WriteStringToFilename(x: PAnsiFileName; s: AnsiString);
begin
  ZeroMemory(x, Length(x^));
  StrPLCopy(x^, s, Length(x^));
end;

function TGameBinFile.AddSceneAtEnd(SceneID: integer): PSceneDef;
begin
  if Self.numScenes >= Length(Self.scenes) then raise Exception.Create('No more space for another scene');
  if sceneID >= Length(Self.scenes) then raise Exception.Create('SceneID is too large.');
  result := @Self.scenes[Self.numScenes];
  ZeroMemory(result, SizeOf(TSceneDef));
  _WriteStringToFilename(@result.szSceneFolder, AnsiString(Format('SC%.2d', [sceneID])));
  Inc(Self.numScenes);
end;

procedure TGameBinFile.DeleteScene(SceneIndex: integer);
begin
  if ((SceneIndex < 0) or (SceneIndex >= Length(Self.scenes))) then raise Exception.Create('Invalid scene index');
  If SceneIndex < Length(Self.scenes)-1 then
  begin
    CopyMemory(@Self.scenes[SceneIndex], @Self.scenes[SceneIndex+1], (Length(Self.scenes)-SceneIndex-1)*SizeOf(TSceneDef));
  end;
  ZeroMemory(@Self.scenes[Length(Self.scenes)-1], SizeOf(TSceneDef));
end;

procedure TGameBinFile.SwapScene(IndexA, IndexB: integer);
var
  bakScene: TSceneDef;
begin
  if IndexA = IndexB then exit;
  if ((Min(IndexA, IndexB) < 0) or (Max(IndexA, IndexB) >= Length(Self.scenes))) then raise Exception.Create('Invalid scene index');
  CopyMemory(@bakScene, @Self.scenes[IndexA], SizeOf(TSceneDef));
  CopyMemory(@Self.scenes[IndexA], @Self.scenes[IndexB], SizeOf(TSceneDef));
  CopyMemory(@Self.scenes[IndexB], @bakScene, SizeOf(TSceneDef));
end;

procedure TGameBinFile.DeletePicture(PictureIndex: integer);
var
  iScene: integer;
begin
  if (PictureIndex < 0) or (PictureIndex >= Length(Self.pictures)) then raise Exception.Create('Invalid picture index');

  for iScene := 0 to Self.numScenes-1 do
  begin
    if (PictureIndex >= Self.scenes[iScene].pictureIndex) and
       (PictureIndex <= Self.scenes[iScene].pictureIndex + Self.scenes[iScene].numPics - 1) then
    begin
      Dec(Self.scenes[iScene].numPics);
    end
    else if (PictureIndex < Self.scenes[iScene].pictureIndex) then
    begin
      Dec(Self.scenes[iScene].pictureIndex);
    end;
  end;

  If PictureIndex < Length(Self.pictures)-1 then
  begin
    CopyMemory(@Self.pictures[PictureIndex], @Self.pictures[PictureIndex+1], (Length(Self.pictures)-PictureIndex-1)*SizeOf(TPictureDef));
  end;
  ZeroMemory(@Self.pictures[Length(Self.pictures)-1], SizeOf(TPictureDef));
end;

procedure TGameBinFile.SwapPicture(IndexA, IndexB: integer);
var
  bakPicture: TPictureDef;
begin
  // QUE: should we forbid that a picture between "scene borders" are swapped?

  if IndexA = IndexB then exit;
  if ((Min(IndexA, IndexB) < 0) or (Max(IndexA, IndexB) >= Length(Self.pictures))) then raise Exception.Create('Invalid picture index');

  CopyMemory(@bakPicture, @Self.pictures[IndexA], SizeOf(TPictureDef));
  CopyMemory(@Self.pictures[IndexA], @Self.pictures[IndexB], SizeOf(TPictureDef));
  CopyMemory(@Self.pictures[IndexB], @bakPicture, SizeOf(TPictureDef));
end;

function TGameBinFile.AddPictureBetween(Index: integer): PPictureDef;
var
  iScene: integer;
begin
  if Self.numPics >= Length(Self.pictures) then raise Exception.Create('No more space for another picture');
  if ((Index < 0) or (Index >= Length(Self.pictures))) then raise Exception.Create('Invalid picture index');

  for iScene := 0 to Self.numScenes-1 do
  begin
    if (Index >= Self.scenes[iScene].pictureIndex) and
       (index <= Self.scenes[iScene].pictureIndex + Max(0,Self.scenes[iScene].numPics - 1)) then
    begin
      Inc(Self.scenes[iScene].numPics);
    end
    else if (index < Self.scenes[iScene].pictureIndex) then
    begin
      Inc(Self.scenes[iScene].pictureIndex);
    end;
  end;

  result := @Self.pictures[Index];
  CopyMemory(@Self.pictures[Index+1], result, (Length(Self.pictures)-Index-1)*SizeOf(TPictureDef));
  ZeroMemory(result, SizeOf(TPictureDef));
end;

end.
