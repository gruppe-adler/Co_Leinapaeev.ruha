params ["_position"];


private _spawnPos = [8190.88,8197.78,150];
private _originPos = [worldSize - 300, worldSize, 100];

private _mi8 = createVehicle ["RHS_Mi8AMT_vdv", _spawnPos, [], 150, "FLY"];
_mi8 setPos _spawnPos;
createVehicleCrew _mi8;
_mi8 setDir (_mi8 getDir _position);

private _cargo = [_mi8] call GRAD_convoy_fnc_addSquadToCargo;

[_mi8] remoteexec ["MissionControl_fnc_addKilledEH", 2];

_mi8 setCombatMode "RED";
_mi8 disableAI "AUTOCOMBAT";
_mi8 disableAI "Autotarget";
_mi8 allowFleeing 0;
_mi8 setskill ["courage",1];
_mi8 flyInHeight 150;
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
            private _mi8 = _this select 0;
            private _unit = _this select 1;
            moveOut _unit;
            [_unit] orderGetIn false;
            unassignVehicle (_unit);

            [{
                private _unit = _this select 0;
                private _position = position _unit;
                _position set [2, position _unit select 2 - 2];
                private _chute = createVehicle ['rhs_d6_Parachute', position _unit,[],0,'Fly'];
                _chute setPos position _unit;
                _unit moveIndriver _chute;
            }, [_unit], (random 3) + 2] call CBA_fnc_waitAndExecute;
            
        }, [_mi8, _unit], (random 4)] call CBA_fnc_waitAndExecute;
    } forEach _cargo;
"];

/*
[{
                private _unit = _this select 0;
                private _chute = createVehicle ['rhs_d6_Parachute', position _unit,[],0,'Fly'];
                _chute setPos position _unit;
                _unit moveIndriver _chute;
            }, [_unit], (random 3) + 2] call CBA_fnc_waitAndExecute;
*/

// next waypoint
private _wp2 = (group _mi8) addWaypoint [_position getPos [3000, (_mi8 getDir _position)], 0];
_wp2 setWaypointType "MOVE";

[{
        params ["_mi8"];
        (count (fullCrew [ _mi8, "cargo" ] apply { _x select 0 })) < 1
    },{
            params ["_mi8", "_originPos"];
            [_mi8] doFollow _mi8;
            private _wp = (group _mi8) addWaypoint [_originPos, 0];
            _mi8 flyInHeight 150;
            _wp setWaypointStatements ["true", "
                { deleteVehicle _x } foreach  thislist + [vehicle this]
            "];

    }, [_mi8, _originPos]] call CBA_fnc_waitUntilAndExecute;