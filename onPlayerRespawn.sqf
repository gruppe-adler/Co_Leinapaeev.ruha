["Terminate"] call BIS_fnc_EGSpectator;
[false] call ace_spectator_fnc_setSpectator; // launch spec
[player, false] call TFAR_fnc_forceSpectator; // force tfar spec

if (([missionConfigFile >> "missionSettings","waveRespawnEnabled",0] call BIS_fnc_returnConfigEntry) == 1) then {
    [] call grad_waverespawn_fnc_onPlayerRespawn;
};
