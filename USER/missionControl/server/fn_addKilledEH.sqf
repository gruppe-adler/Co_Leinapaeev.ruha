params ["_vehicle"];

if (!isServer) exitWith {};

if (_vehicle getVariable ["GRAD_LP_killedEH", false]) exitWith {};

_vehicle addMPEventhandler ["MPKilled", {
    
        params ["_unit", "_killer", "_instigator", "_useEffects"];

        _unit setVariable ["GRAD_LP_killedEH", true];

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

            if (isServer) then { diag_log ((str _newCount) + " killed " + (str _selector)); };

            ["missionControl_curatorInfo", [typeOf _unit, "killed"]] call CBA_fnc_serverEvent;
        };
}];

