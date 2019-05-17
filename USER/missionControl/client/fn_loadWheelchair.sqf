params ["_wheelchair", "_vehicle"];



private _offsets = [
	["gm_demo_nato_mb_u1300l_cargo", [0,-2,0.8]]
];

{
  	_x params ["_type", "_offset"];

  	if (typeOf _vehicle == _type) then {
		_wheelchair attachTo [_vehicle, _offset];
  	} else {
  		// hint "cant load wheelchair onto vehicle";
  	};

} forEach _offsets;

_vehicle setVariable ["wheelChairLoaded", true, true];
_wheelchair setVariable ["wheelChairLoaded", true, true];