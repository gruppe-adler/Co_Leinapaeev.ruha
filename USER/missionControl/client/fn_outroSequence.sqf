params ["_unit", "_chair", "_chairs", "_count"];

STHud_UIMode = 0;
diwako_dui_main_toggled_off = true;

private _zeusDisplay = (findDisplay 312);

if (!isNull _zeusDisplay) then {
    _zeusDisplay closeDisplay 2;
};

// prepare players to watch intro
[objNull, _unit] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;
if (([] call ace_spectator_fnc_players) find _unit > -1) then {
    setPlayerRespawnTime 0;
    forceRespawn _unit;
    hideObjectGlobal _unit; // hide him but sit him in chair anyway
};

moveout _unit;

playMusic "outroSong";
"introBlackLoading" cutText ["", "BLACK OUT", 10];
sleep 10;

private _center = getPos chaircircle_position;
private _distance = _count/7;

[_chair, _unit] call acex_sitting_fnc_sit;



private _startPos = getMarkerPos "mrk_outroSequence_start";
private _endPos = getMarkerPos "mrk_outroSequence_end";
private _targetPosStart = getMarkerPos "mrk_outroSequence_target_start";
private _targetPosEnd = getMarkerPos "mrk_outroSequence_target_end";

private _camStartPos = _startPos getPos [100, ((_startPos getDir _endPos) - 180)];
_camStartPos set [2, 30];

private _camEndPos = _endPos getPos [200, ((_startPos getDir _endPos) - 180)];
_camEndPos set [2, 150];



private _camera = "camera" camCreate (ASLToAGL eyePos player);
_camera cameraEffect ["internal","back"];
_camera camSetPos (_camStartPos);
_camera camSetTarget _targetPosStart;
_camera camCommand "inertia on";
_camera camSetFov 0.40;
_camera camCommit 0;

private _filmgrain = ppEffectCreate ["FilmGrain",2000];
_filmgrain ppEffectEnable true;
_filmgrain ppEffectAdjust [0.3,0.3,0.12,0.12,0.12,true];  
_filmgrain ppEffectCommit 0;

0 fadeSound 0;
sleep 3;

0 fadeMusic 1;
playMusic "outroSong";

"introBlackLoading" cutText ["", "BLACK IN", 15];

sleep 3;

titleText ["<t color='#ffffff' shadow='0' size='1.5'>Einige Stunden später...</t>", "PLAIN", 5, true, true];
titleFadeOut 5;

_camera camSetFov 0.45;
_camera camSetTarget _targetPosEnd;
_camera camSetPos (_camEndPos);
_camera camCommit 46.5;
sleep 44;

/*
cutText ["", "BLACK OUT", 1];
sleep 1;
_filmgrain ppEffectEnable false;   
ppEffectDestroy _filmgrain; 
_camera cameraEffect ["terminate","back"];
camDestroy _camera;
sleep 1;
cutText ["", "BLACK IN", 1];

sleep 3;

playMusic "";
*/

_camera camSetFov 0.75;
_camera camSetPos (position outroEndSequence_1);
_camera camSetTarget _center;
_camera camCommit 0;

sleep 3;

_camera camSetFov 0.4;
_camera camSetPos (position outroEndSequence_2);
_camera camCommit 20;

0 = ["WetDistortion", 300, [
    0.1,
    0.1, 0.1,
    4.10, 3.70, 2.50, 1.85,
    0.0054, 0.0041, 0.0090, 0.0070,
    0.5, 0.3, 10.0, 6.0]] spawn
{
    sleep 11;
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

sleep 22;

cutText ["", "BLACK OUT", 5];
sleep 5;

[
    _center,
    30,
    _distance,
    360,
    1,
    0,
    0.1,
    true,
    _chairs
] call missionControl_fnc_rotatingCam;