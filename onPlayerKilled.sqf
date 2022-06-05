// DEATH CAM
        
GRAD_DEATHCAM_RUNNING = true;
[] spawn GRAD_deathcam_fnc_start;
[false] call ace_spectator_fnc_setSpectator;
waitUntil {!GRAD_DEATHCAM_RUNNING};
[] call grad_permaChoice_fnc_setPlayerSpectator;