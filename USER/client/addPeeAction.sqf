params ["_unit"];

_unit addAction [
    "<t color='#FF00FF'>Pee</t>", {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_caller] execVM "USER\client\doPee.sqf";
    },
    [],
    1.5, 
    true, 
    true, 
    "",
    "_this == _target && _this getVariable ['GRAD_LP_peeing', false]",
    2,
    false,
    "",
    ""
];