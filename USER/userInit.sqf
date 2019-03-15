/*
*   Wird zum Missionsstart auf Server und Clients ausgeführt.
*   Funktioniert wie die init.sqf.
*/


if (!isServer) exitWith {};

["GRAD_loadout_loadoutApplied", {
    params ["_loadoutTarget", "_unitLoadout"];

    if (typeOf _loadoutTarget == "I_medic_F" && _loadoutTarget getVariable ["GRAD_loadout_applicationCount", 0] == 0) exitWith {
        removeAllAssignedItems _loadoutTarget;
        removeAllContainers _loadoutTarget;
        removeHeadgear _loadoutTarget;
        removeWeaponGlobal _loadoutTarget;
    };
    
    {
        [_x,"Kaitseliit"] call BIS_fnc_setUnitInsignia;
    } forEach (playableUnits + switchableUnits); 
}] call CBA_fnc_addEventHandler;



// draw death positions for curator
{
	[_x] call BIS_fnc_drawCuratorDeaths;
} forEach (playableUnits + switchableUnits); 

{
 [_x, [west]] call BIS_fnc_drawCuratorRespawnMarkers;
} forEach allCurators;

// [ curatorModule, ["targetIcon.paa", [1,1,1,1], position player, 1, 1, 45, "Target", 1, 0.05, "TahomaB"], false ] call BIS_fnc_addCuratorIcon;