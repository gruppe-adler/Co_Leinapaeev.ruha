[{

    params ["_args", "_handle"];
    
    private _playerCount = count (call BIS_fnc_listPlayers);
    private _losses = missionNamespace getVariable ["GRAD_LP_currentLosses", 0];

    if (count _losses > (_playerCount/2)) exitWith {

        ["50% Ausfälle. Sofort zurückziehen!"] remoteExec ["hint", [0,-2] select isDedicated];
        [_handle] call CBA_fnc_removePerFramehandler;
    };

}, 1, []] call CBA_fnc_addPerFramehandler;