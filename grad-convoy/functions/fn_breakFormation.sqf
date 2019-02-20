params ["_convoy", "_waypoints"];


{
	driver vehicle _x enableAI "FSM";
	driver vehicle _x enableAI "PATH";
	driver vehicle _x setBehaviour "CARELESS"; 
	driver vehicle _x disableAi "autoCombat";
	_x setVariable ["GRAD_convoy_formationBroken", true];
	_x setConvoySeparation 20;
} forEach _convoy;

private _firstVehicle = _convoy select 0;

// regroup units into formation
(units (group _firstVehicle)) doFollow _firstVehicle;

// add destination, as convoy should now search best way on its own
private _lastWaypoint = (_waypoints select (count _waypoints - 1));
private _waypoint = (group _firstVehicle) addWaypoint _lastWaypoint;
(group _firstVehicle) setCurrentWaypoint _lastWaypoint;

_waypoint setWaypointCombatMode "GREEN"; // Defensiv behaviour
_waypoint setWaypointBehaviour "SAFE"; // Force convoy to normally drive on the street.
_waypoint setWaypointFormation "STAG COLUMN";
_waypoint setWaypointSpeed "NORMAL";