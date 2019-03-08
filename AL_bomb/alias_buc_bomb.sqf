// by ALIAS

if (!hasInterface) exitWith {};

_buc_nap_fum = _this select 0;

_fum_buc = "#particlesource" createVehicleLocal getpos _buc_nap_fum;
_fum_buc setParticleCircle [0, [0, 0, 0]];
_fum_buc setParticleRandom [2,[0.1,0.1,0],[0.1,0.1,0], 0.3, 0.5, [0, 0, 0, 0.5], 0, 0];
_fum_buc setParticleParams [["\A3\data_f\cl_basic.p3d", 1, 0, 1], "", "Billboard", 1,3+random 7, [0,0,0],[0,0,0.5],0,10.2,7.9,0.01,[0.5,1,2],[[1,1,1,1],[1,1,1,0.5],[1,1,1,0]], [0.125], 1, 0, "", "", _buc_nap_fum];
_fum_buc setDropInterval 0.01;