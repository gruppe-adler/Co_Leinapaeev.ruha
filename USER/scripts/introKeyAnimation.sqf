private _timeline = GRAD_LEIP_introKeyFrameAnimation;
diwako_dui_main_toggled_off = true;

// if (!isMultiplayer) exitWith {};
// if (didJIP) exitWith {};

cutText ["", "BLACK", 999];

[_timeline] call BIS_fnc_timeline_play;

private _camera = ([introCam1] call BIS_fnc_camera_getCam);
_camera cameraEffect ["internal","back"];
/*
_camera camSetPos (position introCamPos_1);
_camera camSetTarget introCamTarget_1;
*/

0 fadeMusic 1;
0 fadeSound 0;


cutText ["", "BLACK IN", 8];

/*
for "_i" from 0 to 20 do {
    private _agent = createAgent ["Mullet_F", position introFishSpawnPos, [], 2, "CAN_COLLIDE"]; 
    _agent setDir 20;
};
*/


private _filmgrain = ppEffectCreate ["FilmGrain",2000];  
_filmgrain ppEffectEnable true;  
_filmgrain ppEffectAdjust [0.3,0.3,0.12,0.12,0.12,true];  
_filmgrain ppEffectCommit 0;


/*
_camera camSetPos (position introCamPos_1);
_camera camCommand "inertia on";
_camera camSetTarget introCamTarget_1;
_camera cameraEffect ["internal","back"];
_camera camSetFov 0.25;
_camera camCommit 0;
_camera camSetFov 0.35;
_camera camSetPos (position introCamPos_2);
_camera camSetTarget introCamTarget_2;
_camera camCommit 50;
sleep 50;
_camera camSetPos (position introCamPos_3);
_camera camCommit 5;
sleep 5;
_camera camSetTarget introCamTarget_3;
_camera camCommit 5;
sleep 5;
_camera camSetTarget introCamTarget_4;
_camera camCommit 5;
sleep 5;
_camera camSetPos (position introCamPos_4);
_camera camCommit 10;
sleep 10;
*/
sleep 120;

10 fadeMusic 0;
10 fadeSound 1;

// private _camera = ([introCam1] call BIS_fnc_camera_getCam);
_camera camSetTarget player;
_camera camCommit 3;
sleep 1;
detach _camera;
_camera camSetPos [getPos player select 0, getPos player select 1, 1.7];
_camera camCommit 5;
sleep 3;
cutText ["", "BLACK OUT", 1];
sleep 1;
_filmgrain ppEffectEnable false;   
ppEffectDestroy _filmgrain; 
_camera cameraEffect ["terminate","back"];
camDestroy _camera;
sleep 1;
cutText ["", "BLACK IN", 1];


cutText ["","BLACK FADED",999];
sleep 3;


introTexture_1 setObjectTexture [0, ""];
introTexture_2 setObjectTexture [0, ""];
introTexture_3 setObjectTexture [0, ""];
introTexture_4 setObjectTexture [0, ""];


cutText ["", "BLACK IN", 10];

sleep 5;
STHud_UIMode = 1;
diwako_dui_main_toggled_off = false;