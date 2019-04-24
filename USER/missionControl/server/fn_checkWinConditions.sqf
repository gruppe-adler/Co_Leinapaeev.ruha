if (!isServer) exitWith {};

LP_SHOWSTATS = false;

[{

    params ["_args", "_handle"];
    _args params [""];   

    if (LP_SHOWSTATS) exitWith {
        [] remoteExec ["MissionControl_fnc_showStats", 0, true];
        [_handle] call CBA_fnc_removePerFrameHandler;
    };
    
}, 1, []] call CBA_fnc_addPerFramehandler;