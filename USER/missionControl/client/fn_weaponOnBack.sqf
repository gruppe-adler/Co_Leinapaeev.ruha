params ["_unit"];

if (!local _unit) exitWith {};
    
_unit action ["SWITCHWEAPON",_unit,_unit,-1];