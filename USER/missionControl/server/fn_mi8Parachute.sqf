params ["_position"];


private _spawnPos = [8190.88,8197.78,0];
private _originPos = [worldSize - 300, worldSize, 100];

private _mi8 = createVehicle ["RHS_Mi8AMT_vdv", _spawnPos, [], 50, "FLY"];
createVehicleCrew _mi8;
_mi8 setDir (_mi8 getDir _position);

private _cargo = [_mi8] call GRAD_convoy_fnc_addSquadToCargo;

_mi8 setCombatMode "RED";
_mi8 disableAI "AUTOCOMBAT";
_mi8 disableAI "Autotarget";
_mi8 allowFleeing 0;
_mi8 setskill ["courage",1];
_mi8 flyInHeight 20;
_mi8 setSpeedMode "FULL";

_mi8 setVariable ['GRAD_WP_targetPos', _position];
_mi8 setVariable ['GRAD_WP_originPos', _originPos];
_mi8 setVariable ['GRAD_WP_cargo', _cargo];

private _wp = (group _mi8) addWaypoint [_position, 0];
_wp setWaypointCompletionRadius 200;
_wp setWaypointType "MOVE";
_wp setWaypointStatements ["true", "
    private _mi8 = vehicle this;
    private _cargo = _mi8 getVariable ['GRAD_WP_cargo', []];
    {
        private _unit = _x;
        [{
            params ['_mi8', '_unit'];
            _unit action ['EJECT', _mi8];
            unassignVehicle (_unit);

            [{
                params ['_unit'];
                private _chute = createVehicle ['rhs_d6_Parachute', position _unit,[],0,'Fly'];
                _chute setPos position _unit;
                _unit moveIndriver _chute;
            }, [_unit], (random 1) + 1] call CBA_fnc_waitAndExecute;
        }, [_mi8, _unit], (random 4)] call CBA_fnc_waitAndExecute;
    } forEach _cargo;
"];