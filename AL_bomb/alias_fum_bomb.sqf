// by ALIAS

if (!hasInterface) exitWith {};

_fum_rest_obj = _this select 0;

_sizef 	= floor (5 + random 5);
_colorf = [0,0.1,0.15,0.2] call BIS_fnc_selectRandom;

_fum_rest = "#particlesource" createVehicleLocal getPosATL _fum_rest_obj;
_fum_rest setParticleCircle [0, [0, 0, 0]];
_fum_rest setParticleRandom [1,[0.2,0.2,0.5],[0.175, 0.175, 0],0, 0.25,[0, 0, 0, 0.1],0, 0];
_fum_rest setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 7,48,1], "", "Billboard", 1,5,[0,0,0],[0,0,5],30, 85, 7.9, 1, [_sizef, 100], [[0, 0, 0, 1], [_colorf, _colorf, _colorf, 0.4],[_colorf, _colorf, _colorf, 0]], [0.08], 1, 0, "", "", _fum_rest_obj];
_fum_rest setDropInterval 0.01;