params ["_convoyID"];

private _definitions = [(missionConfigFile >> "CfgGRADConvoy" >> "convoyDefinitions"), "Array", []] call CBA_fnc_getConfigEntry;
if ((count _definitions - 1) < _convoyID) exitWith {
	[]
};

_definitions select _convoyID