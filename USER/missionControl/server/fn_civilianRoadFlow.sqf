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
    "UK3CB_CHC_C_Datsun_Civ_Closed",
    "UK3CB_CHC_C_Datsun_Civ_Open",
    "UK3CB_CHC_C_Hatchback",
    "UK3CB_CHC_C_Hilux_Civ_Closed",
    "UK3CB_CHC_C_Lada",
    "UK3CB_CHC_C_Landcruiser",
    "UK3CB_CHC_C_Octavia",
    "UK3CB_CHC_C_Pickup",
    "UK3CB_CHC_C_Sedan",
    "UK3CB_CHC_C_Skoda",
    "UK3CB_CHC_C_Gaz24",
    "UK3CB_CHC_C_Golf",
    "UK3CB_CHC_C_V3S_Refuel",
    "UK3CB_CHC_C_V3S_Recovery",
    "UK3CB_CHC_C_V3S_Closed",
    "UK3CB_CHC_C_Ural_Repair",
    "UK3CB_CHC_C_Ural_Empty",
    "UK3CB_CHC_C_Ural_Fuel",
    "UK3CB_CHC_C_Hatchback",
    "UK3CB_CHC_C_Hilux_Civ_Closed",
    "UK3CB_CHC_C_Lada",
    "UK3CB_CHC_C_Landcruiser",
    "UK3CB_CHC_C_Octavia",
    "UK3CB_CHC_C_Pickup",
    "UK3CB_CHC_C_Sedan",
    "UK3CB_CHC_C_Skoda",
    "UK3CB_CHC_C_Gaz24",
    "UK3CB_CHC_C_Golf",
    "UK3CB_CHC_C_V3S_Refuel",
    "UK3CB_CHC_C_V3S_Recovery",
    "UK3CB_CHC_C_V3S_Closed",
    "UK3CB_CHC_C_Ural_Repair",
    "UK3CB_CHC_C_Ural_Empty",
    "UK3CB_CHC_C_Ural_Fuel"
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
        private _agent = createAgent ["UK3CB_CHC_C_CIV", _positionA, [], 0, "NONE"];
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
        if (_type == "UK3CB_CHC_C_Lada") then {

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