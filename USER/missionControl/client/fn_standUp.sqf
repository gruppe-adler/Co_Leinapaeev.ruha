params ["_unit"];

if (!local _unit) exitWith {};
[{
	params ["_args", "_handle"];
    _args params ["_unit"];

    if (!alive _unit) exitWith {
        [_handle] call CBA_fnc_removePerFramehandler;
    };

    
    if (stance _unit != "PRONE" && speed _unit > 2) then {
         // [player, objNull, 5] call ACE_hitreactions_fnc_fallDown;
         player setHitPointDamage ["HitLegs", 0.6];
    };
    
}, 2, [_unit]] call CBA_fnc_addPerFramehandler;