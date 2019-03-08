params ["_timeline"];

systemChat str _timeline;

waitUntil {
    !isNil "FUCKINGHELL"
};

[_timeline] call BIS_fnc_timeline_play;

diag_log format ["typeof %1", _timeline];

private _cameraHelper = cameraHelper1;

private _camera = "camera" camCreate (position _cameraHelper);
// _camera camSetPos (position _cameraHelper);
_camera camCommand "inertia on";
_camera cameraEffect ["internal","back"];
_camera camSetFov 0.5;
_camera attachTo [_cameraHelper,[0,0,0]];
_camera camCommit 0;


systemChat "starting cam";


// 

/*
[{
    params ["_args", "_handle"];
    _args params ["_camera", "_cameraHelper"];

    // _camera setDir (getDir _cameraHelper);

    
}, 0, [_camera, _cameraHelper]] call CBA_fnc_addPerFramehandler;
*/