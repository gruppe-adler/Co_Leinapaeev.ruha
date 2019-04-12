/*
 * Script by Michal Hudák (M1keSK)
 * modified by McDiod + nomisum
 */


params [["_unit",objNull]];

if (!hasInterface) exitWith {};

_unit setVariable ['GRAD_LP_peeing', true];
_unit playMoveNow "Acts_AidlPercMstpSlowWrflDnon_pissing";

sleep 4;

[_unit] remoteExec ["MissionControl_fnc_peeFX", [0,-2] select isDedicated];