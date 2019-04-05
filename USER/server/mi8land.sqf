params ["_mi8"];

private _position = _mi8 getVariable ["GRAD_WP_targetPos", [0,0,0]];
private _originPos = _mi8 getVariable ["GRAD_WP_originPos", [0,0,0]];
_position set [2,2];
private _helipad = "Land_HelipadEmpty_F" createVehicle _position;
_mi8 land "GET OUT";
_mi8 flyInHeight 4;

[{
    params ["_mi8"];
    getPos _mi8 select 2 < 1
},{
    params ["_mi8", "_originPos"];
    doStop _mi8;
    private _cargo = _mi8 getVariable ['GRAD_WP_cargo', []];
    {
        [{
            params ["_mi8", "_unit"];
            _unit action ["EJECT", _mi8];
            unassignVehicle (_unit);
            _x setFormation "DIAMOND";
        }, [_mi8, _x], random 7] call CBA_fnc_waitAndExecute;
    } forEach _cargo;

    [{
        params ["_mi8"];
        (count (fullCrew [ _mi8, "cargo" ] apply { _x select 0 })) < 1
    },{
            params ["_mi8", "_originPos", "_helipad"];
            [_mi8] doFollow _mi8;
            private _wp = (group _mi8) addWaypoint [_originPos, 0];
            _mi8 forceSpeed 100;
            _mi8 flyInHeight 20;
            deleteVehicle _helipad;
            _wp setWaypointStatements ["true", "
                { deleteVehicle _x } foreach  thislist + [vehicle this]
            "];

    }, [_mi8, _originPos, _helipad]] call CBA_fnc_waitUntilAndExecute;

}, [_mi8, _originPos, _helipad]] call CBA_fnc_waitUntilAndExecute;

