// by ALIAS// null = [] execVM "AL_bomb\bomber_bomb.sqf";

if (!isServer) exitWith {};

_start_marker		= _this select 0;
_waypoint_marker	= _this select 1;
size_b				= _this select 2;
publicVariable "size_b";
al_crater	= _this select 3;
publicVariable "al_crater";
al_destruction	= _this select 4;
publicVariable "al_destruction";

// pe baza marketului se stabileste vectorul de zbor pentru JET
_pos1 = getMarkerPos _start_marker; // markerul ce indica punctul din care incepe bombardamentul - trebuie plasat pe harta
_pos2 = getMarkerPos _waypoint_marker; // markerul ce indica punctul incotro zboara avionul - trebuie plasat pe harta
_unghi = [_pos1,_pos2] call BIS_fnc_dirTo;
_unghiorig = _unghi - 180;

_origpos = [_pos1, 3000, _unghiorig] call BIS_fnc_relPos;
_finpos = [_pos2, 3000, _unghi] call BIS_fnc_relPos;

_avion_bomb = [_origpos, _unghi, "B_Plane_CAS_01_F", civilian] call bis_fnc_spawnvehicle;
_veh_avion = _avion_bomb select 0;
_veh_avion allowdamage false;
_veh_avion setPosATL [getPosATL _veh_avion select 0, getPosATL _veh_avion select 1, 1000];
_veh_avion setcombatmode "BLUE";
_veh_avion setBehaviour "CARELESS";
_veh_avion disableAI "TARGET";
_veh_avion disableAI "AUTOTARGET";
_veh_avion flyInHeight 500;


_wp1 = group _veh_avion addWaypoint [_pos1, 0];
_wp1 setWaypointType "MOVE";
_wp1 setWayPointBehaviour "CARELESS";
_wp1 setWaypointSpeed "NORMAL";
_wp1 setWaypointStatements ["true", "[this,size_b,al_crater,al_destruction] execvm 'AL_bomb\alias_bomb_ini.sqf'"];


_wp2 = group _veh_avion addWaypoint [_pos2, 1];
_wp2 setWaypointType "MOVE";
_wp2 setWayPointBehaviour "AWARE";
_wp2 setWaypointSpeed "NORMAL";

_wp3 = group _veh_avion addWaypoint [_finpos, 2];
_wp3 setWaypointType "MOVE";
_wp3 setWayPointBehaviour "CARELESS";
_wp3 setWaypointSpeed "NORMAL";
_wp3 setWaypointStatements ["true", "{deleteVehicle _x} forEach (crew this)+[this];"];