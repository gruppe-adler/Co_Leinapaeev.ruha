params ["_markerA", "_markerB"];

if (!isNil "CIVILIAN_FLOW_ACTIVE" && {!CIVILIAN_FLOW_ACTIVE}) exitWith { systemChat "dont spawn twice"; };

CIVILIAN_FLOW_ACTIVE = true;
CIVILIAN_CARS = [];

private _positionA = getMarkerPos _markerA;
private _positionB = getMarkerPos _markerB;

private _dir = 180;
private _maxCount = 40;

// motorbikes tend to make problems
private _types = [
    "RDS_Gaz24_Civ_03",
    "RDS_Gaz24_Civ_01",
    "RDS_Gaz24_Civ_02",
    "RDS_Golf4_Civ_01",
    "RDS_Octavia_Civ_01",
    "RDS_Van_01_box_F",
    "RDS_Lada_Civ_01",
    "RDS_Lada_Civ_03",
    "RDS_Lada_Civ_02",
    "gm_demo_idap_mb_u1300l_cargo",
    "C_IDAP_Van_02_vehicle_F",
    "C_IDAP_Truck_02_F",
    "LOP_CHR_Civ_UAZ",
    "LOP_CHR_Civ_Ural",
    "C_Truck_02_fuel_F",
    "C_Offroad_01_repair_F",
    "C_Van_02_vehicle_F",
    "C_Van_02_service_F",
    "RDS_Lada_Civ_01",
    "RDS_Lada_Civ_03",
    "RDS_Lada_Civ_02",
    "C_Truck_02_fuel_F",
    "sfp_van_hemglass",
    "RDS_Lada_Civ_01",
    "RDS_Lada_Civ_03",
    "RDS_Lada_Civ_02",
    "RDS_Lada_Civ_01",
    "RDS_Lada_Civ_03",
    "RDS_Lada_Civ_02",
    "RDS_Golf4_Civ_01",
    "RDS_Octavia_Civ_01",
    "RDS_Gaz24_Civ_03",
    "RDS_Gaz24_Civ_01",
    "RDS_Gaz24_Civ_02",
    "RDS_Golf4_Civ_01",
    "RDS_Gaz24_Civ_03",
    "RDS_Gaz24_Civ_01",
    "RDS_Gaz24_Civ_02",
    "RDS_Golf4_Civ_01"
];

// agent variante
[{
    params ["_args", "_handle"];
    _args params ["_positionA", "_positionB", "_maxCount", "_types"];
    
    if (!CIVILIAN_FLOW_ACTIVE) exitWith {};
    if (count CIVILIAN_CARS > _maxCount) exitWith {};

    if (random 3 > 1) exitWith {};

    private _isEmpty = !(count (_positionA nearEntities [["Man", "LandVehicle"], 10]) > 0);
    // systemChat str (_isEmpty);

    if (_isEmpty) then {
        private _car = (selectRandom _types) createVehicle _positionA;
        _car setDir 180;
        private _agent = createAgent ["RDS_Civilian_Random", _positionA, [], 0, "NONE"];
        // _agent disableAI "ALL";
        _agent disableAI "FSM";
        _agent disableAI "MINEDETECTION";
        _agent setBehaviour "CARELESS";
        _agent setCombatMode "BLUE";
        _agent setSpeedMode "FULL";
        _agent enableAI "MOVE";

        _agent setCaptive true;

        _agent assignAsDriver _car;
        _agent moveInDriver _car;

        private _type = typeOf _car;
        if (_type == "RDS_Lada_Civ_01" ||
            _type == "RDS_Lada_Civ_02" ||
            _type == "RDS_Lada_Civ_03") then {

            private _item = "Land_LuggageHeap_01_F" createVehicle [0,0,0.3];

            _item attachTo [_car, [0,0,0]];
        };


        CIVILIAN_CARS pushBackUnique _car;
        _car limitSpeed 40;

        systemChat str (count CIVILIAN_CARS);

        _agent setDestination [
            _positionB,
            'VEHICLE PLANNED',
            true
        ];
    };
    
}, 5, [_positionA, _positionB, _maxCount, _types]] call CBA_fnc_addPerFramehandler;

/*
[{
    params ["_args", "_handle"];
    _args params ["_positionA", "_positionB", "_types"];
    
    private _isEmpty = !(count (_positionA nearEntities [["Man", "LandVehicle"], 10]) > 0);
    systemChat str (_isEmpty);

    if ((count CIVILIAN_CARS < 50) && CIVILIAN_FLOW_ACTIVE && _isEmpty) then {
        private _vehicleArray = [_positionA, 180, selectRandom _types, civilian] call BIS_fnc_spawnVehicle;
        _vehicleArray params ["_vehicle", "_crew", "_group"];

        CIVILIAN_CARS pushBackUnique _vehicle;
        _vehicle limitSpeed 40;

        systemChat str (count CIVILIAN_CARS);

        private _wp = _group addWaypoint [_positionB, 0];
        _wp setWaypointStatements ["true", "{
            CIVILIAN_CARS deleteAt [CIVILIAN_CARS find this];
            {deleteVehicle _x;} forEach crew this; deleteVehicle this;
        }"];
        _vehicle setBehaviour "CARELESS";
        _vehicle setCombatMode "BLUE";
        _vehicle setSpeedMode "FULL"

        {
            _x disableAI "AUTOTARGET";
            _x disableAI "TARGET";
        } forEach _crew;
    };
    
}, 5, [_positionA, _positionB, _types]] call CBA_fnc_addPerFramehandler;
*/