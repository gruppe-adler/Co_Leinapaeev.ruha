params ["_wheelchair", "_vehicle"];



private _offsets = [
	["gm_demo_nato_mb_u1300l_cargo", [0,-2,0.8]],
	["classname", [0,2,1.5]],
	["classname", [0,2,1.5]]
];

{
  	_x params ["_type", "_offset"];

  	if (typeOf _vehicle == _type) then {
		_wheelchair attachTo [_vehicle, _offset];
  	} else {
  		hint "cant load wheelchair onto vehicle";
  	};

} forEach _offsets;
