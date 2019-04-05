/*
 * Script by Michal Hudák (M1keSK)
 * modified for grad_electricFence by McDiod
 */


params [["_unit",objNull]];

if (!hasInterface) exitWith {};

_unit setVariable ['GRAD_LP_peeing', true];
_unit playMoveNow "Acts_AidlPercMstpSlowWrflDnon_pissing";

sleep 4;

[_unit,"USER\client\peeFX.sqf"] remoteExec ["BIS_fnc_execVM", [0,-2] select isDedicated];