params ["_unit", "_chair", "_chairs", "_count"];

if (!canSuspend) exitWith {
    [_unit, _chair, _chairs, _count] spawn missionControl_fnc_decideOutro;
};

private _isSpectator = _unit in ([] call ace_spectator_fnc_players);

if (_isSpectator) then {
    setPlayerRespawnTime 0;
    forceRespawn _unit;

    diag_log "force respawn";
};

[{  
    params ["_unit"];
    !(_unit in ([] call ace_spectator_fnc_players))
}, {
    params ["_unit", "_chair", "_chairs", "_count", "_isSpectator"];

    if (_isSpectator) then {
        [false] call ace_spectator_fnc_setSpectator;
        [_unit, false] call TFAR_fnc_forceSpectator;

        diag_log "force exit spectator"; // should never trigger apparently
    };

    [_unit, _chair, _chairs, _count, _isSpectator] spawn missionControl_fnc_outroSequence;

}, [_unit, _chair, _chairs, _count, _isSpectator]] call CBA_fnc_waitUntilAndExecute;

