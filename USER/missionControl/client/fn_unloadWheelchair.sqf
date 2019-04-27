params ["_wheelchair"];

private _vehicle = attachedTo _wheelchair;

if (isNull _vehicle) exitWith { hint "not loaded onto anything"; };

(boundingBoxReal _vehicle) params ["_arg1","_arg2"];
private _width = abs ((_arg2 select 0) - (_arg1 select 0));
private _length = abs ((_arg2 select 1) - (_arg1 select 1));

private _positionBehindVehicle = _vehicle modelToWorld [0,-(_length/2 + 1),0];

detach _wheelchair; 
_wheelchair setPos _positionBehindVehicle;

_vehicle setVariable ["wheelChairLoaded", false, true];
_wheelchair setVariable ["wheelChairLoaded", false, true];