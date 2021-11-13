/*
 * Plumbers Don't Wear Ties - Structure of GAME.BIN
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
 */

#ifndef PLUMBERS_GAMESTRUCT_HEADER
#define PLUMBERS_GAMESTRUCT_HEADER

#include <stdint.h>

#define SCENEID_PREVDECISION 32767
#define SCENEID_ENDGAME      -1

#define SEGMENT_BEGINNING 0
#define SEGMENT_DECISION  1

#pragma pack(push, 1)

struct _coord {
	int16_t     x;
	int16_t     y;
};

struct _actionDef {
	int32_t     scoreDelta;
	int16_t     nextSceneID;       // will jump to the scene with the name "SCxx", where xx stands for nextSceneID (2 digits at least)
	                               // SCENEID_PREVDECISION (0x7FFF) = end game
	                               // SCENEID_ENDGAME (0xFFFF)      = go back to the last decision
	int16_t     sceneSegment;      // SEGMENT_BEGINNING (0) = start scene from beginning
	                               // SEGMENT_DECISION (1)  = go to decision page
	_coord      cHotspotTopLeft;
	_coord      cHotspotBottomRight;
};

struct _sceneDef {
	int16_t     numPics;
	int16_t     pictureIndex;
	int16_t     numActions;
	char        szSceneFolder[14]; // Foldername *must* be "SCxx" (case sensitive) where xx stands for a 2 digit ID
	char        szDialogWav[14];
	char        szDecisionBmp[14];
	_actionDef  actions[3];
};

struct _pictureDef {
	int16_t     duration;          // deciseconds
	char        szBitmapFile[14];
};

struct _gameBinFile {
	int16_t     unknown1[7];
	int16_t     numScenes;
	int16_t     numPics;
	int16_t     unknown2[2];
	_sceneDef   scenes[100];       // Scenes start at file position 0x0016
	_pictureDef pictures[2000];    // Pictures start at file position 0x2596
};

#pragma pack(pop)

#endif // PLUMBERS_GAMESTRUCT_HEADER
