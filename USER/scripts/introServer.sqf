for "_i" from 0 to 20 do {
    private _agent = createAgent ["Mullet_F", position introFishSpawnPos, [], 2, "CAN_COLLIDE"]; 
    _agent setDir 20;
};

[fakeRadio, ["introRadioSong",150]] remoteExec ["say3D", [0, -2] select isDedicated];

sleep 75;

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

sleep 7;

siren1 say3d ["introSiren", 7000];
sleep 4;
siren2 say3d ["introSiren", 7000];