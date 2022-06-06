/*

  notification for curator if player switches to DIE & SPECTATE

*/

params ["_unit"];


// add name to list to retreive later on
private _allSpectators = missionNameSpace getVariable ["GRAD_permaChoice_spectatorList", []];
_allSpectators pushback [name _unit];
missionNameSpace setVariable ["GRAD_permaChoice_spectatorList", _allSpectators];

["missionControl_curatorInfo", [_unit, "spectating"]] call CBA_fnc_serverEvent;
