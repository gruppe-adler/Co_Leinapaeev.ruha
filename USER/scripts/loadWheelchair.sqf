params ["_wheelchair", "_vehicle"];



private _offsets = [
	["classname", [0,2,1.5]],
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
