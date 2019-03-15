
params ["_unit"];

private _availableSounds_A = [
        "WoundedGuyA_01",
        "WoundedGuyA_02",
        "WoundedGuyA_03",
        "WoundedGuyA_04",
        "WoundedGuyA_05",
        "WoundedGuyA_06",
        "WoundedGuyA_07",
        "WoundedGuyA_08"
    ];

[{
	params ["_args", "_handle"];
	_handle params ["_unit", "_availableSounds_A"];	

	if (!alive _unit) exitWith {
		[_handle] call CBA_fnc_removePerFramehandler;
	};

	if (stance _unit != "PRONE" && {speed _unit > 1}) then {
		[player, objNull, 5] call ACE_hitreactions_fnc_fallDown;

		/*
		_unit switchMove "AidlPpneMstpSnonWnonDnon_AI";

    	// Play the sound
    	playSound3D [
    		(getArray(configFile >> "CfgSounds" >> (selectRandom _availableSounds_A) >> "sound") select 0) + ".wss", 
    		objNull, 
    		false, 
    		getPos _unit, 
    		15, 
    		1, 
    		25
    	]; // +2db, 15 meters.
    	*/
	};﻿


}, 1, [_unit, _availableSounds_A]] call CBA_fnc_addPerFramehandler;