[] spawn {
  waitUntil {!isNull player};
  waitUntil {  time > 3 };

  {
    
      _x addEventHandler ["CuratorGroupPlaced", {
          params ["", "_group"];

          { 
              _x setSkill ["aimingShake", 0.2]; 
              _x setSkill ["aimingSpeed", 0.9]; 
              _x setSkill ["endurance", 0.6]; 
              _x setSkill ["spotDistance", 1]; 
              _x setSkill ["spotTime", 0.9]; 
              _x setSkill ["courage", 1]; 
              _x setSkill ["reloadSpeed", 1]; 
              _x setSkill ["commanding", 1];
              _x setSkill ["general", 1];

              [_x] remoteExec ["MissionControl_fnc_addKilledEH", 2];

          } forEach units _group;
      }];

      _x addEventHandler ["CuratorObjectPlaced", {
          params ["", "_object"];
          

          _object setSkill ["aimingShake", 0.2]; 
          _object setSkill ["aimingSpeed", 0.9]; 
          _object setSkill ["endurance", 0.6]; 
          _object setSkill ["spotDistance", 1]; 
          _object setSkill ["spotTime", 0.9]; 
          _object setSkill ["courage", 1]; 
          _object setSkill ["reloadSpeed", 1]; 
          _object setSkill ["commanding", 1];
          _object setSkill ["general", 1];

      }];

  } forEach allCurators;


  if (  
    isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")
  ) then
  {
    // Note that the line below has to be uncommented if your mission is a Zeus Game Master mission.
    // TODO check if below is necessary to uncomment
    waitUntil {not isNil "ares_category_list"};


    ["LEINAPAEEV Mission Progress", "01 End Siren Alarm",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      INTRO_SIREN_WAILING = false; publicVariableServer "INTRO_SIREN_WAILING";

      systemChat "ZEUS: Ending Siren Alarm";

    }] call Ares_fnc_RegisterCustomModule;

    ["LEINAPAEEV Mission Progress", "02 Bombard Airfield",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [] remoteExec ["MissionControl_fnc_executeExplosions",2,false];

      systemChat "ZEUS: Bombard Airfield executed";

    }] call Ares_fnc_RegisterCustomModule;


    ["LEINAPAEEV Mission Progress", "04 Create Chair Circle + Outro",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [] remoteExec ["missionControl_fnc_outro", 2];

      private _count = 30; // count (playableUnits + switchableUnits) + 2;
      
      // possible chairs
      private _chairs = ["Land_CampingChair_V1_F", getPos chaircircle_position, _count] call missionControl_fnc_createChairCircle;
      {
        private _chair = (_chairs select _forEachIndex);
        if (_forEachIndex > (_count -1)) exitWith {};
        [_x, _chair, _chairs, _count] remoteExec ["missionControl_fnc_outroSequence", _x];
        _chair setVariable ["grad_seatClaimedBy", _x, true];
      } forEach (playableUnits + switchableUnits);

      
    }] call Ares_fnc_RegisterCustomModule;



     ["LEINAPAEEV Mission Progress", "05 Show stats",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [] remoteExec ["MissionControl_fnc_showStats", [0, -2] select isDedicated, true];

      systemChat "ZEUS: Showing Stats";

    }] call Ares_fnc_RegisterCustomModule;


    ["LEINAPAEEV Reinforcements", "Mi8 Recon over Street",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [[
        getPos civWP_1,
        getPos civWP_2,
        getPos civWP_3,
        getPos civWP_4,
        getPos civWP_5,
        getPos civWP_6,
        getPos civWP_7,
        getPos civWP_8,
        getPos civWP_9,
        getPos civWP_10,
        getPos civWP_11,
        getPos civWP_12,
        getPos civWP_13,
        getPos civWP_14,
        getPos civWP_15,
        getPos civWP_16,
        getPos civWP_17,
        getPos civWP_18,
        getPos civWP_19,
        getPos civWP_20,
        getPos civWP_21,
        getPos civWP_22,
        getPos civWP_23,
        getPos civWP_24,
        getPos civWP_25,
        getPos civWP_26,
        getPos civWP_27,
        getPos civWP_28,
        getPos civWP_29,
        getPos civWP_30,
        getPos civWP_31,
        getPos civWP_32,
        getPos civWP_33,
        getPos civWP_34,
        getPos civWP_35,
        getPos civWP_36,
        getPos civWP_37,
        getPos civWP_38,
        getPos civWP_39,
        getPos civWP_40,
        getPos civWP_41,
        getPos civWP_42,
        getPos civWP_43,
        getPos civWP_44,
        getPos civWP_45,
        getPos civWP_46

      ]] remoteExec ["MissionControl_fnc_mi8Recon",2,false];

      systemChat "ZEUS: Mi8 Recon executed";

    }] call Ares_fnc_RegisterCustomModule;


    ["LEINAPAEEV Reinforcements", "Mi8 Infantry Drop",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [_position] remoteExec ["MissionControl_fnc_mi8Drop",2,false];

      systemChat "ZEUS: Mi8 Drop executed";

    }] call Ares_fnc_RegisterCustomModule;


    ["LEINAPAEEV FX", "Pee Pee Unit",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [_objectUnderCursor] remoteExec ["MissionControl_fnc_doPee", [0, -2] select isDedicated, false];

      systemChat "ZEUS: Pee Pee executed";

    }] call Ares_fnc_RegisterCustomModule;

    ["LEINAPAEEV FX", "Add Smoke to Car",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      if (!isNull _objectUnderCursor && {_objectUnderCursor isKindOf "Car"}) exitWith {
        [_objectUnderCursor] call MissionControl_fnc_addSmokeToCar;
        systemChat "ZEUS: Smoke added";
      };

      systemChat "ZEUS: Smoke cant be added";

    }] call Ares_fnc_RegisterCustomModule;


    ["LEINAPAEEV FX", "Start Civilian Spawn",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      ["mrk_flag_rus", "mrk_sign_tallin"] remoteExec ["missionControl_fnc_civilianRoadFlow", 2];

      systemChat "ZEUS: Civ Flow started";

    }] call Ares_fnc_RegisterCustomModule;

    ["LEINAPAEEV FX", "Stop Civilian Spawn",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      CIVILIAN_FLOW_ACTIVE = false; publicVariableServer "CIVILIAN_FLOW_ACTIVE";

      systemChat "ZEUS: Civ Flow stopped";

    }] call Ares_fnc_RegisterCustomModule;



    ["LEINAPAEEV OUTRO MARKERS", "Define Outro Start",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      "mrk_outroSequence_start" setMarkerPos _position;
      "mrk_outroSequence_start" setMarkerAlphaLocal 1;

      systemChat "ZEUS: Moved Outro Start Marker";

    }] call Ares_fnc_RegisterCustomModule;

    ["LEINAPAEEV OUTRO MARKERS", "Define Outro End",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      "mrk_outroSequence_end" setMarkerPos _position;
      "mrk_outroSequence_end" setMarkerAlphaLocal 1;

      systemChat "ZEUS: Moved Outro End Marker";

    }] call Ares_fnc_RegisterCustomModule;

    ["LEINAPAEEV OUTRO MARKERS", "Define Outro Target",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      "mrk_outroSequence_target" setMarkerPos _position;
      "mrk_outroSequence_target" setMarkerAlphaLocal 1;

      systemChat "ZEUS: Moved Outro Start Marker";

    }] call Ares_fnc_RegisterCustomModule;


    ["LEINAPAEEV CONVOY", "Start Bundeswehr Convoy",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [] remoteExec ["missionControl_fnc_bwConvoyStart", 2];

    }] call Ares_fnc_RegisterCustomModule;


    ["LEINAPAEEV CONVOY", "Start Russian Convoy",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [1, east] remoteExec ["GRAD_convoy_fnc_startConvoy", 2];

    }] call Ares_fnc_RegisterCustomModule;


    ["LEINAPAEEV CONVOY", "Toggle Russian Convoy Movement",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      private _convoyID = 1;
      private _convoyIdentifier = format ["GRAD_convoy_%1_pause", _convoyID];
      private _pause = missionNamespace getVariable [_convoyIdentifier, false];
      _pause = !_pause;

      missionNamespace setVariable [_convoyIdentifier, _pause, true];

      systemChat ("ZEUS: Toggling Convoy Pause to " + (str _pause));

    }] call Ares_fnc_RegisterCustomModule;


  };
};