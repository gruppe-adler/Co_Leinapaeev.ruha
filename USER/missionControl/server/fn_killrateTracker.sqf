[{

    params ["_args", "_handle"];
    
    private _playerCount = count (playableUnits + switchableUnits);
    private _losses = missionNamespace getVariable ["GRAD_LP_currentLosses", 0];

    if (_losses > (_playerCount/100*40)) exitWith {

        ["40% Ausfälle. Sofort zurückziehen!"] remoteExec ["hint", [0,-2] select isDedicated];
        [_handle] call CBA_fnc_removePerFramehandler;
    };

}, 1, []] call CBA_fnc_addPerFramehandler;