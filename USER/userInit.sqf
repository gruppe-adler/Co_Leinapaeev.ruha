/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/

// draw death positions for curator
{
	[_x] call BIS_fnc_drawCuratorDeaths;
} forEach (playableUnits + switchableUnits); 

{
 [_x, [west]] call BIS_fnc_drawCuratorRespawnMarkers;
} forEach allCurators;

// [ curatorModule, ["targetIcon.paa", [1,1,1,1], position player, 1, 1, 45, "Target", 1, 0.05, "TahomaB"], false ] call BIS_fnc_addCuratorIcon;