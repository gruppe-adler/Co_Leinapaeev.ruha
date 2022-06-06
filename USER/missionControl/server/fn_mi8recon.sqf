params ["_positionArray"];


private _spawnPos = (_positionArray select 0);
private _originPos = [worldSize - 300, worldSize, 100];

private _mi8 = createVehicle ["RHS_Mi8AMT_vdv", _spawnPos, [], 50, "FLY"];
createVehicleCrew _mi8;
_mi8 setDir (_mi8 getDir (_positionArray select 0));

_mi8 setCombatMode "RED";
_mi8 disableAI "AUTOCOMBAT";
_mi8 disableAI "Autotarget";
_mi8 allowFleeing 0;
_mi8 setskill ["courage",1];
_mi8 flyInHeight 20;
_mi8 limitSpeed 50;

{
    private _wp = (group _mi8) addWaypoint [_x,0];
    _wp setWaypointCompletionRadius 100;
    _wp setWaypointType "MOVE";
} forEach  _positionArray;

[_mi8] remoteexec ["MissionControl_fnc_addKilledEH", 2];