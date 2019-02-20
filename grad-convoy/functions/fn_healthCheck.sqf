params ["_convoyID", "_thisVeh", "_waypoints", "_handle"];

// ensure convoy can always move, leading vehicle is first in array
if (!canMove _thisVeh || !alive _thisVeh) then {
	[_convoyID, _thisVeh, _waypoints] call GRAD_convoy_fnc_removeVehicleFromConvoy;
	// delete loop for that vehicle
	[_handle] call CBA_fnc_removePerFrameHandler;
};