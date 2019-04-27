if (!isServer) exitWith {};

waitUntil {
  time > 7
};

for "_i" from 0 to 20 do {
    private _agent = createAgent ["Mullet_F", position introFishSpawnPos, [], 1, "CAN_COLLIDE"]; 
    _agent setDir 20;
};

[] remoteExec ["MissionControl_fnc_introLocal", [0, -2] select isDedicated];
sleep (160 + 90);

deleteVehicle fakeRadio;

[klapperradio, ["introRadio01",150]] remoteExec ["say3D", [0, -2] select isDedicated];
["Radio Host", "Dear citizens."] remoteExec ["BIS_fnc_showSubtitle", [0, -2] select isDedicated];
sleep 1.3;

[klapperradio, ["introRadio02",150]] remoteExec ["say3D", [0, -2] select isDedicated];
["Radio Host", "We interrupt our music program with breaking news!"] remoteExec ["BIS_fnc_showSubtitle", [0, -2] select isDedicated];
sleep 3.5;

[klapperradio, ["introRadio03",150]] remoteExec ["say3D", [0, -2] select isDedicated];
["Radio Host", "Soldiers of the Russian Federation violently crossed our border on multiple points and are heading southwest."] remoteExec ["BIS_fnc_showSubtitle", [0, -2] select isDedicated];
sleep 6.5;

[klapperradio, ["introRadio04",150]] remoteExec ["say3D", [0, -2] select isDedicated];
["Radio Host", "This is no emergency exercise! I repeat, this is no emergency exercise."] remoteExec ["BIS_fnc_showSubtitle", [0, -2] select isDedicated];
sleep 6;

[klapperradio, ["introRadio05",150]] remoteExec ["say3D", [0, -2] select isDedicated];
["Radio Host", "We call all citizens to their evacuation and support plans, resist the intruders!"] remoteExec ["BIS_fnc_showSubtitle", [0, -2] select isDedicated];
sleep 6.2;


[klapperradio, ["introRadio06",150]] remoteExec ["say3D", [0, -2] select isDedicated];
["Radio Host", "Dont fall for misinformation! We are being attacked! Again:"] remoteExec ["BIS_fnc_showSubtitle", [0, -2] select isDedicated];
sleep 6;

["unintelligible voice", "..."] remoteExec ["BIS_fnc_showSubtitle", [0, -2] select isDedicated];

sleep 20;

INTRO_SIREN_WAILING = true;

while {INTRO_SIREN_WAILING} do {
    [siren1, ["introSiren", 7000]] remoteExec ["say3D", [0, -2] select isDedicated];
    sleep 4;
    [siren2, ["introSiren", 7000]] remoteExec ["say3D", [0, -2] select isDedicated];
    sleep 47;
};