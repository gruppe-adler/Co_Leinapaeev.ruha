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

     ["LEINAPAEEV Mission Progress", "05 Show stats",
    {
      // Get all the passed parameters
      params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

      [] remoteExec ["MissionControl_fnc_showStats", [0, -2] select isDedicated, true];

      systemChat "ZEUS: Showing Stats";

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