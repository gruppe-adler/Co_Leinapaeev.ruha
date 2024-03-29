if (didJIP || !isMultiplayer) exitWith {
    "introBlackLoading" cutText ["", "BLACK IN", 2];
    // [player] call missionControl_fnc_jipSpawn;
    sleep 3;
    "introBlackLoading" cutText ["", "PLAIN", 3];
    0 fadeSound 1;
};

diwako_dui_main_toggled_off = true;

"introBlackLoading" cutText ["loading", "BLACK FADED", 999];

private _camera = "camera" camCreate (ASLToAGL eyePos player);
_camera cameraEffect ["internal","back"];
_camera camSetPos (position classicIntroPos_1);
_camera camSetTarget introCamTarget_1;
_camera camCommand "inertia on";
_camera camSetFov 0.30;
_camera camCommit 0;

private _filmgrain = ppEffectCreate ["FilmGrain",2000];  
_filmgrain ppEffectEnable true;  
_filmgrain ppEffectAdjust [0.01,0.3,0.12,0.12,0.12,true];  
_filmgrain ppEffectCommit 0;

0 fadeMusic 1;
0 fadeSound 0;

sleep 3;

fakeRadio say3D ["introRadioSong",150];
playMusic "rossiya";

missionNamespace setVariable ["introRadioSongStartTime", CBA_missionTime];


"introBlackLoading" cutText ["", "BLACK IN", 15];


_camera camSetFov 0.23;
_camera camSetPos (position classicIntroPos_2);
_camera camSetTarget introCamTarget_2;
_camera camCommit 46.5;
sleep 48.2;

if (!weaponLowered player) then {
    player action ["WeaponOnBack", player];
};

[{
    ((positionCameraToWorld [0,0,0]) select 2) > -0.1
}, {
    0 = ["WetDistortion", 300, [
    0.1,
    0.1, 0.1,
    4.10, 3.70, 2.50, 1.85,
    0.0054, 0.0041, 0.0090, 0.0070,
    0.5, 0.3, 10.0, 6.0]] spawn
    {
        params ["_name", "_priority", "_effect", "_handle"];
        [missionNamespace getVariable ["CO_LP_peeGuy", objNull]] spawn MissionControl_fnc_doPee;

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
        // systemChat "admire effect for a sec";
        _handle ppEffectAdjust [
        0,
        0, 0,
        4.10, 3.70, 2.50, 1.85,
        0.0054, 0.0041, 0.0090, 0.0070,
        0.5, 0.3, 10.0, 6.0];
        _handle ppEffectCommit 3;
        waitUntil {ppEffectCommitted _handle};
        uiSleep 1;
        _handle ppEffectEnable false;
        ppEffectDestroy _handle;
    };
}] call CBA_fnc_waitUntilAndExecute;


sleep 1;
_camera camSetPos (position classicIntroPos_7);
_camera camSetTarget introCamTarget_3;
_camera camCommit 10;
sleep 5.5;

if (!weaponLowered player) then {
    player action ["WeaponOnBack", player];
};


sleep 5;

_camera camSetTarget introCamTarget_4;
_camera camCommit 12;
sleep 15;

_camera camSetPos (position classicIntroPos_8);
_camera camCommit 50;
sleep 50;

// sleep 120;

10 fadeMusic 0;
10 fadeSound 1;

if (rank player != "LIEUTENANT") then {
    _camera camSetTarget player;
    _camera camCommit 3;
    sleep 1;
    detach _camera;
    _camera camSetPos [getPos player select 0, getPos player select 1, 1.7];
    _camera camCommit 5;
};
sleep 3;
cutText ["", "BLACK OUT", 1];

fakeRadio2 say3D ["introRadioSong",150, 1, true, CBA_missionTime - (missionNamespace getVariable ["introRadioSongStartTime", 0])];
fakeRadio3 say3D ["introRadioSong",150, 1, true, CBA_missionTime - (missionNamespace getVariable ["introRadioSongStartTime", 0])];
fakeRadio4 say3D ["introRadioSong",150, 1, true, CBA_missionTime - (missionNamespace getVariable ["introRadioSongStartTime", 0])];
 

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
sleep 50;
STHud_UIMode = 1;
diwako_dui_main_toggled_off = false;