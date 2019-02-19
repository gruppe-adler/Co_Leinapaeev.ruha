params ["_distFront"];

private _speed = 0;

if (_distFront > DISTANCE_MIN) then {
    if (_distFront < DISTANCE_MAX) then {
    		_speed = SPEED_STEADY;
    	} else {
    		_speed = SPEED_GET_CLOSER;
    	}
} else {
	_speed = SPEED_INCREASE_DISTANCE;
};

_speed