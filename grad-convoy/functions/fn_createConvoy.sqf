/*
	


*/

params ["_id", "_side"];

private _convoyID = missionNamespace getVariable ["GRAD_convoy_convoyCount", 0];
missionNamespace setVariable ["GRAD_convoy_convoyCount", (_convoyID + 1)];

private _vehicleDefinitions = [_id] call GRAD_convoy_fnc_getVehicleDefinitions;

_vehicleDefinitions params ["_waypoints", "_vehicles"];

if (count _vehicleDefinitions < 1) exitWith {
	systemChat "no convoy of this ID found";
};


private _convoy = [];
private _group = createGroup _side;

{   
    _x params ["_classname", "_position", "_dir"];

    private _position = call compile _position;
    private _dir = call compile _dir;

    private _vehParams = ([_position,_dir,_classname,_group] call BIS_fnc_spawnVehicle);
    _vehParams params ["_veh", "_crew", "_group"];

    _convoy pushBack _veh;

} forEach _vehicles;

// cache vehicle in front and in back for easier access
{
    if (_forEachIndex > 0) then {
      _x setVariable ["GRAD_convoy_vehicleInFront", _convoy select (_forEachIndex - 1)];
    };

    if (_forEachIndex < ((count _convoy) - 1)) then {
      _x setVariable ["GRAD_convoy_vehicleBehind", _convoy select (_forEachIndex + 1)];
    };

} forEach _convoy;


_group setFormation "STAG COLUMN";

[_waypoints, _convoy]