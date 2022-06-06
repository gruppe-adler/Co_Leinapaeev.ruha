/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/

// disable channels
0 enableChannel false;
1 enableChannel false;

// needs to be local!
["GRAD_loadout_loadoutApplied", {
params ["_loadoutTarget", "_unitLoadout"];

if (local _loadoutTarget) then {

    if (rank _loadoutTarget != "LIEUTENANT" && typeOf _loadoutTarget == "I_medic_F" && _loadoutTarget getVariable ["GRAD_loadout_applicationCount", 0] == 0) exitWith {
        removeAllAssignedItems _loadoutTarget;
        removeAllContainers _loadoutTarget;
        removeHeadgear _loadoutTarget;
        removeAllWeapons _loadoutTarget;
        removeGoggles _loadoutTarget;
    };

    private _markerstr = createMarkerLocal ["mrk_lp_spawn", position _loadoutTarget];
    _markerstr setMarkerShapeLocal "ICON";
    _markerstr setMarkerTypeLocal "hd_start";
    _markerstr setMarkerColorLocal "ColorIndependent";
    _markerstr setMArkerTextLocal "Startpunkt";
};

[player,"Kaitseliit"] call BIS_fnc_setUnitInsignia;

}] call CBA_fnc_addEventHandler;



if (!isServer) exitWith {


	// draw death positions for curator
	{
		[_x] call BIS_fnc_drawCuratorDeaths;
	} forEach (playableUnits + switchableUnits); 

	{
	 [_x, [west]] call BIS_fnc_drawCuratorRespawnMarkers;
	} forEach allCurators; 

};







// [ curatorModule, ["targetIcon.paa", [1,1,1,1], position player, 1, 1, 45, "Target", 1, 0.05, "TahomaB"], false ] call BIS_fnc_addCuratorIcon;