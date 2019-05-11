sleep 11;

setDate [2020, 6, 15, 0, 0];
0 setFog [2, 0.7, 1];

sleep 44;
for "_i" from 0 to 20 do {
    private _agent = createAgent ["Mullet_F", ASLtoAGL (position outroEndSequence_1), [], 1, "CAN_COLLIDE"]; 
    _agent setDir (random 360);
};
