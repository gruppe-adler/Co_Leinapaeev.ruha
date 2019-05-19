// DEATH CAM
        
private _currentLoss = missionNamespace getVariable ["GRAD_LP_currentLosses", 0];
_currentLoss = _currentLoss + 1;
missionNamespace setVariable ["GRAD_LP_currentLosses", _currentLoss, true];

GRAD_DEATHCAM_RUNNING = true;
[] spawn GRAD_deathcam_fnc_start;
[false] call ace_spectator_fnc_setSpectator;
waitUntil {!GRAD_DEATHCAM_RUNNING};
[] call grad_permaChoice_fnc_setPlayerSpectator;