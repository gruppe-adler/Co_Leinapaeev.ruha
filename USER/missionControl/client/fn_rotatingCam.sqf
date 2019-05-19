/* by mcdiod */



_this spawn {
    params ["_target",["_timeout",15],["_radius",50],["_angle",180],["_altitude",15],["_dir",0],["_commitTime",0.1],["_showCinemaBorder",false], ["_targets", []]];
 
    cutText ["", "BLACK IN", 5];

    mcd_rotateCamRunning = true;

    /*
    [
        [
            ["Debriefing","<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><t align = 'center'  color='#59ffffff' shadow = '0' size = '1.5' font='EtelkaNarrowMediumPro'>%1</t><br/><br/>",25]
        ]
    ] spawn GRAD_missionControl_fnc_typeText;
    */
    


    if (count _targets > 0) exitWith {
        _target set [2,1.2];
        _camera = "camera" camCreate _target;
        _camera cameraEffect ["Internal","BACK"];
        showCinemaBorder _showCinemaBorder;
        _camera camPrepareFOV 0.400;
        _camera camPrepareTarget _target;
        _camera camCommitPrepared 0;
        
        titleFadeOut 1;
        {
            _camera camPrepareTarget _x;
            _camera camCommitPrepared 2;

            private _occupier = _x getVariable ["grad_seatClaimedBy", objNull];
            if (!isNull _occupier) then {
                
                private _string = ("ÜBERLEBT");

                if (_occupier getVariable ["CO_LP_ISHIDDEN", false]) then {
                    _string = ("GEFALLEN");
                };

                titleText ["<t color='#ffffff' align='left' shadow='0' size='1'>" + _string + "</t><br/>
                <t color='#ffffff' align='left' shadow='0' size='2'>" + (name _occupier) + "</t>", "PLAIN", 1, true, true];
                titleFadeOut 1;
            };

            waitUntil {camCommitted _camera};
        } forEach _targets;

        cutText ["", "BLACK OUT", 1];
        sleep 1;

        titleText ["", "PLAIN", 0, true, true];


        _camera cameraEffect ["terminate","back"];
        camDestroy _camera;   
        sleep 1;
        cutText ["", "BLACK IN", 1];

        7 fadeMusic 0.25;
    };



 
    _coords = _target getPos [_radius,_angle];
    _targetPos = if (_target isEqualType []) then {_target} else {getPos _target};
    _target set [2,1.2];
    _heightASL = (getTerrainHeightASL _targetPos) + _altitude;
 
    _coords set [2, _altitude];
    _camera = "camera" camCreate _coords;
    _camera cameraEffect ["Internal","BACK"];
    showCinemaBorder _showCinemaBorder;
    _camera camPrepareFOV 0.300;
    _camera camPrepareTarget _target;
    _camera camCommitPrepared 0;

    [_timeout] spawn {
        params ["_timeout"];
        [{mcd_rotateCamRunning = false;}, [], _timeout] call CBA_fnc_waitAndExecute;
    };
 
    while {mcd_rotateCamRunning} do {
        _coords = _target getPos [_radius,_angle];
        _coords set [2, _heightASL];
        _coords = ASLToATL _coords;
 
        _camera camPreparePos _coords;
        _camera camCommitPrepared _commitTime;

        private _camTarget = cursorObject;
        if (_camTarget isKindOf "Man") then {
            
            private _string = ("Überlebt: ");

            if (isHidden _camTarget) then {
                _string = ("Gestorben: ");
            };

            cutText ["<t color='#ffffff' shadow='0' size='1'>" + _string + "</t><br/>
            <t color='#ffffff' shadow='0' size='2'>" + (name _camTarget) + "</t>", "PLAIN", 0, true, true];
        };

        waitUntil {camCommitted _camera || !(mcd_rotateCamRunning)};
 
        _angle = if (_dir == 0) then {_angle - 1} else {_angle + 1};
    };

    cutText ["", "BLACK OUT", 1];
    sleep 1;
    _camera cameraEffect ["terminate","back"];
    camDestroy _camera;   
    sleep 1;
    cutText ["", "BLACK IN", 1];

    7 fadeMusic 0.25;
    10 fadeSound 1;

};