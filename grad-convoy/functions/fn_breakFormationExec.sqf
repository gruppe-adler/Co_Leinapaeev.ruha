params ["_convoyID"];

private _identifier = format ["GRAD_convoy_vehicleList_%1", _convoyID];
private _vehicles = missionNamespace getVariable [_identifier, []];

diag_log format ["breaking convoy %1 for vehicles %2", _convoyID, _vehicles];

{
    _thisVeh setVariable ["GRAD_convoy_formationBroken", true, true];
} forEach _vehicles;