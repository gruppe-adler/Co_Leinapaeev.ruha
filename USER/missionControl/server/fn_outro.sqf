

private _count = count (playableUnits + switchableUnits + (allDeadMen select {isPlayer _x}));

// in case no chairs are set yet
if (isNil "CO_LP_CHAIRCIRCLE") then {
  private _chairs = ["Land_CampingChair_V1_F", getPos chaircircle_position, _count] call missionControl_fnc_createChairCircle;
  CO_LP_CHAIRCIRCLE = _chairs; publicVariable "CO_LP_CHAIRCIRCLE";
};

{
    private _chair = (CO_LP_CHAIRCIRCLE select _forEachIndex);
    if (_forEachIndex > (_count -1)) exitWith { diag_log format ["didnt find position for all players in chairs at %1", _forEachIndex]; };
    _chair setVariable ["grad_seatClaimedBy", _x, true];
    [_x, _chair, CO_LP_CHAIRCIRCLE, _count] remoteExec ["missionControl_fnc_decideOutro", _x];
} forEach (playableUnits + switchableUnits + (allDeadMen select {isPlayer _x}));


sleep 11;

setDate [2020, 6, 15, 0, 0];
0 setFog [2, 0.7, 1];

private _position = [6325.58,2205.45,0.299999]; 
private _lightpoint = "#lightpoint" createVehicleLocal _position; 
_lightpoint setLightColor [0,1,1]; 
_lightpoint setLightAmbient [0.2,0.0,0.3]; 
_lightpoint setLightUseFlare true; 
_lightpoint setLightFlareSize 3; 
_lightpoint setLightFlareMaxDistance 3.5; 
_lightpoint setLightBrightness 4; 
_lightpoint setLightDayLight true;


private _ambulance = "UK3CB_C_Hilux_Ambulance" createVehicle (getMarkerPos "mrk_outroSequence_target_start"); 
_ambulance spawn rds_fnc_syrena;

private _ambulance2 = "rhs_gaz66_ap2_vmf" createVehicle (getMarkerPos "mrk_outroSequence_target_end"); 
_ambulance2 setDir (random 360);


private _miPos = (getMarkerPos "mrk_outroSequence_target_end");
_miPos set [2,30];
private _mi8 = createVehicle ["RHS_Mi8AMT_vdv", _miPos, [], 50, "FLY"];
createVehicleCrew _mi8;
_mi8 setDir (random 360);

_mi8 setCombatMode "RED";
_mi8 disableAI "AUTOCOMBAT";
_mi8 disableAI "Autotarget";
_mi8 allowFleeing 0;
_mi8 setskill ["courage",1];
_mi8 flyInHeight 20;
_mi8 limitSpeed 1;
_mi8 setPilotLight true;
_mi8 setCollisionLight true;

sleep 44;

_fishes = [];

for "_i" from 0 to 20 do {
    private _agent = createAgent ["Mullet_F", ASLtoAGL (position outroEndSequence_1), [], 1, "CAN_COLLIDE"]; 
    _agent setDir (random 360);
    _fishes pushBackUnique _agent;
};

sleep 120;

{ deleteVehicle _x; } forEach _fishes;
