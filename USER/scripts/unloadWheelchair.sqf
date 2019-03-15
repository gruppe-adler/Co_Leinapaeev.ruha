params ["_wheelchair", "_vehicle"];



(boundingBoxReal _vehicle) params ["_arg1","_arg2"];
private _width = abs ((_arg2 select 0) - (_arg1 select 0));
private _length = abs ((_arg2 select 1) - (_arg1 select 1));

private _positionBehindVehicle = _vehicle modelToWorld [0,-(_length/2 + 1),0];

detach _wheelchair; 
_wheelchair setPos _positionBehindVehicle;