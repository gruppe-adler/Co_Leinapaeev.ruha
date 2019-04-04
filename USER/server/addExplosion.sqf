/*

	3DEN
	
	[this, 600] execVM "USER\server\addExplosion.sqf";

*/

if (!isServer) exitWith {};

params ["_object", ["_timeout",600]];

private _position = position _object;
_position set [2,0];

private _explosions = missionNamespace getVariable ["GRAD_LP_explosionSpawns", []];
_explosions pushBack [_position, _timeout];
missionNamespace setVariable ["GRAD_LP_explosionSpawns", _explosions];