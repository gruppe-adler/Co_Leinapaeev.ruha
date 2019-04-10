params ["_vehicle", "_pos", "_vectorup"];

private _flag = "rhs_Flag_chdkz" createVehicle [0,0,0];
if (side _vehicle == east) then {
    _flag setFlagTexture "\rhsafrf\addons\rhs_main\data\Flag_rus_CO.paa";
} else {
    _flag setFlagTexture "ca\Ca_E\data\flag_ger_co.paa";
};

_flag attachto [_vehicle,_pos];
_flag setVectorUp _vectorup;

_vehicle setVariable ["GRAD_showFlag", true, true];
_vehicle setVariable ["GRAD_flagObject",_flag, true];