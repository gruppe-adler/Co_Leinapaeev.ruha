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
sleep 0.1;

if (_isSpectator) then {
    [false] call ace_spectator_fnc_setSpectator; // launch spec
    [_unit, false] call TFAR_fnc_forceSpectator;

    diag_log "exit spectator";
};

// new player?!
if (isPlayer _unit) then {
    [player, _chair, _chairs, _count, _isSpectator] spawn missionControl_fnc_outroSequence;
} else {
    [_unit, _chair, _chairs, _count, _isSpectator] spawn missionControl_fnc_outroSequence;
};