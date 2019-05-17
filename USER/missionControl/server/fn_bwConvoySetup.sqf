if (!isServer) exitWith {};
    
private _vehicles = [bwVehicle1,bwVehicle2,bwVehicle3,bwVehicle4,bwVehicle5,bwVehicle6];

{
    _x animate ['blaulicht_an',1];
    _x animate ['blaulicht_an_flare',1];
    _x animate ['BeaconsStart',1];
    _x action ['lightOn', _x];

} forEach [bwVehicle1, bwVehicle5, bwVehicle6];

{
    [_x,3] call Redd_fnc_wolf_flags;

    [_x, true] call BC_flagsOnVehicles_fnc_toggleFlag;
} forEach [bwVehicle1, bwVehicle6];