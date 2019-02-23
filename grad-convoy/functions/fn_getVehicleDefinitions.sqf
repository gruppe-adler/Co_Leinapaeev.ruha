params ["_convoyID"];

private _definitions = call compile preprocessFileLineNumbers "USER\userConvoys.sqf";
if ((count _definitions - 1) < _convoyID) exitWith {
	[]
};

(_definitions select _convoyID)