params ["_wheelchair"];

if (!isServer) exitWith {};

_wheelchair addEventHandler ["GetOut", {
    private _vehicle = param [0, objNull, [objNull]];
    (_vehicle call BIS_fnc_getPitchBank) params ["_vx","_vy"];
    if (([_vx,_vy] findIf {_x > 80 || _x < -80}) != -1) then {  
        0 = [_vehicle] spawn {
            private _vehicle = param [0, objNull, [objNull]];
            // waitUntil {(_vehicle nearEntities ["Man", 10]) isEqualTo [] || !alive _vehicle};
            if (!alive _vehicle) exitWith {};
            _vehicle allowDamage false;
            _vehicle setVectorUp [0,0,1];
            _vehicle setPosATL [(getPosATL _vehicle) select 0, (getPosATL _vehicle) select 1, 0];
            _vehicle allowDamage true;
        };
    };
}];