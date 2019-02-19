params ["_convoyID", "_thisVeh"];

private _identifier = format ["GRAD_convoy_vehicleList_%1", _convoyID];
private _convoy = missionNamespace getVariable [_identifier, []];

private _index = _convoy find _thisVeh;

private _vehicleInFront = _thisVeh getVariable ["GRAD_convoy_vehicleInFront", objNull];
private _vehicleBehind = _thisVeh getVariable ["GRAD_convoy_vehicleBehind", objNull];


if (!isNull _vehicleInFront && {_convoy > (_index - 1)}) then {
	// set new vehicleBehind for vehicle in front, if available
	_vehicleInFront setVariable ["GRAD_convoy_vehicleBehind", (_convoy select (_index + 1))];
};

if (!isNull _vehicleBehind && {_index > 0}) then {
	_vehicleBehind setVariable ["GRAD_convoy_vehicleInFront", (_convoy select (_index - 1))];
};


_convoy deleteAt [_index];

missionNamespace setVariable [_identifier, _convoy];