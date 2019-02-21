/*

	// use unique IDs (number) to start!
	[0] call GRAD_convoy_fnc_startConvoy;
	
*/

params ["_convoyID"];

private _convoyParams = [_convoyID] call GRAD_convoy_fnc_createConvoy;
_convoyParams params ["_waypoints", "_convoy"];

// store convoy in MNS to be able to remove vehicles out of it later on
private _identifier = format ["GRAD_convoy_vehicleList_%1", _convoyID];
missionNamespace setVariable [_identifier, _convoy];

// give leader all the waypoints necessary
{
	(_convoy select 0) addWaypoint [_x, _forEachIndex];
} forEach _waypoints;

for [{_i=0},{_i<count _convoy},{_i=_i+1}] do {

	// disable AI as we dont need it
	private _thisVeh = _convoy select _i;
    (driver _thisVeh) disableAI "FSM"; // safe some performance here
    // path planning necessary in first veh
    if (_i > 0) then {
        (driver _thisVeh) disableAI "PATH";   // potentially safe some performance here for following vehicles
    };
    (driver _thisVeh) setBehaviour "AWARE"; // to force lights off
    (driver _ThisVeh) setCombatMode "BLUE";  // disable him attacking
    (driver _thisVeh) disableAi "autoCombat";


    [{
        params ["_vehicles","_handle"];
        _vehicles params ["_convoyID", "_thisVeh", "_waypoints"];

        // remove vehicle from convoy if necessary
        [_convoyID, _thisVeh, _waypoints, _handle] call GRAD_convoy_fnc_healthCheck;

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
                _thisVeh setVariable ["GRAD_convoy_vehicleHolds", true];
            } else {
            	// all fine, go rollin on path travelled from veh in front
            	private _path = _thisVeh getVariable ["grad_convoy_nextPath", []];
                _thisVeh setDriveOnPath _path; // [getPos _thisVeh,_thisVeh getPos [0.8 * _distFront,_thisVeh getDir  _vehicleInFront]];

                private _speedLimit = [_distFront] call GRAD_convoy_fnc_getSpeedLimit;
                _thisVeh limitSpeed _speedLimit;
                _thisVeh setVariable ["GRAD_convoy_vehicleHolds", false];
            };
        };

        if (!isNull _vehicleBehind && {_thisVeh distance _vehicleBehind > DISTANCE_MAX_LEADING}) then {
            _thisVeh limitSpeed SPEED_HOLD;
            _thisVeh setVariable ["GRAD_convoy_vehicleHolds", true];
        } else {
            if (isNull _vehicleInFront) then {
                _thisVeh limitSpeed SPEED_STEADY;
                _thisVeh setVariable ["GRAD_convoy_vehicleHolds", false];
            };
        };


        // reset history paths of each vehicle (experimental)
        {
	        private _path = _x getVariable ["grad_convoy_pathHistory", []];
	        if (_forEachIndex > 0 && _forEachIndex < (count _convoy - 1)) then {
	            (_convoy select (_forEachIndex + 1)) setVariable ["grad_convoy_nextPath", _path];
	        };
	    } forEach _convoyVehicles;

	    {   
	        _x setVariable ["grad_convoy_pathHistory", []];
	    } forEach _convoyVehicles;

    },0.5,[_convoyID, _thisVeh, _waypoints] call CBA_fnc_addPerFrameHandler;
};

// record history path of each vehicle (experimental)
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


// check for stuck vehicle (experimental)
[{
    params ["_args", "_handle"];
    _args params ["_convoyID"];
    
    private _vehicleListIdentifier = format ["GRAD_convoy_vehicleList_%1", _convoyID];
    private _convoyVehicles = missionNamespace getVariable [_vehicleListIdentifier, []];

    if (count _convoyVehicles < 1) exitWith {
        [_handle] call CBA_fnc_removePerFramehandler;
    };

    {   
        [_x] call GRAD_convoy_fnc_checkForStuckVehicle;
    } forEach _convoyVehicles;

}, 3, [_convoyID]] call CBA_fnc_addPerFrameHandler;