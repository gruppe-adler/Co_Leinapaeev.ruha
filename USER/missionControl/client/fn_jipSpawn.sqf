params ["_unit"];

private _position = getMarkerPos (selectRandom [
    "mrk_spawnPos_1",
    "mrk_spawnPos_2",
    "mrk_spawnPos_3",
    "mrk_spawnPos_4",
    "mrk_spawnPos_5",
    "mrk_spawnPos_6"
]);

_unit setPos _position;

sleep 1;
private _bike = (selectRandom ["sfp_dakota", "RDS_JAWA353_Civ_01", "RDS_tt650_Civ_01"]) createVehicle _position;

[_position] remoteExec ["MissionControl_fnc_addSpawnMarker", _unit];