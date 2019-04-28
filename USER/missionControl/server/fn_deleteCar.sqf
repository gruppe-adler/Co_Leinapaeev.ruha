params ["_vehicle"];

{
  detach _x;
  deleteVehicle _x;
} forEach attachedObjects _vehicle;


CIVILIAN_CARS deleteAt (CIVILIAN_CARS find _vehicle); 
{ deleteVehicle _vehicle } forEach ((crew _vehicle)+ [_vehicle]);