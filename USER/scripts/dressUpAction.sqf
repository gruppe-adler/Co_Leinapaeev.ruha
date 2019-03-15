params ["_waescheleine"];

_waescheleine addAction [
    "<t color='#FF0000'>Anziehen und Ausrüsten</t>", {
    params ["_target", "_caller", "_actionId", "_arguments"];
    [_caller] call GRAD_loadout_fnc_applyLoadout;
    ["rhs_orsis_bolt"] call bis_fnc_playSound;
    _target removeAction _actionId;
}];