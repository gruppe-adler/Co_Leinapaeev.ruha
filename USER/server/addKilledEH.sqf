params ["_vehicle"];

_vehicle addEventhandler ["Killed", {
    
        params ["_unit", "_killer", "_instigator", "_useEffects"];

        private _selector = ["", "GRAD_LP_enemyKilledMan"] select ( _unit isKindOf "Man" );
        _selector = [_selector, "GRAD_LP_enemyKilledCar"] select ( _unit isKindOf "Car_F" );
        _selector = [_selector, "GRAD_LP_enemyKilledTank"] select ( _unit isKindOf "Tank" );
        _selector = [_selector, "GRAD_LP_enemyKilledAPC"] select ( _unit isKindOf "Wheeled_Apc_F" );
        _selector = [_selector, "GRAD_LP_enemyKilledHeli"] select ( _unit isKindOf "Helicopter" );
        _selector = [_selector, "GRAD_LP_enemyKilledPlane"] select ( _unit isKindOf "Plane" );

        private _currentCount = missionNamespace getVariable [_selector, 0];

        if (_selector != "") then {
            private _newCount = _currentCount + 1;
            missionNamespace setVariable [_selector, _newCount];

            systemChat ((str _newCount) + " killed " + (str _selector));
        };
}];