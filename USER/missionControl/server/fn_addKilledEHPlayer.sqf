params ["_unit"];

/*

// MOVED TO ONPLAYERKILLED

_unit addMPEventHandler ["MPKilled", {
    params ["_unit", "_killer", "_instigator", "_useEffects"];
        
        if (!isServer) exitWith {};
        // dont count twice in SP
        if (_unit getVariable ["GRAD_LP_firstDeath", false]) exitWith {};
            
        _unit setVariable ["GRAD_LP_firstDeath", true, true];
        private _currentLoss = missionNamespace getVariable ["GRAD_LP_currentLosses", 0];
        _currentLoss = _currentLoss + 1;
        missionNamespace setVariable ["GRAD_LP_currentLosses", _currentLoss, true];
}];
*/