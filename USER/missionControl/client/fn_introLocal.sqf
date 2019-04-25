diwako_dui_main_toggled_off = true;

private _camera = "camera" camCreate (ASLToAGL eyePos player);
_camera cameraEffect ["internal","back"];
_camera camSetPos (position classicIntroPos_1);
_camera camSetTarget introCamTarget_1;
_camera camCommand "inertia on";
_camera camSetFov 0.35;
_camera camCommit 0;

0 fadeMusic 1;
0 fadeSound 0;

sleep 3;

cutText ["", "BLACK IN", 5];

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


_camera camSetFov 0.25;
_camera camSetPos (position classicIntroPos_2);
_camera camSetTarget introCamTarget_2;
_camera camCommit 44;
sleep 45;

0 = ["WetDistortion", 300, [
    0.1,
    0.1, 0.1,
    4.10, 3.70, 2.50, 1.85,
    0.0054, 0.0041, 0.0090, 0.0070,
    0.5, 0.3, 10.0, 6.0]] spawn
{
    sleep 7;
    params ["_name", "_priority", "_effect", "_handle"];
    while {
        _handle = ppEffectCreate [_name, _priority];
        _handle < 0
    } do {
        _priority = _priority + 1;
    };
    _handle ppEffectEnable true;
    _handle ppEffectAdjust _effect;
    _handle ppEffectCommit 1;
    waitUntil {ppEffectCommitted _handle};
    systemChat "admire effect for a sec";
    _handle ppEffectAdjust [
    0,
    0, 0,
    4.10, 3.70, 2.50, 1.85,
    0.0054, 0.0041, 0.0090, 0.0070,
    0.5, 0.3, 10.0, 6.0];
    _handle ppEffectCommit 2;
    waitUntil {ppEffectCommitted _handle};
    uiSleep 1;
    _handle ppEffectEnable false;
    ppEffectDestroy _handle;
};



_camera camSetPos (position classicIntroPos_7);
_camera camSetTarget introCamTarget_3;
_camera camCommit 10;
sleep 7;

[introPeeGuy] spawn MissionControl_fnc_doPee;
sleep 4;

_camera camSetTarget introCamTarget_4;
_camera camCommit 12;
sleep 12;

_camera camSetPos (position classicIntroPos_8);
_camera camCommit 30;
sleep 30;

// sleep 120;

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

playMusic "";
sleep 5;
STHud_UIMode = 1;
diwako_dui_main_toggled_off = false;