params ["_convoy", "_waypoints"];

if (CONVOY_DEFEND_ON_AMBUSH) then {
    {
        private _vehicle = _x;
        private _goLeft = (_forEachIndex mod 2 == 0);
        private _dir = if (_goLeft) then { 120 } else { 240 };
        _vehicle limitSpeed 50;
        private _ownPosition = getPos _vehicle;
        private _targetPosition = _vehicle getPos [20, _dir];
        // set speed
        _vehicle move _targetPosition;
        // systemChat "move";
    } forEach _convoy;

    systemChat "Defend convoy triggered";

    [{
        params ["_convoy"];

        {
            private _group = (createGroup east);
            (driver _x) enableAI "FSM";
            (driver _x) enableAI "PATH";
            (driver _x) setBehaviour "AWARE"; 
            (driver _x) disableAi "autoCombat";
            (driver _x) setCaptive false;
            private _crew = crew _x;
            _crew joinGroup _group;

            _x setVariable ["GRAD_convoy_formationBroken", true, true];

            private _cargo = assignedCargo _x;
            _cargo allowGetIn false;
            _cargo joinGroup _group;
            {
                _x action ["Eject", vehicle _x];
                unassignVehicle _x;
                [_x] allowGetIn false;

                _x setUnitPos "MIDDLE";
                _x setBehaviour "COMBAT"; // to force lights off
                _x setCombatMode "RED";  // disable him attacking
                _x enableAI "autoCombat";
                _x enableAI "TARGET";
                _x enableAI "AUTOTARGET";
                _x setSpeedMode "FULL";
            } forEach _cargo; // (crew _x); // cargo
            

        } forEach _convoy;
    }, [_convoy], 7] call CBA_fnc_waitAndExecute;
} else {

    {
    	_x setVariable ["GRAD_convoy_formationBroken", true];
    	_x setConvoySeparation 20;
    	_x limitSpeed 50;
    	_x forceFollowRoad true; // todo maybe counterproductive here
    } forEach _convoy;

    private _firstVehicle = _convoy select 0;

    systemChat "breakthrough triggered";

    // regroup units into formation
    (units (group _firstVehicle)) doFollow _firstVehicle;

    // add destination, as convoy should now search best way on its own
    private _lastWaypoint = (_waypoints select (count _waypoints - 1));
    private _waypoint = (group _firstVehicle) addWaypoint _lastWaypoint;

    _waypoint setWaypointCombatMode "YELLOW"; // Open fire but stay in formation
    // _waypoint setWaypointBehaviour "SAFE"; // Force convoy to normally drive on the street.
    _waypoint setWaypointFormation "COLUMN";
    _waypoint setWaypointSpeed "FULL";

    (group _firstVehicle) setCurrentWaypoint _waypoint;

};