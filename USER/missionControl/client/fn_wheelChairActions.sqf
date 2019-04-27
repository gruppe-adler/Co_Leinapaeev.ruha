params ["_vehicle"];

_vehicle addAction [
    "<t color='#FF0000'>Rollstuhl aufladen</t>", {
    params ["_target", "_caller", "_actionId", "_arguments"];
        [vehicle _caller, _target] call missionControl_fnc_loadWheelchair;
    },
    [],
    1.5, 
    true, 
    true, 
    "",
    "!(_target getVariable ['wheelChairLoaded', false]) && !((vehicle _this) getVariable ['wheelChairLoaded', false])",
    4,
    false,
    "",
    ""
];

_vehicle addAction [
    "<t color='#FF0000'>Rollstuhl abladen</t>", {
    params ["_target", "_caller", "_actionId", "_arguments"];
        [vehicle _caller] call missionControl_fnc_unloadWheelchair;
    },
    [],
    1.5, 
    true, 
    true, 
    "",
    "(_target getVariable ['wheelChairLoaded', false]) && ((vehicle _this) getVariable ['wheelChairLoaded', false])",
    4,
    false,
    "",
    ""
];