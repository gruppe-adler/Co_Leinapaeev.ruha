params ["_car"];

private _smoke = "test_EmptyObjectForSmoke" createVehicle [0,0,0];

_smoke attachTo [_car, [0,1,-0.5]];