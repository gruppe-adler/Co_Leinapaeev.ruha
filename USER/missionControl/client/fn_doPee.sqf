/*
 * Script by Michal Hudák (M1keSK)
 * modified by McDiod + nomisum
 */

// executed on all clients

params [["_unit",objNull]];

if (!hasInterface) exitWith {};

if (!canSuspend) exitWith {
    [_unit] spawn MissionControl_fnc_doPee;
};

_unit setVariable ['GRAD_LP_peeing', true];
_unit switchMove "Acts_AidlPercMstpSlowWrflDnon_pissing";


sleep 4;

[_unit] call MissionControl_fnc_peeFX;