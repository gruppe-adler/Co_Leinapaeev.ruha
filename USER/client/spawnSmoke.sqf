params ["_position", "_timeout"];

// SMOKE
//--- variables set by user
_colorRed = 0;
_colorGreen = 0;
_colorBlue = 0;
_colorAlpha = 1;
_particleLifeTime = 60; //50, 5 is HUGE amount of smoke, so lower is more
_particleDensity = 2; //10
_particleSize = 5; //1
_particleSpeed = 2; //1
_particleLifting = 1;
_windEffect = 1;
_effectSize = .5; //1
_expansion = 1;
_emitterSmoke = "#particlesource" createVehicleLocal _position;

//--- particle effect creation
_emitterSmoke setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02",8,0,40,1],"","billboard",1,_particleLifeTime,[0,0,0],[0,0,2*_particleSpeed],0,0.05,0.04*_particleLifting,0.05*_windEffect,
        [
        1 *_particleSize + 1,
        1.8 * _particleSize + 15,
        1.9 * _particleSize + 15,
        2 * _particleSize + 15,
        2.2 * _particleSize + 15,
        2.6 * _particleSize + 15,
        3 * _particleSize + 15,
        3.5 * _particleSize + 15,
        4 * _particleSize + 15
        ],
        [
            [0.7*_colorRed,0.7*_colorGreen,0.7*_colorBlue,1*_colorAlpha],
            [0.7*_colorRed,0.7*_colorGreen,0.7*_colorBlue,0.8*_colorAlpha],
            [0.7*_colorRed,0.7*_colorGreen,0.7*_colorBlue,0.7*_colorAlpha],
            [0.84*_colorRed,0.84*_colorGreen,0.84*_colorBlue,0.65*_colorAlpha],
            [0.84*_colorRed,0.84*_colorGreen,0.84*_colorBlue,0.6*_colorAlpha],
            [0.84*_colorRed,0.84*_colorGreen,0.84*_colorBlue,0.5*_colorAlpha],
            [0.84*_colorRed,0.84*_colorGreen,0.84*_colorBlue,0.2*_colorAlpha],
            [1*_colorRed,1*_colorGreen,1*_colorBlue,0.1*_colorAlpha],
            [1*_colorRed,1*_colorGreen,1*_colorBlue,0*_colorAlpha]
        ],
        [1,0.55,0.35], 0.1, 0.08*_expansion, "", "", ""];
_emitterSmoke setParticleRandom [_particleLifeTime/4, [0.2*_effectSize,0.2*_effectSize,0.2*_effectSize], [0.2,0.2,0.3], 1, 0, [0,0,0,0.06], 0, 0];
                        //[lifeTime, position, moveVelocity, rotationVelocity, size, color, randomDirectionPeriod, randomDirectionIntensity] 
_emitterSmoke setDropInterval (1/_particleDensity);
// _emitterSmoke attachTo [_attachToObj, [0,0,0]];



//--- timeout
if (_timeout != 0) then {
    [{
        params ["_emitterSmoke"];
        deleteVehicle _emitterSmoke;
    }, [_emitterSmoke], _timeout] call CBA_fnc_waitAndExecute;
};