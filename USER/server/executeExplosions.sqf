

private _targetPos = getMarkerPos "mrk_natobase_hidden";
private _spawnPos = [worldSize, worldSize, 500];
private _plane = createVehicle ["RHS_TU95MS_vvs_irkutsk", _spawnPos, [], 100, "FLY"];
createVehicleCrew _plane;
_plane setPos [getPos _plane select 0, getPos _plane select 1, 500];
_plane setDir (_plane getDir _targetPos);
_plane setVelocityModelSpace [0, 500, 0];

_plane setCombatMode "RED";
_plane disableAI "AUTOCOMBAT";
_plane disableAI "Autotarget";
_plane allowFleeing 0;
_plane setskill ["courage",1];
_plane flyInHeight 500;
_plane setSpeedMode "FULL";

_plane setVariable ['GRAD_WP_targetPos', _position];
_plane setVariable ['GRAD_WP_originPos', _originPos];

private _wp = (group _plane) addWaypoint [_targetPos, 0];
_wp setWaypointCompletionRadius 300;
_wp setWaypointType "MOVE";
_wp setWaypointStatements ["true", "
    
"];



[{
    params ["_plane", "_targetPos"];    
    _plane distance2d _targetPos < 300
},
{
    [] spawn {
        private _explosions = missionNamespace getVariable ["GRAD_LP_explosionSpawns", []];
        {
          
            private _position = _x select 0;
            private _timeout = _x select 1;

            [_position, _timeout] execVM "USER\server\spawnExplosion.sqf";

            sleep (random 3);

        } forEach _explosions;
    };
}, [_plane, _targetPos]] call CBA_fnc_waitUntilAndExecute;