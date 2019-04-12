params ["_waescheleine"];

_waescheleine addAction [
    "<t color='#FF0000'>Anziehen und Ausrüsten</t>", {
    params ["_target", "_caller", "_actionId", "_arguments"];
    [_caller] call GRAD_loadout_fnc_applyLoadout;
    ["rhs_orsis_bolt"] call bis_fnc_playSound;
    _target removeAction _actionId;
    },
    [],
    1.5, 
    true, 
    true, 
    "",
    "(_this select 1) getVariable ['GRAD_LP_nakedGuy', false]",
    2,
    false,
    "",
    ""
];