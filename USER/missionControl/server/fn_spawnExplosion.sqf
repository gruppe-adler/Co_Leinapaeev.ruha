params ["_position", ["_timeout", 600]];

_position set [2,0];

private _bomb = "Bo_GBU12_lgb" createVehicle _position;
_bomb setVelocity [0,0,-100];


[_position, _timeout] remoteExec ["MissionControl_fnc_spawnSmoke", [0,-2] select isDedicated];