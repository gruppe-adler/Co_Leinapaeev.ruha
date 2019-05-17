params ["_unit"];

if (!local _unit) exitWith {};
    
_unit action ["sitDown", _unit];