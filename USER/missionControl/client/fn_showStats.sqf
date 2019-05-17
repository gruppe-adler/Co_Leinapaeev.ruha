if (isServer) then {
    /*
    [] spawn {
        
        // private _resultArmored = ["", "1", "2", "3", "4"];

        private _resultTotalNumber_west = ((parseNumber _resultInf_west) + (parseNumber _resultSoft_west) + (parseNumber _resultFuel_west));
        private _resultTotalNumber_east = ((parseNumber _resultInf_east) + (parseNumber _resultSoft_east) + (parseNumber _resultFuel_east));

        private _resultTotal_west = str _resultTotalNumber_west;
        private _resultTotal_east= str _resultTotalNumber_east;

        private _results_west = ["", _resultInf_west, _resultSoft_west, _resultFuel_west, _resultTotal_west];
        private _results_east = ["", _resultInf_east, _resultSoft_east, _resultFuel_east, _resultTotal_east];

        private _eastWins = _resultTotalNumber_east > _resultTotalNumber_west;
        private _draw = _resultTotalNumber_west == _resultTotalNumber_east;

        sleep 16;
        // [] call GRAD_replay_fnc_stopRecord;

        
        if (_eastWins) then {
            [[east]] remoteExec ["grad_endings_fnc_endMissionClient",0,false];
        } else {
            if (!_draw) then {
                [[west]] remoteExec ["grad_endings_fnc_endMissionClient",0,false];
            } else {
                [[west,east]] remoteExec ["grad_endings_fnc_endMissionClient",0,false];
            };
        };
        
    };
    */
};


if (hasInterface) then {

    // playMusic "EventTrack01_F_Curator";
    // [player, true] call TFAR_fnc_forceSpectator;
    [player, player] call ACE_medical_fnc_treatmentAdvanced_fullHealLocal;




    private _screenWidth = safeZoneW;
    private _screenHeight = safeZoneH;

    private _columnWidth = _screenWidth/26;
    private _rowHeight = _screenHeight/40;

    disableSerialization;





    
    private _iconInf = "\A3\ui_f\data\igui\cfg\mptable\infantry_ca.paa";
    private _iconSoft = "\A3\ui_f\data\igui\cfg\mptable\soft_ca.paa";
    private _iconAPC = "\A3\ui_f\data\map\vehicleicons\iconAPC_ca.paa";
    private _iconArmored = "\A3\ui_f\data\igui\cfg\mptable\armored_ca.paa";
    // private _iconFuel = "USER\winstats\drop2.paa";
    private _iconHeli = "\A3\ui_f\data\map\vehicleicons\iconHelicopter_ca.paa"; // "\A3\ui_f\data\igui\cfg\mptable\air_ca.paa";
    private _iconTotal = "\A3\ui_f\data\igui\cfg\mptable\total_ca.paa";
    

    private _columns = ["", "Estland", "Russland"];
    private _picturePath = ["", _iconInf, _iconSoft, _iconAPC, _iconArmored, _iconHeli, _iconTotal];
    private _picturePathDescription = ["", "Infanterie (1 Effizienzpunkt)", "Autos (2 Effizienzpunkte)", "APC (3 Effizienzpunkte)", "Tank (4 Effizienzpunkte)", "Heli (5 Effizienzpunkte)", "Insgesamt"];

    private _resultInf_west = (missionNamespace getVariable ["GRAD_LP_currentLosses", 0]);  
    private _resultInf_east = (missionNamespace getVariable ["GRAD_LP_enemyKilledMan", 0]);

    private _resultSoft_west = 0;
    private _resultSoft_east = (missionNamespace getVariable ["GRAD_LP_enemyKilledCar", 0]);

    private _resultAPC_west = 0;
    private _resultAPC_east = (missionNamespace getVariable ["GRAD_LP_enemyKilledAPC", 0]);

    private _resultArmored_west = 0;
    private _resultArmored_east = (missionNamespace getVariable ["GRAD_LP_enemyKilledTank", 0]);

    private _resultHeli_west = 0;
    private _resultHeli_east = (missionNamespace getVariable ["GRAD_LP_enemyKilledHeli", 0]);
    



    /*
        systemChat _resultInf_west;
        systemChat _resultSoft_west;
        systemChat _resultFuel_west;
    */



    private _resultTotalNumber_west = ((_resultInf_west) + (_resultSoft_west) + (_resultAPC_west) + (_resultArmored_west) + (_resultHeli_west));
    private _resultTotalNumber_east = ((_resultInf_east) + (_resultSoft_east) + (_resultAPC_east) + (_resultArmored_east) + (_resultHeli_east));

    private _resultTotal_west =  _resultTotalNumber_west;
    private _resultTotal_east=  _resultTotalNumber_east;

    private _results_west = ["", _resultInf_west, _resultSoft_west, _resultAPC_west, _resultArmored_west, _resultHeli_west, _resultTotal_west];
    private _results_east = ["", _resultInf_east, _resultSoft_east, _resultAPC_east, _resultArmored_east, _resultHeli_east, _resultTotal_east];

    private _eastWins = _resultTotalNumber_east > _resultTotalNumber_west * 4;

    hint str _resultHeli_east;

    private _efficiency = round (
            (((_resultInf_east) + (_resultSoft_east*2) + (_resultAPC_east*3) + (_resultArmored_east*4) + (_resultHeli_east*5)) * 4) / 
            (((_resultInf_west) + (_resultSoft_west*2) + (_resultAPC_west*3) + (_resultArmored_west*4) + (_resultHeli_west*5)) * 100 + 0.1)
        );

    private _draw = _resultTotalNumber_west == _resultTotalNumber_east;

    private _display = findDisplay 46 createDisplay "RscDisplayEmpty";

    _display displayAddEventHandler ["KeyDown", "if (((_this select 1) == 1) && (!isServer)) then {true} else {false};"];


    private _resultText = if (!_draw && _eastWins) then { "Sieg" } else { "Niederlage"  };
    if (_draw) then { _resultText = "Unentschieden!" };

    private _background = _display ctrlCreate ["RscText", -1];
    _background ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _screenHeight];
    _background ctrlSetBackgroundColor [0,0,0,0.9];
    _background ctrlCommit 0;

    private _backgroundHeader = _display ctrlCreate ["RscText", -1];
    _backgroundHeader ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _rowHeight*4];
    _backgroundHeader ctrlSetBackgroundColor [0,0,0,1];
    _backgroundHeader ctrlCommit 0;

    private _bgHeadline = _display ctrlCreate ["RscStructuredText", -1];
    _bgHeadline ctrlsetFont "RobotoCondensedBold";
    _bgHeadline ctrlSetBackgroundColor [0,0,0,0];
    _bgHeadline ctrlSetStructuredText parseText ("<t size='3' align='center' color='#333333'>" + _resultText + "</t>");
    _bgHeadline ctrlSetPosition [safezoneX, safeZoneY, _screenWidth, _rowHeight*3];
    _bgHeadline ctrlCommit 0;




    for "_i" from 1 to 3 do {

        private _multiplicator = _i * 5;

        private _column = _display ctrlCreate ["RscText", -1];
        _column ctrlSetPosition [
            _columnWidth * _multiplicator + safezoneX + _columnWidth,
            _rowHeight + safezoneY,
            _columnWidth * 4,
            _screenHeight + safezoneY
        ];
        _column ctrlSetBackgroundColor [1,1,1,0];
        _column ctrlCommit 0;

        private _headline = _display ctrlCreate ["RscStructuredText", -1];
        _headline ctrlsetFont "RobotoCondensedBold";
        _headline ctrlSetBackgroundColor [0,0,0,0];
        _headline ctrlSetTextColor [1,1,1,1];
        _headline ctrlSetStructuredText parseText ("<t size='2' align='center' color='#666666'>" + (_columns select (_i-1)) + "</t>");
        _headline ctrlSetPosition [
            _columnWidth * _multiplicator + safezoneX + _columnWidth,
            _rowHeight * 4 + safezoneY + _rowHeight * 2,
            _columnWidth * 4,
            _rowHeight * 2.5
        ];
        _headline ctrlCommit 0;


        for "_j" from 1 to 6 do {

                private _textFadeResult = if (_j == 6) then { 0 } else { 0.5 };

                if (_i == 1) then {
                    private _picture = _display ctrlCreate ["RscPictureKeepAspect", -1];
                    _picture ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth + _columnWidth/2,
                        (_j * (_rowHeight * 4) + safezoneY) + _rowHeight * 6,
                        _columnWidth * 2,
                        _rowHeight * 2
                    ];
                    _picture ctrlSetBackgroundColor [0,0,0,0];
                    _picture ctrlSetText (_picturePath select _j);
                    _picture ctrlSetTooltip (_picturePathDescription select _j);
                    _picture ctrlSetFade 0.5;
                    _picture ctrlCommit 0;
                };

                if (_i == 2) then {
                    private _subline = _display ctrlCreate ["RscStructuredText", -1];
                    _subline ctrlsetFont "RobotoCondensedBold";
                    _subline ctrlSetBackgroundColor [0,0,0,0];
                    _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#ffffff'>" + str (_results_east select _j) + "</t>");
                    _subline ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth,
                        (_j * (_rowHeight * 4) + safezoneY) + _rowHeight * 6,
                        _columnWidth * 4,
                        _rowHeight * 2
                    ];
                    _subline ctrlSetFade _textFadeResult;
                    _subline ctrlCommit 0;
                };

                if (_i == 3) then {
                    private _subline = _display ctrlCreate ["RscStructuredText", -1];
                    _subline ctrlsetFont "RobotoCondensedBold";
                    _subline ctrlSetBackgroundColor [0,0,0,0];
                    _subline ctrlSetStructuredText parseText ("<t size='2' align='center' shadow='0' color='#ffffff'>" + str (_results_west select _j) + "</t>");
                    _subline ctrlSetPosition [
                        _columnWidth * _multiplicator + safezoneX  + _columnWidth,
                        (_j * (_rowHeight * 4) + safezoneY) + _rowHeight * 6,
                        _columnWidth * 4,
                        _rowHeight * 2
                    ];
                    _subline ctrlSetFade _textFadeResult;
                    _subline ctrlCommit 0;
                };


                private _dividerHeight = if (_j == 4) then { _rowHeight/10 } else { _rowHeight/20 };
                private _divider = _display ctrlCreate ["RscStructuredText", -1];
                _divider ctrlSetPosition [
                    safezoneX,
                    (_j * (_rowHeight * 4) + safezoneY) + _rowHeight * 9,
                    _screenWidth,
                    _dividerHeight
                ];
                _divider ctrlSetBackgroundColor [1,1,1,0.03];
                _divider ctrlCommit 0;
        };
    };

    private _colorEfficiency = if (_efficiency > 399) then { "#339933" } else { "#993333" };

    private _efficiencyLine = _display ctrlCreate ["RscStructuredText", -1];
        _efficiencyLine ctrlsetFont "RobotoCondensedBold";
        _efficiencyLine ctrlSetBackgroundColor [0,0,0,0];
        _efficiencyLine ctrlSetStructuredText parseText ("
                <t size='2.5' align='center' shadow='0' color='" + _colorEfficiency +"'>" + str _efficiency + " %</t>
                <t size='0.7' align='center' shadow='0' color='#666666' font='RobotoCondensed'><br/>Effizienz</t>"
                );
        _efficiencyLine ctrlSetPosition [
            safezoneX,
            (7 * (_rowHeight * 4) + safezoneY) + _rowHeight * 6,
            _screenWidth,
            _rowHeight * 4
        ];
        _efficiencyLine ctrlSetFade 0;
        _efficiencyLine ctrlCommit 0;

    sleep 16;
    _display displayRemoveAllEventHandlers "KeyDown";
    _display closeDisplay 1;

};
