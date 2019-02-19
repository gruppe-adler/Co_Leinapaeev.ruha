params ["_convoyID"];

private _convoy = [_convoyID] call GRAD_convoy_fnc_createConvoy;

// store convoy in MNS to be able to remove vehicles out of it later on
private _identifier = format ["GRAD_convoy_vehicleList_%1", _convoyID];
missionNamespace setVariable [_identifier, _convoy];

SPEED_HOLD = 0.5;
SPEED_STEADY = 30;
SPEED_GET_CLOSER = 32;
SPEED_INCREASE_DISTANCE = 28;

DISTANCE_EMERGENCY_BREAK = 5;
DISTANCE_MIN = 15;
DISTANCE_MAX = 20;

DISTANCE_MAX_LEADING = 50;

for [{_i=0},{_i<count _convoy},{_i=_i+1}] do {

	// disable AI as we dont need it
	private _thisVeh = _convoy select _i;
	_thisVeh disableAI "FSM";
	_thisVeh disableAI "PATH";


    [{
        params ["_vehicles","_handle"];
        _vehicles params ["_convoyID", "_thisVeh"];

        // remove vehicle from convoy if necessary
        [_convoyID, _thisVeh, _handle] call GRAD_convoy_fnc_healthCheck;

        private _vehicleListIdentifier = format ["GRAD_convoy_vehicleList_%1", _convoyID];
		private _convoyVehicles = missionNamespace getVariable [_vehicleListIdentifier, _convoy];

		if (count _convoyVehicles < 1) exitWith {
			[_handle] call CBA_fnc_removePerFramehandler;
		};

        private _firstVehicle = _convoyVehicles select 0;
        private _vehicleInFront = _thisVeh getVariable ["GRAD_convoy_vehicleInFront", objNull];
        private _vehicleBehind = _thisVeh getVariable ["GRAD_convoy_vehicleBehind", objNull];

        if (!isNull _vehicleInFront) then {
        	private _distFront = _thisVeh distance _vehicleInFront;
            if (_distFront < DISTANCE_EMERGENCY_BREAK) then {
                _thisVeh limitSpeed SPEED_HOLD;
            } else {
            	// all fine, go rollin on path travelled from veh in front
            	private _path = _thisVeh getVariable ["grad_convoy_nextPath", []];
                _thisVeh setDriveOnPath _path; // [getPos _thisVeh,_thisVeh getPos [0.8 * _distFront,_thisVeh getDir  _vehicleInFront]];

                private _speedLimit = [_distFront] call GRAD_convoy_fnc_getSpeedLimit;
                _thisVeh limitSpeed _speedLimit;
            };
        };

        if (!isNull _vehicleBehind && {_thisVeh distance _vehicleBehind > DISTANCE_MAX_LEADING}) then {
            _thisVeh limitSpeed SPEED_HOLD;
        } else {
            if (isNull _vehicleInFront) then {
                _thisVeh limitSpeed SPEED_STEADY;
            };
        };


        // reset history paths of each vehicle
        {
	        private _path = _x getVariable ["grad_convoy_pathHistory", []];
	        if (_forEachIndex > 0 && _forEachIndex < (count _convoy - 1)) then {
	            (_convoy select (_forEachIndex + 1)) setVariable ["grad_convoy_nextPath", _path];
	        };
	    } forEach _convoyVehicles;

	    {   
	        _x setVariable ["grad_convoy_pathHistory", []];
	    } forEach _convoyVehicles;

    },0.5,[_convoyID, _thisVeh] call CBA_fnc_addPerFrameHandler;
};

// record history path of each vehicle
[{
    params ["_args", "_handle"];
    _args params ["_convoyID"];
    
    private _vehicleListIdentifier = format ["GRAD_convoy_vehicleList_%1", _convoyID];
	private _convoyVehicles = missionNamespace getVariable [_vehicleListIdentifier, []];

	if (count _convoyVehicles < 1) exitWith {
		[_handle] call CBA_fnc_removePerFramehandler;
	};

    {   
        private _pathHistory = _x getVariable ["grad_convoy_pathHistory", []];
        _pathHistory pushBackUnique (getPos _x);
        _x setVariable ["grad_convoy_pathHistory", _pathHistory];
    } forEach _convoyVehicles;

}, 0.1, [_convoyID]] call CBA_fnc_addPerFrameHandler;