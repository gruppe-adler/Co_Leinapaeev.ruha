/*
	
	

*/

params ["_id", "_side"];

private _convoyID = missionNamespace getVariable ["GRAD_convoy_convoyCount", 0];
missionNamespace setVariable ["GRAD_convoy_convoyCount", (_convoyID + 1)];

private _vehicleDefinitions = [_id] call GRAD_convoy_fnc_getVehicleDefinitions;
if (count _vehicleDefinitions < 1) exitWith {
	systemChat "no convoy of this ID found";
};


private _convoy = [];

{   
    _x params ["_classname", "_position", "_dir"];

    private _veh = ([_position,_dir,_classname,_side] call BIS_fnc_spawnVehicle) select 0;

    _convoy pushBack _veh;
  
} forEach _vehicleDefinitions;

_convoy